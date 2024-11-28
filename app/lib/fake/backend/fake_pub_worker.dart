// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:_pub_shared/dartdoc/dartdoc_page.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/data/task_payload.dart';
import 'package:_pub_shared/worker/docker_utils.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:indexed_blob/indexed_blob.dart';
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/fake/backend/fake_pana_runner.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/service/async_queue/async_queue.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/cloudcompute/fakecloudcompute.dart';
import 'package:pub_dev/tool/utils/http.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:retry/retry.dart';

/// Updates the task status for all packages and runs the local
/// pub worker for each.
Future<void> processTasksLocallyWithPubWorker() async {
  // ignore: invalid_use_of_visible_for_testing_member
  await asyncQueue.ongoingProcessing;

  /// Get hold of the [FakeCloudCompute]
  final cloud = taskWorkerCloudCompute as FakeCloudCompute;
  // Backfill tracking state
  await taskBackend.backfillTrackingState();

  /// Start instance execution
  cloud.startInstanceExecution();

  // Start listening for instances, before we create any. This avoids any
  // race conditions.
  final instancesCreated = cloud.onCreated.take(1).toList();
  final instancesDeleted = cloud.onDeleted.take(1).toList();

  // Start the taskbackend, this will scheduled instances and track state
  // driving scheduling.
  await taskBackend.start();

  // Wait for instances to be created.
  await instancesCreated;

  // Wait for instances to be deleted, this indicates that they are done
  // doing whatever work they planned to do.
  await instancesDeleted;

  // Stop the task backend, and instance execution
  await Future.wait([
    taskBackend.stop(),
    cloud.stopInstanceExecution(),
  ]);
}

/// Process analysis tasks locally, using either:
/// - `fake`: the semi-randomized fake analysis that is fast
/// - `local`: running pkg/pub_worker using the same context as the app
/// - `worker`: running pkg/pub_worker using the dockerized container
Future<void> processTaskFakeLocalOrWorker(String analysis) async {
  if (analysis == 'none') {
    return;
  } else if (analysis == 'local') {
    await _analyzeLocal();
  } else if (analysis == 'worker') {
    await _analyzeWorker();
  } else if (analysis == 'fake') {
    await processTasksWithFakePanaAndDartdoc();
  } else {
    throw ArgumentError('Unknown analysis: `$analysis`');
  }
}

/// Updates the task status for all packages and imitates
/// pub_worker using fake pana and dartdoc results.
Future<void> processTasksWithFakePanaAndDartdoc() async {
  await taskBackend.backfillAndProcessAllPackages(_fakeAnalysis);
}

Future<void> _fakeAnalysis(Payload payload) async {
  for (final v in payload.versions) {
    final client = httpClientWithAuthorization(
      tokenProvider: () async => v.token,
      sessionIdProvider: () async => null,
      csrfTokenProvider: () async => null,
    );
    try {
      final api = PubApiClient(payload.pubHostedUrl, client: client);
      await withTempDirectory((tempDir) async {
        final packageStatus =
            await scoreCardBackend.getPackageStatus(payload.package, v.version);

        final random = Random('${payload.package}/${v.version}'.hashCode);
        final documented = random.nextInt(21);
        final dartdocFiles = _fakeDartdocFiles(
          payload.package,
          v.version,
          documented: documented,
          total: 20,
        );

        final Summary summary;
        if (packageStatus.isObsolete || packageStatus.isLegacy) {
          summary = _emptySummary(payload.package, v.version);
          dartdocFiles.clear();
        } else {
          summary = await fakePanaSummary(
            package: payload.package,
            version: v.version,
            packageStatus: packageStatus,
            documentedRatio: documented / 20,
          );
        }

        final r = await api.taskUploadResult(payload.package, v.version);

        final blobFile = File(p.join(tempDir.path, 'files.blob'));
        final builder = IndexedBlobBuilder(blobFile.openWrite());

        Future<void> addFileAsStringGzipped(String path, String content) async {
          final stream =
              Stream.fromIterable([gzip.encode(utf8.encode(content))]);
          await builder.addFile(path, stream);
        }

        for (final e in dartdocFiles.entries) {
          await addFileAsStringGzipped('doc/${e.key}', e.value);
        }
        await addFileAsStringGzipped(
            'summary.json', json.encode(summary.toJson()));
        await addFileAsStringGzipped('log.txt', 'started\nstopped\n');
        final index = await builder.buildIndex(r.blobId);

        // Upload blob and index
        await _upload(
          client,
          r.blob,
          () => blobFile.openRead(),
          blobFile.statSync().size,
          filename: r.blobId,
          contentType: 'application/octet-stream',
        );
        // Always upload the index last, this references the blobId, and when we
        // upload this we will overwrite the previous value. So we have atomicity
        // even though we're uploading two files.
        await _upload(
          client,
          r.index,
          () => Stream.value(index.asBytes()),
          index.asBytes().length,
          filename: 'index.json',
          contentType: 'application/json',
        );

        await api.taskUploadFinished(payload.package, v.version);
      });
    } finally {
      client.close();
    }
  }
}

