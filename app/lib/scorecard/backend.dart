// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pool/pool.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/task/backend.dart';

import '../package/backend.dart';
import '../package/models.dart' show Package, PackageVersion, PackageView;
import '../package/overrides.dart';
import '../shared/datastore.dart' as db;
import '../shared/redis_cache.dart' show cache;
import '../shared/utils.dart';
import '../shared/versions.dart' as versions;

import 'models.dart';

final _logger = Logger('pub.scorecard.backend');

final Duration _deleteThreshold = const Duration(days: 182);

/// Sets the active scorecard backend.
void registerScoreCardBackend(ScoreCardBackend backend) =>
    ss.register(#_scorecard_backend, backend);

/// The active job backend.
ScoreCardBackend get scoreCardBackend =>
    ss.lookup(#_scorecard_backend) as ScoreCardBackend;

/// Handles the data store and lookup for ScoreCard.
class ScoreCardBackend {
  final db.DatastoreDB _db;

  /// Concurrency control to get [PackageView] entities from the cache or Datastore.
  final _packageViewGetterPool = Pool(10);

  /// Concurrency control to get [ScoreCardData] from the Datastore.
  final _scoreCardDataPool = Pool(10);

  ScoreCardBackend(this._db);

  Future<void> close() async {
    await _packageViewGetterPool.close();
    await _scoreCardDataPool.close();
  }

  /// Returns the [PackageView] instance for each package in [packages], using
  /// the latest stable version.
  ///
  /// If the package does not exist, it will return null in the given index.
  Future<List<PackageView?>> getPackageViews(Iterable<String> packages) async {
    final futures = <Future<PackageView?>>[];
    for (final p in packages) {
      futures.add(
          _packageViewGetterPool.withResource(() async => getPackageView(p)));
    }
    return await Future.wait(futures);
  }

  /// Returns the [PackageView] instance for [package] on its latest stable version.
  ///
  /// Returns null if the package does not exists.
  Future<PackageView?> getPackageView(String package) async {
    return await cache.packageView(package).get(() async {
      final p = await packageBackend.lookupPackage(package);
      if (p == null) {
        _logger.warning('Package lookup failed for "$package".');
        return null;
      }

      final releases = await packageBackend.latestReleases(p);
      final version = releases.stable.version;
      final pvFuture = packageBackend.lookupPackageVersion(package, version);
      final cardFuture = scoreCardBackend.getScoreCardData(package, version);
      await Future.wait([pvFuture, cardFuture]);

      final pv = await pvFuture;
      final card = await cardFuture;
      return PackageView.fromModel(
        package: p,
        releases: releases,
        version: pv,
        scoreCard: card,
      );
    });
  }

  /// Returns the [ScoreCardData] for the given package and version.
  Future<ScoreCardData?> getScoreCardData(
    String packageName,
    String? packageVersion, {
    bool onlyCurrent = false,
  }) async {
    if (packageVersion == null || packageVersion == 'latest') {
      packageVersion = await packageBackend.getLatestVersion(packageName);
      if (packageVersion == null) {
        // package does not exists
        return null;
      }
    }
    final cacheEntry =
        onlyCurrent ? null : cache.scoreCardData(packageName, packageVersion);
    if (cacheEntry != null) {
      final cached = await cacheEntry.get();
      if (cached != null && cached.hasAllReports) {
        return cached;
      }
    }

    final package = await packageBackend.lookupPackage(packageName);
    if (package == null) {
      throw NotFoundException('Package "$packageName" does not exist.');
    }
    final version =
        await packageBackend.lookupPackageVersion(packageName, packageVersion);
    if (version == null) {
      throw NotFoundException(
          'Package version "$packageName $packageVersion" does not exist.');
    }
    final status = PackageStatus.fromModels(package, version);
    final summary = await taskBackend.panaSummary(packageName, packageVersion);
    final stateInfo = await taskBackend.packageStatus(packageName);
    final versionInfo = stateInfo.versions[packageVersion];
    final hasDartdocFile = versionInfo?.docs ?? false;

    final data = ScoreCardData(
      packageName: packageName,
      packageVersion: packageVersion,
      // this is unused outside scorecard backend, and a bit wrong:
      runtimeVersion: stateInfo.runtimeVersion,
      updated: summary?.createdAt ?? version.created,
      packageCreated: package.created,
      packageVersionCreated: version.created,
      dartdocReport: DartdocReport(
        timestamp: summary?.createdAt ?? version.created,
        reportStatus:
            hasDartdocFile ? ReportStatus.success : ReportStatus.failed,
        dartdocEntry: null, // unused
        documentationSection: null, // already embedded in summary
      ),
      panaReport: PanaReport.fromSummary(summary, packageStatus: status),
      taskStatus: versionInfo?.status,
    );
    if (cacheEntry != null) {
      await cacheEntry.set(data);
    }
    return data;
  }

  /// Deletes the old entries that predate [versions.gcBeforeRuntimeVersion].
  Future<void> deleteOldEntries() async {
    final now = clock.now();
    await _db.deleteWithQuery(_db.query<ScoreCard>()
      ..filter('runtimeVersion <', versions.gcBeforeRuntimeVersion));
    await _db.deleteWithQuery(_db.query<ScoreCard>()
      ..filter('updated <', now.subtract(_deleteThreshold)));
  }

  /// Returns the status of a package and version.
  Future<PackageStatus> getPackageStatus(String package, String version) async {
    final packageKey = _db.emptyKey.append(Package, id: package);
    final list = await _db
        .lookup([packageKey, packageKey.append(PackageVersion, id: version)]);
    final p = list[0] as Package?;
    final pv = list[1] as PackageVersion?;
    return PackageStatus.fromModels(p, pv);
  }
}

Future<void> purgeScorecardData(
  String package,
  String version, {
  required bool isLatest,
}) async {
  await Future.wait([
    cache.scoreCardData(package, version).purge(),
    cache.uiPackagePage(package, version).purge(),
    if (isLatest) cache.uiPackagePage(package, null).purge(),
    if (isLatest) cache.packageView(package).purge(),
  ]);
}

class PackageStatus {
  final bool exists;
  final DateTime? publishDate;
  final Duration? age;
  final bool isLatestStable;
  final bool isDiscontinued;
  final bool isObsolete;
  final bool isLegacy;
  final bool isDart3Incompatible;
  final bool usesFlutter;
  final bool usesPreviewAnalysisSdk;
  final bool isPublishedByDartDev;

  PackageStatus._({
    required this.exists,
    this.publishDate,
    this.age,
    this.isLatestStable = false,
    this.isDiscontinued = false,
    this.isObsolete = false,
    this.isLegacy = false,
    this.isDart3Incompatible = false,
    this.usesFlutter = false,
    this.usesPreviewAnalysisSdk = false,
    this.isPublishedByDartDev = false,
  });

  factory PackageStatus.fromModels(Package? p, PackageVersion? pv) {
    if (p == null || pv == null || p.isNotVisible) {
      return PackageStatus._(exists: false);
    }
    final publishDate = pv.created!;
    final isLatestStable = p.latestVersion == pv.version;
    final now = clock.now().toUtc();
    final age = now.difference(publishDate).abs();
    final isObsolete = age > twoYears && !isLatestStable;
    return PackageStatus._(
      exists: true,
      publishDate: publishDate,
      age: age,
      isLatestStable: isLatestStable,
      isDiscontinued: p.isDiscontinued,
      isObsolete: isObsolete,
      isLegacy: pv.pubspec!.supportsOnlyLegacySdk,
      isDart3Incompatible: pv.pubspec!.isDart3Incompatible,
      usesFlutter: pv.pubspec!.usesFlutter,
      usesPreviewAnalysisSdk: pv.pubspec!.usesPreviewAnalysisSdk(),
      isPublishedByDartDev:
          p.publisherId != null && isDartDevPublisher(p.publisherId),
    );
  }
}
