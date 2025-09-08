// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis/storage/v1.dart' show DetailedApiRequestError;
import 'package:logging/logging.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/package/api_export/api_exporter.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/tool/test_profile/importer.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../../shared/test_models.dart';
import '../../shared/test_services.dart';

final _log = Logger('api_export.test');

final _testProfile = TestProfile(
  defaultUser: userAtPubDevEmail,
  generatedPackages: [
    GeneratedTestPackage(
      name: 'foo',
      versions: [GeneratedTestVersion(version: '1.0.0')],
    ),
  ],
  users: [TestUser(email: userAtPubDevEmail, likes: [])],
);

void main() {
  testWithProfile(
    'synchronizeExportedApi()',
    testProfile: _testProfile,
    expectedLogMessages: [
      'SHOUT Deleting object from public bucket: "packages/bar-2.0.0.tar.gz".',
      'SHOUT Deleting object from public bucket: "packages/bar-3.0.0.tar.gz".',
    ],
    fn: () async {
      // Since we want to verify post-upload tasks triggering API exporter,
      // we cannot use an isolated instance, we need to use the same setup.
      // However, for better control and consistency, we can remove all the
      // existing files from the bucket at the start of this test:
      await apiExporter.stop();
      final bucket = storageService.bucket(
        activeConfiguration.exportedApiBucketName!,
      );
      await _deleteAll(bucket);

      await _testExportedApiSynchronization(
        bucket,
        apiExporter.synchronizeExportedApi,
      );
    },
  );

  testWithProfile(
    'apiExporter.start()',
    expectedLogMessages: [
      'SHOUT Deleting object from public bucket: "packages/bar-2.0.0.tar.gz".',
      'SHOUT Deleting object from public bucket: "packages/bar-3.0.0.tar.gz".',
    ],
    testProfile: _testProfile,
    fn: () async {
      // Since we want to verify post-upload tasks triggering API exporter,
      // we cannot use an isolated instance, we need to use the same setup.
      // However, for better control and consistency, we can remove all the
      // existing files from the bucket at the start of this test:
      await apiExporter.stop();
      final bucket = storageService.bucket(
        activeConfiguration.exportedApiBucketName!,
      );
      await _deleteAll(bucket);

      await apiExporter.synchronizeExportedApi();

      await apiExporter.start();

      await _testExportedApiSynchronization(
        bucket,
        () async => await clockControl.elapse(minutes: 15),
      );

      await apiExporter.stop();
    },
  );
}

Future<void> _deleteAll(Bucket bucket) async {
  await for (final entry in bucket.list(delimiter: '')) {
    if (entry.isObject) {
      await bucket.delete(entry.name);
    }
  }
}

