// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import 'package:pub_dev/package/models.dart' show Package, PackageVersion;
import '../package/overrides.dart';
import '../shared/popularity_storage.dart';
import '../shared/redis_cache.dart' show cache;
import '../shared/utils.dart';
import '../shared/versions.dart' as versions;

import 'helpers.dart';
import 'models.dart';

export 'models.dart';

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
    if (cached != null &&
        cached.hasReports(requiredReportTypes) &&
        !versions.blacklistedRuntimeVersions.contains(cached.runtimeVersion)) {
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

    // List cards that at minimum have a pana report.
    final query = _db.query<ScoreCard>(ancestorKey: key.parent);
    final cardsWithPana = await query
        .run()
        .where((sc) =>
            sc.runtimeVersion == versions.runtimeVersion ||
            isNewer(sc.semanticRuntimeVersion, versions.semanticRuntimeVersion))
        .where((sc) =>
            !versions.blacklistedRuntimeVersions.contains(sc.runtimeVersion))
        .where((sc) => sc.toData().hasReports([ReportType.pana]))
        .toList();
    final cardsWithAll = cardsWithPana
        .where((sc) => sc.toData().hasReports(requiredReportTypes))
        .toList();

    final cards = cardsWithAll.isNotEmpty ? cardsWithAll : cardsWithPana;
    if (cards.isEmpty) {
      return null;
    }

    final latest = cards.fold<ScoreCard>(
        cards.first,
        (latest, current) => isNewer(
                latest.semanticRuntimeVersion, current.semanticRuntimeVersion)
            ? current
            : latest);
    return latest.toData();
  }

  /// Creates or updates a [ScoreCardReport] entry with the report's [data].
  /// The [data] will be converted to json and stored as a byte in the report
  /// entry.
  Future<void> updateReport(
      String packageName, String packageVersion, ReportData data) async {
    final key = scoreCardKey(packageName, packageVersion)
        .append(ScoreCardReport, id: data.reportType);
    await _db.withTransaction((tx) async {
      ScoreCardReport report;
      final reportList = await tx.lookup([key]);
      report = reportList.first as ScoreCardReport;
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
      tx.queueMutations(inserts: [report]);
      await tx.commit();
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

    final status = PackageStatus.fromModels(package, version);
    final reports = await loadReports(packageName, packageVersion);

    await _db.withTransaction((tx) async {
      ScoreCard scoreCard;
      final scoreCardList = await tx.lookup([key]);
      scoreCard = scoreCardList.first as ScoreCard;

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
      if (package.doNotAdvertise ?? false) {
        scoreCard.addFlag(PackageFlags.doNotAdvertise);
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

      tx.queueMutations(inserts: [scoreCard]);
      await tx.commit();
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
    final deletes = <db.Key>[];
    final now = DateTime.now();

    // Deletes the entries that are returned from the [query].
    Future<void> deleteQuery<T extends db.Model>(db.Query<T> query) async {
      await for (T model in query.run()) {
        deletes.add(model.key);
        if (deletes.length == 20) {
          await _db.commit(deletes: deletes);
          deletes.clear();
        }
      }
      if (deletes.isNotEmpty) {
        await _db.commit(deletes: deletes);
        deletes.clear();
      }
    }

    // deleting reports
    await deleteQuery(_db.query<ScoreCardReport>()
      ..filter('runtimeVersion <', versions.gcBeforeRuntimeVersion));
    await deleteQuery(_db.query<ScoreCardReport>()
      ..filter('updated <', now.subtract(_deleteThreshold)));

    // deleting scorecards
    await deleteQuery(_db.query<ScoreCard>()
      ..filter('runtimeVersion <', versions.gcBeforeRuntimeVersion));
    await deleteQuery(_db.query<ScoreCard>()
      ..filter('updated <', now.subtract(_deleteThreshold)));
  }

  /// Returns the status of a package and version.
  Future<PackageStatus> getPackageStatus(String package, String version) async {
    final packageKey = _db.emptyKey.append(Package, id: package);
    final List list = await _db
        .lookup([packageKey, packageKey.append(PackageVersion, id: version)]);
    final p = list[0] as Package;
    final pv = list[1] as PackageVersion;
    return PackageStatus.fromModels(p, pv);
  }

  /// Returns whether we should update the [reportType] report for the given
  /// [packageName] and [packageVersion].
  ///
  /// The method will return false, if the package or version does not exists.
  /// The method will return true, if either of the following is true:
  /// - it does not have a report yet,
  /// - the report was updated before [updatedAfter],
  /// - the report is older than [successThreshold] if it was a success,
  /// - the report is older than [failureThreshold] if it was a failure.
  Future<bool> shouldUpdateReport(
    String packageName,
    String packageVersion,
    String reportType, {
    Duration successThreshold = const Duration(days: 30),
    Duration failureThreshold = const Duration(days: 1),
    DateTime updatedAfter,
  }) async {
    if (packageName == null ||
        packageVersion == null ||
        isSoftRemoved(packageName)) {
      return false;
    }
    final pkgStatus = await getPackageStatus(packageName, packageVersion);
    if (!pkgStatus.exists) {
      return false;
    }

    // checking existing report
    final key = scoreCardKey(packageName, packageVersion)
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

  PackageStatus({
    this.exists,
    this.publishDate,
    this.age,
    this.isLatestStable = false,
    this.isDiscontinued = false,
    this.isObsolete = false,
    this.isLegacy = false,
    this.usesFlutter = false,
  });

  factory PackageStatus.fromModels(Package p, PackageVersion pv) {
    if (p == null || pv == null) {
      return PackageStatus(exists: false);
    }
    final publishDate = pv.created;
    final isLatestStable = p.latestVersion == pv.version;
    final now = DateTime.now().toUtc();
    final age = now.difference(publishDate).abs();
    final isObsolete = age > twoYears && !isLatestStable;
    return PackageStatus(
      exists: true,
      publishDate: publishDate,
      age: age,
      isLatestStable: isLatestStable,
      isDiscontinued: p.isDiscontinued,
      isObsolete: isObsolete,
      isLegacy: pv.pubspec.supportsOnlyLegacySdk,
      usesFlutter: pv.pubspec.usesFlutter,
    );
  }
}
