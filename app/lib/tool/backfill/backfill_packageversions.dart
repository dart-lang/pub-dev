// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

import 'package:pub_package_reader/pub_package_reader.dart';

import '../../package/backend.dart';
import '../../package/models.dart';

final _logger = Logger('backfill.packageversions');

/// Calls [backfillAllVersionsOfPackage] for each [Package], with a configurable
/// [concurrency].
Future<BackfillStat> backfillAllVersionsOfPackages(int concurrency) async {
  final pool = Pool(concurrency);
  final futures = <Future<BackfillStat>>[];

  await for (Package p in dbService.query<Package>().run()) {
    final f = pool.withResource(() => backfillAllVersionsOfPackage(p.name));
    futures.add(f);
  }

  final stats = await Future.wait(futures);
  await pool.close();
  return stats.reduce((a, b) => a + b);
}

typedef ArchiveResolver = Future<PackageSummary> Function(
    String package, String version);

/// Ensures a matching [PackageVersionPubspec] entity exists for each [PackageVersion]
/// Ensures a matching [PackageVersionInfo] entity exists for each [PackageVersion].
Future<BackfillStat> backfillAllVersionsOfPackage(
  String package, {
  @visibleForTesting ArchiveResolver archiveResolver,
}) async {
  _logger.info('Backfill PackageVersion[Pubspec|Info|Asset(s)] in: $package');

  final packageKey = dbService.emptyKey.append(Package, id: package);
  final query = dbService.query<PackageVersion>(ancestorKey: packageKey);
  final stats = <BackfillStat>[];
  final httpClient = http.Client();
  archiveResolver ??= (p, v) => _parseArchive(httpClient, p, v);
  await for (PackageVersion pv in query.run()) {
    final archive = await archiveResolver(pv.package, pv.version);
    final stat = await backfillPackageVersion(
      package: pv.package,
      version: pv.version,
      archive: archive,
      versionCreated: pv.created,
    );
    stats.add(stat);
  }
  httpClient.close();
  return stats.reduce((a, b) => a + b);
}

Future<BackfillStat> backfillPackageVersion({
  @required String package,
  @required String version,
  @required PackageSummary archive,
  @required DateTime versionCreated,
}) async {
  _logger.info(
      'Backfill PackageVersion[Pubspec|Info|Asset(s)] in: $package/$version');
  final derived = derivePackageVersionEntities(
    archive: archive,
    versionCreated: versionCreated,
  );
  final qualifiedVersionKey = derived.packageVersionInfo.qualifiedVersionKey;
  final existingAssetQuery = dbService.query<PackageVersionAsset>()
    ..filter('packageVersion =', qualifiedVersionKey.qualifiedVersion);
  final existingAssetKeys =
      await existingAssetQuery.run().map((a) => a.key).toList();

  return await dbService.withTransaction((tx) async {
    final pvPubspec = await tx.lookupValue<PackageVersionPubspec>(
        dbService.emptyKey.append(PackageVersionPubspec,
            id: derived.packageVersionPubspec.id),
        orElse: () => null);
    final pvInfo = await tx.lookupValue<PackageVersionInfo>(
      dbService.emptyKey
          .append(PackageVersionInfo, id: derived.packageVersionInfo.id),
      orElse: () => null,
    );
    final pvAssets = await tx.lookup<PackageVersionAsset>(existingAssetKeys);

    final inserts = <Model>[];
    final deletes = <Key>[];

    if (pvPubspec == null) {
      inserts.add(derived.packageVersionPubspec);
    } else if (pvPubspec.updateIfChanged(derived.packageVersionPubspec)) {
      inserts.add(pvPubspec);
    }

    if (pvInfo == null) {
      inserts.add(derived.packageVersionInfo);
    } else if (pvInfo.updateIfChanged(derived.packageVersionInfo)) {
      inserts.add(pvInfo);
    }

    // insert of update derived assets
    for (final derivedAsset in derived.assets) {
      final pvAsset = pvAssets.firstWhere(
          (a) => a.assetId == derivedAsset.assetId,
          orElse: () => null);
      if (pvAsset == null) {
        inserts.add(derivedAsset);
      } else if (pvAsset.updateIfChanged(derivedAsset)) {
        inserts.add(pvAsset);
      }
    }

    // remove assets that are no longer derived
    deletes.addAll(pvAssets
        .where(
            (asset) => !derived.assets.any((e) => e.assetId == asset.assetId))
        .map((a) => a.key));

    if (inserts.isNotEmpty || deletes.isNotEmpty) {
      tx.queueMutations(inserts: inserts, deletes: deletes);
    }
    await tx.commit();
    return BackfillStat(
      versionCount: 1,
      pvPubspecCount: inserts.whereType<PackageVersionPubspec>().length,
      pvInfoCount: inserts.whereType<PackageVersionInfo>().length,
      pvAssetUpdatedCount: inserts.whereType<PackageVersionAsset>().length,
      pvAssetDeletedCount: deletes.length, // only assets are deleted
    );
  });
}

Future<PackageSummary> _parseArchive(
    http.Client httpClient, String package, String version) async {
  final fn = '$package-$version.tar.gz';
  final uri = 'https://storage.googleapis.com/pub-packages/packages/$fn';
  final rs = await httpClient.get(uri);
  if (rs.statusCode != 200) {
    throw Exception('Unable to download: $uri');
  }
  final tempFile = File(p.join(Directory.systemTemp.path, fn));
  await tempFile.writeAsBytes(rs.bodyBytes);
  try {
    return await summarizePackageArchive(tempFile.path);
  } finally {
    await tempFile.delete();
  }
}

class BackfillStat {
  // package stat
  final int versionCount;
  // updated counts
  final int pvPubspecCount;
  final int pvInfoCount;
  final int pvAssetUpdatedCount;
  final int pvAssetDeletedCount;

  BackfillStat({
    @required this.versionCount,
    @required this.pvPubspecCount,
    @required this.pvInfoCount,
    @required this.pvAssetUpdatedCount,
    @required this.pvAssetDeletedCount,
  });

  BackfillStat operator +(BackfillStat other) => BackfillStat(
        versionCount: versionCount + other.versionCount,
        pvInfoCount: pvInfoCount + other.pvInfoCount,
        pvPubspecCount: pvPubspecCount + other.pvPubspecCount,
        pvAssetUpdatedCount: pvAssetUpdatedCount + other.pvAssetUpdatedCount,
        pvAssetDeletedCount: pvAssetDeletedCount + other.pvAssetDeletedCount,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'versionCount': versionCount,
        'pvPubspecCount': pvPubspecCount,
        'pvInfoCount': pvInfoCount,
        'pvAssetUpdatedCount': pvAssetUpdatedCount,
        'pvAssetDeletedCount': pvAssetDeletedCount,
      };

  @override
  String toString() {
    return toJson().entries.map((e) => '${e.key}=${e.value}').join(' ');
  }
}
