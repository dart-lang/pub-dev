// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_semver/pub_semver.dart';

import '../package/models.dart' show Package, PackageVersion;
import '../package/overrides.dart';
import '../shared/datastore.dart' as db;
import '../shared/popularity_storage.dart';
import '../shared/redis_cache.dart' show cache;
import '../shared/utils.dart';
import '../shared/versions.dart' as versions;
import '../tool/utils/dart_sdk_version.dart';

import 'helpers.dart';
import 'models.dart';

export 'models.dart';

final _logger = Logger('pub.scorecard.backend');

final Duration _deleteThreshold = const Duration(days: 182);

/// The minimum age of the [PackageVersion] which will trigger a fallback to
/// older scorecards. Below this age we only display the current [ScoreCard].
final _fallbackMinimumAge = const Duration(hours: 4);

/// The maximum number of keys we'll try to lookup when we need to load the
/// scorecard or the report information for multiple versions.
///
/// The Datastore limit is 1000, but that caused resource constraint issues
/// https://github.com/dart-lang/pub-dev/issues/4040
const _batchLookupMaxKeyCount = 100;

/// Sets the active scorecard backend.
void registerScoreCardBackend(ScoreCardBackend backend) =>
    ss.register(#_scorecard_backend, backend);

/// The active job backend.
ScoreCardBackend get scoreCardBackend =>
    ss.lookup(#_scorecard_backend) as ScoreCardBackend;

/// Handles the data store and lookup for ScoreCard.
class ScoreCardBackend {
  final db.DatastoreDB _db;
  ScoreCardBackend(this._db);

  /// Returns the [ScoreCardData] for the given package and version.
  Future<ScoreCardData> getScoreCardData(
    String packageName,
    String packageVersion, {
    bool onlyCurrent = false,
  }) async {
    final requiredReportTypes = ReportType.values;
    if (packageVersion == null || packageVersion == 'latest') {
      final key = _db.emptyKey.append(Package, id: packageName);
      final ps = await _db.lookup([key]);
      final p = ps.single as Package;
      if (p == null) {
        return null;
      }
      packageVersion = p.latestVersion;
    }
    final cached = onlyCurrent
        ? null
        : await cache.scoreCardData(packageName, packageVersion).get();
    if (cached != null && cached.hasReports(requiredReportTypes)) {
      return cached;
    }

    final key = scoreCardKey(packageName, packageVersion);
    final current = (await _db.lookup<ScoreCard>([key])).single?.toData();
    if (current != null) {
      // only full cards will be stored in cache
      if (current.isCurrent && current.hasReports(ReportType.values)) {
        await cache.scoreCardData(packageName, packageVersion).set(current);
      }
      if (onlyCurrent || current.hasReports(requiredReportTypes)) {
        return current;
      }
    }

    if (onlyCurrent) return null;

    // List cards that at minimum have a pana report.
    final fallbackKeys = versions.fallbackRuntimeVersions
        .map(
            (v) => scoreCardKey(packageName, packageVersion, runtimeVersion: v))
        .toList();
    final fallbackCards = await _db.lookup<ScoreCard>(fallbackKeys);
    final fallbackCardData =
        fallbackCards.where((c) => c != null).map((c) => c.toData()).toList();

    if (fallbackCardData.isEmpty) return null;

    final fallbackCard = fallbackCardData.firstWhere(
      (d) => d.hasReports(requiredReportTypes),
      orElse: () => fallbackCardData.firstWhere(
        (d) => d.hasReports([ReportType.pana]),
        orElse: () => null,
      ),
    );

    // For recently uploaded version, we don't want to fallback to an analysis
    // coming from an older running deployment too early. A new analysis may
    // come soon from the current runtime, and if it is different in significant
    // ways (e.g. score or success status differs), it may confuse users looking
    // at it in the interim period.
    //
    // However, once the upload is above the specified age, it is better to
    // display and old analysis than to keep waiting on a new one.
    if (fallbackCard != null) {
      final age = DateTime.now().difference(fallbackCard.packageVersionCreated);
      if (age < _fallbackMinimumAge) {
        return null;
      }
    }
    return fallbackCard;
  }

  /// Creates or updates a [ScoreCardReport] entry with the report's [data].
  /// The [data] will be converted to json and stored as a byte in the report
  /// entry.
  Future<void> updateReport(
      String packageName, String packageVersion, ReportData data) async {
    final key = scoreCardKey(packageName, packageVersion)
        .append(ScoreCardReport, id: data.reportType);
    await db.withRetryTransaction(_db, (tx) async {
      var report =
          await tx.lookupValue<ScoreCardReport>(key, orElse: () => null);
      if (report != null) {
        _logger.info(
            'Updating report: $packageName $packageVersion ${data.reportType}.');
        report
          ..updated = DateTime.now().toUtc()
          ..reportStatus = data.reportStatus
          ..reportJson = data.toJson();
      } else {
        _logger.info(
            'Creating new report: $packageName $packageVersion ${data.reportType}.');
        report = ScoreCardReport.init(
          packageName: packageName,
          packageVersion: packageVersion,
          reportData: data,
        );
      }
      tx.insert(report);
    });
  }

  /// Load and deserialize the reports for the given package and version.
  Future<Map<String, ReportData>> loadReports(
    String packageName,
    String packageVersion, {
    List<String> reportTypes,
    String runtimeVersion,
  }) async {
    reportTypes ??= [ReportType.pana, ReportType.dartdoc];
    final key = scoreCardKey(packageName, packageVersion,
        runtimeVersion: runtimeVersion);

    final list = await _db.lookup(reportTypes
        .map((type) => key.append(ScoreCardReport, id: type))
        .toList());

    final result = <String, ReportData>{};
    for (db.Model model in list) {
      if (model == null) continue;
      final report = model as ScoreCardReport;
      result[report.reportType] = report.reportData;
    }
    return result;
  }

  /// Load and deserialize a specific report type for the given package's versions.
  Future<List<ReportData>> loadReportForAllVersions(
    String packageName,
    Iterable<String> versions, {
    @required String reportType,
    String runtimeVersion,
  }) async {
    final results = <ReportData>[];
    for (var start = 0;
        start < versions.length;
        start += _batchLookupMaxKeyCount) {
      final keys = versions
          .skip(start)
          .take(_batchLookupMaxKeyCount)
          .map((v) =>
              scoreCardKey(packageName, v, runtimeVersion: runtimeVersion)
                  .append(ScoreCardReport, id: reportType))
          .toList();
      final items = await _db.lookup<ScoreCardReport>(keys);
      results.addAll(items.map((item) => item?.reportData));
    }
    return results;
  }

  /// Updates the [ScoreCard] entry, reading both the package and version data,
  /// alongside the data from reports, and compiles a new summary of them.
  Future<void> updateScoreCard(
      String packageName, String packageVersion) async {
    final key = scoreCardKey(packageName, packageVersion);
    final pAndPv = await _db.lookup([key.parent, key.parent.parent]);
    final version = pAndPv[0] as PackageVersion;
    final package = pAndPv[1] as Package;
    if (package == null || version == null) {
      throw Exception('Unable to lookup $packageName $packageVersion.');
    }

    final currentSdkVersion = await getDartSdkVersion();
    final status = PackageStatus.fromModels(
        package, version, currentSdkVersion.semanticVersion);
    final reports = await loadReports(packageName, packageVersion);

    await db.withRetryTransaction(_db, (tx) async {
      var scoreCard = await tx.lookupValue<ScoreCard>(key, orElse: () => null);

      if (scoreCard == null) {
        _logger.info('Creating new ScoreCard $packageName $packageVersion.');
        scoreCard = ScoreCard.init(
          packageName: packageName,
          packageVersion: packageVersion,
          packageCreated: package.created,
          packageVersionCreated: version.created,
        );
      } else {
        _logger.info('Updating ScoreCard $packageName $packageVersion.');
        scoreCard.updated = DateTime.now().toUtc();
      }

      scoreCard.flags.clear();
      if (package.isDiscontinued) {
        scoreCard.addFlag(PackageFlags.isDiscontinued);
      }
      if (status.isLatestStable) {
        scoreCard.addFlag(PackageFlags.isLatestStable);
      }
      if (status.isLegacy) {
        scoreCard.addFlag(PackageFlags.isLegacy);
      }
      if (status.isObsolete) {
        scoreCard.addFlag(PackageFlags.isObsolete);
      }
      if (version.pubspec.usesFlutter) {
        scoreCard.addFlag(PackageFlags.usesFlutter);
      }

      scoreCard.popularityScore = popularityStorage.lookup(packageName) ?? 0.0;

      scoreCard.updateFromReports(
        panaReport: reports[ReportType.pana] as PanaReport,
        dartdocReport: reports[ReportType.dartdoc] as DartdocReport,
      );

      tx.insert(scoreCard);
    });

    final isLatest = package.latestVersion == version.version;
    await Future.wait([
      cache.scoreCardData(packageName, packageVersion).purge(),
      cache.uiPackagePage(packageName, packageVersion).purge(),
      if (isLatest) cache.uiPackagePage(packageName, null).purge(),
      if (isLatest) cache.packageView(packageName).purge(),
    ]);
  }

  /// Deletes the old entries that predate [versions.gcBeforeRuntimeVersion].
  Future<void> deleteOldEntries() async {
    final now = DateTime.now();

    // deleting reports
    await _db.deleteWithQuery(_db.query<ScoreCardReport>()
      ..filter('runtimeVersion <', versions.gcBeforeRuntimeVersion));
    await _db.deleteWithQuery(_db.query<ScoreCardReport>()
      ..filter('updated <', now.subtract(_deleteThreshold)));

    // deleting scorecards
    await _db.deleteWithQuery(_db.query<ScoreCard>()
      ..filter('runtimeVersion <', versions.gcBeforeRuntimeVersion));
    await _db.deleteWithQuery(_db.query<ScoreCard>()
      ..filter('updated <', now.subtract(_deleteThreshold)));
  }

  /// Returns the status of a package and version.
  Future<PackageStatus> getPackageStatus(String package, String version) async {
    final currentSdkVersion = await getDartSdkVersion();
    final packageKey = _db.emptyKey.append(Package, id: package);
    final List list = await _db
        .lookup([packageKey, packageKey.append(PackageVersion, id: version)]);
    final p = list[0] as Package;
    final pv = list[1] as PackageVersion;
    return PackageStatus.fromModels(p, pv, currentSdkVersion.semanticVersion);
  }

  /// Returns whether we should update the [reportType] report for the given
  /// package version.
  ///
  /// The method will return true, if either of the following is true:
  /// - it does not have a report yet,
  /// - the report was updated before [updatedAfter],
  /// - the report is older than [successThreshold] if it was a success,
  /// - the report is older than [failureThreshold] if it was a failure.
  Future<bool> shouldUpdateReport(
    PackageVersion pv,
    String reportType, {
    Duration successThreshold = const Duration(days: 30),
    Duration failureThreshold = const Duration(days: 1),
    DateTime updatedAfter,
  }) async {
    if (pv == null || isSoftRemoved(pv.package)) {
      return false;
    }

    // checking existing report
    final key = scoreCardKey(pv.package, pv.version)
        .append(ScoreCardReport, id: reportType);
    final list = await _db.lookup([key]);
    final report = list.single as ScoreCardReport;
    if (report == null) {
      return true;
    }

    // checking freshness
    if (updatedAfter != null && updatedAfter.isAfter(report.updated)) {
      return true;
    }

    // checking age
    final age = DateTime.now().toUtc().difference(report.updated);
    final isSuccess = report.reportStatus == ReportStatus.success;
    final ageThreshold = isSuccess ? successThreshold : failureThreshold;
    return age > ageThreshold;
  }
}

class PackageStatus {
  final bool exists;
  final DateTime publishDate;
  final Duration age;
  final bool isLatestStable;
  final bool isDiscontinued;
  final bool isObsolete;
  final bool isLegacy;
  final bool usesFlutter;
  final bool usesPreviewSdk;

  PackageStatus._({
    this.exists,
    this.publishDate,
    this.age,
    this.isLatestStable = false,
    this.isDiscontinued = false,
    this.isObsolete = false,
    this.isLegacy = false,
    this.usesFlutter = false,
    this.usesPreviewSdk = false,
  });

  factory PackageStatus.fromModels(
      Package p, PackageVersion pv, Version currentSdkVersion) {
    if (p == null || pv == null || p.isNotVisible) {
      return PackageStatus._(exists: false);
    }
    final publishDate = pv.created;
    final isLatestStable = p.latestVersion == pv.version;
    final now = DateTime.now().toUtc();
    final age = now.difference(publishDate).abs();
    final isObsolete = age > twoYears && !isLatestStable;
    return PackageStatus._(
      exists: true,
      publishDate: publishDate,
      age: age,
      isLatestStable: isLatestStable,
      isDiscontinued: p.isDiscontinued,
      isObsolete: isObsolete,
      isLegacy: pv.pubspec.supportsOnlyLegacySdk,
      usesFlutter: pv.pubspec.usesFlutter,
      usesPreviewSdk: pv.pubspec.isPreviewForCurrentSdk(currentSdkVersion),
    );
  }
}
