// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:gcloud/db.dart' as db;
import 'package:meta/meta.dart';

import 'package:pub_dartlang_org/search/scoring.dart'
    show calculateOverallScore;

import '../frontend/models.dart' show Package, PackageVersion;
import '../shared/model_properties.dart';
import '../shared/versions.dart' as versions;

db.Key _pvKey(String packageName, String packageVersion) {
  return db.dbService.emptyKey
      .append(Package, id: packageName)
      .append(PackageVersion, id: packageVersion);
}

final _gzipCodec = new GZipCodec();

abstract class PackageFlags {
  static const String doNotAdvertise = 'do-not-adverise';
  static const String isDiscontinued = 'discontinued';
}

/// Summary of various reports for a given PackageVersion.
@db.Kind(name: 'ScoreCard', idType: db.IdType.String)
class ScoreCard extends db.ExpandoModel {
  @db.StringProperty(required: true)
  String packageName;

  @db.StringProperty(required: true)
  String packageVersion;

  @db.StringProperty(required: true)
  String runtimeVersion;

  @db.DateTimeProperty(required: true)
  DateTime packageCreated;

  @db.DateTimeProperty(required: true)
  DateTime packageVersionCreated;

  /// Score for code health (0.0 - 1.0).
  @db.DoubleProperty()
  double healthScore;

  /// Score for package maintenance (0.0 - 1.0).
  @db.DoubleProperty()
  double maintenanceScore;

  /// Score for package popularity (0.0 - 1.0).
  @db.DoubleProperty()
  double popularityScore;

  /// The platform tags (flutter, web, other).
  @CompatibleStringListProperty()
  List<String> platformTags;

  /// The flags for the package, version or analysis.
  @CompatibleStringListProperty()
  List<String> flags;

  ScoreCard();

  ScoreCard.init({
    @required this.packageName,
    @required this.packageVersion,
    @required this.packageCreated,
    @required this.packageVersionCreated,
  }) {
    parentKey = _pvKey(packageName, packageVersion);
    runtimeVersion = versions.runtimeVersion;
    id = runtimeVersion;
  }

  double get overallScore =>
      // TODO: use documentationScore too
      calculateOverallScore(
        health: healthScore ?? 0.0,
        maintenance: maintenanceScore ?? 0.0,
        popularity: popularityScore ?? 0.0,
      );

  bool get isNew => new DateTime.now().difference(packageCreated).inDays <= 30;

  bool get isDiscontinued =>
      flags != null && flags.contains(PackageFlags.isDiscontinued);

  bool get doNotAdvertise =>
      flags != null && flags.contains(PackageFlags.doNotAdvertise);

  void addFlag(String flag) {
    flags ??= <String>[];
    if (!flags.contains(flag)) {
      flags.add(flag);
    }
  }

  void removeFlag(String flag) {
    flags?.remove(flag);
  }
}

/// Detail of a specific report for a given PackageVersion.
@db.Kind(name: 'ScoreCardReport', idType: db.IdType.String)
class ScoreCardReport extends db.ExpandoModel {
  @db.StringProperty(required: true)
  String packageName;

  @db.StringProperty(required: true)
  String packageVersion;

  @db.StringProperty(required: true)
  String runtimeVersion;

  @db.StringProperty(required: true)
  String reportType;

  @db.BlobProperty()
  List<int> reportJsonGz;

  ScoreCardReport();

  ScoreCardReport.init({
    @required this.packageName,
    @required this.packageVersion,
    @required this.reportType,
  }) {
    runtimeVersion = versions.runtimeVersion;
    parentKey = _pvKey(packageName, packageVersion)
        .append(ScoreCard, id: runtimeVersion);
    id = reportType;
  }

  Map<String, dynamic> get reportJson {
    if (reportJsonGz == null) return null;
    return json.decode(utf8.decode(_gzipCodec.decode(reportJsonGz)))
        as Map<String, dynamic>;
  }

  set reportJson(Map<String, dynamic> map) {
    if (map == null) {
      reportJsonGz = null;
    } else {
      reportJsonGz = _gzipCodec.encode(utf8.encode(json.encode(map)));
    }
  }
}
