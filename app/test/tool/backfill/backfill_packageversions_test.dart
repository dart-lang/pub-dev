// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:pub_dev/tool/backfill/backfill_packageversions.dart';
import 'package:pub_package_reader/pub_package_reader.dart';

import '../../shared/test_services.dart';

void main() {
  group('normalization tests', () {
    Future<PackageSummary> _archive(String package, String version) async {
      return await withTempDirectory((dir) async {
        final file = File('${dir.path}/archive.tar.gz');
        final stream = packageBackend.download(package, version);
        await stream.pipe(file.openWrite());
        return await summarizePackageArchive(file.path);
      });
    }

    testWithProfile(
      'No updated needed',
      fn: () async {
        final readme = await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.2.0',
          AssetKind.readme,
        );
        final stat = await backfillAllVersionsOfPackage(
          'oxygen',
          archiveResolver: _archive,
        );
        expect(
          stat.toJson(),
          {
            'versionCount': 3,
            'pvInfoCount': 0,
            'pvAssetUpdatedCount': 0,
            'pvAssetDeletedCount': 0
          },
        );
        final readme2 = await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.2.0',
          AssetKind.readme,
        );
        expect(readme2.textContent, readme.textContent);
      },
    );

    testWithProfile(
      'Create info and change assets',
      fn: () async {
        final info =
            await packageBackend.lookupPackageVersionInfo('oxygen', '1.2.0');

        final readme = await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.2.0',
          AssetKind.readme,
        );
        await dbService.commit(deletes: [info.key, readme.key]);

        final stat = await backfillAllVersionsOfPackage(
          'oxygen',
          archiveResolver: _archive,
        );

        expect(
          stat.toJson(),
          {
            'versionCount': 3,
            'pvInfoCount': 1,
            'pvAssetUpdatedCount': 1,
            'pvAssetDeletedCount': 0
          },
        );

        final info2 =
            await packageBackend.lookupPackageVersionInfo('oxygen', '1.2.0');
        expect(info2.versionCreated, info.versionCreated);
        expect(info2.assetCount, info.assetCount);
        expect(info2.assets, info.assets);

        final readme2 = await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.2.0',
          AssetKind.readme,
        );
        expect(readme2.textContent, readme.textContent);
      },
    );
  });
}
