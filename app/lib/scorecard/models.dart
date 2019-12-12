// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:gcloud/db.dart' as db;
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pana/models.dart'
    show LicenseFile, PanaRuntimeInfo, PkgDependency, Suggestion;
import 'package:pub_semver/pub_semver.dart';

import 'package:pub_dev/search/scoring.dart' show calculateOverallScore;

import '../shared/model_properties.dart';
import '../shared/versions.dart' as versions;

import 'helpers.dart';

export 'package:pana/models.dart'
    show
        LicenseFile,
        PanaRuntimeInfo,
        PkgDependency,
        Suggestion,
        SuggestionCode,
        SuggestionLevel;

part 'models.g.dart';

final _gzipCodec = GZipCodec();

abstract class PackageFlags {
  static const String doNotAdvertise = 'do-not-adverise';
  static const String isDiscontinued = 'discontinued';
  static const String isLatestStable = 'latest-stable';
  static const String isLegacy = 'legacy';
  static const String isObsolete = 'obsolete';
  static const String usesFlutter = 'uses-flutter';
}

abstract class ReportType {
  static const String pana = 'pana';
  static const String dartdoc = 'dartdoc';

  static const values = <String>[pana, dartdoc];
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
class ScoreCard extends db.ExpandoModel with FlagMixin {
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

  /// List of tags computed by `pana` or other analyzer.
  @db.StringListProperty()
  List<String> derivedTags = <String>[];

  /// The flags for the package, version or analysis.
  /// Example values: entries from [PackageFlags].
  @CompatibleStringListProperty()
  @override
  List<String> flags = <String>[];

  /// The report types that are already done for the ScoreCard.
  /// Contains values from [ReportType].
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
    updated = DateTime.now().toUtc();
  }

  ScoreCardData toData() => ScoreCardData(
        packageName: packageName,
        packageVersion: packageVersion,
        runtimeVersion: runtimeVersion,
        updated: updated,
        packageCreated: packageCreated,
        packageVersionCreated: packageVersionCreated,
        healthScore: healthScore,
        maintenanceScore: maintenanceScore,
        popularityScore: popularityScore,
        derivedTags: derivedTags,
        flags: flags,
        reportTypes: reportTypes,
      );

  Version get semanticRuntimeVersion => Version.parse(runtimeVersion);

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
    healthScore = _applySuggestions(
      panaReport?.healthScore ?? 0.0,
      dartdocReport?.healthSuggestions,
    );
    maintenanceScore = _applySuggestions(
      panaReport?.maintenanceScore ?? 0.0,
      dartdocReport?.maintenanceSuggestions,
    );
    derivedTags = panaReport?.derivedTags ?? <String>[];
    reportTypes = [
      panaReport == null ? null : ReportType.pana,
      dartdocReport == null ? null : ReportType.dartdoc,
    ]
      ..removeWhere((type) => type == null)
      ..sort();
    panaReport?.flags?.forEach(addFlag);
    if (isSkipped) {
      healthScore = 0.0;
      maintenanceScore = 0.0;
    }
  }

  double _applySuggestions(double score, List<Suggestion> suggestions) {
    suggestions?.forEach((s) {
      if (s.score != null) {
        score -= s.score / 100.0;
      }
    });
    return math.max(score, 0.0);
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
    updated = DateTime.now().toUtc();
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
        return PanaReport.fromJson(reportJson);
      case ReportType.dartdoc:
        return DartdocReport.fromJson(reportJson);
    }
    throw Exception('Unknown report type: $reportType');
  }
}

abstract class FlagMixin {
  List<String> get flags;

  bool get isDiscontinued =>
      flags != null && flags.contains(PackageFlags.isDiscontinued);

  bool get isLegacy => flags != null && flags.contains(PackageFlags.isLegacy);

  bool get isObsolete =>
      flags != null && flags.contains(PackageFlags.isObsolete);

