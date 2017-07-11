// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_test;

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/search_service.dart';
import 'package:pub_dartlang_org/frontend/templates.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';

Future<shelf.Response> issueGet(String path) async {
  final uri = 'https://pub.dartlang.org$path';
  final request = new shelf.Request('GET', Uri.parse(uri));
  return appHandler(request, null);
}

Future expectHtmlResponse(shelf.Response response, {status: 200}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'text/html; charset="utf-8"');
  expect(await response.readAsString(), TemplateMock.Response);
}

Future expectAtomXmlResponse(shelf.Response response,
    {int status: 200, String regexp}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'],
      'application/atom+xml; charset="utf-8"');
  final text = await response.readAsString();
  expect(new RegExp(regexp).hasMatch(text), isTrue);
}

class BackendMock implements Backend {
  final Function latestPackageVersionsFun;
  final Function latestPackagesFun;
  final Function lookupLatestVersionsFun;
  final Function lookupPackageFun;
  final Function lookupPackageVersionFun;
  final Function versionsOfPackageFun;
  final Function downloadUrlFun;

  BackendMock(
      {this.latestPackageVersionsFun,
      this.latestPackagesFun,
      this.lookupLatestVersionsFun,
      this.lookupPackageFun,
      this.lookupPackageVersionFun,
      this.versionsOfPackageFun,
      this.downloadUrlFun});

  @override
  // ignore: always_declare_return_types
  get db => throw 'unexpected db access';

  @override
  // ignore: always_declare_return_types
  get repository => throw 'unexpected repository access';

  @override
  // ignore: always_declare_return_types
  get uiPackageCache => null;

  @override
  Future<List<PackageVersion>> latestPackageVersions(
      {int offset: null, int limit: null}) async {
    if (latestPackageVersionsFun == null) throw 'no latestPackageVersionsFun';
    return latestPackageVersionsFun(offset: offset, limit: limit);
  }

  @override
  Future<List<Package>> latestPackages(
      {int offset: null, int limit: null, String detectedType}) async {
    if (latestPackagesFun == null) throw 'no latestPackagesFun';
    return latestPackagesFun(
        offset: offset, limit: limit, detectedType: detectedType);
  }

  @override
  Future<List<PackageVersion>> lookupLatestVersions(
      List<Package> packages) async {
    if (lookupLatestVersionsFun == null) throw 'no lookupLatestVersionsFun';
    return lookupLatestVersionsFun(packages);
  }

  @override
  Future<Package> lookupPackage(String packageName) async {
    if (lookupPackageFun == null) throw 'no lookupPackageVersionFun';
    return lookupPackageFun(packageName);
  }

  @override
  Future<PackageVersion> lookupPackageVersion(
      String package, String version) async {
    if (lookupPackageVersionFun == null) throw 'no lookupPackageVersionFun';
    return lookupPackageVersionFun(package, version);
  }

  @override
  Future<List<PackageVersion>> versionsOfPackage(String packageName) async {
    if (versionsOfPackageFun == null) throw 'no versionsOfPackageFun';
    return versionsOfPackageFun(packageName);
  }

  @override
  Future<Uri> downloadUrl(String package, String version) async {
    if (downloadUrlFun == null) throw 'no downloadUrlFun';
    return downloadUrlFun(package, version);
  }
}

class TemplateMock implements TemplateService {
  static String Response = 'foobar';

  @override
  String get templateDirectory => null;

  @override
  String renderAuthorizedPage() {
    return Response;
  }

  @override
  String renderErrorPage(String status, String message, String traceback) {
    return Response;
  }

  @override
  String renderIndexPage(List<PackageVersion> recentPackages) {
    return Response;
  }

  @override
  String renderLayoutPage(String title, String contentString,
      {PackageVersion packageVersion,
      Map<String, String> pageMapAttributes,
      String faviconUrl,
      String searchQuery,
      bool includeSurvey}) {
    return Response;
  }

  @override
  String renderPagination(PageLinks pageLinks) {
    return Response;
  }

  @override
  String renderPkgIndexPage(
      List<Package> packages, List<PackageVersion> versions, PageLinks links,
      {String title, String faviconUrl, String descriptionHtml}) {
    return Response;
  }

  @override
  String renderPkgShowPage(
      Package package,
      AnalysisReport report,
      List<PackageVersion> versions,
      List<Uri> versionDownloadUrls,
      PackageVersion selectedVersion,
      PackageVersion latestStableVersion,
      PackageVersion latestDevVersion,
      int totalNumberOfVersions) {
    return Response;
  }

  @override
  String renderPkgVersionsPage(String package, List<PackageVersion> versions,
      List<Uri> versionDownloadUrls) {
    return Response;
  }

  @override
  String renderPrivateKeysNewPage(bool wasAlreadySet, bool isProduction) {
    return Response;
  }

  @override
  String renderSearchPage(SearchResultPage resultPage, PageLinks pageLinks) {
    return Response;
  }
}

class SearchServiceMock implements SearchService {
  @override
  // ignore: always_declare_return_types
  get csearch => throw 'unexpected csearch';

  @override
  // ignore: always_declare_return_types
  get httpClient => throw 'unexpected httpClient';

  @override
  // ignore: always_declare_return_types
  get searchServiceClient => throw 'unexpected searchServiceClient';

  final Function searchFun;

  SearchServiceMock(this.searchFun);

  @override
  Future<SearchResultPage> search(SearchQuery query, bool useService) async {
    return searchFun(query);
  }
}
