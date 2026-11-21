// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis/storage/v1.dart' show DetailedApiRequestError;
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_cdn_invalidator.dart';
import 'package:pub_dev/package/api_export/api_exporter.dart';
import 'package:pub_dev/service/async_queue/async_queue.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../../shared/test_models.dart';
import '../../shared/test_services.dart';
import '../backend_test_utils.dart';

final _testProfile = TestProfile(
  defaultUser: userAtPubDevEmail,
  generatedPackages: [
    GeneratedTestPackage(
      name: 'foo',
      versions: [
        GeneratedTestVersion(version: '1.0.0'),
        GeneratedTestVersion(version: '2.0.0'),
      ],
    ),
  ],
  users: [TestUser(email: userAtPubDevEmail, likes: [])],
);

Future<void> _uploadVersion(String package, String version) async {
  final bytes = await packageArchiveBytes(
    pubspecContent:
        '''
name: $package
version: $version
description: Test package $package $version for CDN invalidation.
environment:
  sdk: '>=3.0.0 <4.0.0'
''',
  );
  final client = createPubApiClient(authToken: userClientToken);
  await client.uploadPackageBytes(bytes);
  await asyncQueue.ongoingProcessing;
}

Future<void> _invokeAdminAction(
  String action,
  Map<String, String> arguments,
) async {
  await withRetryPubApiClient(
    authToken: createFakeServiceAccountToken(email: 'admin@pub.dev'),
    (adminApi) async {
      await adminApi.adminInvokeAction(
        action,
        AdminInvokeActionArguments(arguments: arguments),
      );
    },
  );
  await asyncQueue.ongoingProcessing;
}