  bool get doNotAdvertise =>
      flags != null && flags.contains(PackageFlags.doNotAdvertise);

  bool get isSkipped => isDiscontinued || isLegacy || isObsolete;

  bool get usesFlutter =>
      flags != null && flags.contains(PackageFlags.usesFlutter);
}

@JsonSerializable()
class ScoreCardData extends Object with FlagMixin {
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

  /// List of tags computed by `pana` or other analyzer.
  final List<String> derivedTags;

  /// The flags for the package, version or analysis.
  @override
  final List<String> flags;

  /// The report types that are already done for the ScoreCard.
  final List<String> reportTypes;

  ScoreCardData({
    this.packageName,
    this.packageVersion,
    this.runtimeVersion,
    this.updated,
    this.packageCreated,
    this.packageVersionCreated,
    this.healthScore,
    this.maintenanceScore,
    this.popularityScore,
    this.derivedTags,
    this.flags,
    this.reportTypes,
  });

  factory ScoreCardData.fromJson(Map<String, dynamic> json) =>
      _$ScoreCardDataFromJson(json);

  double get overallScore {
    return calculateOverallScore(
      health: healthScore ?? 0.0,
      maintenance: maintenanceScore ?? 0.0,
      popularity: popularityScore ?? 0.0,
    );
  }

  bool get isNew => DateTime.now().difference(packageCreated).inDays <= 30;

  bool get isCurrent => runtimeVersion == versions.runtimeVersion;

  Map<String, dynamic> toJson() {
    final map = _$ScoreCardDataToJson(this);
    map['overallScore'] = overallScore;
    return map;
  }

  /// Whether the data has all the required report types.
  bool hasReports(List<String> requiredTypes) {
    if (requiredTypes == null || requiredTypes.isEmpty) return true;
    if (reportTypes == null || reportTypes.isEmpty) return false;
    return requiredTypes.every(reportTypes.contains);
  }
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

  final DateTime timestamp;

  final PanaRuntimeInfo panaRuntimeInfo;

  @override
  final String reportStatus;

  final double healthScore;

  final double maintenanceScore;

  /// List of tags computed by `pana`.
  final List<String> derivedTags;

  final List<PkgDependency> pkgDependencies;

  /// Suggestions related to the pana processing and overall package status.
  @JsonKey(includeIfNull: false)
  final List<Suggestion> panaSuggestions;

  /// Suggestions related to the package health score.
  @JsonKey(includeIfNull: false)
  final List<Suggestion> healthSuggestions;

  /// Suggestions related to the package maintenance score.
  @JsonKey(includeIfNull: false)
  final List<Suggestion> maintenanceSuggestions;

  List<LicenseFile> licenses;

  /// The flags for the package, version or analysis.
  /// Example values: entries from [PackageFlags].
  @JsonKey(includeIfNull: false)
  List<String> flags = <String>[];

  PanaReport({
    @required this.timestamp,
    @required this.panaRuntimeInfo,
    @required this.reportStatus,
    @required this.healthScore,
    @required this.maintenanceScore,
    @required this.derivedTags,
    @required this.pkgDependencies,
    @required this.licenses,
    @required this.panaSuggestions,
    @required this.healthSuggestions,
    @required this.maintenanceSuggestions,
    @required this.flags,
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

  /// The percent of API symbols with documentation.
  final double coverage;
  final double coverageScore;

  /// Suggestions related to the package health score.
  @JsonKey(includeIfNull: false)
  final List<Suggestion> healthSuggestions;

  /// Suggestions related to the package maintenance score.
  @JsonKey(includeIfNull: false)
  final List<Suggestion> maintenanceSuggestions;

  DartdocReport({
    @required this.reportStatus,
    @required this.coverage,
    @required this.coverageScore,
    @required this.healthSuggestions,
    @required this.maintenanceSuggestions,
  });

  factory DartdocReport.fromJson(Map<String, dynamic> json) =>
      _$DartdocReportFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DartdocReportToJson(this);
}
