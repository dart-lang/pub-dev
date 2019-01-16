// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';

import '../../shared/handlers_test_utils.dart';
import '../mocks.dart';
import '../utils.dart';

import '_utils.dart';

Future main() async {
  await updateLocalBuiltFiles();

  group('ui', () {
    tScopedTest('/packages/foobar_pkg - found', () async {
      final backend = new BackendMock(lookupPackageFun: (String packageName) {
        expect(packageName, 'foobar_pkg');
        return testPackage;
      }, versionsOfPackageFun: (String package) {
        expect(package, testPackage.name);
        return [testPackageVersion];
      }, downloadUrlFun: (String package, String version) {
        return Uri.parse('http://blobstore/$package/$version');
      });
      registerBackend(backend);
      registerAnalyzerClient(new AnalyzerClientMock());
      registerDartdocClient(new DartdocClientMock());
      registerScoreCardBackend(new ScoreCardBackendMock());
      await expectHtmlResponse(await issueGet('/packages/foobar_pkg'));
    });

    tScopedTest('/packages/foobar_pkg - not found', () async {
      final backend = new BackendMock(lookupPackageFun: (String packageName) {
        expect(packageName, 'foobar_pkg');
        return null;
      });
      registerBackend(backend);
      await expectRedirectResponse(
          await issueGet('/packages/foobar_pkg'), '/packages?q=foobar_pkg');
    });

    tScopedTest('/packages/foobar_pkg/versions - found', () async {
      final backend = new BackendMock(versionsOfPackageFun: (String package) {
        expect(package, testPackage.name);
        return [testPackageVersion];
      }, downloadUrlFun: (String package, String version) {
        return Uri.parse('http://blobstore/$package/$version');
      });
      registerBackend(backend);
      registerDartdocClient(new DartdocClientMock());
      await expectHtmlResponse(await issueGet('/packages/foobar_pkg/versions'));
    });

    tScopedTest('/packages/foobar_pkg/versions - not found', () async {
      final backend = new BackendMock(versionsOfPackageFun: (String package) {
        expect(package, testPackage.name);
        return [];
      });
      registerBackend(backend);
      await expectRedirectResponse(
          await issueGet('/packages/foobar_pkg/versions'),
          '/packages?q=foobar_pkg');
    });

    tScopedTest('/packages/foobar_pkg/versions/0.1.1 - found', () async {
      final backend = new BackendMock(lookupPackageFun: (String package) {
        expect(package, testPackage.name);
        return testPackage;
      }, versionsOfPackageFun: (String package) {
        expect(package, testPackage.name);
        return [testPackageVersion];
      }, downloadUrlFun: (String package, String version) {
        return Uri.parse('http://blobstore/$package/$version');
      });
      registerBackend(backend);
      registerAnalyzerClient(new AnalyzerClientMock());
      registerDartdocClient(new DartdocClientMock());
      registerScoreCardBackend(new ScoreCardBackendMock());
      await expectHtmlResponse(
          await issueGet('/packages/foobar_pkg/versions/0.1.1+5'));
    });

    tScopedTest('/packages/foobar_pkg/versions/0.1.2 - not found', () async {
      final backend = new BackendMock(lookupPackageFun: (String package) {
        expect(package, testPackage.name);
        return testPackage;
      }, versionsOfPackageFun: (String package) {
        expect(package, testPackage.name);
        return [testPackageVersion];
      }, downloadUrlFun: (String package, String version) {
        return Uri.parse('http://blobstore/$package/$version');
      });
      registerBackend(backend);
      registerAnalyzerClient(new AnalyzerClientMock());
      registerDartdocClient(new DartdocClientMock());
      await expectRedirectResponse(
          await issueGet('/packages/foobar_pkg/versions/0.1.2'),
          '/packages/foobar_pkg#-versions-tab-');
    });
  });
}
