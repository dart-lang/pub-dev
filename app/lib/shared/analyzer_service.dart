// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides

import 'package:meta/meta.dart';

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

  /// Analysis was not started, because package is considered discontinued.
  discontinued,

  /// Analysis was not started, because package is considered old and has a
  /// newer stable release.
  outdated,

  /// Analysis was not started, because package doesn't support current Dart SDK.
  legacy,

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
    case AnalysisStatus.discontinued:
    case AnalysisStatus.outdated:
    case AnalysisStatus.legacy:
    case AnalysisStatus.success:
      return 2;
  }
  return -1;
}

class AnalysisData {
  final String packageName;
  final String packageVersion;
  final int analysis;
  final DateTime timestamp;
  final String runtimeVersion;
  final String panaVersion;
  final String flutterVersion;
  final AnalysisStatus analysisStatus;
  final double maintenanceScore;
  final Map<String, dynamic> analysisContent;

  AnalysisData({
    @required this.packageName,
    @required this.packageVersion,
    @required this.analysis,
    @required this.timestamp,
    @required this.runtimeVersion,
    @required this.panaVersion,
    @required this.flutterVersion,
    @required this.analysisStatus,
    @required this.analysisContent,
    @required this.maintenanceScore,
  });
}
