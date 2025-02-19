// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'dart:io' show Platform;

import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:pub_integration/src/screenshot_utils.dart';
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

        final githubRepository =
            Platform.environment['GITHUB_REPOSITORY'] ?? 'dart-lang/pub-dev';

        // github publishing
        await user.withBrowserPage((page) async {
          await page.gotoOrigin('/packages/test_pkg/admin');
          await page.takeScreenshots(
              prefix: 'package-page/admin-page', selector: 'body');

          await page.waitAndClick('#-pkg-admin-automated-github-enabled');
          await page.waitForLayout([
            '#-pkg-admin-automated-github-repository',
            '#-pkg-admin-automated-github-tagpattern',
          ]);
          await page.waitFocusAndType(
              '#-pkg-admin-automated-github-repository', githubRepository);
          await page.waitAndClick('#-pkg-admin-automated-button',
              waitForOneResponse: true);
          await page.waitAndClickOnDialogOk();
          await page.reload();
          final value = await page.propertyValue(
              '#-pkg-admin-automated-github-repository', 'value');
          expect(value, githubRepository);
        });
      });
    },
    timeout: Timeout.factor(testTimeoutFactor),
  );
}
