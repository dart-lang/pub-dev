// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/frontend/handlers/documentation.dart';
import 'package:pub_dev/shared/urls.dart';

import '../../frontend/handlers/_utils.dart';
import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';

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
    testWithServices('/documentation/flutter redirect', () async {
      await expectRedirectResponse(
        await issueGet('/documentation/flutter'),
        'https://docs.flutter.io/',
      );
    });

    testWithServices('/documentation/flutter/version redirect', () async {
      await expectRedirectResponse(
        await issueGet('/documentation/flutter/version'),
        'https://docs.flutter.io/',
      );
    });

    testWithServices('/documentation/foor/bar redirect', () async {
      await expectRedirectResponse(
        await issueGet('/documentation/foor/bar'),
        'https://pub.dev/documentation/foor/bar/',
      );
    });

    testWithServices('trailing slash redirect', () async {
      await expectRedirectResponse(
          await issueGet('/documentation/foo'), '/documentation/foo/latest/');
    });

    testWithServices('/documentation/no_pkg redirect', () async {
      await expectRedirectResponse(
          await issueGet('/documentation/no_pkg/latest/'),
          '/packages/no_pkg/versions');
    });

    testWithServices('/d/foobar_pkg/latest/ redirect', () async {
      await expectRedirectResponse(
          await issueGet('/documentation/foobar_pkg/latest/'),
          '/packages/foobar_pkg/versions');
    });

    testWithServices('/d/foobar_pkg/latest/unknown.html redirect', () async {
      await expectRedirectResponse(
          await issueGet('/documentation/foobar_pkg/latest/unknown.html'),
          '/packages/foobar_pkg/versions');
    });
  });
}
