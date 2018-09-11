// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:gcloud/db.dart' as db;
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pana/models.dart' show Suggestion, PkgDependency;
import 'package:pub_semver/pub_semver.dart';

import 'package:pub_dartlang_org/search/scoring.dart'
    show calculateOverallScore;

import '../shared/model_properties.dart';
import '../shared/versions.dart' as versions;

import 'helpers.dart';

export 'package:pana/models.dart'
    show Suggestion, SuggestionCode, SuggestionLevel;

part 'models.g.dart';

final _gzipCodec = new GZipCodec();

abstract class PackageFlags {
  static const String doNotAdvertise = 'do-not-adverise';
  static const String isDiscontinued = 'discontinued';
}

abstract class ReportType {
  static const String pana = 'pana';
  static const String dartdoc = 'dartdoc';
}

abstract class ReportStatus {
  static const String success = 'success';
  static const String failed = 'failed';
  static const String aborted = 'aborted';
}

/// Summary of various reports for a given PackageVersion.
///
/// The details are pulled in from various data sources, and the entry is
/// recalculated from scratch each time any of the sources change.
@db.Kind(name: 'ScoreCard', idType: db.IdType.String)
class ScoreCard extends db.ExpandoModel {
  @db.StringProperty(required: true)
  String packageName;

  @db.StringProperty(required: true)
  String packageVersion;

  @db.StringProperty(required: true)
  String runtimeVersion;

  @db.DateTimeProperty()
  DateTime updated;

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
  List<String> platformTags = <String>[];

  /// The flags for the package, version or analysis.
  /// Example values: entries from [PackageFlags].
  @CompatibleStringListProperty()
  List<String> flags = <String>[];

  /// The report types that are already done for the ScoreCard.
  @CompatibleStringListProperty()
  List<String> reportTypes = <String>[];

  ScoreCard();

  ScoreCard.init({
    @required this.packageName,
    @required this.packageVersion,
    @required this.packageCreated,
    @required this.packageVersionCreated,
  }) {
    runtimeVersion = versions.runtimeVersion;
    final key = scoreCardKey(packageName, packageVersion);
    parentKey = key.parent;
    id = key.id;
    updated = new DateTime.now().toUtc();
  }

  ScoreCardData toData() => new ScoreCardData(
        packageName: packageName,
        packageVersion: packageVersion,
        runtimeVersion: runtimeVersion,
        updated: updated,
        packageCreated: packageCreated,
        packageVersionCreated: packageVersionCreated,
        healthScore: healthScore,
        maintenanceScore: maintenanceScore,
        popularityScore: popularityScore,
        platformTags: platformTags,
        flags: flags,
        reportTypes: reportTypes,
      );

  Version get semanticRuntimeVersion => new Version.parse(runtimeVersion);

  void addFlag(String flag) {
    flags ??= <String>[];
    if (!flags.contains(flag)) {
      flags.add(flag);
    }
  }

  void removeFlag(String flag) {
    flags?.remove(flag);
  }

  void updateFromReports({
    PanaReport panaReport,
    DartdocReport dartdocReport,
  }) {
    healthScore = (panaReport?.healthScore ?? 0.0) *
        (0.9 + ((dartdocReport?.coverageScore ?? 1.0) * 0.1));
    maintenanceScore = panaReport?.maintenanceScore ?? 0.0;
    platformTags = panaReport?.platformTags ?? <String>[];
    reportTypes = [
      panaReport == null ? null : ReportType.pana,
      dartdocReport == null ? null : ReportType.dartdoc,
    ]
      ..removeWhere((type) => type == null)
      ..sort();
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

  @db.DateTimeProperty()
  DateTime updated;

  @db.StringProperty(required: true)
  String reportStatus;

  @db.BlobProperty()
  List<int> reportJsonGz;

  ScoreCardReport();

  ScoreCardReport.init({
    @required this.packageName,
    @required this.packageVersion,
    @required ReportData reportData,
  }) {
    runtimeVersion = versions.runtimeVersion;
    parentKey = scoreCardKey(packageName, packageVersion);
    reportType = reportData.reportType;
    reportStatus = reportData.reportStatus;
    id = reportType;
    updated = new DateTime.now().toUtc();
    reportJson = reportData.toJson();
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

  ReportData get reportData {
    switch (reportType) {
      case ReportType.pana:
        return new PanaReport.fromJson(reportJson);
      case ReportType.dartdoc:
        return new DartdocReport.fromJson(reportJson);
    }
    throw new Exception('Unknown report type: $reportType');
  }
}

@JsonSerializable()
class ScoreCardData {
  final String packageName;
  final String packageVersion;
  final String runtimeVersion;
  final DateTime updated;
  final DateTime packageCreated;
  final DateTime packageVersionCreated;

  /// Score for code health (0.0 - 1.0).
  final double healthScore;

  /// Score for package maintenance (0.0 - 1.0).
  final double maintenanceScore;

  /// Score for package popularity (0.0 - 1.0).
  final double popularityScore;

  /// The platform tags (flutter, web, other).
  final List<String> platformTags;

  /// The flags for the package, version or analysis.
  final List<String> flags;

  /// The report types that are already done for the ScoreCard.
  final List<String> reportTypes;

  ScoreCardData({
    @required this.packageName,
    @required this.packageVersion,
    @required this.runtimeVersion,
    @required this.updated,
    @required this.packageCreated,
    @required this.packageVersionCreated,
    @required this.healthScore,
    @required this.maintenanceScore,
    @required this.popularityScore,
    @required this.platformTags,
    @required this.flags,
    @required this.reportTypes,
  });

  factory ScoreCardData.fromJson(Map<String, dynamic> json) =>
      _$ScoreCardDataFromJson(json);

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

  bool get isCurrent => runtimeVersion == versions.runtimeVersion;

  Map<String, dynamic> toJson() => _$ScoreCardDataToJson(this);
}

abstract class ReportData {
  String get reportType;
  String get reportStatus;
  Map<String, dynamic> toJson();
}

@JsonSerializable()
class PanaReport implements ReportData {
  @override
  String get reportType => ReportType.pana;

  @override
  final String reportStatus;

  final double healthScore;

  final double maintenanceScore;

  /// The platform tags (flutter, web, other).
  @CompatibleStringListProperty()
  List<String> platformTags;

  /// The reason pana decided on the [platformTags].
  final String platformReason;

  final List<PkgDependency> pkgDependencies;

  final List<Suggestion> suggestions;

  PanaReport({
    @required this.reportStatus,
    @required this.healthScore,
    @required this.maintenanceScore,
    @required this.platformTags,
    @required this.platformReason,
    @required this.pkgDependencies,
    @required this.suggestions,
  });

  factory PanaReport.fromJson(Map<String, dynamic> json) =>
      _$PanaReportFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PanaReportToJson(this);
}

@JsonSerializable()
class DartdocReport implements ReportData {
  @override
  String get reportType => ReportType.dartdoc;

  @override
  final String reportStatus;

  final double coverageScore;

  final List<Suggestion> suggestions;

  DartdocReport({
    @required this.reportStatus,
    @required this.coverageScore,
    @required this.suggestions,
  });

  factory DartdocReport.fromJson(Map<String, dynamic> json) =>
      _$DartdocReportFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DartdocReportToJson(this);
}
