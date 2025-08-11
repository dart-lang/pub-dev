// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_test_context_provider.dart';
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
        body: json.encode(
          {
            'testProfile': {
              'defaultUser': 'admin@pub.dev',
              'generatedPackages': [
                {'name': 'test_pkg'},
              ],
            },
          },
        ),
      );

      final user = await fakeTestScenario.createTestUser(email: 'user@pub.dev');

      await user.withBrowserPage((page) async {
        Future<String> getCountLabel() async {
          final label = await page.$('.like-button-and-label--count');
          return await label.textContent();
        }

        await page.gotoOrigin('/packages/test_pkg');
        expect(await getCountLabel(), '0');

        await page.click('.like-button-and-label--button');
        await Future.delayed(Duration(seconds: 1));
        expect(await getCountLabel(), '1');

        await page.gotoOrigin('/packages/test_pkg');
        expect(await getCountLabel(), '1');

        await page.click('.like-button-and-label--button');
        await Future.delayed(Duration(seconds: 1));

        expect(await getCountLabel(), '0');
        await page.gotoOrigin('/packages/test_pkg');
        expect(await getCountLabel(), '0');
      });
    });
  });
}
