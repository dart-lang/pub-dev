// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pool/pool.dart';

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

/// Ensures a matching [PackageVersionPubspec] entity exists for each [PackageVersion]
/// Ensures a matching [PackageVersionInfo] entity exists for each [PackageVersion].
Future<BackfillStat> backfillAllVersionsOfPackage(String package) async {
  _logger.info('Backfill PackageVersion[Pubspec|Info] in: $package');

  final packageKey = dbService.emptyKey.append(Package, id: package);
  final query = dbService.query<PackageVersion>(ancestorKey: packageKey);
  int versionCount = 0;
  int pvInfoCount = 0;
  int pvPubspecCount = 0;
  await for (PackageVersion pv in query.run()) {
    versionCount++;
    final qualifiedKey =
        QualifiedVersionKey(package: pv.package, version: pv.version);

    final pvPubspecKey = dbService.emptyKey
        .append(PackageVersionPubspec, id: qualifiedKey.qualifiedVersion);
    final pvInfoKey = dbService.emptyKey
        .append(PackageVersionInfo, id: qualifiedKey.qualifiedVersion);

    final items = await dbService.lookup([pvPubspecKey, pvInfoKey]);
    final inserts = <Model>[];
    if (items[0] == null) {
      pvPubspecCount++;
      inserts.add(PackageVersionPubspec()
        ..initFromKey(qualifiedKey)
        ..pubspec = pv.pubspec
        ..updated = pv.created);
    }
    if (items[1] == null) {
      pvInfoCount++;
      inserts.add(PackageVersionInfo()
        ..initFromKey(qualifiedKey)
        ..libraries = pv.libraries
        ..libraryCount = pv.libraries.length
        ..updated = pv.created);
    }
    if (inserts.isNotEmpty) {
      await dbService.commit(inserts: inserts);
    }
  }
  return BackfillStat(
    versionCount: versionCount,
    pvPubspecCount: pvPubspecCount,
    pvInfoCount: pvInfoCount,
  );
}

class BackfillStat {
  // package stat
  final int versionCount;
  // updated counts
  final int pvPubspecCount;
  final int pvInfoCount;

  BackfillStat({
    @required this.versionCount,
    @required this.pvPubspecCount,
    @required this.pvInfoCount,
  });

  BackfillStat operator +(BackfillStat other) => BackfillStat(
        versionCount: versionCount + other.versionCount,
        pvInfoCount: pvInfoCount + other.pvInfoCount,
        pvPubspecCount: pvPubspecCount + other.pvPubspecCount,
      );
}
