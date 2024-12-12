// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/test_browser.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:test/test.dart';

void main() {
  group('dartdoc search', () {
    late final TestContextProvider fakeTestScenario;
    final httpClient = http.Client();

    setUpAll(() async {
      fakeTestScenario = await TestContextProvider.start();
    });

    tearDownAll(() async {
      await fakeTestScenario.close();
      httpClient.close();
    });

    test('bulk tests', () async {
      final origin = fakeTestScenario.pubHostedUrl;
      // Importing one package + local analysis
      await httpClient.post(Uri.parse('$origin/fake-test-profile'),
          body: json.encode({
            'testProfile': {
              'defaultUser': 'admin@pub.dev',
              'packages': [
                {'name': 'oxygen'},
              ],
            },
            'analysis': 'local',
          }));

      final user = await fakeTestScenario.createAnonymousTestUser();

      // test keyboard navigation
      await user.withBrowserPage((page) async {
        await page.gotoOrigin('/documentation/oxygen/latest/');

        await page.keyboard.press(Key.slash);
        await Future.delayed(Duration(milliseconds: 200));
        await page.keyboard.type('enum');
        await Future.delayed(Duration(milliseconds: 200));
        await page.keyboard.press(Key.arrowDown);
        await Future.delayed(Duration(milliseconds: 200));
        await page.keyboard.press(Key.enter);

        await page.waitForNavigation();

        // It is likely that we end up on the `TypeEnum.html` page, but we don't
        // need to hardcode it here, in case dartdoc changes the order of the options.
        expect(page.url,
            startsWith('$origin/documentation/oxygen/latest/oxygen/'));
        expect(page.url, endsWith('.html'));
        expect(await page.content, contains('TypeEnum'));
      });

      // test library page redirect
      await user.withBrowserPage((page) async {
        await page.gotoOrigin(
            '/documentation/oxygen/latest/oxygen/oxygen-library.html');
        await Future.delayed(Duration(milliseconds: 200));
        expect(page.url, '$origin/documentation/oxygen/latest/oxygen/');
      });
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
