// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:gcloud/db.dart' as db;
import 'package:pub_semver/pub_semver.dart';

import '../shared/analyzer_service.dart' show AnalysisStatus;
import '../shared/utils.dart';
import '../shared/versions.dart' as versions;

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
    latestVersionKey = analysis.packageVersionKey;
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

  /// The timestamp of the analysis (either the linked one, or an identical,
  /// but not stored one).
  @db.DateTimeProperty()
  DateTime analysisTimestamp;

  @db.StringProperty()
  String panaVersion;

  @db.StringProperty()
  String flutterVersion;

  Version get semanticPanaVersion => new Version.parse(panaVersion);
  Version get semanticFlutterVersion => new Version.parse(flutterVersion);

  @AnalysisStatusProperty()
  AnalysisStatus analysisStatus;

  @db.StringProperty()
  String analysisHash;

  PackageVersionAnalysis();
  PackageVersionAnalysis.fromAnalysis(Analysis analysis) {
    parentKey =
        db.dbService.emptyKey.append(PackageAnalysis, id: analysis.packageName);
    id = analysis.packageVersion;
    latestAnalysisKey = analysis.key;
    analysisTimestamp = analysis.timestamp;
    panaVersion = analysis.panaVersion;
    flutterVersion = analysis.flutterVersion;
    analysisStatus = analysis.analysisStatus;
    analysisHash = analysis.analysisHash;
  }

  /// Returns true if there was a change that warrants an update in Datastore.
  bool updateWithLatest(Analysis analysis) {
    if (isNewer(analysis.semanticPanaVersion, semanticPanaVersion) ||
        isNewer(analysis.semanticFlutterVersion, semanticFlutterVersion)) {
      // the new analysis' version is older, result probably obsolete
      return false;
    }
    latestAnalysisKey = analysis.key;
    analysisTimestamp = analysis.timestamp;
    panaVersion = analysis.panaVersion;
    flutterVersion = analysis.flutterVersion;
    analysisStatus = analysis.analysisStatus;
    analysisHash = analysis.analysisHash;
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
  String panaVersion;

  @db.StringProperty()
  String flutterVersion;

  Version get semanticPanaVersion => new Version.parse(panaVersion);
  Version get semanticFlutterVersion => new Version.parse(flutterVersion);

  @AnalysisStatusProperty()
  AnalysisStatus analysisStatus;

  @db.DoubleProperty()
  double maintenanceScore;

  @db.BlobProperty()
  List<int> analysisJsonGz;

  @db.StringProperty()
  String analysisHash;

  /// Empty constructor only for appengine.
  Analysis();

  /// Proper constructor that initializes the required fields.
  Analysis.init(this.packageName, this.packageVersion, this.timestamp) {
    parentKey = db.dbService.emptyKey
        .append(PackageAnalysis, id: packageName)
        .append(PackageVersionAnalysis, id: packageVersion);
    timestamp = new DateTime.now().toUtc();
    panaVersion = versions.panaVersion;
    flutterVersion = versions.flutterVersion;
  }

  Map get analysisJson {
    if (analysisJsonGz == null) return null;
    return JSON.decode(UTF8.decode(_gzipCodec.decode(analysisJsonGz)));
  }

  set analysisJson(Map map) {
    if (map == null) {
      analysisJsonGz = null;
      analysisHash = null;
    } else {
      analysisJsonGz = _gzipCodec.encode(UTF8.encode(JSON.encode(map)));
      analysisHash = sha256.convert(analysisJsonGz).toString();
    }
  }
}

final GZipCodec _gzipCodec = new GZipCodec();
