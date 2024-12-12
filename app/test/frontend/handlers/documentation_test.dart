// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/frontend/handlers/documentation.dart';
import 'package:pub_dev/shared/urls.dart';
import 'package:test/test.dart';

import '../../frontend/handlers/_utils.dart';
import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';

void main() {
  group('path parsing', () {
    void testUri(String rqPath, String? package,
        [String? version, String? path]) {
      final p = parseRequestUri(Uri.parse('$siteRoot$rqPath'));
      if (package == null) {
        expect(p, isNull);
      } else {
        expect(p, isNotNull);
        expect(p!.package, package);
        expect(p.version, version);
        expect(p.path, path);
      }
    }

    test('bad prefix', () {
      testUri('/doc/pkg/latest/', null);
    });

    test('insufficient prefix', () {
      testUri('/documentation', null);
      testUri('/documentation/', null);
    });

    test('bad package name', () {
      testUri('/documentation//latest/', null);
      testUri('/documentation/<pkg>/latest/', null);
      testUri('/documentation/pkg with space/latest/', null);
    });

    test('no version specified', () {
      testUri('/documentation/angular', 'angular');
      testUri('/documentation/angular/', 'angular');
    });

    test('bad version', () {
      testUri('/documentation/pkg//', 'pkg');
      testUri('/documentation/pkg/first-release/', null);
      testUri('/documentation/pkg/1.2.3.4.5.6/', null);
    });

    test('version without path', () {
      testUri('/documentation/angular/4.0.0+2', 'angular', '4.0.0+2');
      testUri('/documentation/angular/4.0.0+2/', 'angular', '4.0.0+2',
          'index.html');
    });

    test('version with a path', () {
      testUri('/documentation/angular/4.0.0+2/subdir', 'angular', '4.0.0+2',
          'subdir/index.html');
      testUri('/documentation/angular/4.0.0+2/subdir/', 'angular', '4.0.0+2',
          'subdir/index.html');
      testUri('/documentation/angular/4.0.0+2/file.html', 'angular', '4.0.0+2',
          'file.html');
      testUri('/documentation/angular/4.0.0+2/file.html', 'angular', '4.0.0+2',
          'file.html');
    });

    test('bad path segment with URL', () {
      testUri(
          '/documentation/permission_handler/5.0.0/(https:/github.com/Baseflow/flutter-permission-handler/blob/develop/example/android/app/src/main/AndroidManifest.xml)',
          null);
    });

    test('various characters in the path segments', () {
      testUri(
          '/documentation/pkg/1.0.0/A%20_0.html', 'pkg', '1.0.0', 'A _0.html');
    });

    test('library with dots are recognized', () {
      testUri('/documentation/pkg/latest/a.b.c', 'pkg', 'latest',
          'a.b.c/index.html');
      testUri('/documentation/pkg/latest/a.b.c/', 'pkg', 'latest',
          'a.b.c/index.html');
    });

    test('static assets are left as-is', () {
      testUri('/documentation/pkg/latest/static-assets/search.svg', 'pkg',
          'latest', 'static-assets/search.svg');
    });
  });

  group('dartdoc handlers', () {
    testWithProfile('/documentation/flutter redirect', fn: () async {
      await expectRedirectResponse(
        await issueGet('/documentation/flutter'),
        'https://api.flutter.dev/',
      );
    });

    testWithProfile('/documentation/flutter/latest redirect', fn: () async {
      await expectRedirectResponse(
        await issueGet('/documentation/flutter/latest'),
        'https://api.flutter.dev/',
      );
    });

    testWithProfile('trailing slash redirect', fn: () async {
      await expectRedirectResponse(await issueGet('/documentation/oxygen'),
          '/documentation/oxygen/latest/');
      await expectRedirectResponse(await issueGet('/documentation/oxygen/'),
          '/documentation/oxygen/latest/');
      await expectRedirectResponse(
          await issueGet('/documentation/oxygen/latest'),
          '/documentation/oxygen/latest/');
      await expectRedirectResponse(
          await issueGet('/documentation/oxygen/1.0.0'),
          '/documentation/oxygen/1.0.0/');

      await expectRedirectResponse(
          await issueGet('/documentation/oxygen/1.0.0/abc'),
          '/documentation/oxygen/1.0.0/abc/');
      await expectRedirectResponse(
          await issueGet('/documentation/oxygen/1.0.0/abc.def'),
          '/documentation/oxygen/1.0.0/abc.def/');
      await expectRedirectResponse(
          await issueGet('/documentation/oxygen/latest/abc/def'),
          '/documentation/oxygen/latest/abc/def/');
    });

    testWithProfile(
      '/documentation/oxygen - latest redirect',
      fn: () async {
        await expectRedirectResponse(await issueGet('/documentation/oxygen/'),
            '/documentation/oxygen/latest/');
      },
      processJobsWithFakeRunners: true,
    );

    testWithProfile(
      '/documentation/oxygen/wrong/',
      fn: () async {
        await expectNotFoundResponse(
            await issueGet('/documentation/oxygen/wrong/'));
      },
      processJobsWithFakeRunners: true,
    );

    testWithProfile(
      '/documentation/oxygen/latest/unknown.html',
      fn: () async {
        await expectNotFoundResponse(
            await issueGet('/documentation/oxygen/latest/unknown.html'));
      },
      processJobsWithFakeRunners: true,
    );
  });
}
