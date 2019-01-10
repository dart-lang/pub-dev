// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.frontend.handlers_test;

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
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
  final content = await response.readAsString();
  expect(content, contains('<!DOCTYPE html>'));
  expect(content, contains('</html>'));
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
  final Function updatePackageInviteFn;

  BackendMock({
    this.newestPackagesFun,
    this.latestPackageVersionsFun,
    this.latestPackagesFun,
    this.lookupLatestVersionsFun,
    this.lookupPackageFun,
    this.lookupPackageVersionFun,
    this.versionsOfPackageFun,
    this.downloadUrlFun,
    this.updatePackageInviteFn,
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

  @override
  Future<PackageInvite> confirmPackageInvite({
    String packageName,
    String type,
    String recipientEmail,
    String urlNonce,
  }) {
    throw new UnimplementedError();
  }

  @override
  Future<InviteStatus> updatePackageInvite({
    String packageName,
    String type,
    String recipientEmail,
    String fromEmail,
  }) async {
    if (updatePackageInviteFn == null) {
      throw new Exception('no downloadUrlFun');
    }
    return (await updatePackageInviteFn(
      packageName: packageName,
      type: type,
      recipientEmail: recipientEmail,
      fromEmail: fromEmail,
    )) as InviteStatus;
  }

  @override
  Future deleteObsoleteInvites() {
    throw new UnimplementedError();
  }
}
