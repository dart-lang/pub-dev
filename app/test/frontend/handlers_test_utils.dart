// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.frontend.handlers_test;

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

import 'package:pub_dartlang_org/dartdoc/models.dart';
import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/search_service.dart';
import 'package:pub_dartlang_org/frontend/templates.dart';
import 'package:pub_dartlang_org/shared/analyzer_service.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/search_client.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';
import 'package:pub_dartlang_org/shared/urls.dart';

Future<shelf.Response> issueGet(String path) {
  final uri = '$siteRoot$path';
  return issueGetUri(Uri.parse(uri));
}

Future<shelf.Response> issueGetUri(Uri uri) async {
  final request = new shelf.Request('GET', uri);
  return appHandler(request, null);
}

Future expectHtmlResponse(shelf.Response response, {int status = 200}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'text/html; charset="utf-8"');
  expect(await response.readAsString(), TemplateMock._response);
}

Future expectAtomXmlResponse(shelf.Response response,
    {int status = 200, String regexp}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'],
      'application/atom+xml; charset="utf-8"');
  final text = await response.readAsString();
  expect(new RegExp(regexp).hasMatch(text), isTrue);
}

class BackendMock implements Backend {
  final Function newestPackagesFun;
  final Function latestPackageVersionsFun;
  final Function latestPackagesFun;
  final Function lookupLatestVersionsFun;
  final Function lookupPackageFun;
  final Function lookupPackageVersionFun;
  final Function versionsOfPackageFun;
  final Function downloadUrlFun;

  BackendMock({
    this.newestPackagesFun,
    this.latestPackageVersionsFun,
    this.latestPackagesFun,
    this.lookupLatestVersionsFun,
    this.lookupPackageFun,
    this.lookupPackageVersionFun,
    this.versionsOfPackageFun,
    this.downloadUrlFun,
  });

  @override
  // ignore: always_declare_return_types
  get db => throw new Exception('unexpected db access');

  @override
  // ignore: always_declare_return_types
  get repository => throw new Exception('unexpected repository access');

  @override
  // ignore: always_declare_return_types
  get uiPackageCache => null;

  @override
  Future<List<Package>> newestPackages({int offset, int limit}) async {
    if (newestPackagesFun == null) {
      throw new Exception('no newestPackagesFun');
    }
    return ((await newestPackagesFun(offset: offset, limit: limit)) as List)
        .cast<Package>();
  }

  @override
  Stream<String> allPackageNames(
      {DateTime updatedSince, bool excludeDiscontinued = false}) {
    throw new UnsupportedError('sorry!');
  }

  @override
  Future<List<PackageVersion>> latestPackageVersions(
      {int offset, int limit, bool devVersions = false}) async {
    if (latestPackageVersionsFun == null) {
      throw new Exception('no latestPackageVersionsFun');
    }
    return ((await latestPackageVersionsFun(offset: offset, limit: limit))
            as List)
        .cast<PackageVersion>();
  }

  @override
  Future<List<Package>> latestPackages(
      {int offset, int limit, String detectedType}) async {
    if (latestPackagesFun == null) {
      throw new Exception('no latestPackagesFun');
    }
    return ((await latestPackagesFun(
            offset: offset, limit: limit, detectedType: detectedType)) as List)
        .cast<Package>();
  }

  @override
  Future<List<PackageVersion>> lookupLatestVersions(List<Package> packages,
      {bool devVersions = false}) async {
    if (lookupLatestVersionsFun == null) {
      throw new Exception('no lookupLatestVersionsFun');
    }
    return ((await lookupLatestVersionsFun(packages)) as List)
        .cast<PackageVersion>();
  }

  @override
  Future<Package> lookupPackage(String packageName) async {
    if (lookupPackageFun == null) {
      throw new Exception('no lookupPackageFun');
    }
    return (await lookupPackageFun(packageName)) as Package;
  }

  @override
  Future<List<Package>> lookupPackages(Iterable<String> packageNames) {
    return Future.wait(packageNames.map(lookupPackage));
  }

