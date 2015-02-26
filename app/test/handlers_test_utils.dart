// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_test;

import 'dart:async';
import 'dart:convert';

import 'package:unittest/unittest.dart';

import 'package:appengine/appengine.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'package:pub_dartlang_org/backend.dart';
import 'package:pub_dartlang_org/handlers.dart';
import 'package:pub_dartlang_org/models.dart';
import 'package:pub_dartlang_org/search_service.dart';
import 'package:pub_dartlang_org/templates.dart';

Future<shelf.Response> issueGet(String path) async {
  var uri = 'https://pub.dartlang.org$path';
  var request = new shelf.Request('GET', Uri.parse(uri));
  return appHandler(request, null);
}

Future expectHtmlResponse(shelf.Response response, {status: 200}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'text/html; charset="utf-8"');
  expect(await response.readAsString(), TemplateMock.Response);
}

Future expectJsonResponse(shelf.Response response, {status: 200, body}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'application/json; charset="utf-8"');
  expect(JSON.decode(await response.readAsString()), body);
}

Future expectYamlResponse(shelf.Response response, {status: 200, body}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'text/yaml; charset="utf-8"');
  expect(JSON.decode(await response.readAsString()), body);
}

Future expectAtomXmlResponse(shelf.Response response,
                             {int status: 200, String regexp}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'],
         'application/atom+xml; charset="utf-8"');
  var text = await response.readAsString();
  expect(new RegExp(regexp).hasMatch(text), isTrue);
}

Future expectRedirectResponse(shelf.Response response, String url) async {
  expect(response.statusCode, 303);
  expect(response.headers['location'], url);
  expect(await response.readAsString(), '');
}

class BackendMock implements Backend {
  final Function latestPackageVersionsFun;
  final Function latestPackagesFun;
  final Function lookupLatestVersionsFun;
  final Function lookupPackageFun;
  final Function lookupPackageVersionFun;
  final Function versionsOfPackageFun;
  final Function downloadUrlFun;

  BackendMock({this.latestPackageVersionsFun,
               this.latestPackagesFun,
               this.lookupLatestVersionsFun,
               this.lookupPackageFun,
               this.lookupPackageVersionFun,
               this.versionsOfPackageFun,
               this.downloadUrlFun});

  get db => throw 'unexpected db access';
  get repository => throw 'unexpected repository access';

  Future<List<PackageVersion>> latestPackageVersions(
      {int offset: null, int limit: null}) async {
    if (latestPackageVersionsFun == null) throw 'no latestPackageVersionsFun';
    return latestPackageVersionsFun(offset: offset, limit: limit);
  }

  Future<List<Package>> latestPackages(
      {int offset: null, int limit: null}) async {
    if (latestPackagesFun == null) throw 'no latestPackagesFun';
    return latestPackagesFun(offset: offset, limit: limit);
  }

  Future<List<PackageVersion>> lookupLatestVersions(
      List<Package> packages) async {
    if (lookupLatestVersionsFun == null) throw 'no lookupLatestVersionsFun';
    return lookupLatestVersionsFun(packages);
  }

  Future<Package> lookupPackage(String packageName) async {
    if (lookupPackageFun == null) throw 'no lookupPackageVersionFun';
    return lookupPackageFun(packageName);
  }

  Future<Package> lookupPackageVersion(String package, String version) async {
    if (lookupPackageVersionFun == null) throw 'no lookupPackageVersionFun';
    return lookupPackageVersionFun(package, version);
  }

  Future<List<PackageVersion>> versionsOfPackage(String packageName) async {
    if (versionsOfPackageFun == null) throw 'no versionsOfPackageFun';
    return versionsOfPackageFun(packageName);
  }

  Future<Uri> downloadUrl(String package, String version) async {
    if (downloadUrlFun == null) throw 'no downloadUrlFun';
    return downloadUrlFun(package, version);
  }
}

class TemplateMock implements TemplateService {
  static String Response = 'foobar';

  String get templateDirectory => null;

  String renderAdminPage(bool privateKeysSet, bool isProduction,
                         {ReloadStatus reloadStatus}) {
    return Response;
  }

  String renderAuthorizedPage() {
    return Response;
  }

  String renderErrorPage(String status, String message, String traceback) {
    return Response;
  }

  String renderIndexPage(List<PackageVersion> recentPackages) {
    return Response;
  }

  String renderLayoutPage(String title, String contentString,
                          {PackageVersion packageVersion}) {
    return Response;
  }

  String renderPagination(PageLinks pageLinks) {
    return Response;
  }

  String renderPkgIndexPage(List<Package> packages,
                            List<PackageVersion> versions,
                            PageLinks links) {
    return Response;
  }

  String renderPkgShowPage(Package package,
                           List<PackageVersion> versions,
                           List<Uri> downloadUris,
                           PackageVersion latestVersion,
                           int totalNumberOfVersions) {
    return Response;
  }

  String renderPkgVersionsPage(String package,
                               List<PackageVersion> versions,
                               List<Uri> versionDownloadUrls) {
    return Response;
  }

  String renderPrivateKeysNewPage(bool wasAlreadySet, bool isProduction) {
    return Response;
  }

  String renderSearchPage(String query,
                          List<PackageVersion> latestVersions,
                          PageLinks pageLinks) {
    return Response;
  }

  String renderSitemapPage() {
    return Response;
  }
}

class UserServiceMock implements UserService {
  static String LoginUrl = 'https://login-service.com';
  static String LogoutUrl = 'https://login-service.com?action=logout';

  final User user;

  UserServiceMock({String email})
      : user = email != null ? new User(email: email) : null;

  Future<String> createLoginUrl(String destination) async {
    return LoginUrl;
  }

  Future<String> createLogoutUrl(String destination) async {
    return LogoutUrl;
  }

  User get currentUser => user;
}

class SearchServiceMock implements SearchService {
  get csearch => throw 'unexpected csearch';
  get httpClient => throw 'unexpected httpClient';

  final Function searchFun;

  SearchServiceMock(this.searchFun);

  Future<SearchResultPage> search(
      String query, int offset, int numResults) async {
    return searchFun(query, offset, numResults);
  }
}
