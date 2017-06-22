// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart' as db;
import 'package:pub_semver/pub_semver.dart';

import '../shared/analyzer_service.dart' show AnalysisStatus;

import 'model_properties.dart';

/// Analyzed package report.
@db.Kind(name: 'PackageAnalysis', idType: db.IdType.String)
class PackageAnalysis extends db.ExpandoModel {
  String get packageName => id;

  @db.ModelKeyProperty(required: true)
  db.Key latestVersionKey;

  String get latestVersion => latestVersionKey.id;
  Version get latestSemanticVersion => new Version.parse(latestVersion);

  PackageAnalysis();
  PackageAnalysis.fromAnalysis(Analysis analysis) {
    parentKey = db.dbService.emptyKey;
    id = analysis.packageName;
    latestVersionKey = analysis.packageVersionKey;
  }

  /// Returns true if there was a change that warrants an update in Datastore.
  bool updateWithLatest(Analysis analysis) {
    if (isNewer(analysis.semanticPackageVersion, latestSemanticVersion)) {
      // Current package version is already the latest stable version.
      return false;
    }
    package.latestVersionKey = analysis.packageVersionKey;
    return true;
  }
}

/// Analyzed version report.
@db.Kind(name: 'PackageVersionAnalysis', idType: db.IdType.String)
class PackageVersionAnalysis extends db.ExpandoModel {
  db.Key get packageKey => parentKey;
  String get packageName => packageKey.id;
  String get packageVersion => id;

  Version get semanticPackageVersion => new Version.parse(packageVersion);

  @db.ModelKeyProperty(required: true)
  db.Key latestAnalysisKey;

  int get latestAnalysis => latestAnalysisKey.id;

  @db.DateTimeProperty()
  DateTime analysisTimestamp;

  @db.StringProperty()
  String analysisVersion;

  Version get semanticAnalysisVersion => new Version.parse(analysisVersion);

  @AnalysisStatusProperty()
  AnalysisStatus analysisStatus;

  PackageVersionAnalysis();
  PackageVersionAnalysis.fromAnalysis(Analysis analysis) {
    parentKey =
        db.dbService.emptyKey.append(PackageAnalysis, id: analysis.packageName);
    id = analysis.packageVersion;
    latestAnalysisKey = analysis.key;
    analysisTimestamp = analysis.timestamp;
    analysisVersion = analysis.analysisVersion;
    analysisStatus = analysis.analysisStatus;
  }

  /// Returns true if there was a change that warrants an update in Datastore.
  bool updateWithLatest(Analysis analysis) {
    if (isNewer(analysis.semanticAnalysisVersion, semanticAnalysisVersion)) {
      // the new analysis' pana version is older, result probably obsolete
      return false;
    }
    version.latestAnalysisKey = analysis.key;
    version.analysisTimestamp = analysis.timestamp;
    version.analysisVersion = analysis.analysisVersion;
    version.analysisStatus = analysis.analysisStatus;
    return true;
  }
}

/// Immutable record of an analysis.
@db.Kind(name: 'Analysis', idType: db.IdType.Integer)
class Analysis extends db.ExpandoModel {
  @db.StringProperty(required: true)
  String packageName;

  @db.StringProperty(required: true)
  String packageVersion;

  int get analysis => id;
  db.Key get packageVersionKey => parentKey;

  Version get semanticPackageVersion => new Version.parse(packageVersion);

  @db.DateTimeProperty()
  DateTime timestamp;

  // Analysis fields contain information about the pana version being used,
  // how its execution went, and the raw output.

  @db.StringProperty()
  String analysisVersion;

  Version get semanticAnalysisVersion => new Version.parse(analysisVersion);

  @AnalysisStatusProperty()
  AnalysisStatus analysisStatus;

  @db.StringProperty(indexed: false)
  String analysisJsonContent;

  // Report fields contain our interpretation and relevant extracts of the pana
  // analysis output.
  // TODO: add report fields

  /// Empty constructor only for appengine.
  Analysis();

  /// Proper constructor that initializes the required fields.
  Analysis.init(this.packageName, this.packageVersion) {
    timestamp = new DateTime.now().toUtc();
    parentKey = db.dbService.emptyKey
        .append(PackageAnalysis, id: package)
        .append(PackageVersionAnalysis, id: version);
  }
}
