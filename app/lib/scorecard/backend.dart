// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pool/pool.dart';
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:pub_dev/service/download_counts/computations.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/popularity_storage.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/models.dart';

import '../package/backend.dart';
import '../package/models.dart' show Package, PackageVersion, PackageView;
import '../package/overrides.dart';
import '../shared/datastore.dart' as db;
import '../shared/redis_cache.dart' show cache;
import '../shared/utils.dart';

import 'models.dart';

final _logger = Logger('pub.scorecard.backend');

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
  /// the latest finished version.
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

  /// Returns the [PackageView] instance for [package] on its "best" version:
  /// either loading the latest finished version, or if no analysis has been
  /// done yet, the latest stable version.
  ///
  /// Returns null if the package does not exists.
  @visibleForTesting
  Future<PackageView?> getPackageView(String package) async {
    return await cache.packageView(package).get(() async {
      final p = await packageBackend.lookupPackage(package);
      if (p == null) {
        _logger.warning('Package lookup failed for "$package".');
        return null;
      }

      final version = await taskBackend.latestFinishedVersion(package) ??
          await packageBackend.getLatestVersion(package);
      if (version == null) {
        return null;
      }

      final releases = await packageBackend.latestReleases(p);
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
        popularity: popularityStorage.lookupAsScore(package),
        thirtyDaysDownloadCounts:
            downloadCountsBackend.lookup30DaysTotalCounts(package),
      );
    });
  }

  /// Returns the latest finished [ScoreCardData] for the given [package].
  ///
  /// If no analysis has been finished for this package, the method loads
  /// the information for the latest version.
  Future<ScoreCardData> getLatestFinishedScoreCardData(String package) async {
    final version = await taskBackend.latestFinishedVersion(package) ??
        await packageBackend.getLatestVersion(package);
    if (version == null) {
      throw NotFoundException.resource('package "$package"');
    }
    return getScoreCardData(package, version);
  }

  /// Returns the [ScoreCardData] for the given package and version.
  Future<ScoreCardData> getScoreCardData(
    String packageName,
    String packageVersion, {
    Package? package,
  }) async {
    InvalidInputException.check(
        packageVersion != 'latest', 'latest is no longer supported');
    final cacheEntry = cache.scoreCardData(packageName, packageVersion);
    final cached = await cacheEntry.get();
    if (cached != null) {
      return cached;
    }

    package ??= await packageBackend.lookupPackage(packageName);
    if (package == null) {
      throw NotFoundException('Package "$packageName" does not exist.');
    }
    if (package.isNotVisible) {
      throw ModeratedException.package(packageName);
    }
    final version =
        await packageBackend.lookupPackageVersion(packageName, packageVersion);
    if (version == null) {
      throw NotFoundException(
          'Package version "$packageName $packageVersion" does not exist.');
    }
    if (version.isModerated) {
      throw ModeratedException.packageVersion(packageName, packageVersion);
    }
    final status = PackageStatus.fromModels(package, version);
    final summary = await taskBackend.panaSummary(packageName, packageVersion);
    final stateInfo = await taskBackend.packageStatus(packageName);
    final versionInfo = stateInfo.versions[packageVersion];
    final hasDartdocFile = versionInfo?.docs ?? false;

    var taskStatus = versionInfo?.status;
    // There is a small risk that the task backend's state is not yet updated
    // for the latest stable version (stale cache). We can be sure that in such
    // cases it will be scheduled eventually for analysis and `pending` status
    // is the right fallback value here.
    if (taskStatus == null && package.latestVersion == version.version) {
      taskStatus = PackageVersionStatus.pending;
    }

    final weeklyVersionDownloads = await getWeeklyVersionDownloads(packageName);

    final data = ScoreCardData(
      packageName: packageName,
      packageVersion: packageVersion,
      runtimeVersion: stateInfo.runtimeVersion,
      updated: summary?.createdAt ?? version.created,
      dartdocReport: DartdocReport(
        reportStatus:
            hasDartdocFile ? ReportStatus.success : ReportStatus.failed,
      ),
      panaReport: PanaReport.fromSummary(summary, packageStatus: status),
      taskStatus: taskStatus,
      weeklyVersionDownloads: weeklyVersionDownloads,
    );
    await cacheEntry.set(data);
    return data;
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
