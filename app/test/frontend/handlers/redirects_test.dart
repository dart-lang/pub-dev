// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/frontend/handlers/redirects.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/shared/urls.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFilesIfNeeded());

  group('redirects', () {
    testWithServices('pub.dartlang.org', () async {
      Future<void> testRedirect(String path) async {
        expectRedirectResponse(
            await issueGet(path, host: 'pub.dartlang.org'), '$siteRoot$path');
      }

      testRedirect('/');
      testRedirect('/packages');
      testRedirect('/packages/pana');
      testRedirect('/flutter');
      testRedirect('/web');
    });

    testWithServices('dartdocs.org redirect', () async {
      expectRedirectResponse(
        await issueGet('/documentation/pkg/latest/', host: 'dartdocs.org'),
        '$siteRoot/documentation/pkg/latest',
      );
    });

    testWithServices('www.dartdocs.org redirect', () async {
      expectRedirectResponse(
        await issueGet('/documentation/pkg/latest/', host: 'www.dartdocs.org'),
        '$siteRoot/documentation/pkg/latest',
      );
    });

    testWithServices('/doc', () async {
      for (var path in redirectPaths.keys) {
        final redirectUrl = 'https://dart.dev/tools/pub/${redirectPaths[path]}';
        expectNotFoundResponse(await issueGet(path));
        expectRedirectResponse(
            await issueGet(path, host: 'pub.dartlang.org'), redirectUrl);
      }
    });

    // making sure /doc does not catches /documentation request
    testWithServices('/documentation', () async {
      expectRedirectResponse(await issueGet('/documentation/pana/'),
          '/documentation/pana/latest/');
    });

    testWithServices('/flutter/plugins', () async {
      expectRedirectResponse(
          await issueGet('/flutter/plugins', host: 'pub.dartlang.org'),
          'https://pub.dev/flutter/packages');
      expectNotFoundResponse(await issueGet('/flutter/plugins'));
    });

    testWithServices('/search?q=foobar', () async {
      expectRedirectResponse(
          await issueGet('/search?q=foobar', host: 'pub.dartlang.org'),
          '$siteRoot/packages?q=foobar');
      expectNotFoundResponse(await issueGet('/search?q=foobar'));
    });

    testWithServices('/search?q=foobar&page=2', () async {
      expectRedirectResponse(
          await issueGet('/search?q=foobar&page=2', host: 'pub.dartlang.org'),
          '$siteRoot/packages?q=foobar&page=2');
      expectNotFoundResponse(await issueGet('/search?q=foobar&page=2'));
    });

    testWithServices('/server', () async {
      expectRedirectResponse(
          await issueGet('/server', host: 'pub.dartlang.org'), '$siteRoot/');
      expectNotFoundResponse(await issueGet('/server'));
    });

    testWithServices('/server/packages with parameters', () async {
      expectRedirectResponse(
          await issueGet('/server/packages?sort=top', host: 'pub.dartlang.org'),
          '$siteRoot/packages?sort=top');
      expectNotFoundResponse(await issueGet('/server/packages?sort=top'));
    });

    testWithServices('/server/packages', () async {
      expectRedirectResponse(
          await issueGet('/server/packages', host: 'pub.dartlang.org'),
          '$siteRoot/packages');
      expectNotFoundResponse(await issueGet('/server/packages'));
    });

    testWithServices('/packages/flutter - redirect', () async {
      expectRedirectResponse(
        await issueGet('/packages/flutter'),
        '$siteRoot/flutter',
      );
    });

    testWithServices('/packages/flutter/versions/* - redirect', () async {
      expectRedirectResponse(
        await issueGet('/packages/flutter/versions/0.20'),
        '$siteRoot/flutter',
      );
    });
  });
}
