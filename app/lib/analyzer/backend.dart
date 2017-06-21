// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:gcloud/db.dart';

import 'models.dart';

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
    });
  }
}
