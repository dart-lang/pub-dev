// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:_pub_shared/search/tags.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pana/models.dart';
import 'package:pub_dev/task/models.dart';

import '../scorecard/backend.dart';
import '../shared/datastore.dart' as db;
import '../shared/popularity_storage.dart';
import '../shared/utils.dart' show jsonUtf8Encoder, utf8JsonDecoder;

part 'models.g.dart';

final _gzipCodec = GZipCodec();

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
class ScoreCard extends db.ExpandoModel<String> {}

mixin FlagMixin {
  List<String>? get tags;

  bool get isDiscontinued =>
      tags?.contains(PackageTags.isDiscontinued) ?? false;

  bool get isLegacy => tags?.contains(PackageVersionTags.isLegacy) ?? false;

  bool get isDart3Incompatible =>
      tags?.contains(PackageVersionTags.isDart3Incompatible) ?? false;

  bool get isObsolete => tags?.contains(PackageVersionTags.isObsolete) ?? false;

  bool get isSkipped =>
      isDiscontinued || isLegacy || isDart3Incompatible || isObsolete;
}

@JsonSerializable()
class ScoreCardData extends Object with FlagMixin {
  final String? packageName;
  final String? packageVersion;
  final String? runtimeVersion;
  final DateTime? updated;
  final DartdocReport? dartdocReport;
  final PanaReport? panaReport;
  final PackageVersionStatus? taskStatus;

  ScoreCardData({
    this.packageName,
    this.packageVersion,
    this.runtimeVersion,
    this.updated,
    this.dartdocReport,
    this.panaReport,
    this.taskStatus,
  });

  factory ScoreCardData.fromJson(Map<String, dynamic> json) =>
      _$ScoreCardDataFromJson(json);

  /// Granted score from pana and dartdoc analysis.
  int get grantedPubPoints => report?.grantedPoints ?? 0;

  /// Max score from pana and dartdoc analysis.
  /// `null` if report is not ready yet.
  /// `0` if analysis was not running
  int get maxPubPoints => report?.maxPoints ?? 0;

  /// List of tags computed by `pana` or other analyzer.
  List<String>? get derivedTags => panaReport?.derivedTags;

  bool get hasApiDocs => dartdocReport?.reportStatus == ReportStatus.success;
  bool get hasPanaReport => panaReport != null;

  Map<String, dynamic> toJson() => _$ScoreCardDataToJson(this);

  late final report = panaReport?.report;

  @override
  List<String>? get tags => panaReport?.derivedTags;

  // TODO: refactor code to use popularityStorage directly.
  double get popularityScore => popularityStorage.lookup(packageName!);
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

  final List<License>? licenses;

  final Report? report;
  final AnalysisResult? result;

  final List<ProcessedScreenshot>? screenshots;

  final List<UrlProblem>? urlProblems;

  PanaReport({
    required this.timestamp,
    required this.panaRuntimeInfo,
    required this.reportStatus,
    required this.derivedTags,
    required this.allDependencies,
    required this.licenses,
    required this.report,
    required this.result,
    required this.urlProblems,
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

  static PanaReport fromSummary(
    Summary? summary, {
    required PackageStatus packageStatus,
  }) {
    final reportStatus =
        summary == null ? ReportStatus.aborted : ReportStatus.success;
    return PanaReport(
      timestamp: summary?.createdAt,
      panaRuntimeInfo: summary?.runtimeInfo,
      reportStatus: reportStatus,
      derivedTags: <String>{
        ...?summary?.tags,
        if (packageStatus.isLegacy) PackageVersionTags.isLegacy,
        if (packageStatus.isDart3Incompatible)
          PackageVersionTags.isDart3Incompatible,
        if (packageStatus.isObsolete) PackageVersionTags.isObsolete,
        if (packageStatus.isDiscontinued) PackageTags.isDiscontinued,
      }.toList(),
      allDependencies: summary?.allDependencies,
      licenses: summary?.licenses,
      report: summary?.report,
      result: summary?.result,
      urlProblems: summary?.urlProblems,
      screenshots: summary?.screenshots,
    );
  }

  Map<String, dynamic> toJson() => _$PanaReportToJson(this);

  late final asBytes = _gzipCodec.encode(jsonUtf8Encoder.convert(toJson()));
}

@JsonSerializable()
class DartdocReport {
  final String? reportStatus;

  DartdocReport({
    required this.reportStatus,
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

  late final asBytes = _gzipCodec.encode(jsonUtf8Encoder.convert(toJson()));
}
