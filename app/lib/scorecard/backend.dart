// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pana/pana.dart' as pana;
import 'package:pool/pool.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/task/backend.dart';

import '../package/backend.dart';
import '../package/models.dart' show Package, PackageVersion, PackageView;
import '../package/overrides.dart';
import '../shared/datastore.dart' as db;
import '../shared/redis_cache.dart' show cache;
import '../shared/utils.dart';
import '../shared/versions.dart' as versions;

import 'helpers.dart';
import 'models.dart';

final _logger = Logger('pub.scorecard.backend');

final Duration _deleteThreshold = const Duration(days: 182);
final _reportSizeWarnThreshold = 16 * 1024;
final _reportSizeDropThreshold = 32 * 1024;

/// The minimum age of the [PackageVersion] which will trigger a fallback to
/// older scorecards. Below this age we only display the current [ScoreCard].
final _fallbackMinimumAge = const Duration(hours: 4);

/// The maximum number of keys we'll try to lookup when we need to load the
/// scorecard or the report information for multiple versions.
///
/// The Datastore limit is 1000, but that caused resource constraint issues
/// https://github.com/dart-lang/pub-dev/issues/4040
///
/// Another issue was if the total size of the reports got too long
/// https://github.com/dart-lang/pub-dev/issues/4780
const _batchLookupMaxKeyCount = 10;

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
    bool showSandboxedOutput = false,
  }) async {
    if (packageVersion == null || packageVersion == 'latest') {
      packageVersion = await packageBackend.getLatestVersion(packageName);
      if (packageVersion == null) {
        // package does not exists
        return null;
      }
    }
    final cacheEntry = onlyCurrent
        ? null
        : (showSandboxedOutput
            ? cache.scoreCardData2(packageName, packageVersion)
            : cache.scoreCardData(packageName, packageVersion));
    if (cacheEntry != null) {
      final cached = await cacheEntry.get();
      if (cached != null && cached.hasAllReports) {
        return cached;
      }
    }

    if (showSandboxedOutput) {
      final package = await packageBackend.lookupPackage(packageName);
      if (package == null) {
        throw NotFoundException('Package "$packageName" does not exist.');
      }
      final version = await packageBackend.lookupPackageVersion(
          packageName, packageVersion);
      if (version == null) {
        throw NotFoundException(
            'Package version "$packageName $packageVersion" does not exist.');
      }
      final status = PackageStatus.fromModels(package, version);
      final summary =
          await taskBackend.panaSummary(packageName, packageVersion);
      // TODO: check existence of the dartdoc index.html by loading only the index
      final dartdocFile = summary == null
          ? null
          : await taskBackend.dartdocFile(
              packageName, packageVersion, 'index.html');
      final hasDartdocFile = dartdocFile != null;

      final data = ScoreCardData(
        packageName: packageName,
        packageVersion: packageVersion,
        // this is unused outside scorecard backend, and a bit wrong:
        runtimeVersion: runtimeVersion,
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
      );
      if (cacheEntry != null) {
        await cacheEntry.set(data);
      }
      return data;
    }

    final key = scoreCardKey(packageName, packageVersion);
    final current = (await _db.lookupOrNull<ScoreCard>(key))?.tryDecodeData();
    if (current != null) {
      if (cacheEntry != null) {
        await cacheEntry.set(current);
      }
      if (onlyCurrent || current.hasAllReports) {
        return current;
      }
    }

    if (onlyCurrent) return null;

    // List cards that at minimum have a pana report.
    final fallbackKeys = versions.fallbackRuntimeVersions
        .map((v) =>
            scoreCardKey(packageName, packageVersion!, runtimeVersion: v))
        .toList();
    final fallbackCards = await _db.lookup<ScoreCard>(fallbackKeys);
    final fallbackCardData = fallbackCards
        .whereNotNull()
        .map((c) => c.tryDecodeData())
        .whereNotNull()
        .toList();

    if (fallbackCardData.isEmpty) return null;

    final fallbackCard =
        fallbackCardData.firstWhereOrNull((d) => d.hasAllReports) ??
            fallbackCardData.firstWhereOrNull((d) => d.hasPanaReport);

    // For recently uploaded version, we don't want to fallback to an analysis
    // coming from an older running deployment too early. A new analysis may
    // come soon from the current runtime, and if it is different in significant
    // ways (e.g. score or success status differs), it may confuse users looking
    // at it in the interim period.
    //
    // However, once the upload is above the specified age, it is better to
    // display and old analysis than to keep waiting on a new one.
    if (fallbackCard != null) {
      final age = clock.now().difference(fallbackCard.packageVersionCreated!);
      if (age < _fallbackMinimumAge) {
        return null;
      }
    }
    return fallbackCard;
  }

  /// Creates or updates a [ScoreCard] entry with the provided [panaReport] and/or [dartdocReport].
  /// The report data will be converted to json+gzip and stored as a bytes in the [ScoreCard] entry.
  Future<void> updateReportOnCard(
    String packageName,
    String packageVersion, {
    PanaReport? panaReport,
    DartdocReport? dartdocReport,
  }) async {
    final key = scoreCardKey(packageName, packageVersion);
    final pAndPv = await _db.lookup([key.parent!, key.parent!.parent!]);
    final version = pAndPv[0] as PackageVersion?;
    final package = pAndPv[1] as Package?;
    if (package == null || version == null) {
      throw Exception('Unable to lookup $packageName $packageVersion.');
    }

    await db.withRetryTransaction(_db, (tx) async {
      var scoreCard = await tx.lookupOrNull<ScoreCard>(key);

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
        scoreCard.updated = clock.now().toUtc();
      }

      bool reportIsTooBig(String reportType, List<int>? bytes) {
        if (bytes == null || bytes.isEmpty) return false;
        final size = bytes.length;
        if (size > _reportSizeDropThreshold) {
          _logger.reportError(
              '$reportType report exceeded size threshold ($packageName $packageVersion - $size > $_reportSizeWarnThreshold)');
          return true;
        } else if (size > _reportSizeWarnThreshold) {
          _logger.warning(
              '$reportType report exceeded size threshold ($packageName $packageVersion - $size > $_reportSizeWarnThreshold)');
        }
        return false;
      }

      if (panaReport != null &&
          reportIsTooBig(ReportType.pana, panaReport!.asBytes)) {
        panaReport = PanaReport(
          timestamp: clock.now().toUtc(),
          panaRuntimeInfo: null,
          reportStatus: ReportStatus.aborted,
          derivedTags: <String>[
            'has:pana-report-exceeds-size-threshold',
          ],
          allDependencies: <String>[],
          licenses: null,
          report: pana.Report(
            sections: [
              pana.ReportSection(
                id: 'error',
                title: 'Report exceeded size limit.',
                grantedPoints: panaReport!.report?.grantedPoints ?? 0,
                maxPoints: panaReport!.report?.maxPoints ?? 1,
                status: pana.ReportStatus.partial,
                summary: 'The `pana` report exceeded size limit. '
                    'A log about the issue has been filed, the site admins will address it soon.',
              ),
            ],
          ),
          result: null,
          urlProblems: <pana.UrlProblem>[],
          screenshots: null,
        );
      }
      if (dartdocReport != null &&
          reportIsTooBig(ReportType.dartdoc, dartdocReport!.asBytes)) {
        dartdocReport = DartdocReport(
          timestamp: dartdocReport!.timestamp,
          reportStatus: ReportStatus.aborted,
          dartdocEntry: null,
          documentationSection: pana.ReportSection(
            id: pana.ReportSectionId.documentation,
            title: pana.documentationSectionTitle,
            grantedPoints:
                dartdocReport!.documentationSection?.grantedPoints ?? 0,
            maxPoints: dartdocReport!.documentationSection?.maxPoints ?? 10,
            status: pana.ReportStatus.partial,
            summary: 'The `dartdoc` report exceeded size limit. '
                'A log about the issue has been filed, the site admins will address it soon.',
          ),
        );
      }

      scoreCard.updateReports(
        panaReport: panaReport,
        dartdocReport: dartdocReport,
      );

      tx.insert(scoreCard);
    });

    await purgeScorecardData(
      package.name!,
      version.version!,
      isLatest: package.latestVersion == version.version,
    );
  }

  /// Load and deserialize a [ScoreCardData] for the given package's versions.
  Future<List<ScoreCardData?>> getScoreCardDataForAllVersions(
    String packageName,
    Iterable<String> versions, {
    String? runtimeVersion,
  }) async {
    final futures = <Future<List<ScoreCardData?>>>[];
    for (var start = 0;
        start < versions.length;
        start += _batchLookupMaxKeyCount) {
      final keys = versions
          .skip(start)
          .take(_batchLookupMaxKeyCount)
          .map((v) =>
              scoreCardKey(packageName, v, runtimeVersion: runtimeVersion))
          .toList();
      final f = _scoreCardDataPool.withResource(() async {
        final items = await _db.lookup<ScoreCard>(keys);
        return items.map((item) => item?.tryDecodeData()).toList();
      });
      futures.add(f);
    }
    final lists = await Future.wait(futures);
    final results = lists.fold<List<ScoreCardData?>>(
      <ScoreCardData?>[],
      (r, list) => r..addAll(list),
    );
    return results;
  }

  /// Updates the `updated` field of the [ScoreCard] entry, forcing search
  /// indexes to pick it up and update their index.
  Future<void> markScoreCardUpdated(
      String packageName, String packageVersion) async {
    final key = scoreCardKey(packageName, packageVersion);
    await db.withRetryTransaction(_db, (tx) async {
      final card = await tx.lookupOrNull<ScoreCard>(key);
      if (card == null) return;
      card.updated = clock.now().toUtc();
      tx.insert(card);
    });
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

  /// Returns whether we should update the [reportType] report for the given
  /// package version.
  ///
  /// The method will return true, if either of the following is true:
  /// - it does not have a report yet,
  /// - the report was updated before [updatedAfter],
  /// - the report is older than [successThreshold] if it was a success,
  /// - the report is older than [failureThreshold] if it was a failure.
  Future<bool> shouldUpdateReport(
    String package,
    String version,
    String reportType, {
    Duration successThreshold = const Duration(days: 30),
    Duration failureThreshold = const Duration(days: 1),
    DateTime? updatedAfter,
  }) async {
    if (isSoftRemoved(package)) {
      return false;
    }

    // checking existing card
    final key = scoreCardKey(package, version);
    final card = await _db.lookupOrNull<ScoreCard>(key);
    if (card == null) return true;

    bool checkUpdatedAndStatus(DateTime? updated, String? reportStatus) {
      // checking existence
      if (updated == null) {
        return true;
      }
      // checking freshness
      if (updatedAfter != null && updatedAfter.isAfter(updated)) {
        return true;
      }
      // checking age
      final age = clock.now().toUtc().difference(updated);
      final isSuccess = reportStatus == ReportStatus.success;
      final ageThreshold = isSuccess ? successThreshold : failureThreshold;
      return age > ageThreshold;
    }

    final data = card.tryDecodeData();
    if (data == null) {
      return true;
    }
    if (reportType == ReportType.pana) {
      return checkUpdatedAndStatus(
          data.panaReport?.timestamp, data.panaReport?.reportStatus);
    } else if (reportType == ReportType.dartdoc) {
      return checkUpdatedAndStatus(
          data.dartdocReport?.timestamp, data.dartdocReport?.reportStatus);
    } else {
      throw AssertionError('Unknown report type: $reportType.');
    }
  }
}

Future<void> purgeScorecardData(
  String package,
  String version, {
  required bool isLatest,
}) async {
  await Future.wait([
    cache.scoreCardData(package, version).purge(),
    cache.scoreCardData2(package, version).purge(),
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
