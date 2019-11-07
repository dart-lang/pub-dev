// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:puppeteer/puppeteer.dart';
import 'package:test/test.dart';

import 'package:pub_integration/src/headless_env.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';

void main() {
  group('browser', () {
    FakePubServerProcess fakePubServerProcess;
    HeadlessEnv headlessEnv;
    Page page;
    final httpClient = http.Client();

    setUpAll(() async {
      fakePubServerProcess = await FakePubServerProcess.start();
      await fakePubServerProcess.started;
    });

    tearDownAll(() async {
      await page?.close();
      await headlessEnv?.close();
      await fakePubServerProcess?.kill();
      httpClient.close();
    });

    // Starting browser separately, as it may timeout when run together with the
    // server startup.
    test('start browser', () async {
      headlessEnv = HeadlessEnv();
      page = await headlessEnv.newPage();
    });

    test('puppeteer', () async {
      await page.goto('http://localhost:${fakePubServerProcess.port}',
          wait: Until.networkIdle);

      // checking if there is a login button
      await page.hover('#-account-login');

      // check uncaught exception
      expect(headlessEnv.clientErrors.isEmpty, true);
    });
  }, timeout: Timeout.factor(2));
}
