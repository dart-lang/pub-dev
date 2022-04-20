// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pana/models.dart';
import 'package:pub_semver/pub_semver.dart';

import '../dartdoc/models.dart';
import '../shared/datastore.dart' as db;
import '../shared/model_properties.dart';
import '../shared/utils.dart' show jsonUtf8Encoder, utf8JsonDecoder;
import '../shared/versions.dart' as versions;

import 'helpers.dart';

part 'models.g.dart';

final _gzipCodec = GZipCodec();

abstract class PackageFlags {
  static const String isDiscontinued = 'discontinued';
  static const String isLatestStable = 'latest-stable';
  static const String isLegacy = 'legacy';
  static const String isObsolete = 'obsolete';
  static const String usesFlutter = 'uses-flutter';
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
class ScoreCard extends db.ExpandoModel<String> {
  @db.StringProperty(required: true)
  String? packageName;

  @db.StringProperty(required: true, indexed: false)
  String? packageVersion;

  @db.StringProperty(required: true)
  String? runtimeVersion;

  @db.DateTimeProperty(required: true)
  DateTime? updated;

  @db.DateTimeProperty(required: true, indexed: false)
  DateTime? packageCreated;

  @db.DateTimeProperty(required: true, indexed: false)
  DateTime? packageVersionCreated;

  /// Granted score from pana and dartdoc analysis.
  @db.IntProperty(indexed: false)
  int? grantedPubPoints;

  /// Max score from pana and dartdoc analysis.
  /// `null` if report is not ready yet.
  /// `0` if analysis was not running
  @db.IntProperty(indexed: false)
  int? maxPubPoints;

  /// Score for package popularity (0.0 - 1.0).
  @db.DoubleProperty(indexed: false)
  double? popularityScore;

  /// List of tags computed by `pana` or other analyzer.
  @db.StringListProperty(indexed: false)
  List<String> derivedTags = <String>[];

  /// The flags for the package, version or analysis.
  /// Example values: entries from [PackageFlags].
  @CompatibleStringListProperty(indexed: false)
  List<String> flags = <String>[];

  /// Compressed, json-encoded content of [PanaReport].
  @db.BlobProperty()
  List<int>? panaReportJsonGz;

  /// Compressed, json-encoded content of [DartdocReport].
  @db.BlobProperty()
  List<int>? dartdocReportJsonGz;

  ScoreCard();

  ScoreCard.init({
    required this.packageName,
    required this.packageVersion,
    required this.packageCreated,
    required this.packageVersionCreated,
  }) {
    runtimeVersion = versions.runtimeVersion;
    final key = scoreCardKey(packageName!, packageVersion!);
    parentKey = key.parent;
    id = key.id;
    updated = clock.now().toUtc();
  }

  ScoreCardData toData() => ScoreCardData(
        packageName: packageName!,
        packageVersion: packageVersion!,
        runtimeVersion: runtimeVersion!,
        updated: updated!,
        packageCreated: packageCreated!,
        packageVersionCreated: packageVersionCreated!,
        grantedPubPoints: grantedPubPoints,
        maxPubPoints: maxPubPoints,
        popularityScore: popularityScore,
        derivedTags: derivedTags,
        flags: flags,
        dartdocReport: DartdocReport.fromBytes(dartdocReportJsonGz),
        panaReport: PanaReport.fromBytes(panaReportJsonGz),
      );

  Version get semanticRuntimeVersion => Version.parse(runtimeVersion!);

  void updateReports({
    PanaReport? panaReport,
    DartdocReport? dartdocReport,
  }) {
    if (panaReport != null) {
      panaReportJsonGz = panaReport.toBytes();
    } else if (panaReportJsonGz != null && panaReportJsonGz!.isNotEmpty) {
      panaReport = PanaReport.fromBytes(panaReportJsonGz);
    }
    if (dartdocReport != null) {
      dartdocReportJsonGz = dartdocReport.toBytes();
    } else if (dartdocReportJsonGz != null && dartdocReportJsonGz!.isNotEmpty) {
      dartdocReport = DartdocReport.fromBytes(dartdocReportJsonGz);
    }

    derivedTags = panaReport?.derivedTags ?? derivedTags;
    flags = {
      ...flags,
      ...?panaReport?.flags,
    }.toList();
    final report =
        joinReport(panaReport: panaReport, dartdocReport: dartdocReport);
    grantedPubPoints = report?.grantedPoints ?? 0;
    maxPubPoints = report?.maxPoints ?? 0;
  }
}

abstract class FlagMixin {
  List<String>? get flags;

  bool get isDiscontinued =>
      flags != null && flags!.contains(PackageFlags.isDiscontinued);

  bool get isLegacy => flags != null && flags!.contains(PackageFlags.isLegacy);

