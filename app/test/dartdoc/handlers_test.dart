// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_test;

import 'dart:async';
import 'dart:io';

import 'package:pub_dartlang_org/dartdoc/models.dart';
import 'package:pub_dartlang_org/dartdoc/pub_dartdoc_data.dart';
import 'package:pub_dartlang_org/shared/task_scheduler.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

import 'package:pub_dartlang_org/dartdoc/backend.dart';
import 'package:pub_dartlang_org/dartdoc/handlers.dart';
import 'package:pub_dartlang_org/shared/urls.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/utils.dart';

void main() {
  group('path parsing', () {
    void testUri(String rqPath, String package, [String version, String path]) {
      final p = parseRequestUri(Uri.parse('$siteRoot$rqPath'));
      if (package == null) {
        expect(p, isNull);
      } else {
        expect(p, isNotNull);
        expect(p.package, package);
        expect(p.version, version);
        expect(p.path, path);
      }
    }

    test('/documentation', () {
      testUri('/documentation', null);
    });
    test('/documentation/', () {
      testUri('/documentation/', null);
    });
    test('/documentation/angular', () {
      testUri('/documentation/angular', 'angular');
    });
    test('/documentation/angular/', () {
      testUri('/documentation/angular/', 'angular');
    });
    test('/documentation/angular/4.0.0+2', () {
      testUri('/documentation/angular/4.0.0+2', 'angular', '4.0.0+2');
    });
    test('/documentation/angular/4.0.0+2/', () {
      testUri('/documentation/angular/4.0.0+2/', 'angular', '4.0.0+2',
          'index.html');
    });
    test('/documentation/angular/4.0.0+2/subdir/', () {
      testUri('/documentation/angular/4.0.0+2/subdir/', 'angular', '4.0.0+2',
          'subdir/index.html');
    });
    test('/documentation/angular/4.0.0+2/file.html', () {
      testUri('/documentation/angular/4.0.0+2/file.html', 'angular', '4.0.0+2',
          'file.html');
    });
    test('/documentation/angular/4.0.0+2/file.html', () {
      testUri('/documentation/angular/4.0.0+2/file.html', 'angular', '4.0.0+2',
          'file.html');
    });
  });

  group('dartdoc handlers', () {
    Future<shelf.Response> issueGet(String uri) => dartdocServiceHandler(
        new shelf.Request('GET', Uri.parse('https://pub.dartlang.org$uri')));

    test('/documentation/flutter redirect', () async {
      expectRedirectResponse(
        await issueGet('/documentation/flutter'),
        'https://docs.flutter.io/',
      );
    });

    test('/documentation/flutter/version redirect', () async {
      expectRedirectResponse(
        await issueGet('/documentation/flutter/version'),
        'https://docs.flutter.io/',
      );
    });

    test('/documentation/foo/bar redirect', () async {
      expectRedirectResponse(
        await issueGet('/documentation/foor/bar'),
        'https://pub.dartlang.org/documentation/foor/bar/',
      );
    });

    scopedTest('trailing slash redirect', () async {
      expectRedirectResponse(
          await issueGet('/documentation/foo'), '/documentation/foo/latest/');
    });

    scopedTest('/documentation/no_pkg redirect', () async {
      registerDartdocBackend(new DartdocBackendMock());
      expectRedirectResponse(await issueGet('/documentation/no_pkg/latest/'),
          '/packages/no_pkg/versions');
    });

    test('dartdocs.org redirect', () async {
      expectRedirectResponse(
        await dartdocServiceHandler(new shelf.Request('GET',
            Uri.parse('https://dartdocs.org/documentation/pkg/latest/'))),
        'https://pub.dartlang.org/documentation/pkg/latest/',
      );
    });

    test('www.dartdocs.org redirect', () async {
      expectRedirectResponse(
        await dartdocServiceHandler(new shelf.Request('GET',
            Uri.parse('https://www.dartdocs.org/documentation/pkg/latest/'))),
        'https://pub.dartlang.org/documentation/pkg/latest/',
      );
    });
  });
}

class DartdocBackendMock implements DartdocBackend {
  final List<DartdocEntry> entries;
  final Map<String, String> latestVersions;

  DartdocBackendMock({this.entries, this.latestVersions});

  @override
  Future<TaskTargetStatus> checkTargetStatus(
      String package, String version, DateTime updated, bool retryFailed) {
    throw new UnimplementedError();
  }

  @override
  Future<FileInfo> getFileInfo(DartdocEntry entry, String relativePath) {
    throw new UnimplementedError();
  }

  @override
  Future<DartdocEntry> getServingEntry(String package, String version) async {
    return entries?.lastWhere(
      (entry) =>
          entry.packageName == package &&
          entry.packageVersion == version &&
          entry.isServing,
      orElse: () => null,
    );
  }

  @override
  Future<DartdocEntry> getLatestEntry(String package, String version) async {
    return entries?.lastWhere(
      (entry) =>
          entry.packageName == package && entry.packageVersion == version,
      orElse: () => null,
    );
  }

  @override
  Future<String> getLatestVersion(String package) async {
    if (latestVersions == null) return null;
    return latestVersions[package];
  }

  @override
  Future<List<String>> getLatestVersions(String package,
      {int limit: 10}) async {
    if (latestVersions == null) return <String>[];
    final v = latestVersions[package];
    if (v == null) return <String>[];
    return <String>[v];
  }

  @override
  Stream<List<int>> readContent(DartdocEntry entry, String relativePath) {
    throw new UnimplementedError();
  }

  @override
  Future removeAll(String package, {String version}) {
    throw new UnimplementedError();
  }

  @override
  Future removeObsolete(String package, String version) {
    throw new UnimplementedError();
  }

  @override
  Future uploadDir(DartdocEntry entry, String dirPath) {
    throw new UnimplementedError();
  }

  @override
  Future<bool> isLegacy(String package, String version) {
    throw new UnimplementedError();
  }

  @override
  Future<bool> hasValidDartSdkDartdocData() {
    throw new UnimplementedError();
  }

  @override
  Future<PubDartdocData> getDartSdkDartdocData() {
    throw new UnimplementedError();
  }

  @override
  Future uploadDartSdkDartdocData(File file) {
    throw new UnimplementedError();
  }

  @override
  Future deleteOldSdkData() {
    throw new UnimplementedError();
  }

  @override
  Future<String> getTextContent(DartdocEntry entry, String relativePath) {
    throw new UnimplementedError();
  }
}
