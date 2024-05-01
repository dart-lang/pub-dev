// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:pub_integration/src/test_browser.dart';
import 'package:test/test.dart';

void main() {
  group('report', () {
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
      // base setup: publish packages
      await httpClient.post(
          Uri.parse('${fakeTestScenario.pubHostedUrl}/fake-test-profile'),
          body: json.encode({
            'testProfile': {
              'defaultUser': 'admin@pub.dev',
              'packages': [
                {
                  'name': 'oxygen',
                  'versions': ['1.0.0', '1.2.0'],
                },
              ],
            },
          }));

      final user = await fakeTestScenario.createAnonymousTestUser();

      // visit report page and file a report
      await user.withBrowserPage(
        (page) async {
          // enable experimental flag
          await page.gotoOrigin('/experimental?report=1');
          await Future.delayed(Duration(seconds: 1));

          await page.gotoOrigin('/report?subject=package:oxygen');
          await page.waitAndClick('.report-page-direct-report');
          await page.waitFocusAndType('#report-email', 'user@pub.dev');
          await page.waitFocusAndType(
              '#report-message', 'Huston, we have a problem.');
          await page.waitAndClick('#report-submit', waitForOneResponse: true);
          expect(
              await page.content, contains('Report submitted successfully.'));
          await page.waitAndClickOnDialogOk();
        },
      );
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
