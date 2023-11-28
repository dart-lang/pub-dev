// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:pub_integration/src/test_browser.dart';
import 'package:test/test.dart';

void main() {
  group(
    'package admin page',
    () {
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
        // init server data
        await httpClient.post(Uri.parse('$origin/fake-test-profile'),
            body: json.encode({
              'testProfile': {
                'defaultUser': 'admin@pub.dev',
                'packages': [
                  {
                    'name': 'test_pkg',
                  },
                ],
              },
            }));

        final user =
            await fakeTestScenario.createTestUser(email: 'admin@pub.dev');

        // github publishing
        await user.withBrowserPage((page) async {
          await page.gotoOrigin('/packages/test_pkg/admin');

          await page.waitAndClick('#-pkg-admin-automated-github-enabled');
          await page.waitFocusAndType(
              '#-pkg-admin-automated-github-repository', 'dart-lang/pub-dev');
          await page.waitAndClick('#-pkg-admin-automated-button',
              waitForOneResponse: true);
          await page.waitAndClickOnDialogOk();
          await page.reloadUntilIdle();
          final value = await page.propertyValue(
              '#-pkg-admin-automated-github-repository', 'value');
          expect(value, 'dart-lang/pub-dev');
        });
      });
    },
    timeout: Timeout.factor(testTimeoutFactor),
  );
}
