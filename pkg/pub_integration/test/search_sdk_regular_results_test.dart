// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:pub_integration/src/test_browser.dart';
import 'package:test/test.dart';

void main() {
  group('Search with SDK and regular results', () {
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
              {'name': 'json_pkg', 'description': 'Some JSON utility'},
            ],
          },
        }),
      );

      final anon = await fakeTestScenario.createAnonymousTestUser();

      await anon.withBrowserPage((page) async {
        await page.gotoOrigin('/packages?q=json');
        final info = await listingPageInfo(page);
        expect(info.packageNames, [
          'dart:convert', // SDK package
          'flutter_driver', // SDK package
          'json_pkg', // regular package
        ]);
      });
    });
  });
}
