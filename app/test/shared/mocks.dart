// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dartlang_org/frontend/search_service.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/search_client.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';

class SearchClientMock implements SearchClient {
  final Function searchFun;
  SearchClientMock({this.searchFun});

  @override
  Future<PackageSearchResult> search(SearchQuery query) async {
    if (searchFun == null) throw 'no searchFun';
    return searchFun(query);
  }

  @override
  Future close() async {}
}

class SearchServiceMock implements SearchService {
  final Function searchFun;

  SearchServiceMock(this.searchFun);

  @override
  Future<SearchResultPage> search(SearchQuery query) async {
    return searchFun(query);
  }

  @override
  Future close() async => null;
}

class AnalyzerClientMock implements AnalyzerClient {
  AnalysisData mockAnalysisData;

  @override
  Future<AnalysisData> getAnalysisData(String package, String version) async =>
      mockAnalysisData;

  @override
  Future close() async => null;

  @override
  Future<AnalysisView> getAnalysisView(String package, String version) async =>
      new AnalysisView(await getAnalysisData(package, version));
}

class AnalysisViewMock implements AnalysisView {
  @override
  bool hasAnalysisData = true;

  @override
  AnalysisStatus analysisStatus;

  @override
  List<String> getTransitiveDependencies() => throw 'Not implemented';

  @override
  double health;

  @override
  String licenseText;

  @override
  DateTime timestamp;

  @override
  List<String> platforms;

  AnalysisViewMock({this.platforms});
}
