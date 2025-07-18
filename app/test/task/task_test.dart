// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/data/package_api.dart' show UploadInfo;
import 'package:_pub_shared/data/task_payload.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/db.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:indexed_blob/indexed_blob.dart';
import 'package:pana/pana.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/cloudcompute/fakecloudcompute.dart';
import 'package:pub_dev/task/models.dart';
import 'package:pub_dev/tool/test_profile/importer.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_services.dart';

extension on FakeCloudInstance {
  /// First argument is always a JSON blob with the [Payload].
  Payload get payload =>
      Payload.fromJson(json.decode(arguments.first) as Map<String, dynamic>);
}

/// Get hold of the [FakeCloudCompute]
FakeCloudCompute get cloud => taskWorkerCloudCompute as FakeCloudCompute;

void main() {
  testWithProfile('tasks can scheduled and processed',
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(
            name: 'oxygen',
            versions: [
              GeneratedTestVersion(version: '1.0.0'),
              GeneratedTestVersion(version: '1.1.0'),
              GeneratedTestVersion(version: '1.2.0'),
              GeneratedTestVersion(version: '2.0.0-dev'),
            ],
          ),
          GeneratedTestPackage(name: 'neon'),
          GeneratedTestPackage(name: 'flutter_titanium'),
        ],
        users: [
          TestUser(email: 'admin@pub.dev', likes: []),
        ],
      ), fn: () async {
    await taskBackend.backfillTrackingState();
    await clockControl.elapse(minutes: 1);

    await taskBackend.start();
    await clockControl.elapse(minutes: 5);

    // Check that the log is missing.
    final log1 = await taskBackend.taskLog('oxygen', '1.2.0');
    expect(log1, 'no log - version is not tracked');

    // Check that the dartdoc is missing
    final dartdoc1 = await taskBackend.dartdocFile(
      'oxygen',
      '1.2.0',
      'index.html',
    );
    expect(dartdoc1, isNull);

    // 5 minutes after start of scheduling we expect there to be 3 instances
    final instances = await cloud.listInstances().toList();
    expect(instances, hasLength(3));

    for (final instance in instances) {
      cloud.fakeStartInstance(instance.instanceName);
    }

    await clockControl.elapse(minutes: 5);

    for (final instance in instances) {
      final payload = instance.payload;

      for (final v in payload.versions) {
        // Note: We might change this assertion if we decide to analyse more
        //       versions of a package.
        expect(
          payload.package != 'oxygen' || v.version != '1.0.0',
          isTrue,
          reason:
              'oxygen 1.0.0 should not be analyzed when 1.1.0 and 1.2.0 exists',
        );

        // Use token to get the upload information
        final api = createPubApiClient(authToken: v.token);
        final uploadInfo = await api.taskUploadResult(
          payload.package,
          v.version,
        );

        // Upload the minimum result, log file
        final c = http.Client();
        try {
          // Create a fake output
          final blobId = uploadInfo.blobId;
          final output = await BlobIndexPair.build(blobId, (addFile) async {
            await addFile(
              'doc/index.html',
              Stream.value(
                '<h1>dartdoc for ${payload.package} version ${v.version}</h1>',
              ).transform(utf8.fuse(gzip).encoder),
            );
            await addFile(
              'log.txt',
              Stream.value(
                'This is a pana log file',
              ).transform(utf8.fuse(gzip).encoder),
            );
          });

          // Upload dartdoc results
          await upload(
            c,
            uploadInfo.blob,
            () => Stream.value(output.blob),
            output.blob.length,
            filename: uploadInfo.blobId,
          );
          await upload(
            c,
            uploadInfo.index,
            () => Stream.value(output.index.asBytes()),
            output.index.asBytes().length,
            filename: 'index.json',
            contentType: 'application/json',
          );
        } finally {
          c.close();
        }

        // Report the task as finished
        await api.taskUploadFinished(payload.package, v.version);
      }
    }

    await clockControl.elapse(minutes: 5);

    // Check that we can get the log file
    final log2 = await taskBackend.taskLog('oxygen', '1.2.0');
    expect(log2, contains('This is a pana log file'));

    // Check that we can get the generated dartdoc
    final dartdoc2 = await taskBackend.dartdocFile(
      'oxygen',
      '1.2.0',
      'index.html',
    );
    expect(dartdoc2, isNotNull);
    expect(
      utf8.decode(gzip.decode(dartdoc2!)),
      contains('dartdoc for oxygen version 1.2.0'),
    );

    // All instances should be terminated, api.taskUploadFinished terminate
    // when all versions for the instance is done. And fake instances take 1
    // minute to simulate termination.
    expect(await cloud.listInstances().toList(), hasLength(0));

    await taskBackend.stop();

    await clockControl.elapse(minutes: 10);
  });

  testWithProfile('failing instances will be retried', expectedLogMessages: [
    'SHOUT [pub-notice:cached_value] Updating cached `thirtyDaysTotalDownloadCounts` value failed.',
  ], fn: () async {
    await taskBackend.backfillTrackingState();
    await clockControl.elapse(minutes: 1);

    await taskBackend.start();

    // We are going to let the task timeout, if this happens we should only
    // try to scheduled it until we hit the [taskRetryLimit].
    for (var i = 0; i < taskRetryLimit; i++) {
      // Within 24 hours an instance should be created
      await clockControl.elapseUntil(
        () => cloud.listInstances().isNotEmpty,
        timeout: Duration(days: 1),
      );

      // If nothing happens, then it should be killed within 24 hours.
      // Actually, it'll happen much sooner, like ~2 hours, but we'll leave the
      // test some wiggle room.
      await clockControl.elapseUntil(
        () => cloud.listInstances().isEmpty,
        timeout: Duration(days: 1),
      );
    }

    // Once we've exceeded the [taskRetryLimit], we shouldn't see any instances
    // created for the next day...
    assert(taskRetriggerInterval > Duration(days: 1));
    await expectLater(
      clockControl.elapseUntil(
        () => cloud.listInstances().isNotEmpty,
        timeout: Duration(days: 1),
      ),
      throwsA(isA<TimeoutException>()),
    );

    // But the task should be retried after [taskRetriggerInterval], this is a
    // long time, but for sanity we do re-analyze everything occasionally.
    await clockControl.elapseUntil(
      () => cloud.listInstances().isNotEmpty,
      timeout: taskRetriggerInterval + Duration(days: 1),
    );

    await taskBackend.stop();

    await clockControl.elapse(minutes: 10);
  },
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(
            name: 'neon',
            versions: [GeneratedTestVersion(version: '1.0.0')],
            publisher: 'example.com',
          ),
        ],
        users: [
          TestUser(email: 'admin@pub.dev', likes: []),
        ],
      ));

  testWithProfile('Limit to 5 latest major versions', fn: () async {
    await taskBackend.backfillTrackingState();
    await clockControl.elapse(minutes: 1);
    await taskBackend.start();
    await clockControl.elapse(minutes: 15);

    // We expect there to be one instance with less than 10 versions to be
    // analyzed, this even though there really is 20 versions.
    final instances = await cloud.listInstances().toList();
    expect(instances, hasLength(1));
    expect(
      instances.first.payload.versions.map((vt) => vt.version),
      containsAll([
        '6.0.0',
        '5.1.0',
        '4.0.0',
        '3.2.0',
        '2.0.0',
      ]),
    );
    expect(
      instances.first.payload.versions.map((vt) => vt.version).toList(),
      hasLength(5),
    );

    await taskBackend.stop();

    await clockControl.elapse(minutes: 10);
  },
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(
            name: 'neon',
            versions: [
              GeneratedTestVersion(version: '6.0.0'),
              GeneratedTestVersion(version: '5.1.0'),
              GeneratedTestVersion(version: '5.0.0'),
              GeneratedTestVersion(version: '4.0.0'),
              GeneratedTestVersion(version: '3.2.0'),
              GeneratedTestVersion(version: '3.1.0'),
              GeneratedTestVersion(version: '3.0.0'),
              GeneratedTestVersion(version: '2.0.0'),
              GeneratedTestVersion(version: '1.0.0'),
            ],
            publisher: 'example.com',
            isDiscontinued: true,
          ),
        ],
        users: [
          TestUser(email: 'admin@pub.dev', likes: []),
        ],
      ));

  testWithProfile('continued scan finds new packages', fn: () async {
    await taskBackend.backfillTrackingState();
    await taskBackend.start();
    await clockControl.elapse(minutes: 15);

    expect(await cloud.listInstances().toList(), hasLength(0));

    // Create a package
    await importProfile(
      profile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(
            name: 'neon',
            versions: [GeneratedTestVersion(version: '1.0.0')],
            publisher: 'example.com',
          ),
        ],
      ),
    );

    await clockControl.elapse(minutes: 15);

    expect(await cloud.listInstances().toList(), hasLength(1));

    await taskBackend.stop();

    await clockControl.elapse(minutes: 10);
  },
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [],
        users: [
          TestUser(email: 'admin@pub.dev', likes: []),
        ],
      ));

  testWithProfile('analyzed packages stay idle', fn: () async {
    await taskBackend.backfillTrackingState();
    await taskBackend.start();
    await clockControl.elapse(minutes: 15);

    final instances = await cloud.listInstances().toList();
    // There is only one package, so we should only get one instance
    expect(instances, hasLength(1));

    final instance = instances.first;
    final payload = instance.payload;

    // There should only be one version
    expect(payload.versions, hasLength(1));

    final v = payload.versions.first;
    // Use token to get the upload information
    final api = createPubApiClient(authToken: v.token);
    final uploadInfo = await api.taskUploadResult(
      payload.package,
      v.version,
    );

    // Upload the minimum result, log file
    final c = http.Client();
    try {
      // Create a fake output
      final blobId = uploadInfo.blobId;
      final output = await BlobIndexPair.build(blobId, (addFile) async {
        await addFile(
          'log.txt',
          Stream.value(
            'This is a pana log file',
          ).transform(utf8.fuse(gzip).encoder),
        );
      });

      // Upload dartdoc results
      await upload(
        c,
        uploadInfo.blob,
        () => Stream.value(output.blob),
        output.blob.length,
        filename: uploadInfo.blobId,
      );
      await upload(
        c,
        uploadInfo.index,
        () => Stream.value(output.index.asBytes()),
        output.index.asBytes().length,
        filename: 'index.json',
        contentType: 'application/json',
      );
    } finally {
      c.close();
    }

    // Report the task as finished
    await api.taskUploadFinished(payload.package, v.version);

    // Leave time for the instance to be deleted (takes 1 min in fake cloud)
    await clockControl.elapse(minutes: 5);

    // We don't expect anything to be scheduled for the next 7 days.
    await clockControl.expectUntil(
      () => cloud.listInstances().isEmpty,
      Duration(days: 7),
    );

    await taskBackend.stop();

    await clockControl.elapse(minutes: 10);
  },
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(
            name: 'neon',
            versions: [GeneratedTestVersion(version: '1.0.0')],
            publisher: 'example.com',
          ),
        ],
        users: [
          TestUser(email: 'admin@pub.dev', likes: []),
        ],
      ));

  testWithProfile('continued scan finds new versions', fn: () async {
    await taskBackend.backfillTrackingState();
    await taskBackend.start();
    await clockControl.elapse(minutes: 15);
    {
      final instances = await cloud.listInstances().toList();
      // There is only one package, so we should only get one instance
      expect(instances, hasLength(1));

      final instance = instances.first;
      final payload = instance.payload;

      // There should only be one version
      expect(payload.versions, hasLength(1));

      final v = payload.versions.first;
      // Use token to get the upload information
      final api = createPubApiClient(authToken: v.token);
      final uploadInfo = await api.taskUploadResult(
        payload.package,
        v.version,
      );

      // Upload the minimum result, log file and empty pana-report
      final c = http.Client();
      try {
        // Create a fake output
        final blobId = uploadInfo.blobId;
        final output = await BlobIndexPair.build(blobId, (addFile) async {
          await addFile(
            'log.txt',
            Stream.value(
              'This is a pana log file',
            ).transform(utf8.fuse(gzip).encoder),
          );
        });

        // Upload dartdoc results
        await upload(
          c,
          uploadInfo.blob,
          () => Stream.value(output.blob),
          output.blob.length,
          filename: uploadInfo.blobId,
        );
        await upload(
          c,
          uploadInfo.index,
          () => Stream.value(output.index.asBytes()),
          output.index.asBytes().length,
          filename: 'index.json',
          contentType: 'application/json',
        );
      } finally {
        c.close();
      }

      // Report the task as finished
      await api.taskUploadFinished(payload.package, v.version);
    }
    // Leave time for the instance to be deleted (takes 1 min in fake cloud)
    await clockControl.elapse(minutes: 5);

    // We don't expect anything to be scheduled for the next 3 days.
    await clockControl.expectUntil(
      () => cloud.listInstances().isEmpty,
      Duration(days: 3),
    );

    // Create a new version of existing package, this should trigger analysis
    await importProfile(
      profile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(
            name: 'neon',
            versions: [GeneratedTestVersion(version: '2.0.0')],
            publisher: 'example.com',
          ),
        ],
      ),
    );

    await clockControl.elapse(minutes: 15);

    {
      final instances = await cloud.listInstances().toList();
      // Arbitrary async delay in order to prevent flaky test timeouts.
      // TODO: remove once we find the root cause
      await Future.delayed(Duration.zero);

      // There is only one package, so we should only get one instance
      expect(instances, hasLength(1));

      final instance = instances.first;
      final payload = instance.payload;

      // There should only be one version
      expect(payload.versions, hasLength(1));
      //expect(payload.versions.map((v) => v.version), contains('2.0.0'));

      final v = payload.versions.first;
      expect(v.version, equals('2.0.0'));
    }

    await taskBackend.stop();

    await clockControl.elapse(minutes: 10);
  },
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(
            name: 'neon',
            versions: [GeneratedTestVersion(version: '1.0.0')],
            publisher: 'example.com',
          ),
        ],
        users: [
          TestUser(email: 'admin@pub.dev', likes: []),
        ],
      ));

  testWithProfile('re-analyzes when dependency is updated', fn: () async {
    await taskBackend.backfillTrackingState();
    await taskBackend.start();
    await clockControl.elapse(minutes: 15);

    // There should be 2 packages for analysis now
    expect(await cloud.listInstances().toList(), hasLength(2));

    // We finish both packages, by uploading a response.
    for (final instance in await cloud.listInstances().toList()) {
      final payload = instance.payload;

      // There should only be one version
      expect(payload.versions, hasLength(1));

      final v = payload.versions.first;
      // Use token to get the upload information
      final api = createPubApiClient(authToken: v.token);
      final uploadInfo = await api.taskUploadResult(
        payload.package,
        v.version,
      );

      // Upload the minimum result, log file and non-empty pana-report
      final c = http.Client();
      try {
        // Create a fake output
        final blobId = uploadInfo.blobId;
        final output = await BlobIndexPair.build(blobId, (addFile) async {
          await addFile(
            'log.txt',
            Stream.value(
              'This is a pana log file',
            ).transform(utf8.fuse(gzip).encoder),
          );
          await addFile(
            'summary.json',
            Stream.value(json.encode(Summary(
              createdAt: clock.now().toUtc(),
              runtimeInfo: PanaRuntimeInfo(
                panaVersion: '0.0.0',
                sdkVersion: '0.0.0',
              ),
              allDependencies: [
                // oxygen has a dependency on neon!
                if (payload.package == 'oxygen') 'neon',
              ],
            ))).transform(utf8.fuse(gzip).encoder),
          );
        });

        // Upload dartdoc results
        await upload(
          c,
          uploadInfo.blob,
          () => Stream.value(output.blob),
          output.blob.length,
          filename: uploadInfo.blobId,
        );
        await upload(
          c,
          uploadInfo.index,
          () => Stream.value(output.index.asBytes()),
          output.index.asBytes().length,
          filename: 'index.json',
          contentType: 'application/json',
        );
      } finally {
        c.close();
      }

      // Report the task as finished
      await api.taskUploadFinished(payload.package, v.version);
    }

    // Leave time for the instance to be deleted (takes 1 min in fake cloud)
    await clockControl.elapse(minutes: 15);

    // We don't expect anything to be scheduled now
    expect(await cloud.listInstances().toList(), isEmpty);

    // Create a new version of neon package, this should trigger analysis
    // of neon, but also of oxygen
    await importProfile(
      profile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(
            name: 'neon',
            versions: [GeneratedTestVersion(version: '2.0.0')],
            publisher: 'example.com',
          ),
        ],
      ),
    );

    await clockControl.elapse(minutes: 15);

    // Expect that neon is scheduled within 15 minutes
    expect(
      await cloud.listInstances().map((i) => i.payload.package).toList(),
      contains('neon'),
    );

    // Since oxygen was recently scheduled, we expect that it won't have been
    // scheduled yet.
    await clockControl.elapse(minutes: 15);
    expect(
      await cloud.listInstances().map((i) => i.payload.package).toList(),
      isNot(contains('oxygen')),
    );

    // At some point oxygen must also be retriggered, by this can be offset by
    // the [taskDependencyRetriggerCoolOff] delay.
    await clockControl.elapseUntil(
      () => cloud.listInstances().any((i) => i.payload.package == 'oxygen'),
      timeout: taskDependencyRetriggerCoolOff + Duration(minutes: 15),
    );

    await taskBackend.stop();

    await clockControl.elapse(minutes: 10);
  },
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(
            name: 'neon',
            versions: [GeneratedTestVersion(version: '1.0.0')],
            publisher: 'example.com',
          ),
          GeneratedTestPackage(
            name: 'oxygen',
            versions: [GeneratedTestVersion(version: '1.0.0')],
            publisher: 'example.com',
          ),
        ],
        users: [
          TestUser(email: 'admin@pub.dev', likes: []),
        ],
      ));

  testWithProfile(
    'new version during ongoing analysis',
    testProfile: TestProfile(
      defaultUser: 'admin@pub.dev',
      generatedPackages: [
        GeneratedTestPackage(
          name: 'neon',
          versions: [GeneratedTestVersion(version: '1.0.0')],
        ),
      ],
      users: [
        TestUser(email: 'admin@pub.dev', likes: []),
      ],
    ),
    fn: () async {
      await taskBackend.backfillTrackingState();
      await taskBackend.start();
      await clockControl.elapse(minutes: 15);
      late VersionTokenPair v;
      {
        final instances = await cloud.listInstances().toList();
        // There is only one package, so we should only get one instance
        expect(instances, hasLength(1));

        final instance = instances.first;
        final payload = instance.payload;

        // There should only be one version
        expect(payload.versions, hasLength(1));
        v = payload.versions.first;

        // Create new versions, removing the token from the first version
        await importProfile(
          profile: TestProfile(
            defaultUser: 'admin@pub.dev',
            generatedPackages: [
              GeneratedTestPackage(
                name: 'neon',
                versions: [
                  GeneratedTestVersion(version: '1.1.0'),
                  GeneratedTestVersion(version: '1.2.0'),
                  GeneratedTestVersion(version: '2.0.0'),
                  GeneratedTestVersion(version: '3.0.0'),
                  GeneratedTestVersion(version: '4.0.0'),
                  GeneratedTestVersion(version: '5.0.0'),
                ],
              ),
            ],
          ),
        );

        await clockControl.elapse(minutes: 15);

        // verify token is now aborted
        final ps = await dbService.lookupValue<PackageState>(
            PackageState.createKey(dbService.emptyKey, runtimeVersion, 'neon'));
        expect(ps.versions?[v.version]?.secretToken, isNull);
        expect(ps.abortedTokens, isNotEmpty);
        expect(ps.abortedTokens?.where((x) => x.token == v.token), isNotEmpty);

        // Use token to get the upload information
        final api = createPubApiClient(authToken: v.token);
        await expectApiException(
          api.taskUploadResult(
            payload.package,
            v.version,
          ),
          status: 400,
          code: 'TaskAborted',
          message: 'neon/1.0.0 has been aborted.',
        );

        // Report the task as finished
        await expectApiException(
          api.taskUploadFinished(payload.package, v.version),
          status: 400,
          code: 'TaskAborted',
          message: 'neon/1.0.0 has been aborted.',
        );
      }
      // Leave time for the instance to be deleted (takes 1 min in fake cloud)
      await clockControl.elapse(minutes: 5);

      {
        await clockControl.elapseTime(maxTaskExecutionTime);
        // Create new version, removing the token from the aborted list
        await importProfile(
          profile: TestProfile(
            defaultUser: 'admin@pub.dev',
            generatedPackages: [
              GeneratedTestPackage(
                name: 'neon',
                versions: [GeneratedTestVersion(version: '6.0.0')],
              ),
            ],
          ),
        );
        final ps = await dbService.lookupValue<PackageState>(
            PackageState.createKey(dbService.emptyKey, runtimeVersion, 'neon'));
        expect(ps.abortedTokens?.where((x) => x.token == v.token), isEmpty);

        // Report the task as finished
        final api = createPubApiClient(authToken: v.token);
        await expectApiException(
          api.taskUploadFinished('neon', v.version),
          status: 400,
          code: 'TaskAborted',
          message: 'The provided token is invalid or expired.',
        );
      }

      await taskBackend.stop();

      await clockControl.elapse(minutes: 10);
    },
  );
}

extension<T> on Stream<T> {
  Future<bool> get isNotEmpty async {
    return !await this.isEmpty;
  }
}

Future<void> upload(
  http.Client client,
  UploadInfo destination,
  Stream<List<int>> Function() content,
  int length, {
  required String filename,
  String contentType = 'application/octet-stream',
}) async {
  final req = http.MultipartRequest('POST', Uri.parse(destination.url))
    ..fields.addAll(destination.fields ?? {})
    ..followRedirects = false
    ..files.add(http.MultipartFile(
      'file',
      content(),
      length,
      filename: filename,
      contentType: MediaType.parse(contentType),
    ));
  final res = await http.Response.fromStream(await client.send(req));

  if (400 <= res.statusCode && res.statusCode < 500) {
    fail(
      'HTTP error, status = ${res.statusCode}, body: ${res.body}',
    );
  }
  if (500 <= res.statusCode && res.statusCode < 600) {
    fail(
      'HTTP intermittent error, status = ${res.statusCode}, body: ${res.body}',
    );
  }
  if (200 <= res.statusCode && res.statusCode < 300) {
    return;
  }

  // Unhandled response code -> retry
  fail(
    'Unhandled HTTP status = ${res.statusCode}, body: ${res.body}',
  );
}
