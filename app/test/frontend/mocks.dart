// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dartlang_org/dartdoc/models.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/scorecard/models.dart';
import 'package:pub_dartlang_org/shared/analyzer_service.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';

class ScoreCardBackendMock implements ScoreCardBackend {
  @override
  Future<ScoreCardData> getScoreCardData(
      String packageName, String packageVersion,
      {bool onlyCurrent}) {
    return null;
  }

  @override
  Future<PackageStatus> getPackageStatus(String package, String version) {
    throw new UnimplementedError();
  }

  @override
  Future deleteOldEntries() {
    throw new UnimplementedError();
  }

  @override
  Future<Map<String, ReportData>> loadReports(
      String packageName, String packageVersion,
      {List<String> reportTypes, String runtimeVersion}) {
    throw new UnimplementedError();
  }

  @override
  Future<bool> shouldUpdateReport(
      String packageName, String packageVersion, String reportType,
      {bool includeDiscontinued = false,
      bool includeObsolete = false,
      Duration successThreshold = const Duration(days: 30),
      Duration failureThreshold = const Duration(days: 1),
      DateTime updatedAfter}) {
    throw new UnimplementedError();
  }

  @override
  Future updateReport(
      String packageName, String packageVersion, ReportData data) {
    throw new UnimplementedError();
  }

  @override
  Future updateScoreCard(String packageName, String packageVersion) {
    throw new UnimplementedError();
  }
}

class AnalyzerClientMock implements AnalyzerClient {
  AnalysisView mockAnalysisView;

  @override
  Future close() async => null;

  @override
  Future<AnalysisView> getAnalysisView(AnalysisKey key) async =>
      mockAnalysisView;

  @override
  Future<List<AnalysisView>> getAnalysisViews(Iterable<AnalysisKey> keys) =>
      Future.wait(keys.map(getAnalysisView));

  @override
  Future triggerAnalysis(
      String package, String version, Set<String> dependentPackages) async {}
}

class DartdocClientMock implements DartdocClient {
  @override
  Future<DartdocEntry> getEntry(String package, String version) async {
    return null;
  }

  @override
  Future<List<DartdocEntry>> getEntries(
      String package, List<String> versions) async {
    return versions.map((s) => null).toList();
  }

  @override
  Future triggerDartdoc(
      String package, String version, Set<String> dependentPackages) async {}

  @override
  Future close() async {}

  @override
  Future<String> getTextContent(
      String package, String version, String relativePath,
      {Duration timeout}) async {
    return null;
  }
}
