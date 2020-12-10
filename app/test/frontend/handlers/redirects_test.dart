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
        await expectRedirectResponse(
            await issueGet(path, host: 'pub.dartlang.org'), '$siteRoot$path');
      }

      await testRedirect('/');
      await testRedirect('/packages');
      await testRedirect('/packages/pana');
      await testRedirect('/flutter');
      await testRedirect('/web');
    });

    testWithServices('dartdocs.org redirect', () async {
      await expectRedirectResponse(
        await issueGet('/documentation/pkg/latest/', host: 'dartdocs.org'),
        '$siteRoot/documentation/pkg/latest',
      );
    });

    testWithServices('www.dartdocs.org redirect', () async {
      await expectRedirectResponse(
        await issueGet('/documentation/pkg/latest/', host: 'www.dartdocs.org'),
        '$siteRoot/documentation/pkg/latest',
      );
    });

    testWithServices('/doc', () async {
      for (var path in redirectPaths.keys) {
        final redirectUrl = 'https://dart.dev/tools/pub/${redirectPaths[path]}';
        await expectNotFoundResponse(await issueGet(path));
        await expectRedirectResponse(
            await issueGet(path, host: 'pub.dartlang.org'), redirectUrl);
      }
    });

    testWithServices('/flutter/plugins', () async {
      await expectRedirectResponse(
          await issueGet('/flutter/plugins', host: 'pub.dartlang.org'),
          'https://pub.dev/flutter/packages');
      await expectNotFoundResponse(await issueGet('/flutter/plugins'));
    });

    testWithServices('/search?q=foobar', () async {
      await expectRedirectResponse(
          await issueGet('/search?q=foobar', host: 'pub.dartlang.org'),
          '$siteRoot/packages?q=foobar');
      await expectNotFoundResponse(await issueGet('/search?q=foobar'));
    });

    testWithServices('/search?q=foobar&page=2', () async {
      await expectRedirectResponse(
          await issueGet('/search?q=foobar&page=2', host: 'pub.dartlang.org'),
          '$siteRoot/packages?q=foobar&page=2');
      await expectNotFoundResponse(await issueGet('/search?q=foobar&page=2'));
    });

    testWithServices('/server', () async {
      await expectRedirectResponse(
          await issueGet('/server', host: 'pub.dartlang.org'), '$siteRoot/');
      await expectNotFoundResponse(await issueGet('/server'));
    });

    testWithServices('/server/packages with parameters', () async {
      await expectRedirectResponse(
          await issueGet('/server/packages?sort=top', host: 'pub.dartlang.org'),
          '$siteRoot/packages?sort=top');
      await expectNotFoundResponse(await issueGet('/server/packages?sort=top'));
    });

    testWithServices('/server/packages', () async {
      await expectRedirectResponse(
          await issueGet('/server/packages', host: 'pub.dartlang.org'),
          '$siteRoot/packages');
      await expectNotFoundResponse(await issueGet('/server/packages'));
    });

    testWithServices('/packages/flutter - redirect', () async {
      await expectRedirectResponse(
        await issueGet('/packages/flutter'),
        'https://api.flutter.dev/',
      );
    });

    testWithServices('/packages/flutter/versions/* - redirect', () async {
      await expectRedirectResponse(
        await issueGet('/packages/flutter/versions/0.20'),
        'https://api.flutter.dev/',
      );
    });
  });
}
