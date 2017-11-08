// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides
library pub_dartlang_org.shared.analyzer_service;

import 'package:json_annotation/json_annotation.dart';

part 'analyzer_service.g.dart';

class AnalysisKey {
  final String package;
  final String version;

  AnalysisKey(this.package, this.version);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnalysisKey &&
          package == other.package &&
          version == other.version;

  @override
  int get hashCode => package.hashCode ^ version.hashCode;

  @override
  String toString() => '$package $version';
}

/// These status codes mark the status of the analysis, not the result/report.
enum AnalysisStatus {
  /// Analysis was aborted without a report.
  /// Probably an issue with pana or an unhandled edge case.
  aborted,

  /// Analysis was completed but there are missing parts.
  /// One or more tools failed to produce the expected output.
  failure,

  /// Analysis was completed without issues.
  success,
}

/// Gets a comparable level for analysis statuses. The bigger the better.
int analysisStatusLevel(AnalysisStatus status) {
  if (status == null) return -1;
  switch (status) {
    case AnalysisStatus.aborted:
      return 0;
    case AnalysisStatus.failure:
      return 1;
    case AnalysisStatus.success:
      return 2;
  }
  return -1;
}

/// The data which is served thought the HTTP interface of the analyzer service.
@JsonSerializable()
class AnalysisData extends Object with _$AnalysisDataSerializerMixin {
  final String packageName;
  final String packageVersion;
  final int analysis;
  final DateTime timestamp;
  final String panaVersion;
  final String flutterVersion;
  final AnalysisStatus analysisStatus;
  final Map analysisContent;

  AnalysisData({
    this.packageName,
    this.packageVersion,
    this.analysis,
    this.timestamp,
    this.panaVersion,
    this.flutterVersion,
    this.analysisStatus,
    this.analysisContent,
  });

  factory AnalysisData.fromJson(Map json) => _$AnalysisDataFromJson(json);
}

@JsonSerializable()
class AnalysisExtract extends Object with _$AnalysisExtractSerializerMixin {
  final double health;
  final double maintenance;
  final double popularity;

  final List<String> platforms;

  final DateTime timestamp;

  AnalysisExtract({
    this.health,
    this.maintenance,
    this.popularity,
    this.platforms,
    this.timestamp,
  });

  factory AnalysisExtract.fromJson(Map<String, dynamic> json) =>
      _$AnalysisExtractFromJson(json);
}
