// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/screenshot_utils.dart';
import 'package:pub_integration/src/test_browser.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:test/test.dart';

void main() {
  group('search completition', () {
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
              'generatedPackages': [
                {
                  'name': 'oxygen',
                  'publisher': 'example.com',
                },
              ],
            },
            'analysis': 'local',
          }));

      final user = await fakeTestScenario.createAnonymousTestUser();

      await user.withBrowserPage((page) async {
        await page.gotoOrigin('/');
        await page.keyboard.type('is:un');
        await Future.delayed(Duration(milliseconds: 200));
        await page.takeScreenshots(
            selector: 'body', prefix: 'landing-page/search-completion');
        await page.keyboard.press(Key.enter);
        await Future.delayed(Duration(milliseconds: 200));
        await page.keyboard.press(Key.enter);
        await page.waitForNavigation();

        // TODO: try to fix form submission to trim whitespaces
        expect(page.url, '$origin/packages?q=is%3Aunlisted+');
      });

      await user.withBrowserPage((page) async {
        await page.gotoOrigin('/packages?q=abc');
        await page.focus('input[name="q"]');
        // go to the end of the input field and start typing
        await page.keyboard.press(Key.arrowDown);
        await page.keyboard.type(' -sdk:fl');
        await page.takeScreenshots(
            selector: 'body', prefix: 'listing-page/search-completion');
        await Future.delayed(Duration(milliseconds: 200));
        await page.keyboard.press(Key.enter);
        await Future.delayed(Duration(milliseconds: 200));
        await page.keyboard.press(Key.enter);
        await page.waitForNavigation();

        // TODO: try to fix form submission to trim whitespaces
        expect(page.url, '$origin/packages?q=abc+-sdk%3Aflutter+');
      });
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
