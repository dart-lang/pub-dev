// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:pana/pana.dart' hide ReportStatus;

import '../job/backend.dart';
import '../scorecard/backend.dart';
import '../scorecard/models.dart';
import '../shared/versions.dart' show runtimeVersion;

export 'package:pana/pana.dart' show LicenseFile;
export '../scorecard/models.dart' show ReportExt;

/// Sets the analyzer client.
void registerAnalyzerClient(AnalyzerClient client) =>
    ss.register(#_analyzerClient, client);

/// The active analyzer client.
AnalyzerClient get analyzerClient =>
    ss.lookup(#_analyzerClient) as AnalyzerClient;

/// Client methods that access the analyzer service and the internals of the
/// analysis data. This keeps the interface narrow over the raw analysis data.
class AnalyzerClient {
  Future<AnalysisView> getAnalysisView(String package, String version) async {
    final card = await scoreCardBackend.getScoreCardData(package, version);
    if (card == null) {
      return AnalysisView();
    }
    final reports = await scoreCardBackend.loadReports(
      package,
      version,
      runtimeVersion: card.runtimeVersion,
    );
    final panaReport = reports[ReportType.pana] as PanaReport;
    final dartdocReport = reports[ReportType.dartdoc] as DartdocReport;
    return AnalysisView._(card, panaReport, dartdocReport);
  }

  Future<void> triggerAnalysis(
    String package,
    String version,
    Set<String> dependentPackages, {
    bool isHighPriority = false,
  }) async {
    await jobBackend.trigger(
      JobService.analyzer,
      package,
      version: version,
      isHighPriority: isHighPriority,
    );
    // dependent packages are triggered with default priority
    for (final String package in dependentPackages) {
      await jobBackend.trigger(JobService.analyzer, package);
    }
  }
}

class AnalysisView {
  final ScoreCardData _card;
  final PanaReport _pana;
  final DartdocReport _dartdoc;
  Report _report;

  AnalysisView._(this._card, this._pana, this._dartdoc);

  factory AnalysisView({
    ScoreCardData card,
    PanaReport panaReport,
    DartdocReport dartdocReport,
  }) =>
      AnalysisView._(card, panaReport, dartdocReport);

  PanaRuntimeInfo get panaRuntimeInfo => _pana?.panaRuntimeInfo;

  bool get isLatestRuntimeVersion => _card?.runtimeVersion == runtimeVersion;

  bool get hasAnalysisData => _card != null;
  ScoreCardData get card => _card;
  bool get hasApiDocs =>
      _dartdoc != null && _dartdoc.reportStatus == ReportStatus.success;

  DateTime get timestamp => _pana?.timestamp;

  Report get report =>
      _report ??= joinReport(panaReport: _pana, dartdocReport: _dartdoc);

  List<String> get derivedTags => _card?.derivedTags ?? const <String>[];

  LicenseFile get licenseFile => _pana?.licenseFile;

  List<String> get allDependencies => _pana?.allDependencies;
}