  bool get isObsolete =>
      flags != null && flags!.contains(PackageFlags.isObsolete);

  bool get isSkipped => isDiscontinued || isLegacy || isObsolete;
}

@JsonSerializable()
class ScoreCardData extends Object with FlagMixin {
  final String? packageName;
  final String? packageVersion;
  final String? runtimeVersion;
  final DateTime? updated;
  final DateTime? packageCreated;
  final DateTime? packageVersionCreated;

  /// Granted score from pana and dartdoc analysis.
  final int? grantedPubPoints;

  /// Max score from pana and dartdoc analysis.
  /// `null` if report is not ready yet.
  /// `0` if analysis was not running
  final int? maxPubPoints;

  /// Score for package popularity (0.0 - 1.0).
  final double? popularityScore;

  /// List of tags computed by `pana` or other analyzer.
  final List<String>? derivedTags;

  /// The flags for the package, version or analysis.
  @override
  final List<String>? flags;

  final DartdocReport? dartdocReport;
  final PanaReport? panaReport;

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
    this.dartdocReport,
    this.panaReport,
  });

  factory ScoreCardData.fromJson(Map<String, dynamic> json) =>
      _$ScoreCardDataFromJson(json);

  bool get isNew => clock.now().difference(packageCreated!).inDays <= 30;
  bool get isCurrent => runtimeVersion == versions.runtimeVersion;
  bool get hasApiDocs => dartdocReport?.reportStatus == ReportStatus.success;
  bool get hasPanaReport => panaReport != null;
  bool get hasAllReports => panaReport != null && dartdocReport != null;

  Map<String, dynamic> toJson() => _$ScoreCardDataToJson(this);

  Report? getJoinedReport() =>
      joinReport(panaReport: panaReport, dartdocReport: dartdocReport);
}

@JsonSerializable(includeIfNull: false)
class PanaReport {
  final DateTime? timestamp;

  final PanaRuntimeInfo? panaRuntimeInfo;

  final String? reportStatus;

  /// List of tags computed by `pana`.
  final List<String>? derivedTags;

  /// The list of packages that the current one depends on either directly or
  /// transitively.
  final List<String>? allDependencies;

  // TODO: remove after the latest release with the new pana becomes stable
  final LicenseFile? licenseFile;
  final List<License>? licenses;

  final Report? report;

  final List<ProcessedScreenshot>? screenshots;

  /// The flags for the package, version or analysis.
  /// Example values: entries from [PackageFlags].
  List<String>? flags = <String>[];

  final List<UrlProblem>? urlProblems;

  final Repository? repository;

  PanaReport({
    required this.timestamp,
    required this.panaRuntimeInfo,
    required this.reportStatus,
    required this.derivedTags,
    required this.allDependencies,
    required this.licenseFile,
    required this.licenses,
    required this.report,
    required this.flags,
    required this.urlProblems,
    required this.repository,
    required this.screenshots,
  });

  factory PanaReport.fromJson(Map<String, dynamic> json) =>
      _$PanaReportFromJson(json);

  static PanaReport? fromBytes(List<int>? bytes) {
    if (bytes == null) return null;
    final map = utf8JsonDecoder.convert(_gzipCodec.decode(bytes))
        as Map<String, dynamic>;
    return PanaReport.fromJson(map);
  }

  Map<String, dynamic> toJson() => _$PanaReportToJson(this);

  List<int> toBytes() => _gzipCodec.encode(jsonUtf8Encoder.convert(toJson()));
}

@JsonSerializable()
class DartdocReport {
  final DateTime? timestamp;
  final String? reportStatus;

  /// The latest dartdoc entry's UUID.
  final DartdocEntry? dartdocEntry;

  /// The dartdoc part of the documentation report section.
  final ReportSection? documentationSection;

  DartdocReport({
    required this.timestamp,
    required this.reportStatus,
    required this.dartdocEntry,
    required this.documentationSection,
  });

  factory DartdocReport.fromJson(Map<String, dynamic> json) =>
      _$DartdocReportFromJson(json);

  static DartdocReport? fromBytes(List<int>? bytes) {
    if (bytes == null) return null;
    final map = utf8JsonDecoder.convert(_gzipCodec.decode(bytes))
        as Map<String, dynamic>;
    return DartdocReport.fromJson(map);
  }

  Map<String, dynamic> toJson() => _$DartdocReportToJson(this);

  List<int> toBytes() => _gzipCodec.encode(jsonUtf8Encoder.convert(toJson()));
}

Report? joinReport({PanaReport? panaReport, DartdocReport? dartdocReport}) {
  var report = panaReport?.report;
  if (report != null && dartdocReport?.documentationSection != null) {
    report = report.joinSection(dartdocReport!.documentationSection!);
  }
  return report;
}
