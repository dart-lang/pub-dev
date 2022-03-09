// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/model_properties.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:pub_dev/tool/backfill/backfill_packageversions.dart';
import 'package:pub_package_reader/pub_package_reader.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('backfill package version from archive', () {
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
        final readme = (await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.2.0',
          AssetKind.readme,
        ))!;
        final stat = await backfillAllVersionsOfPackage(
          'oxygen',
          archiveResolver: _archive,
        );
        expect(
          stat.toJson(),
          {
            'versionCount': 3,
            'pvCount': 0,
            'pvInfoCount': 0,
            'pvAssetUpdatedCount': 0,
            'pvAssetDeletedCount': 0
          },
        );
        final readme2 = (await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.2.0',
          AssetKind.readme,
        ))!;
        expect(readme2.textContent, readme.textContent);
      },
    );

    testWithProfile(
      'Create info and change assets',
      fn: () async {
        final info =
            (await packageBackend.lookupPackageVersionInfo('oxygen', '1.2.0'))!;

        final readme = (await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.2.0',
          AssetKind.readme,
        ))!;
        await dbService.commit(deletes: [info.key, readme.key]);

        final stat = await backfillAllVersionsOfPackage(
          'oxygen',
          archiveResolver: _archive,
        );

        expect(
          stat.toJson(),
          {
            'versionCount': 3,
            'pvCount': 0,
            'pvInfoCount': 1,
            'pvAssetUpdatedCount': 1,
            'pvAssetDeletedCount': 0
          },
        );

        final info2 =
            (await packageBackend.lookupPackageVersionInfo('oxygen', '1.2.0'))!;
        expect(info2.versionCreated, info.versionCreated);
        expect(info2.assetCount, info.assetCount);
        expect(info2.assets, info.assets);

        final readme2 = (await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.2.0',
          AssetKind.readme,
        ))!;
        expect(readme2.textContent, readme.textContent);
      },
    );

    testWithProfile(
      'Update pubspec in PackageVersion and in PackageVersionAsset',
      fn: () async {
        final pv =
            (await packageBackend.lookupPackageVersion('oxygen', '1.2.0'))!;
        final asset = (await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.2.0',
          AssetKind.pubspec,
        ))!;
        final originalPvContent = pv.pubspec!.jsonString;
        final originalAssetContent = asset.textContent;

        // Inject non-normalized version number in the pubspec asset.
        // This ensures that we can cleanup from:
        // https://github.com/dart-lang/pub_semver/pull/63
        pv.pubspec = Pubspec.fromYaml('name: x');
        asset.textContent = 'name: x\nversion: 1,2,3\n';
        await dbService.commit(inserts: [pv, asset]);

        final stat = await backfillAllVersionsOfPackage(
          'oxygen',
          archiveResolver: _archive,
        );

        expect(
          stat.toJson(),
          {
            'versionCount': 3,
            'pvCount': 1,
            'pvInfoCount': 0,
            'pvAssetUpdatedCount': 1,
            'pvAssetDeletedCount': 0
          },
        );

        final pv2 =
            (await packageBackend.lookupPackageVersion('oxygen', '1.2.0'))!;
        final asset2 = (await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.2.0',
          AssetKind.pubspec,
        ))!;

        expect(pv2.pubspec!.jsonString, originalPvContent);
        expect(asset2.textContent, originalAssetContent);
      },
    );
  });

  group('known backfill', () {
    test('built_value 5.2.0', () async {
      final rs = await http.get(Uri.parse(
          'https://pub.dev/packages/built_value/versions/5.2.0.tar.gz'));
      expect(rs.statusCode, 200);
      await withTempDirectory((d) async {
        final file = File(p.join(d.path, 'archive.tar.gz'));
        await file.writeAsBytes(rs.bodyBytes);
        final archive = await summarizePackageArchive(
          file.path,
          published: DateTime(2020, 1, 1),
        );
        expect(archive.pubspecContent, isNot(contains('>=2-0-0-dev')));
        expect(archive.pubspecContent, contains('>=2.0.0-dev'));
        expect(archive.hasIssues, false);
      });
    });
  });
}