Future<void> _analyzeLocal() async {
  await fork(() async {
    await taskBackend.backfillAndProcessAllPackages((Payload payload) async {
      final arguments = [json.encode(payload.toJson())];
      final pr = await Process.run(
        Platform.resolvedExecutable,
        ['run', 'pub_worker', ...arguments],
        workingDirectory: p.join(resolveAppDir(), '..', 'pkg', 'pub_worker'),
      );
      if (pr.exitCode != 0) {
        throw Exception('Unexpected status code: ${pr.exitCode} ${pr.stdout}');
      }
    });
  });
}

Future<void> _analyzeWorker() async {
  await buildDockerImage();
  await fork(() async {
    await taskBackend.backfillAndProcessAllPackages((Payload payload) async {
      final p = await startDockerAnalysis(payload);
      final exitCode = await p.exitCode;
      if (exitCode != 0) {
        throw Exception(
            'Failed to analyze ${payload.package} with exitCode $exitCode');
      }
    });
  });
}

Future<void> fakeCloudComputeInstanceRunner(FakeCloudInstance instance) async {
  final payload = Payload.fromJson(
      json.decode(instance.arguments.first) as Map<String, dynamic>);
  await _fakeAnalysis(payload);
}

Map<String, String> _fakeDartdocFiles(
  String package,
  String version, {
  required int documented,
  required int total,
}) {
  final pubData = {
    'coverage': {
      'documented': documented,
      'total': total,
    },
    'apiElements': [
      // TODO: add fake library elements
    ],
  };
  return {
    'index.html': json.encode(DartDocPage(
      title: 'index',
      description: 'index description',
      breadcrumbs: [],
      content: 'content',
      left: 'left',
      right: 'right',
      baseHref: null,
      usingBaseHref: null,
      aboveSidebarUrl: null,
      belowSidebarUrl: null,
      redirectPath: null,
    ).toJson()),
    'index.json': '{}',
    'pub-data.json': json.encode(pubData),
    'search.html': json.encode(DartDocPage(
      title: 'search',
      description: 'search description',
      breadcrumbs: [],
      content: 'content',
      left: 'left',
      right: 'right',
      baseHref: null,
      usingBaseHref: null,
      aboveSidebarUrl: null,
      belowSidebarUrl: null,
      redirectPath: null,
    ).toJson()),
  };
}

/// Upload [content] to [destination] as returned from pub.dev task API.
///
/// Attach given [filename] and [contentType].
///
/// NOTE: this method was copied from pkg/pub_worker.
/// TODO: extract the two methods into a single shared place
Future<void> _upload(
  Client client,
  UploadInfo destination,
  Stream<List<int>> Function() content,
  int length, {
  required String filename,
  String contentType = 'application/octet-stream',
}) async =>
    await retry(() async {
      final req = MultipartRequest('POST', Uri.parse(destination.url))
        ..fields.addAll(destination.fields ?? {})
        ..followRedirects = false
        ..files.add(MultipartFile(
          'file',
          content(),
          length,
          filename: filename,
          contentType: MediaType.parse(contentType),
        ));
      final res = await Response.fromStream(await client.send(req));

      if (400 <= res.statusCode && res.statusCode < 500) {
        throw UploadException(
          'HTTP error, status = ${res.statusCode}, body: ${res.body}',
        );
      }
      if (500 <= res.statusCode && res.statusCode < 600) {
        throw IntermittentUploadException(
          'HTTP intermittent error, status = ${res.statusCode}, body: ${res.body}',
        );
      }
      if (200 <= res.statusCode && res.statusCode < 300) {
        return;
      }

      // Unhandled response code -> retry
      throw UploadException(
        'Unhandled HTTP status = ${res.statusCode}, body: ${res.body}',
      );
    }, retryIf: (e) => e is IOException || e is IntermittentUploadException);

final class UploadException implements Exception {
  final String message;

  UploadException(this.message);

  @override
  String toString() => message;
}

final class IntermittentUploadException extends UploadException {
  IntermittentUploadException(String message) : super(message);
}

Summary _emptySummary(String package, String version) {
  return Summary(
    createdAt: clock.now().toUtc(),
    packageName: package,
    packageVersion: Version.parse(version),
    runtimeInfo: PanaRuntimeInfo(
      sdkVersion: toolStableDartSdkVersion,
      panaVersion: panaVersion,
      flutterVersions: {},
    ),
    allDependencies: null,
    tags: null,
    report: null,
    result: null,
    licenseFile: null,
    licenses: null,
    errorMessage: null,
    pubspec: null, // will be ignored
  );
}
