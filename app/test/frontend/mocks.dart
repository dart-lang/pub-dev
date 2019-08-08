// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dartlang_org/dartdoc/models.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';

class AnalyzerClientMock implements AnalyzerClient {
  AnalysisView mockAnalysisView;

  @override
  Future<AnalysisView> getAnalysisView(String package, String version) async =>
      mockAnalysisView;

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