Future<void> _testExportedApiSynchronization(
  Bucket bucket,
  Future<void> Function() synchronize,
) async {
  _log.info('## Existing package');
  {
    await synchronize();

    // Check that exsting package was synchronized
    expect(await bucket.readGzippedJson('latest/api/packages/foo'), {
      'name': 'foo',
      'latest': isNotEmpty,
      'versions': hasLength(1),
    });
    expect(
      await bucket.readGzippedJson('latest/api/package-name-completion-data'),
      {'packages': hasLength(1)},
    );
    expect(
      await bucket.readBytes('$runtimeVersion/api/archives/foo-1.0.0.tar.gz'),
      isNotNull,
    );
    expect(
      await bucket.readGzippedJson('$runtimeVersion/api/packages/foo/likes'),
      {'package': 'foo', 'likes': 0},
    );
    expect(
      await bucket.readGzippedJson('$runtimeVersion/api/packages/foo/options'),
      {'isDiscontinued': false, 'replacedBy': null, 'isUnlisted': false},
    );
    expect(
      await bucket.readGzippedJson(
        '$runtimeVersion/api/packages/foo/publisher',
      ),
      {'publisherId': null},
    );
    expect(
      await bucket.readGzippedJson('$runtimeVersion/api/packages/foo/score'),
      {
        'grantedPoints': isNotNull,
        'maxPoints': isNotNull,
        'likeCount': isNotNull,
        'downloadCount30Days': null,
        'tags': isNotEmpty,
      },
    );
    expect(await bucket.readGzippedJson('$runtimeVersion/api/packages/foo'), {
      'name': 'foo',
      'latest': isNotEmpty,
      'versions': hasLength(1),
    });
    expect(
      await bucket.readString('$runtimeVersion/api/packages/foo/feed.atom'),
      contains('v1.0.0 of foo'),
    );
    expect(
      await bucket.readGzippedJson(
        '$runtimeVersion/api/package-name-completion-data',
      ),
      {'packages': hasLength(1)},
    );
    expect(
      await bucket.readBytes('$runtimeVersion/api/archives/foo-1.0.0.tar.gz'),
      isNotNull,
    );
    expect(
      await bucket.readString('$runtimeVersion/feed.atom'),
      contains('v1.0.0 of foo'),
    );
  }

  _log.info('## New package');
  {
    await importProfile(
      profile: TestProfile(
        defaultUser: userAtPubDevEmail,
        generatedPackages: [
          GeneratedTestPackage(
            name: 'bar',
            versions: [GeneratedTestVersion(version: '2.0.0')],
            publisher: 'example.com',
          ),
        ],
      ),
    );

    // Synchronize again
    await synchronize();

    // Check that exsting package is still there
    expect(await bucket.readGzippedJson('latest/api/packages/foo'), isNotNull);
    expect(
      await bucket.readBytes('latest/api/archives/foo-1.0.0.tar.gz'),
      isNotNull,
    );
    expect(
      await bucket.readString('latest/feed.atom'),
      contains('v1.0.0 of foo'),
    );
    expect(
      await bucket.readString('latest/api/packages/foo/feed.atom'),
      contains('v1.0.0 of foo'),
    );
    expect(
      await bucket.readGzippedJson('latest/api/packages/foo/likes'),
      isNotNull,
    );
    expect(
      await bucket.readGzippedJson('latest/api/packages/foo/options'),
      isNotNull,
    );
    expect(
      await bucket.readGzippedJson('latest/api/packages/foo/publisher'),
      isNotNull,
    );
    expect(
      await bucket.readGzippedJson('latest/api/packages/foo/score'),
      isNotNull,
    );
    // Note. that name completion data won't be updated until search caches
    //       are purged, so we won't test that it is updated.

    // Check that new package was synchronized
    expect(await bucket.readGzippedJson('latest/api/packages/bar'), {
      'name': 'bar',
      'latest': isNotEmpty,
      'versions': hasLength(1),
    });
    expect(
      await bucket.readBytes('latest/api/archives/bar-2.0.0.tar.gz'),
      isNotNull,
    );
    expect(
      await bucket.readString('latest/feed.atom'),
      contains('v2.0.0 of bar'),
    );
    expect(
      await bucket.readString('latest/api/packages/bar/feed.atom'),
      contains('v2.0.0 of bar'),
    );
  }

  _log.info('## New package version');
  {
    await importProfile(
      profile: TestProfile(
        defaultUser: userAtPubDevEmail,
        generatedPackages: [
          GeneratedTestPackage(
            name: 'bar',
            versions: [GeneratedTestVersion(version: '3.0.0')],
            publisher: 'example.com',
          ),
        ],
      ),
    );

    // Synchronize again
    await synchronize();

    // Check that version listing was updated
    expect(await bucket.readGzippedJson('latest/api/packages/bar'), {
      'name': 'bar',
      'latest': isNotEmpty,
      'versions': hasLength(2),
    });
    // Check that versions are there
    expect(
      await bucket.readBytes('latest/api/archives/bar-2.0.0.tar.gz'),
      isNotNull,
    );
    expect(
      await bucket.readBytes('latest/api/archives/bar-3.0.0.tar.gz'),
      isNotNull,
    );
    expect(
      await bucket.readString('$runtimeVersion/feed.atom'),
      contains('v3.0.0 of bar'),
    );
    expect(
      await bucket.readString('latest/api/packages/bar/feed.atom'),
      contains('v3.0.0 of bar'),
    );
  }

  _log.info('## Discontinued flipped on');
  {
    final api = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
    await api.setPackageOptions('bar', PkgOptions(isDiscontinued: true));

    // Synchronize again
    await synchronize();

    // Check that version listing was updated
    expect(await bucket.readGzippedJson('latest/api/packages/bar'), {
      'name': 'bar',
      'latest': isNotEmpty,
      'versions': hasLength(2),
      'isDiscontinued': true,
    });
  }

  _log.info('## Discontinued flipped off');
  {
    final api = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
    await api.setPackageOptions('bar', PkgOptions(isDiscontinued: false));

    // Synchronize again
    await synchronize();

    // Check that version listing was updated
    expect(await bucket.readGzippedJson('latest/api/packages/bar'), {
      'name': 'bar',
      'latest': isNotEmpty,
      'versions': hasLength(2),
    });
  }

  _log.info('## Version retracted');
  {
    final api = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
    await api.setVersionOptions(
      'bar',
      '2.0.0',
      VersionOptions(isRetracted: true),
    );

    // Synchronize again
    await synchronize();

    // Check that version listing was updated
    expect(await bucket.readGzippedJson('latest/api/packages/bar'), {
      'name': 'bar',
      'latest': isNotEmpty,
      'versions': contains(containsPair('retracted', true)),
    });
  }

  _log.info('## Version moderated');
  {
    // Elapse time before moderating package, because exported-api won't delete
    // recently created files as a guard against race conditions.
    clockControl.elapseSync(days: 1);

    await withRetryPubApiClient(
      authToken: createFakeServiceAccountToken(email: 'admin@pub.dev'),
      (adminApi) async {
        await adminApi.adminInvokeAction(
          'moderate-package-version',
          AdminInvokeActionArguments(
            arguments: {
              'case': 'none',
              'package': 'bar',
              'version': '2.0.0',
              'state': 'true',
            },
          ),
        );
      },
    );

    // Synchronize again
    await synchronize();

    // Check that version listing was updated
    expect(await bucket.readGzippedJson('latest/api/packages/bar'), {
      'name': 'bar',
      'latest': isNotEmpty,
      'versions': hasLength(1),
    });
    expect(
      await bucket.readBytes('latest/api/archives/bar-2.0.0.tar.gz'),
      isNull,
    );
    expect(
      await bucket.readBytes('latest/api/archives/bar-3.0.0.tar.gz'),
      isNotNull,
    );
  }

  _log.info('## Version reinstated');
  {
    await withRetryPubApiClient(
      authToken: createFakeServiceAccountToken(email: 'admin@pub.dev'),
      (adminApi) async {
        await adminApi.adminInvokeAction(
          'moderate-package-version',
          AdminInvokeActionArguments(
            arguments: {
              'case': 'none',
              'package': 'bar',
              'version': '2.0.0',
              'state': 'false',
            },
          ),
        );
      },
    );

    // Synchronize again
    await synchronize();

    // Check that version listing was updated
    expect(await bucket.readGzippedJson('latest/api/packages/bar'), {
      'name': 'bar',
      'latest': isNotEmpty,
      'versions': hasLength(2),
    });
    expect(
      await bucket.readBytes('latest/api/archives/bar-2.0.0.tar.gz'),
      isNotNull,
    );
    expect(
      await bucket.readBytes('latest/api/archives/bar-3.0.0.tar.gz'),
      isNotNull,
    );
  }

  _log.info('## Package moderated');
  {
    // Elapse time before moderating package, because exported-api won't delete
    // recently created files as a guard against race conditions.
    clockControl.elapseSync(days: 1);

    await withRetryPubApiClient(
      authToken: createFakeServiceAccountToken(email: 'admin@pub.dev'),
      (adminApi) async {
        await adminApi.adminInvokeAction(
          'moderate-package',
          AdminInvokeActionArguments(
            arguments: {'case': 'none', 'package': 'bar', 'state': 'true'},
          ),
        );
      },
    );

    // Synchronize again
    await synchronize();

    expect(await bucket.readGzippedJson('latest/api/packages/bar'), isNull);
    expect(
      await bucket.readGzippedJson('latest/api/packages/bar/options'),
      isNull,
    );
    expect(
      await bucket.readGzippedJson('latest/api/packages/feed.atom'),
      isNull,
    );
    expect(
      await bucket.readBytes('latest/api/archives/bar-2.0.0.tar.gz'),
      isNull,
    );
    expect(
      await bucket.readBytes('latest/api/archives/bar-3.0.0.tar.gz'),
      isNull,
    );
  }

  _log.info('## Package reinstated');
  {
    await withRetryPubApiClient(
      authToken: createFakeServiceAccountToken(email: 'admin@pub.dev'),
      (adminApi) async {
        await adminApi.adminInvokeAction(
          'moderate-package',
          AdminInvokeActionArguments(
            arguments: {'case': 'none', 'package': 'bar', 'state': 'false'},
          ),
        );
      },
    );

    // Synchronize again
    await synchronize();

    expect(await bucket.readGzippedJson('latest/api/packages/bar'), {
      'name': 'bar',
      'latest': isNotEmpty,
      'versions': hasLength(2),
    });
    expect(
      await bucket.readGzippedJson('latest/api/packages/bar/options'),
      isNotNull,
    );
    expect(
      await bucket.readBytes('latest/api/archives/bar-2.0.0.tar.gz'),
      isNotNull,
    );
    expect(
      await bucket.readBytes('latest/api/archives/bar-3.0.0.tar.gz'),
      isNotNull,
    );
  }
}

extension on Bucket {
  /// Read bytes from bucket, return null if missing
  Future<Uint8List?> readBytes(String path) async {
    try {
      return await readAsBytes(path);
    } on DetailedApiRequestError catch (e) {
      if (e.status == 404) return null;
      rethrow;
    }
  }

  /// Read gzipped JSON from bucket
  Future<Object?> readGzippedJson(String path) async {
    final bytes = await readBytes(path);
    if (bytes == null) {
      return null;
    }
    return utf8JsonDecoder.convert(gzip.decode(bytes));
  }

  /// Read bytes from bucket and decode as UTF-8 text.
  Future<String> readString(String path) async {
    final bytes = await readBytes(path);
    return utf8.decode(gzip.decode(bytes!));
  }
}
