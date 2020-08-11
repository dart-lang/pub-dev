// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:gcloud/db.dart' as db;
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pana/models.dart'
    show LicenseFile, PanaRuntimeInfo, PkgDependency, Report, ReportSection;
import 'package:pub_dev/dartdoc/models.dart';
import 'package:pub_semver/pub_semver.dart';

import '../shared/model_properties.dart';
import '../shared/versions.dart' as versions;

import 'helpers.dart';

export 'package:pana/models.dart'
    show LicenseFile, PanaRuntimeInfo, PkgDependency;

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
class ScoreCard extends db.ExpandoModel<String> with FlagMixin {
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

  /// Granted score from pana and dartdoc analysis.
  @db.IntProperty()
  int grantedPubPoints;

  /// Max score from pana and dartdoc analysis.
  /// `null` if report is not ready yet.
  /// `0` if analysis was not running
  @db.IntProperty()
  int maxPubPoints;

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
        grantedPubPoints: grantedPubPoints,
        maxPubPoints: maxPubPoints,
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
    derivedTags = panaReport?.derivedTags ?? <String>[];
    reportTypes = [
      panaReport == null ? null : ReportType.pana,
      dartdocReport == null ? null : ReportType.dartdoc,
    ]
      ..removeWhere((type) => type == null)
      ..sort();
    panaReport?.flags?.forEach(addFlag);
    final report =
        joinReport(panaReport: panaReport, dartdocReport: dartdocReport);
    grantedPubPoints = report?.grantedPoints;
    maxPubPoints = report?.maxPoints;
    if (isSkipped) {
      grantedPubPoints = 0;
      maxPubPoints = 0;
    }
  }
}

/// Detail of a specific report for a given PackageVersion.
@db.Kind(name: 'ScoreCardReport', idType: db.IdType.String)
class ScoreCardReport extends db.ExpandoModel<String> {
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

  /// Granted score from pana and dartdoc analysis.
  final int grantedPubPoints;

  /// Max score from pana and dartdoc analysis.
  /// `null` if report is not ready yet.
  /// `0` if analysis was not running
  final int maxPubPoints;

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
    this.grantedPubPoints,
    this.maxPubPoints,
    this.popularityScore,
    this.derivedTags,
    this.flags,
    this.reportTypes,
  });

  factory ScoreCardData.fromJson(Map<String, dynamic> json) =>
      _$ScoreCardDataFromJson(json);

  bool get isNew => DateTime.now().difference(packageCreated).inDays <= 30;

  bool get isCurrent => runtimeVersion == versions.runtimeVersion;

  Map<String, dynamic> toJson() => _$ScoreCardDataToJson(this);

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

  /// List of tags computed by `pana`.
  final List<String> derivedTags;

  final List<PkgDependency> pkgDependencies;

  // TODO: remove after `2020.08.05` release is no longer accepted.
  final List<LicenseFile> licenses;

  final LicenseFile licenseFile;

  @JsonKey(includeIfNull: false)
  final Report report;

  /// The flags for the package, version or analysis.
  /// Example values: entries from [PackageFlags].
  @JsonKey(includeIfNull: false)
  List<String> flags = <String>[];

  PanaReport({
    @required this.timestamp,
    @required this.panaRuntimeInfo,
    @required this.reportStatus,
    @required this.derivedTags,
    @required this.pkgDependencies,
    List<LicenseFile> licenses,
    @required LicenseFile licenseFile,
    @required this.report,
    @required this.flags,
  })  : licenses = licenses,
        // when reading older reports: populate field from the list of licenses
        licenseFile = licenseFile ??
            (licenses == null || licenses.isEmpty ? null : licenses.first);

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

  /// The latest dartdoc entry's UUID.
  final DartdocEntry dartdocEntry;

  /// The dartdoc part of the documentation report section.
  final ReportSection documentationSection;

  DartdocReport({
    @required this.reportStatus,
    @required this.dartdocEntry,
    @required this.documentationSection,
  });

  factory DartdocReport.fromJson(Map<String, dynamic> json) =>
      _$DartdocReportFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DartdocReportToJson(this);
}

Report joinReport({PanaReport panaReport, DartdocReport dartdocReport}) {
  var report = panaReport?.report;
  if (report != null && dartdocReport?.documentationSection != null) {
    report = report.joinSection(dartdocReport.documentationSection);
  }
  return report;
}

extension ReportExt on Report {
  int get grantedPoints =>
      sections.fold<int>(0, (sum, section) => sum + section.grantedPoints);

  int get maxPoints =>
      sections.fold<int>(0, (sum, section) => sum + section.maxPoints);
}
