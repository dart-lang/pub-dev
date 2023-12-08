// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:pub_integration/src/test_browser.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:test/test.dart';

void main() {
  group('browser', () {
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
                  'name': 'retry',
                  'versions': ['3.1.0'],
                },
                {'name': '_dummy_pkg'},
              ],
            },
          }));

      final user = await fakeTestScenario.createAnonymousTestUser();

      // landing page
      await user.withBrowserPage(
        (page) async {
          await page.gotoOrigin('/');

          // checking if there is a login button
          await page.hover('#-account-login');
        },
      );

      // listing page
      await user.withBrowserPage(
        (page) async {
          await page.gotoOrigin('/packages');

          // check package list
          final info = await listingPageInfo(page);
          expect(info.packageNames, containsAll(['_dummy_pkg', 'retry']));
        },
      );

      // package page
      await user.withBrowserPage(
        (page) async {
          await page.gotoOrigin('/packages/retry');

          // check pub score
          final pubScoreElem = await page
              .$('.packages-score-health .packages-score-value-number');
          final pubScore = await pubScoreElem.textContent();
          expect(int.parse(pubScore), greaterThanOrEqualTo(30));

          // check header with name and version
          Future<void> checkHeaderTitle() async {
            final headerTitle = await page.$('h1.title');
            expect(await headerTitle.textContent(), contains('retry 3.1.0'));
          }

          await checkHeaderTitle();
          await _checkCopyToClipboard(page);

          await page.gotoOrigin('/packages/retry/versions/3.1.0');
          await checkHeaderTitle();

          // TODO: non-canonical version should redirect and we should test for it
          await page.gotoOrigin('/packages/retry/versions/3.01.00');
          await checkHeaderTitle();

          await page.gotoOrigin('/packages/retry/license');
          await checkHeaderTitle();
        },
      );
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}

Future _checkCopyToClipboard(Page page) async {
  // we have an icon that we can hover
  final copyIconHandle = await page.$('.pkg-page-title-copy-icon');
  await copyIconHandle.hover();

  // feedback must not be visible at first
  final feedbackHandle = await page.$('.pkg-page-title-copy-feedback');
  expect(await feedbackHandle.isIntersectingViewport, false);

  // triggers copy to clipboard + feedback
  await copyIconHandle.click();

  // feedback is visible
  expect(await feedbackHandle.isIntersectingViewport, true);

  // clipboard has the content
  expect(
    await page.evaluate('() => navigator.clipboard.readText()'),
    'retry: ^3.1.0',
  );

  // feedback should not be visible after 2.5 seconds
  await Future.delayed(Duration(milliseconds: 2600));
  expect(await feedbackHandle.isIntersectingViewport, false);
}
