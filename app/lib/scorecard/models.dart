// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:_pub_shared/search/tags.dart';
import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:pana/models.dart';
import 'package:pub_semver/pub_semver.dart';

import '../dartdoc/models.dart';
import '../scorecard/backend.dart';
import '../shared/datastore.dart' as db;
import '../shared/popularity_storage.dart';
import '../shared/utils.dart' show jsonUtf8Encoder, utf8JsonDecoder;
import '../shared/versions.dart' as versions;

import 'helpers.dart';

part 'models.g.dart';

final _gzipCodec = GZipCodec();
final _logger = Logger('scorecard.model');

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

  /// Tries to decode and return the data stored on the [ScoreCard].
  ///
  /// May return `null` when the stored data from an older runtime
  /// is not compatible with the current runtime.
  ScoreCardData? tryDecodeData() {
    try {
      return _toData();
    } catch (e, st) {
      if (runtimeVersion == versions.runtimeVersion) {
        final msg =
            'Unable to decode current ScoreCard data ($packageName/$packageVersion).';
        _logger.shout(msg, e, st);
        rethrow;
      }
      _logger.info('Unable to decode old ScoreCard data.', e, st);
    }
    return null;
  }

  ScoreCardData _toData() => ScoreCardData(
        packageName: packageName!,
        packageVersion: packageVersion!,
        runtimeVersion: runtimeVersion!,
        updated: updated!,
        packageCreated: packageCreated!,
        packageVersionCreated: packageVersionCreated!,
        dartdocReport: DartdocReport.fromBytes(dartdocReportJsonGz),
        panaReport: PanaReport.fromBytes(panaReportJsonGz),
      );

  Version get semanticRuntimeVersion => Version.parse(runtimeVersion!);

  void updateReports({
    PanaReport? panaReport,
    DartdocReport? dartdocReport,
  }) {
    if (panaReport != null) {
      panaReportJsonGz = panaReport.asBytes;
    } else if (panaReportJsonGz != null && panaReportJsonGz!.isNotEmpty) {
      panaReport = PanaReport.fromBytes(panaReportJsonGz);
    }
    if (dartdocReport != null) {
      dartdocReportJsonGz = dartdocReport.asBytes;
    } else if (dartdocReportJsonGz != null && dartdocReportJsonGz!.isNotEmpty) {
      dartdocReport = DartdocReport.fromBytes(dartdocReportJsonGz);
    }
  }
}

abstract class FlagMixin {
  List<String>? get tags;

  bool get isDiscontinued =>
      tags?.contains(PackageTags.isDiscontinued) ?? false;

  bool get isLegacy => tags?.contains(PackageVersionTags.isLegacy) ?? false;

  bool get isObsolete => tags?.contains(PackageVersionTags.isObsolete) ?? false;

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
  final DartdocReport? dartdocReport;
  final PanaReport? panaReport;

  ScoreCardData({
    this.packageName,
    this.packageVersion,
    this.runtimeVersion,
    this.updated,
    this.packageCreated,
    this.packageVersionCreated,
    this.dartdocReport,
    this.panaReport,
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

  bool get isNew => clock.now().difference(packageCreated!).inDays <= 30;
  bool get isCurrent => runtimeVersion == versions.runtimeVersion;
  bool get hasApiDocs => dartdocReport?.reportStatus == ReportStatus.success;
  bool get hasPanaReport => panaReport != null;
  bool get hasAllReports => panaReport != null && dartdocReport != null;

  Map<String, dynamic> toJson() => _$ScoreCardDataToJson(this);

  late final report =
      joinReport(panaReport: panaReport, dartdocReport: dartdocReport);

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
      // TODO: use summary.createdAt once it lands
      timestamp: clock.now().toUtc(),
      panaRuntimeInfo: summary?.runtimeInfo,
      reportStatus: reportStatus,
      derivedTags: <String>{
        ...?summary?.tags,
        if (packageStatus.isLegacy) PackageVersionTags.isLegacy,
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

  late final asBytes = _gzipCodec.encode(jsonUtf8Encoder.convert(toJson()));
}

Report? joinReport({PanaReport? panaReport, DartdocReport? dartdocReport}) {
  var report = panaReport?.report;
  if (report != null && dartdocReport?.documentationSection != null) {
    report = report.joinSection(dartdocReport!.documentationSection!);
  }
  return report;
}
