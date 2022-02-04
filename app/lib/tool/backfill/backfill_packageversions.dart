// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

import 'package:pub_package_reader/pub_package_reader.dart';

import '../../package/backend.dart';
import '../../package/models.dart';
import '../../shared/datastore.dart';

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

/// Ensures a matching [PackageVersionInfo] entity exists for each [PackageVersion].
Future<BackfillStat> backfillAllVersionsOfPackage(
  String? package, {
  @visibleForTesting ArchiveResolver? archiveResolver,
}) async {
  _logger.info('Backfill PackageVersion[Pubspec|Info|Asset(s)] in: $package');

  final packageKey = dbService.emptyKey.append(Package, id: package);
  final query = dbService.query<PackageVersion>(ancestorKey: packageKey);
  final stats = <BackfillStat>[];
  final httpClient = http.Client();
  await for (final pv in query.run()) {
    archiveResolver ??= (p, v) => _parseArchive(httpClient, p, v, pv.created!);
    final archive = await archiveResolver(pv.package, pv.version!);
    final stat = await backfillPackageVersion(
      package: pv.package,
      version: pv.version,
      archive: archive,
      versionCreated: pv.created!,
    );
    stats.add(stat);
  }
  httpClient.close();
  return stats.reduce((a, b) => a + b);
}

Future<BackfillStat> backfillPackageVersion({
  required String? package,
  required String? version,
  required PackageSummary archive,
  required DateTime versionCreated,
}) async {
  _logger.info(
      'Backfill PackageVersion[Pubspec|Info|Asset(s)] in: $package/$version');
  if (archive.hasIssues) {
    _logger.warning('Issues were found in the archive: '
        '${archive.issues.map((e) => e.message).join('; ')}');
  }
  final derived = derivePackageVersionEntities(
    archive: archive,
    versionCreated: versionCreated,
  );
  final qualifiedVersionKey = derived.packageVersionInfo.qualifiedVersionKey;
  final existingAssetQuery = dbService.query<PackageVersionAsset>()
    ..filter('packageVersion =', qualifiedVersionKey.qualifiedVersion);
  final existingAssetKeys =
      await existingAssetQuery.run().map((a) => a.key).toList();

  return await withRetryTransaction(dbService, (tx) async {
    final pv = await tx.lookupValue<PackageVersion>(dbService.emptyKey
        .append(Package, id: package)
        .append(PackageVersion, id: version));
    final pvInfo = await tx.lookupOrNull<PackageVersionInfo>(dbService.emptyKey
        .append(PackageVersionInfo, id: derived.packageVersionInfo.id));
    final pvAssets = await tx.lookup<PackageVersionAsset>(existingAssetKeys);

    final inserts = <Model>[];
    final deletes = <Key>[];

    if (pv.updateIfChanged(pubspecContentAsYaml: archive.pubspecContent)) {
      inserts.add(pv);
    }

    if (pvInfo == null) {
      inserts.add(derived.packageVersionInfo);
    } else if (pvInfo.updateIfChanged(derived.packageVersionInfo)) {
      inserts.add(pvInfo);
    }

    // insert of update derived assets
    for (final derivedAsset in derived.assets) {
      final pvAsset = pvAssets.firstWhere(
          (a) => a!.assetId == derivedAsset.assetId,
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
            (asset) => !derived.assets.any((e) => e.assetId == asset!.assetId))
        .map((a) => a!.key));

    if (inserts.isNotEmpty || deletes.isNotEmpty) {
      tx.queueMutations(inserts: inserts, deletes: deletes);
    }
    return BackfillStat(
      versionCount: 1,
      pvCount: inserts.whereType<PackageVersion>().length,
      pvInfoCount: inserts.whereType<PackageVersionInfo>().length,
      pvAssetUpdatedCount: inserts.whereType<PackageVersionAsset>().length,
      pvAssetDeletedCount: deletes.length, // only assets are deleted
    );
  });
}

Future<PackageSummary> _parseArchive(
  http.Client httpClient,
  String? package,
  String? version,
  DateTime published,
) async {
  final fn = '$package-$version.tar.gz';
  final uri =
      Uri.parse('https://storage.googleapis.com/pub-packages/packages/$fn');
  final rs = await httpClient.get(uri);
  if (rs.statusCode != 200) {
    throw Exception('Unable to download: $uri');
  }
  final tempFile = File(p.join(Directory.systemTemp.path, fn));
  await tempFile.writeAsBytes(rs.bodyBytes);
  try {
    return await summarizePackageArchive(
      tempFile.path,
      maxContentLength: maxAssetContentLength,
      published: published,
    );
  } finally {
    await tempFile.delete();
  }
}

class BackfillStat {
  // package stat
  final int versionCount;
  // updated counts
  final int pvCount;
  final int pvInfoCount;
  final int pvAssetUpdatedCount;
  final int pvAssetDeletedCount;

  BackfillStat({
    required this.versionCount,
    required this.pvCount,
    required this.pvInfoCount,
    required this.pvAssetUpdatedCount,
    required this.pvAssetDeletedCount,
  });

  BackfillStat operator +(BackfillStat other) => BackfillStat(
        versionCount: versionCount + other.versionCount,
        pvCount: pvCount + other.pvCount,
        pvInfoCount: pvInfoCount + other.pvInfoCount,
        pvAssetUpdatedCount: pvAssetUpdatedCount + other.pvAssetUpdatedCount,
        pvAssetDeletedCount: pvAssetDeletedCount + other.pvAssetDeletedCount,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'versionCount': versionCount,
        'pvCount': pvCount,
        'pvInfoCount': pvInfoCount,
        'pvAssetUpdatedCount': pvAssetUpdatedCount,
        'pvAssetDeletedCount': pvAssetDeletedCount,
      };

  @override
  String toString() {
    return toJson().entries.map((e) => '${e.key}=${e.value}').join(' ');
  }
}
