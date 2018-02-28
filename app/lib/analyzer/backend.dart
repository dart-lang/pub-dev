// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import '../frontend/models.dart';
import '../shared/analyzer_memcache.dart';
import '../shared/analyzer_service.dart';
import '../shared/task_scheduler.dart' show TaskTargetStatus;
import '../shared/utils.dart';
import '../shared/versions.dart';

import 'models.dart';

/// Sets the backend service.
void registerAnalysisBackend(AnalysisBackend backend) =>
    ss.register(#_analysisBackend, backend);

/// The active backend service.
AnalysisBackend get analysisBackend => ss.lookup(#_analysisBackend);

final Logger _logger = new Logger('pub.analyzer.backend');

const Duration freshThreshold = const Duration(hours: 12);
const Duration identicalThreshold = const Duration(days: 7);
const Duration reanalyzeThreshold = const Duration(days: 30);
const Duration regressionThreshold = const Duration(days: 45);
const Duration obsoleteThreshold = const Duration(days: 180);

/// Datastore-related access methods for the analyzer service
class AnalysisBackend {
  final DatastoreDB db;

  AnalysisBackend(this.db);

  /// Gets the [Analysis] object from the Datastore. [version] and [analysis] is
  /// optional, when they are missing the analysis from the latest rollup will
  /// be returned.
  ///
  /// When [panaVersion] is set (and [analysis] is not), we'll try to return the
  /// latest [Analysis] instance with a matching `panaVersion` value. Note:
  /// If there is no matching `Analysis` instance with the requested version,
  /// we'll still return the latest one, regardless of its version.
  Future<AnalysisData> getAnalysis(String package,
      {String version, int analysis, String panaVersion}) async {
    final Key packageKey = db.emptyKey.append(PackageAnalysis, id: package);

    if (version == null) {
      final list = await db.lookup([packageKey]);
      final PackageAnalysis pa = list[0];
      if (pa == null) {
        _logger.info('PackageAnalysis lookup failed: no entry for $package.');
        return null;
      }
      version = pa.latestVersion;
    }

    // version was set
    final Key versionKey =
        packageKey.append(PackageVersionAnalysis, id: version);

    bool lookupMatchingPanaVersion = false;
    if (analysis == null) {
      final list = await db.lookup([versionKey]);
      final PackageVersionAnalysis pva = list[0];
      if (pva == null) {
        _logger.info(
            'PackageVersionAnalysis lookup failed: no entry for $package $version.');
        return null;
      }
      analysis = pva.latestAnalysis;
      lookupMatchingPanaVersion =
          panaVersion != null && pva.panaVersion != panaVersion;
    }

    if (lookupMatchingPanaVersion) {
      final Query query = db.query(Analysis, ancestorKey: versionKey)
        ..filter('panaVersion =', panaVersion);
      final List<Analysis> list = await query.run().toList();
      if (list.isNotEmpty) {
        list.sort((a, b) => -a.timestamp.compareTo(b.timestamp));
        final Analysis entry = list[0];
        return _toData(entry);
      } else {
        _logger.info(
            "Analysis lookup failed for $package $version (panaVersion=$panaVersion)");
      }
    }

    // analysis was set
    final Key analysisKey = versionKey.append(Analysis, id: analysis);
    final List list = await db.lookup([analysisKey]);
    final Analysis entry = list[0];
    if (entry == null) {
      _logger.info(
          "Analysis lookup failed for $package $version (id=${analysis ?? ''}).");
      return null;
    }
    return _toData(entry);
  }

  AnalysisData _toData(Analysis entry) {
    return new AnalysisData(
        packageName: entry.packageName,
        packageVersion: entry.packageVersion,
        analysis: entry.analysis,
        timestamp: entry.timestamp,
        panaVersion: entry.panaVersion,
        flutterVersion: entry.flutterVersion,
        analysisStatus: entry.analysisStatus,
        maintenanceScore: entry.maintenanceScore,
        analysisContent: entry.analysisJson);
  }

  /// Stores the analysis, and either creates or updates its parent
  /// [PackageAnalysis] and [PackageVersionAnalysis] records.
  ///
  /// Returns the backend status of the [Analysis].
  Future<BackendAnalysisStatus> storeAnalysis(Analysis analysis) {
    final pvText = '${analysis.packageName} ${analysis.packageVersion}';
    // update package and version too
    return db.withTransaction((Transaction tx) async {
      final incompleteRawKey = tx.db.modelDB.toDatastoreKey(analysis.key);
      final completeRawKey =
          (await tx.db.datastore.allocateIds([incompleteRawKey])).single;
      analysis.id = tx.db.modelDB.fromDatastoreKey(completeRawKey).id;
      final Key packageKey =
          db.emptyKey.append(PackageAnalysis, id: analysis.packageName);
      final Key packageVersionKey = packageKey.append(PackageVersionAnalysis,
          id: analysis.packageVersion);
      final List parents = await tx.lookup([packageKey, packageVersionKey]);
      PackageAnalysis package = parents[0];
      PackageVersionAnalysis version = parents[1];
      final isNewVersion = version == null;
      final isRegression = version != null &&
          version.panaVersion == panaVersion &&
          version.flutterVersion == flutterVersion &&
          (analysisStatusLevel(version.analysisStatus) >
              analysisStatusLevel(analysis.analysisStatus));
      final hasIdenticalHash = version != null &&
          version.analysisHash != null &&
          analysis.analysisHash == version.analysisHash;

      final List<Model> inserts = [];
      if (package == null) {
        package = new PackageAnalysis.fromAnalysis(analysis);
        inserts.add(package);
      } else if (package.updateWithLatest(analysis)) {
        inserts.add(package);
      }

      final Duration ageDiff = version == null
          ? null
          : analysis.timestamp.difference(version.analysisTimestamp);
      final bool preventIdentical =
          hasIdenticalHash && ageDiff < identicalThreshold;

      if (version == null) {
        version = new PackageVersionAnalysis.fromAnalysis(analysis);
        inserts.add(version);
      } else if (preventIdentical) {
        version.analysisTimestamp = analysis.timestamp;
        inserts.add(version);
      } else if (version.updateWithLatest(analysis)) {
        inserts.add(version);
      }
      final bool wasRace =
          inserts.isEmpty && ageDiff != null && ageDiff < freshThreshold;
      final isLatestStable = package.latestVersion == version.packageVersion;
      final bool preventRegression =
          isRegression && ageDiff != null && ageDiff < regressionThreshold;

      if (preventRegression) {
        _logger.info('Analysis regression detected, not storing: $pvText');
        await tx.rollback();
      } else if (preventIdentical) {
        _logger
            .info('Identical analysis detected, updating timestamp: $pvText');
        // sanity check that we haven't updated the version's latest analysis
        assert(version.latestAnalysis != analysis.analysis);
        tx.queueMutations(inserts: inserts);
        await tx.commit();
      } else {
        _logger.info('Storing analysis for: $pvText');
        inserts.add(analysis);
        tx.queueMutations(inserts: inserts);
        await tx.commit();

        analyzerMemcache.invalidateContent(analysis.packageName,
            analysis.packageVersion, analysis.panaVersion);
      }
      return new BackendAnalysisStatus(wasRace, isLatestStable, isNewVersion);
    });
  }

  /// Returns the task target status based on:
  /// - whether [packageName] with [packageVersion] exists, and
  /// - it has no recent [Analysis] with the current [panaVersion] or [flutterVersion], or
  /// - it has no newer [Analysis] than [panaVersion] or [flutterVersion].
  Future<TaskTargetStatus> checkTargetStatus(
      String packageName, String packageVersion, DateTime updated) async {
    if (packageName == null || packageVersion == null) {
      return new TaskTargetStatus.skip('Insufficient package or version.');
    }
    final List<PackageVersion> versions = await db.lookup([
      db.emptyKey
          .append(Package, id: packageName)
          .append(PackageVersion, id: packageVersion)
    ]);
    // Does package and version exist?
    final PackageVersion pv = versions.single;
    if (pv == null) {
      return new TaskTargetStatus.skip('PackageVersion does not exists.');
    }

    // Does package have any analysis?
    final Key packageKey = db.emptyKey.append(PackageAnalysis, id: packageName);
    final PackageAnalysis packageAnalysis =
        (await db.lookup([packageKey])).single;
    if (packageAnalysis == null) {
      return new TaskTargetStatus.ok();
    }

    // Does package have newer version than latest analyzed version?
    if (isNewer(packageAnalysis.latestSemanticVersion, pv.semanticVersion)) {
      return new TaskTargetStatus.ok();
    }

    // Does package have analysis for the current version?
    final Key versionKey =
        packageKey.append(PackageVersionAnalysis, id: packageVersion);
    final PackageVersionAnalysis versionAnalysis =
        (await db.lookup([versionKey])).single;
    if (versionAnalysis == null) {
      return new TaskTargetStatus.ok();
    }

    // Is current analysis version newer?
    if (isNewer(versionAnalysis.semanticPanaVersion, semanticPanaVersion) ||
        isNewer(
            versionAnalysis.semanticFlutterVersion, semanticFlutterVersion)) {
      return new TaskTargetStatus.ok();
    }

    // Is current analysis version obsolete?
    if (isNewer(semanticPanaVersion, versionAnalysis.semanticPanaVersion) ||
        isNewer(
            semanticFlutterVersion, versionAnalysis.semanticFlutterVersion)) {
      // existing analysis version is newer, current analyzer is obsolete?
      // TODO: turn off task polling on this instance
      _logger.warning(
          'Newer analysis version detected, current instance is obsolete.');
      return new TaskTargetStatus.skip('Newer analysis instance detected.');
    }

    if (versionAnalysis.panaVersion != panaVersion ||
        versionAnalysis.flutterVersion != flutterVersion) {
      _logger.warning('Versions should be matching: '
          '${versionAnalysis.panaVersion} - $panaVersion and '
          '${versionAnalysis.flutterVersion} - $flutterVersion');
    }

    // Is it due to re-analyze?
    final DateTime now = new DateTime.now().toUtc();
    final Duration age = now.difference(versionAnalysis.analysisTimestamp);
    if (age > reanalyzeThreshold) {
      return new TaskTargetStatus.ok();
    }

    // Is it a newer analysis than the trigger timestamp?
    if (versionAnalysis.analysisTimestamp.isAfter(updated) &&
        versionAnalysis.analysisStatus == AnalysisStatus.success) {
      return new TaskTargetStatus.skip(
          'Previous analysis completed after task\'s trigger timestamp.');
    }

    return new TaskTargetStatus.ok();
  }

  /// Deletes the obsolete [Analysis] instances from Datastore. An instance is
  /// obsolete, if:
  /// - it is **not** the latest for the pana version, or
  /// - it is older than 6 months (except if it is the latest one).
  Future deleteObsoleteAnalysis(String package, String version) async {
    final pvaKey = db.emptyKey
        .append(PackageAnalysis, id: package)
        .append(PackageVersionAnalysis, id: version);
    final PackageVersionAnalysis pva = (await db.lookup([pvaKey])).single;
    if (pva == null) return;

    final DateTime threshold =
        new DateTime.now().toUtc().subtract(obsoleteThreshold);
    final Query scanQuery = db.query(Analysis, ancestorKey: pvaKey);
    final List<Key> obsoleteKeys = <Key>[];

    final List<Analysis> existingAnalysis = await scanQuery.run().toList();
    existingAnalysis.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    final Map<String, Analysis> panaVersion2LatestAnalysis = {};
    for (Analysis analysis in existingAnalysis) {
      if (analysis.analysis == pva.latestAnalysis) {
        // Don't remove the current Analysis instance.
        continue;
      }
      final bool isTooOld = analysis.timestamp.isBefore(threshold);
      if (isTooOld) {
        obsoleteKeys.add(analysis.key);
        continue;
      }
      final Analysis prev = panaVersion2LatestAnalysis[analysis.panaVersion];
      panaVersion2LatestAnalysis[analysis.panaVersion] = analysis;
      if (prev != null) {
        obsoleteKeys.add(prev.key);
      }
    }

    // sanity check that we don't delete everything
    if (obsoleteKeys.isNotEmpty &&
        obsoleteKeys.length == existingAnalysis.length) {
      _logger.warning(
          'Inconsistency: all Analysis entries are marked as obsolete for $package $version.');
      return;
    }

    if (obsoleteKeys.isNotEmpty) {
      _logger.info('Deleting Analysis entries for $package $version: '
          '${obsoleteKeys.map((k)=> k.id).join(',')}');
      await db.commit(deletes: obsoleteKeys);
    }
  }

  /// Returns the status of a package and version.
  Future<PackageStatus> getPackageStatus(String package, String version) async {
    final packageKey = db.emptyKey.append(Package, id: package);
    final List list = await db
        .lookup([packageKey, packageKey.append(PackageVersion, id: version)]);
    final Package p = list[0];
    final PackageVersion pv = list[1];
    if (p == null || pv == null) {
      return new PackageStatus(exists: false);
    }
    return new PackageStatus(
      exists: true,
      publishDate: pv.created,
      isLatestStable: p.latestVersion == version,
      isDiscontinued: p.isDiscontinued ?? false,
    );
  }
}

class PackageStatus {
  final bool exists;
  final DateTime publishDate;
  final bool isLatestStable;
  final bool isDiscontinued;

  PackageStatus({
    this.exists,
    this.publishDate,
    this.isLatestStable: false,
    this.isDiscontinued: false,
  });
}

class BackendAnalysisStatus {
  final bool wasRace;
  final bool isLatestStable;
  final bool isNewVersion;
  BackendAnalysisStatus(this.wasRace, this.isLatestStable, this.isNewVersion);
}
