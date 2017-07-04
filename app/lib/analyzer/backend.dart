// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';

import '../frontend/models.dart';
import '../shared/utils.dart';

import 'models.dart';

/// Sets the backend service.
void registerAnalysisBackend(AnalysisBackend backend) =>
    ss.register(#_analysisBackend, backend);

/// The active backend service.
AnalysisBackend get analysisBackend => ss.lookup(#_analysisBackend);

final Logger _logger = new Logger('pub.analyzer.backend');

/// Datastore-related access methods for the analyzer service
class AnalysisBackend {
  final DatastoreDB db;

  AnalysisBackend(this.db);

  /// Gets the [Analysis] object from the Datastore. [version] and [analysis] is
  /// optional, when they are missing the analysis from the latest rollup will
  /// be returned.
  Future<Analysis> getAnalysis(String package,
      [String version, int analysis]) async {
    final Key packageKey = db.emptyKey.append(PackageAnalysis, id: package);

    if (version == null) {
      final list = await db.lookup([packageKey]);
      final PackageAnalysis pa = list[0];
      if (pa == null) return null;
      version = pa.latestVersion;
    }

    // version was set
    final Key versionKey =
        packageKey.append(PackageVersionAnalysis, id: version);

    if (analysis == null) {
      final list = await db.lookup([versionKey]);
      final PackageVersionAnalysis pva = list[0];
      if (pva == null) return null;
      analysis = pva.latestAnalysis;
    }

    // analysis was set
    final Key analysisKey = versionKey.append(Analysis, id: analysis);
    final List list = await db.lookup([analysisKey]);
    return list[0];
  }

  /// Stores the analysis, and either creates or updates its parent
  /// [PackageAnalysis] and [PackageVersionAnalysis] records.
  Future storeAnalysis(Analysis analysis) async {
    assert(analysis.id == null);
    await db.commit(inserts: [analysis]);
    assert(analysis.id != null);

    // update package and version too
    await db.withTransaction((Transaction tx) async {
      final Key packageKey =
          db.emptyKey.append(PackageAnalysis, id: analysis.packageName);
      final Key packageVersionKey = packageKey.append(PackageVersionAnalysis,
          id: analysis.packageVersion);
      final List parents = await tx.lookup([packageKey, packageVersionKey]);
      final PackageAnalysis package = parents[0];
      final PackageVersionAnalysis version = parents[1];

      final List<Model> inserts = [];
      if (package == null) {
        inserts.add(new PackageAnalysis.fromAnalysis(analysis));
      } else if (package.updateWithLatest(analysis)) {
        inserts.add(package);
      }

      if (version == null) {
        inserts.add(new PackageVersionAnalysis.fromAnalysis(analysis));
      } else if (version.updateWithLatest(analysis)) {
        inserts.add(version);
      }

      if (inserts.isEmpty) {
        await tx.rollback();
        return;
      }

      tx.queueMutations(inserts: inserts);
      await tx.commit();

      // Notify search only if new analysis is of the latest stable version.
      if (package.latestVersion == version.packageVersion) {
        notifySearch(analysis.packageName);
      }
    });
  }

  /// Whether [packageName] with [packageVersion] exists, and
  /// - it has no recent [Analysis] with the given [analysisVersion], or
  /// - it has no newer [Analysis] than [analysisVersion].
  Future<bool> isValidTarget(
      String packageName, String packageVersion, String analysisVersion) async {
    if (packageName == null || packageVersion == null) return false;
    final List<PackageVersion> versions = await db.lookup([
      db.emptyKey
          .append(Package, id: packageName)
          .append(PackageVersion, id: packageVersion)
    ]);
    // package or version does not exists
    if (versions.first == null) return false;

    final List<PackageAnalysis> list =
        await db.lookup([db.emptyKey.append(PackageAnalysis, id: packageName)]);
    // no analysis for the package
    if (list.first == null) return true;

    final PackageAnalysis packageAnalysis = list.first;
    final PackageVersionAnalysis versionAnalysis =
        (await db.lookup([packageAnalysis.latestVersionKey])).first;

    if (versionAnalysis.analysisVersion == analysisVersion) {
      final DateTime now = new DateTime.now().toUtc();
      if (now.difference(versionAnalysis.analysisTimestamp).inHours < 4) {
        // latest analysis has the same version and happened in the past 4 hours
        return false;
      }
    } else {
      final Version analysisSemantic = new Version.parse(analysisVersion);
      if (isNewer(analysisSemantic, versionAnalysis.semanticAnalysisVersion)) {
        // existing analysis version is newer, current analyzer is obsolete?
        // TODO: turn off task polling on this instance
        _logger.warning(
            'Newer analysis version detected, current instance is obsolete.');
        return false;
      }
    }

    return true;
  }
}