void main() {
  testWithProfile(
    'bulk synchronizeExportedApi does not invalidate CDN',
    testProfile: _testProfile,
    fn: () async {
      await apiExporter.synchronizeExportedApi();
      expect(fakeCdnInvalidator.invalidatedPaths, isEmpty);

      await apiExporter.synchronizeExportedApi(forceWrite: true);
      expect(fakeCdnInvalidator.invalidatedPaths, isEmpty);
    },
  );

  testWithProfile(
    'uploading new package and versions invalidates changed paths after GCS write',
    testProfile: _testProfile,
    fn: () async {
      final bucket = storageService.bucket(
        activeConfiguration.exportedApiBucketName!,
      );
      await apiExporter.synchronizeExportedApi();
      fakeCdnInvalidator.invalidatedPaths.clear();

      // Upload a brand-new package and verify GCS already has the files when
      // CDN invalidation runs.
      var gcsHadVersionListingAtInvalidation = false;
      var gcsHadArchiveAtInvalidation = false;
      fakeCdnInvalidator.onInvalidate = (_) async {
        gcsHadVersionListingAtInvalidation =
            await bucket.readGzippedJson('latest/api/packages/fresh_pkg') !=
            null;
        gcsHadArchiveAtInvalidation =
            await bucket.readBytes(
              'latest/api/archives/fresh_pkg-1.0.0.tar.gz',
            ) !=
            null;
      };

      await _uploadVersion('fresh_pkg', '1.0.0');

      expect(gcsHadVersionListingAtInvalidation, isTrue);
      expect(gcsHadArchiveAtInvalidation, isTrue);
      expect(
        fakeCdnInvalidator.invalidatedPaths,
        unorderedEquals([
          '/api/packages/fresh_pkg',
          '/api/packages/fresh_pkg/*',
          '/api/archives/fresh_pkg-1.0.0.tar.gz',
        ]),
      );

      // Upload a second version: only version listing, atom feed, and the new
      // archive should be invalidated.
      fakeCdnInvalidator.invalidatedPaths.clear();
      var versionsCountAtInvalidation = 0;
      fakeCdnInvalidator.onInvalidate = (_) async {
        final data =
            await bucket.readGzippedJson('latest/api/packages/fresh_pkg')
                as Map<String, Object?>?;
        versionsCountAtInvalidation = (data?['versions'] as List?)?.length ?? 0;
      };

      await _uploadVersion('fresh_pkg', '1.1.0+1');

      expect(versionsCountAtInvalidation, 2);
      expect(
        fakeCdnInvalidator.invalidatedPaths,
        unorderedEquals([
          '/api/packages/fresh_pkg',
          '/api/packages/fresh_pkg/feed.atom',
          '/api/archives/fresh_pkg-1.1.0%2B1.tar.gz',
        ]),
      );
    },
  );

  testWithProfile(
    'package options and version retraction invalidate only changed paths',
    testProfile: _testProfile,
    fn: () async {
      await apiExporter.synchronizeExportedApi();
      fakeCdnInvalidator.invalidatedPaths.clear();

      final api = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      await api.setPackageOptions('foo', PkgOptions(isDiscontinued: true));
      await asyncQueue.ongoingProcessing;

      // Discontinuing updates both /options and /score (is:discontinued tag),
      // so the changed subpaths collapse into /api/packages/foo/*.
      expect(
        fakeCdnInvalidator.invalidatedPaths,
        unorderedEquals(['/api/packages/foo', '/api/packages/foo/*']),
      );

      fakeCdnInvalidator.invalidatedPaths.clear();
      await api.setVersionOptions(
        'foo',
        '1.0.0',
        VersionOptions(isRetracted: true),
      );
      await asyncQueue.ongoingProcessing;

      // Retracting updates /api/packages/foo and /api/packages/foo/feed.atom,
      // leaving all other package subpaths and archives untouched.
      expect(
        fakeCdnInvalidator.invalidatedPaths,
        unorderedEquals(['/api/packages/foo', '/api/packages/foo/feed.atom']),
      );
    },
  );

  testWithProfile(
    'moderating and reinstating a single version invalidates after GCS update',
    testProfile: _testProfile,
    expectedLogMessages: [
      RegExp(
        r'SHOUT Deleting object from public bucket: ".*/api/archives/foo-1.0.0.tar.gz".',
      ),
    ],
    fn: () async {
      final bucket = storageService.bucket(
        activeConfiguration.exportedApiBucketName!,
      );
      await apiExporter.synchronizeExportedApi();
      fakeCdnInvalidator.invalidatedPaths.clear();

      var archiveMissingAtInvalidation = false;
      fakeCdnInvalidator.onInvalidate = (_) async {
        archiveMissingAtInvalidation =
            await bucket.readBytes('latest/api/archives/foo-1.0.0.tar.gz') ==
            null;
      };

      await _invokeAdminAction('moderate-package-version', {
        'case': 'none',
        'package': 'foo',
        'version': '1.0.0',
        'state': 'true',
      });

      expect(archiveMissingAtInvalidation, isTrue);
      expect(
        fakeCdnInvalidator.invalidatedPaths,
        containsAll([
          '/api/packages/foo',
          '/api/archives/foo-1.0.0.tar.gz',
          '/api/packages/foo/versions/1.0.0/archive.tar.gz',
          '/packages/foo/versions/1.0.0.tar.gz',
          '/packages/foo/versions/1.0.0/*',
          '/documentation/foo/1.0.0/*',
          '/documentation/foo/latest/*',
        ]),
      );

      // Reinstating the version restores the archive in GCS before invalidation.
      fakeCdnInvalidator.invalidatedPaths.clear();
      var archivePresentAtInvalidation = false;
      fakeCdnInvalidator.onInvalidate = (_) async {
        archivePresentAtInvalidation =
            await bucket.readBytes('latest/api/archives/foo-1.0.0.tar.gz') !=
            null;
      };

      await _invokeAdminAction('moderate-package-version', {
        'case': 'none',
        'package': 'foo',
        'version': '1.0.0',
        'state': 'false',
      });

      expect(archivePresentAtInvalidation, isTrue);
      expect(
        fakeCdnInvalidator.invalidatedPaths,
        containsAll(['/api/packages/foo', '/api/archives/foo-1.0.0.tar.gz']),
      );
    },
  );

  testWithProfile(
    'moderating, admin-deleting, and reinstating a package invalidates after GCS update',
    testProfile: _testProfile,
    expectedLogMessages: [
      RegExp(
        r'SHOUT Deleting object from public bucket: ".*/api/archives/foo-1.0.0.tar.gz".',
      ),
      RegExp(
        r'SHOUT Deleting object from public bucket: ".*/api/archives/foo-2.0.0.tar.gz".',
      ),
    ],
    fn: () async {
      final bucket = storageService.bucket(
        activeConfiguration.exportedApiBucketName!,
      );
      await apiExporter.synchronizeExportedApi();
      fakeCdnInvalidator.invalidatedPaths.clear();

      var gcsClearedAtInvalidation = false;
      fakeCdnInvalidator.onInvalidate = (_) async {
        gcsClearedAtInvalidation =
            await bucket.readGzippedJson('latest/api/packages/foo') == null &&
            await bucket.readBytes('latest/api/archives/foo-1.0.0.tar.gz') ==
                null &&
            await bucket.readBytes('latest/api/archives/foo-2.0.0.tar.gz') ==
                null;
      };

      await _invokeAdminAction('moderate-package', {
        'case': 'none',
        'package': 'foo',
        'state': 'true',
      });

      expect(gcsClearedAtInvalidation, isTrue);
      expect(
        fakeCdnInvalidator.invalidatedPaths,
        unorderedEquals([
          '/api/packages/foo',
          '/api/packages/foo/*',
          '/api/archives/foo-*',
          '/documentation/foo/*',
          '/packages/foo/*',
        ]),
      );

      // Reinstate a multi-version package: collapses subpaths and archives to
      // prefix wildcards.
      fakeCdnInvalidator.invalidatedPaths.clear();
      var gcsRestoredAtInvalidation = false;
      fakeCdnInvalidator.onInvalidate = (_) async {
        gcsRestoredAtInvalidation =
            await bucket.readGzippedJson('latest/api/packages/foo') != null &&
            await bucket.readBytes('latest/api/archives/foo-1.0.0.tar.gz') !=
                null &&
            await bucket.readBytes('latest/api/archives/foo-2.0.0.tar.gz') !=
                null;
      };

      await _invokeAdminAction('moderate-package', {
        'case': 'none',
        'package': 'foo',
        'state': 'false',
      });

      expect(gcsRestoredAtInvalidation, isTrue);
      expect(
        fakeCdnInvalidator.invalidatedPaths,
        unorderedEquals([
          '/api/packages/foo',
          '/api/packages/foo/*',
          '/api/archives/foo-*',
        ]),
      );

      // Admin soft-delete also invalidates all package paths.
      fakeCdnInvalidator.invalidatedPaths.clear();
      fakeCdnInvalidator.onInvalidate = null;
      await _invokeAdminAction('package-delete', {
        'package': 'foo',
        'state': 'true',
      });

      expect(
        fakeCdnInvalidator.invalidatedPaths,
        unorderedEquals([
          '/api/packages/foo',
          '/api/packages/foo/*',
          '/api/archives/foo-*',
          '/documentation/foo/*',
          '/packages/foo/*',
        ]),
      );
    },
  );

  testWithProfile(
    'exported-api-sync invalidates only for targeted packages, not ALL',
    testProfile: _testProfile,
    fn: () async {
      await apiExporter.synchronizeExportedApi();
      fakeCdnInvalidator.invalidatedPaths.clear();

      await _invokeAdminAction('exported-api-sync', {
        'packages': 'ALL',
        'force-write': 'true',
      });
      expect(fakeCdnInvalidator.invalidatedPaths, isEmpty);

      await _invokeAdminAction('exported-api-sync', {
        'packages': 'foo',
        'force-write': 'true',
      });
      expect(
        fakeCdnInvalidator.invalidatedPaths,
        unorderedEquals([
          '/api/packages/foo',
          '/api/packages/foo/*',
          '/api/archives/foo-*',
        ]),
      );
    },
  );

  testWithProfile(
    'moderating a version with build metadata invalidates percent-encoded archive path',
    testProfile: _testProfile,
    expectedLogMessages: [
      RegExp(
        r'SHOUT Deleting object from public bucket: ".*/api/archives/fresh_pkg-1.1.0\+1.tar.gz".',
      ),
    ],
    fn: () async {
      final bucket = storageService.bucket(
        activeConfiguration.exportedApiBucketName!,
      );
      await _uploadVersion('fresh_pkg', '1.0.0');
      await _uploadVersion('fresh_pkg', '1.1.0+1');
      fakeCdnInvalidator.invalidatedPaths.clear();

      var archiveMissingAtInvalidation = false;
      fakeCdnInvalidator.onInvalidate = (_) async {
        archiveMissingAtInvalidation =
            await bucket.readBytes(
              'latest/api/archives/fresh_pkg-1.1.0+1.tar.gz',
            ) ==
            null;
      };

      await _invokeAdminAction('moderate-package-version', {
        'case': 'none',
        'package': 'fresh_pkg',
        'version': '1.1.0+1',
        'state': 'true',
      });

      expect(archiveMissingAtInvalidation, isTrue);
      expect(
        fakeCdnInvalidator.invalidatedPaths,
        containsAll([
          '/api/packages/fresh_pkg',
          '/api/archives/fresh_pkg-1.1.0%2B1.tar.gz',
          '/api/packages/fresh_pkg/versions/1.1.0+1/archive.tar.gz',
          '/packages/fresh_pkg/versions/1.1.0+1.tar.gz',
          '/packages/fresh_pkg/versions/1.1.0+1/*',
          '/documentation/fresh_pkg/1.1.0+1/*',
          '/documentation/fresh_pkg/latest/*',
        ]),
      );
    },
  );

  testWithProfile(
    'deleting more than three versions collapses subpaths and archives without redundant rules',
    testProfile: _testProfile,
    expectedLogMessages: [
      RegExp(
        r'SHOUT Deleting object from public bucket: ".*/api/archives/foo-0\.1\.0\.tar\.gz".',
      ),
      RegExp(
        r'SHOUT Deleting object from public bucket: ".*/api/archives/foo-0\.2\.0\.tar\.gz".',
      ),
      RegExp(
        r'SHOUT Deleting object from public bucket: ".*/api/archives/foo-0\.3\.0\.tar\.gz".',
      ),
      RegExp(
        r'SHOUT Deleting object from public bucket: ".*/api/archives/foo-0\.4\.0\.tar\.gz".',
      ),
    ],
    fn: () async {
      final bucket = storageService.bucket(
        activeConfiguration.exportedApiBucketName!,
      );
      await apiExporter.synchronizeExportedApi();
      // Plant 4 stray archives and delete one subpath so changedSubpaths has
      // length 1 while deletedVersions has length 4.
      for (final v in ['0.1.0', '0.2.0', '0.3.0', '0.4.0']) {
        await bucket.writeBytes('latest/api/archives/foo-$v.tar.gz', [1, 2, 3]);
      }
      await bucket.delete('latest/api/packages/foo/feed.atom');
      fakeCdnInvalidator.invalidatedPaths.clear();

      await apiExporter.synchronizePackage(
        'foo',
        forceDelete: true,
        invalidateCdn: true,
      );

      expect(
        fakeCdnInvalidator.invalidatedPaths,
        unorderedEquals([
          '/api/packages/foo/*',
          '/api/archives/foo-*',
          '/documentation/foo/*',
          '/packages/foo/*',
        ]),
      );
    },
  );
}

extension on Bucket {
  Future<List<int>?> readBytes(String path) async {
    try {
      return await readAsBytes(path);
    } on DetailedApiRequestError catch (e) {
      if (e.status == 404) return null;
      rethrow;
    }
  }

  Future<Object?> readGzippedJson(String path) async {
    final bytes = await readBytes(path);
    if (bytes == null) {
      return null;
    }
    return utf8JsonDecoder.convert(gzip.decode(bytes));
  }
}
