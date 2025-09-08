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
  group('like test', () {
    late final TestContextProvider fakeTestScenario;

    setUpAll(() async {
      fakeTestScenario = await TestContextProvider.start();
    });

    tearDownAll(() async {
      await fakeTestScenario.close();
    });

    test('bulk tests', () async {
      // init server data
      await http.post(
        Uri.parse('${fakeTestScenario.pubHostedUrl}/fake-test-profile'),
        body: json.encode({
          'testProfile': {
            'defaultUser': 'admin@pub.dev',
            'generatedPackages': [
              {'name': 'test_pkg'},
              {'name': 'other_pkg'},
            ],
          },
        }),
      );

      final user = await fakeTestScenario.createTestUser(email: 'user@pub.dev');
      final anon = await fakeTestScenario.createAnonymousTestUser();

      // checking that regular search returns two packages
      await user.withBrowserPage((page) async {
        await page.gotoOrigin('/packages?q=pkg');
        final info = await listingPageInfo(page);
        expect(info.packageNames.toSet(), {'test_pkg', 'other_pkg'});
      });

      // checking that anonymous page request gets an error
      await anon.withBrowserPage((page) async {
        await page.gotoOrigin('/experimental?my-liked-search=1');
        await page.gotoOrigin('/packages?q=pkg+is:liked-by-me');
        expect(await page.content, contains('is only for authenticated users'));
        final info = await listingPageInfo(page);
        expect(info.packageNames, isEmpty);
      });

      await user.withBrowserPage((page) async {
        Future<List<String>> getCountLabels() async {
          final buttonLabel = await page.$OrNull(
            '.like-button-and-label--count',
          );
          final viewLabel = await page.$OrNull(
            '.packages-score-like .packages-score-value-number',
          );
          final keyScoreLabel = await page.$OrNull(
            '.score-key-figure--likes .score-key-figure-value',
          );
          return [
            (await buttonLabel?.textContent()) ?? '',
            (await viewLabel?.textContent()) ?? '',
            (await keyScoreLabel?.textContent()) ?? '',
          ];
        }

        await page.gotoOrigin('/experimental?my-liked-search=1');

        // checking search with my-liked packages - without any likes
        await page.gotoOrigin('/packages?q=pkg+is:liked-by-me');
        final info1 = await listingPageInfo(page);
        expect(info1.packageNames, isEmpty);

        await page.gotoOrigin('/packages/test_pkg');
        expect(await getCountLabels(), ['0', '0', '']);

        await page.click('.like-button-and-label--button');
        await Future.delayed(Duration(milliseconds: 200));
        expect(await getCountLabels(), ['1', '1', '']);

        // checking search with my-liked packages - with the one liked package
        await page.gotoOrigin('/packages?q=pkg+is:liked-by-me');
        final info2 = await listingPageInfo(page);
        expect(info2.packageNames.toSet(), {'test_pkg'});

        // displaying all three
        await page.gotoOrigin('/packages/test_pkg/score');
        expect(await getCountLabels(), ['1', '1', '1']);

        await page.click('.like-button-and-label--button');
        await Future.delayed(Duration(milliseconds: 200));

        // checking it on the main package page too
        expect(await getCountLabels(), ['0', '0', '0']);
        await page.gotoOrigin('/packages/test_pkg');
        expect(await getCountLabels(), ['0', '0', '']);

        // unlike on the is:liked-by-me page
        {
          await page.gotoOrigin('/packages/test_pkg');
          await page.click('.like-button-and-label--button');
          await Future.delayed(Duration(milliseconds: 200));
          expect(await getCountLabels(), ['1', '1', '']);

          await page.gotoOrigin('/packages?q=pkg+is:liked-by-me');
          final info = await listingPageInfo(page);
          expect(info.packageNames.toSet(), {'test_pkg'});
          expect(await getCountLabels(), ['', '1', '']);

          await page.click('.like-button-and-label--button');
          await Future.delayed(Duration(milliseconds: 200));
          expect(await getCountLabels(), ['', '0', '']);

          await page.gotoOrigin('/packages/test_pkg');
          expect(await getCountLabels(), ['0', '0', '']);
        }
      });
    });
  });
}
