// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:pub_integration/src/headless_env.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:test/test.dart';

void main() {
  group(
    'package admin page',
    () {
      late FakePubServerProcess fakePubServerProcess;
      late final HeadlessEnv headlessEnv;
      final httpClient = http.Client();

      setUpAll(() async {
        fakePubServerProcess = await FakePubServerProcess.start();
        await fakePubServerProcess.started;
      });

      tearDownAll(() async {
        await headlessEnv.close();
        await fakePubServerProcess.kill();
        httpClient.close();
      });

      test('bulk tests', () async {
        final origin = 'http://localhost:${fakePubServerProcess.port}';
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

        // start browser
        headlessEnv = HeadlessEnv(testName: 'pkg-admin-page', origin: origin);
        await headlessEnv.startBrowser();

        // github publishing
        await headlessEnv.withPage(fn: (page) async {
          await page.gotoOrigin('/experimental?publishing=1');
          await Future.delayed(Duration(seconds: 2));
          await page.gotoOrigin('/');
          await page.click('#-account-login');
          await page.waitForSelector('#-pub-custom-token-input',
              timeout: Duration(seconds: 2));
          await page.focusAndType('#-pub-custom-token-input',
              'admin-at-pub-dot-dev?source=website');

          await page.clickOnButtonWithLabel('ok');
          await page.waitForNavigation(timeout: Duration(seconds: 5));
          await Future.delayed(Duration(seconds: 2));

          await page.gotoOrigin('/packages/test_pkg/admin');
          await Future.delayed(Duration(seconds: 1));

          await page.click('#-pkg-admin-automated-github-enabled');
          await Future.delayed(Duration(seconds: 1));
          await page.focusAndType(
              '#-pkg-admin-automated-github-repository', 'dart-lang/pub-dev');
          await Future.delayed(Duration(seconds: 1));
          await page.click('#-pkg-admin-automated-button');
          await Future.delayed(Duration(seconds: 1));

          await page.clickOnButtonWithLabel('ok');
          await Future.delayed(Duration(seconds: 1));
          await page.reload();
          await Future.delayed(Duration(seconds: 1));
          final value =
              await (await page.$('#-pkg-admin-automated-github-repository'))
                  .propertyValue('value');
          expect(value, 'dart-lang/pub-dev');
        });
      });
    },
    timeout: Timeout.factor(testTimeoutFactor),
  );
}
