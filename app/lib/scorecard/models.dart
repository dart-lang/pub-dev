// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:gcloud/db.dart' as db;
import 'package:meta/meta.dart';

import 'package:pub_dartlang_org/search/scoring.dart'
    show calculateOverallScore;

import '../shared/model_properties.dart';

String _id(String packageName, String packageVersion) =>
    '$packageName/$packageVersion';

final _gzipCodec = new GZipCodec();

/// Summary of various reports for a given PackageVersion.
@db.Kind(name: 'ScoreCard', idType: db.IdType.String)
class ScoreCard extends db.ExpandoModel {
  @db.StringProperty(required: true)
  String packageName;

  @db.StringProperty(required: true)
  String packageVersion;

  @db.DateTimeProperty(required: true)
  DateTime packageCreated;

  @db.DateTimeProperty(required: true)
  DateTime packageVersionCreated;

  @db.BoolProperty()
  bool isDiscontinued;

  @CompatibleStringListProperty()
  List<String> panaPlatformTags;

  @db.DoubleProperty()
  double documentationScore;

  @db.DoubleProperty()
  double healthScore;

  @db.DoubleProperty()
  double maintenanceScore;

  @db.DoubleProperty()
  double popularityScore;

  @db.DoubleProperty()
  double overallScore;

  ScoreCard();

  ScoreCard.init({
    @required this.packageName,
    @required this.packageVersion,
    @required this.packageCreated,
    @required this.packageVersionCreated,
  }) {
    id = _id(packageName, packageVersion);
  }

  void updateOverallScore() {
    // TODO: use documentationScore too
    overallScore = calculateOverallScore(
      health: healthScore ?? 0.0,
      maintenance: maintenanceScore ?? 0.0,
      popularity: popularityScore ?? 0.0,
    );
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
  String reportType;

  @db.BlobProperty()
  List<int> reportJsonGz;

  ScoreCardReport();

  ScoreCardReport.init({
    @required this.packageName,
    @required this.packageVersion,
    @required this.reportType,
  }) {
    parentKey = db.dbService.emptyKey
        .append(ScoreCard, id: _id(packageName, packageVersion));
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
