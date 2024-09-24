// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/test_browser.dart';
import 'package:test/test.dart';

void main() {
  group('theme switch', () {
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
                {'name': 'oxygen'}
              ],
            },
            'analysis': 'local',
          }));

      final user = await fakeTestScenario.createAnonymousTestUser();

      // test keyboard navigation
      await user.withBrowserPage((page) async {
        await page.gotoOrigin('/experimental?dark=1');

        Future<void> expectDarkTheme() async {
          expect(await page.$OrNull('body.light-theme'), isNull);
          expect(await page.$OrNull('body.dark-theme'), isNotNull);
        }

        Future<void> expectLightTheme() async {
          expect(await page.$OrNull('body.light-theme'), isNotNull);
          expect(await page.$OrNull('body.dark-theme'), isNull);
        }

        // baseline check
        await page.gotoOrigin('/');
        await expectLightTheme();
        await page.gotoOrigin('/documentation/oxygen/latest/');
        await expectLightTheme();

        // switch to dark on dartdoc page
        await page.click('#theme-button');
        await expectDarkTheme();
        await page.gotoOrigin('/');
        await expectDarkTheme();

        // switch to light on dartdoc page
        await page.gotoOrigin('/documentation/oxygen/latest/');
        await expectDarkTheme();
        await page.click('#theme-button');
        await expectLightTheme();
        await page.gotoOrigin('/');
        await expectLightTheme();

        // switch to dark on the pub.dev page
        await page.click('button.-pub-theme-toggle');
        await expectDarkTheme();
        await page.gotoOrigin('/documentation/oxygen/latest/');
        await expectDarkTheme();

        // switch to light on the pub.dev page
        await page.gotoOrigin('/');
        await expectDarkTheme();
        await page.click('button.-pub-theme-toggle');
        await expectLightTheme();
        await page.gotoOrigin('/documentation/oxygen/latest/');
        await expectLightTheme();
      });
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