  @override
  Future<PackageVersion> lookupPackageVersion(
      String package, String version) async {
    if (lookupPackageVersionFun == null) {
      throw new Exception('no lookupPackageVersionFun');
    }
    return (await lookupPackageVersionFun(package, version)) as PackageVersion;
  }

  @override
  Future<List<PackageVersion>> versionsOfPackage(String packageName) async {
    if (versionsOfPackageFun == null) {
      throw new Exception('no versionsOfPackageFun');
    }
    return ((await versionsOfPackageFun(packageName)) as List)
        .cast<PackageVersion>();
  }

  @override
  Future<Uri> downloadUrl(String package, String version) async {
    if (downloadUrlFun == null) {
      throw new Exception('no downloadUrlFun');
    }
    return (await downloadUrlFun(package, version)) as Uri;
  }
}

class TemplateMock implements TemplateService {
  static final String _response = 'foobar';

  @override
  String get templateDirectory => null;

  @override
  String renderAuthorizedPage() {
    return _response;
  }

  @override
  String renderErrorPage(
      String title, String message, List<PackageView> packages) {
    return _response;
  }

  @override
  String renderHelpPage() {
    return _response;
  }

  @override
  String renderIndexPage(String topHtml, String platform) {
    return _response;
  }

  @override
  String renderMiniList(List<PackageView> packages) {
    return _response;
  }

  @override
  String renderLayoutPage(
    PageType type,
    String contentHtml, {
    @required String title,
    String pageDescription,
    String faviconUrl,
    String canonicalUrl,
    String platform,
    SearchQuery searchQuery,
    bool includeSurvey = true,
    bool noIndex = false,
  }) =>
      _response;

  @override
  String renderPagination(PageLinks pageLinks) {
    return _response;
  }

  @override
  String renderPkgIndexPage(
      List<PackageView> packages, PageLinks links, String currentPlatform,
      {SearchQuery searchQuery, int totalCount}) {
    return _response;
  }

  @override
  String renderPkgShowPage(
      Package package,
      bool isVersionPage,
      List<PackageVersion> versions,
      List<Uri> versionDownloadUrls,
      PackageVersion selectedVersion,
      PackageVersion latestStableVersion,
      PackageVersion latestDevVersion,
      int totalNumberOfVersions,
      AnalysisExtract extract,
      AnalysisView analysis) {
    return _response;
  }

  @override
  String renderPkgVersionsPage(String package, List<PackageVersion> versions,
      List<Uri> versionDownloadUrls) {
    return _response;
  }

  @override
  String renderAnalysisTab(
      String package, String sdkConstraint, extract, analysis) {
    return _response;
  }

  @override
  String renderPlatformTabs({
    String platform,
    SearchQuery searchQuery,
    bool isLanding = false,
  }) {
    return _response;
  }
}

class SearchClientMock implements SearchClient {
  final Function searchFun;
  SearchClientMock({this.searchFun});

  @override
  Future<PackageSearchResult> search(SearchQuery query) async {
    if (searchFun == null) {
      throw new Exception('no searchFun');
    }
    return (await searchFun(query)) as PackageSearchResult;
  }

  @override
  Future triggerReindex(String package) async {}

  @override
  Future close() async {}
}

class SearchServiceMock implements SearchService {
  final Function searchFun;

  SearchServiceMock(this.searchFun);

  @override
  Future<SearchResultPage> search(SearchQuery query) async {
    return (await searchFun(query)) as SearchResultPage;
  }

  @override
  Future close() async => null;
}

class AnalyzerClientMock implements AnalyzerClient {
  AnalysisData mockAnalysisData;
  AnalysisExtract mockAnalysisExtract;

  @override
  Future close() async => null;

  @override
  Future<AnalysisView> getAnalysisView(AnalysisKey key) async =>
      new AnalysisView(mockAnalysisData);

  @override
  Future<List<AnalysisView>> getAnalysisViews(Iterable<AnalysisKey> keys) =>
      Future.wait(keys.map(getAnalysisView));

  @override
  Future<AnalysisExtract> getAnalysisExtract(AnalysisKey key) async =>
      mockAnalysisExtract;

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
