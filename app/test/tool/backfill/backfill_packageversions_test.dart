// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/tool/backfill/backfill_packageversions.dart';
import 'package:pub_package_reader/pub_package_reader.dart';

import '../../shared/test_models.dart';
import '../../shared/test_services.dart';

void main() {
  group('normalization tests', () {
    Future<PackageSummary> _archive(String package, String version) async {
      return PackageSummary(
        pubspecContent: 'name: $package\nversion: $version\n',
        libraries: ['$package.dart'],
        readmePath: 'README.md',
        readmeContent: '# $package\n\nA dart package',
      );
    }

    Future<void> _updateModels() async {
      // Entries in the test were not extracted the same way we are doing here.
      // TODO: make sure test entries follow the same pattern and remove this method.
      final stat = await backfillAllVersionsOfPackage(
        'hydrogen',
        archiveResolver: _archive,
      );
      expect(
        stat.toJson(),
        {
          'versionCount': 13,
          'pvPubspecCount': 13,
          'pvInfoCount': 13,
          'pvAssetUpdatedCount': 26,
          // TODO: fix test models and don't delete here
          'pvAssetDeletedCount': 22,
        },
      );
    }

    testWithServices('second time no update', () async {
      await _updateModels();
      // second time there should be no update
      final stats = await backfillAllVersionsOfPackage(
        'hydrogen',
        archiveResolver: _archive,
      );
      expect(
        stats.toJson(),
        {
          'versionCount': 13,
          'pvPubspecCount': 0,
          'pvInfoCount': 0,
          'pvAssetUpdatedCount': 0,
          'pvAssetDeletedCount': 0,
        },
      );
      final query = dbService.query<PackageVersionAsset>()
        ..filter('package =', 'hydrogen');
      final assets = await query.run().toList();
      assets.sort((a, b) => a.assetId.compareTo(b.assetId));
      final summary = assets.take(4).fold(
          {},
          (map, a) => {
                ...map,
                a.assetId: {
                  'path': a.path,
                  'length': a.textContent.length,
                }
              });
      expect(summary, {
        'hydrogen/1.0.0/pubspec': {'path': 'pubspec.yaml', 'length': 30},
        'hydrogen/1.0.0/readme': {'path': 'README.md', 'length': 26},
        'hydrogen/1.0.9/pubspec': {'path': 'pubspec.yaml', 'length': 30},
        'hydrogen/1.0.9/readme': {'path': 'README.md', 'length': 26},
      });
    });

    testWithServices('info missing', () async {
      await _updateModels();
      final lastId =
          hydrogen.versions.last.qualifiedVersionKey.qualifiedVersion;
      await dbService.commit(deletes: [
        dbService.emptyKey.append(PackageVersionInfo, id: lastId),
      ]);
      final stats = await backfillAllVersionsOfPackage(
        'hydrogen',
        archiveResolver: _archive,
      );
      expect(
        stats.toJson(),
        {
          'versionCount': 13,
          'pvPubspecCount': 0,
          'pvInfoCount': 1,
          'pvAssetUpdatedCount': 0,
          'pvAssetDeletedCount': 0,
        },
      );
    });

    testWithServices('asset missing', () async {
      await _updateModels();
      final lastId =
          hydrogen.versions.last.qualifiedVersionKey.qualifiedVersion;
      await dbService.commit(deletes: [
        dbService.emptyKey.append(PackageVersionAsset, id: '$lastId/readme')
      ]);
      final stats = await backfillAllVersionsOfPackage(
        'hydrogen',
        archiveResolver: _archive,
      );
      expect(
        stats.toJson(),
        {
          'versionCount': 13,
          'pvPubspecCount': 0,
          'pvInfoCount': 0,
          'pvAssetUpdatedCount': 1,
          'pvAssetDeletedCount': 0,
        },
      );
    });
  });
}
