// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:puppeteer/puppeteer.dart';
import 'package:test/test.dart';

import 'package:pub_integration/script/base_setup_script.dart';
import 'package:pub_integration/src/headless_env.dart';
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';

void main() {
  final coverageDir = Platform.environment['COVERAGE_DIR'];
  final trackCoverage =
      coverageDir != null || Platform.environment['COVERAGE'] == '1';

  group('browser', () {
    FakePubServerProcess fakePubServerProcess;
    HeadlessEnv headlessEnv;
    final httpClient = http.Client();

    setUpAll(() async {
      fakePubServerProcess = await FakePubServerProcess.start();
      await fakePubServerProcess.started;
    });

    tearDownAll(() async {
      await headlessEnv?.close();
      await fakePubServerProcess?.kill();
      httpClient.close();
      headlessEnv?.printCoverage();
      if (coverageDir != null) {
        await headlessEnv?.saveCoverage(coverageDir, 'browser');
      }
    });

    test('run base setup script', () async {
      final script = BaseSetupScript(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        credentialsFileContent: fakeCredentialsFileContent(),
      );
      await script.setup();
    });

    // Starting browser separately, as it may timeout when run together with the
    // server startup.
    test('start browser', () async {
      headlessEnv = HeadlessEnv(trackCoverage: trackCoverage);
      await headlessEnv.startBrowser();
    });

    test('landing page', () async {
      await headlessEnv.withPage(
        user: FakeGoogleUser.withDefaults('dev@example.org'),
        fn: (page) async {
          await page.goto('http://localhost:${fakePubServerProcess.port}',
              wait: Until.networkIdle);

          // checking if there is a login button
          await page.hover('#-account-login');

          // check uncaught exception
          expect(headlessEnv.clientErrors.isEmpty, true);
        },
      );
    });

    test('listing page', () async {
      await headlessEnv.withPage(
        user: FakeGoogleUser.withDefaults('dev@example.org'),
        fn: (page) async {
          await page.goto(
              'http://localhost:${fakePubServerProcess.port}/packages',
              wait: Until.networkIdle);

          // check package list
          final packages = <String>{};
          for (final item in await page.$$('.list-item.-full h3')) {
            final text = await (await item.property('textContent')).jsonValue;
            packages.add(text as String);
          }
          expect(packages, {'_dummy_pkg', 'retry'});

          // check uncaught exception
          expect(headlessEnv.clientErrors.isEmpty, true);
        },
      );
    });

    test('package page', () async {
      await headlessEnv.withPage(
        user: FakeGoogleUser.withDefaults('dev@example.org'),
        fn: (page) async {
          await page.goto(
              'http://localhost:${fakePubServerProcess.port}/packages/retry',
              wait: Until.networkIdle);

          // check header with name and version
          final headerTitle = await page.$('h2.title');
          final headerTitleText =
              await (await headerTitle.property('textContent')).jsonValue;
          expect(headerTitleText, 'retry 2.0.0');

          // check uncaught exception
          expect(headlessEnv.clientErrors.isEmpty, true);
        },
      );
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
