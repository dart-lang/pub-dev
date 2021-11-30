// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:pub_integration/src/headless_env.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:test/test.dart';

void main() {
  group('browser', () {
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
              'packages': List.generate(
                100,
                (i) => {
                  'name': i % 3 == 0 ? 'flutter_pkg_$i' : 'pkg_$i',
                  if (i % 11 == 0) 'publisher': 'example.com',
                },
              ),
            },
          }));
      await httpClient.get(Uri.parse('$origin/fake-update-search'));

      // start browser
      headlessEnv = HeadlessEnv(testName: 'search-update', origin: origin);
      await headlessEnv.startBrowser();

      // listing page
      await headlessEnv.withPage(
        fn: (page) async {
          await page.gotoOrigin('/experimental?enabled=1');
          await page.gotoOrigin('/packages');

          // check package list
          final i1 = await listingPageInfo(page);
          expect(i1.totalCount, 100);
          expect(i1.packageNames, [
            'pkg_11',
            'flutter_pkg_51',
            'pkg_13',
            'pkg_62',
            'pkg_34',
            'pkg_28',
            'pkg_94',
            'flutter_pkg_66',
            'flutter_pkg_0',
            'pkg_73',
          ]);

          // click Android
          await page.click('#search-form-checkbox-platform-android');
          await page.waitForNavigation(wait: Until.networkIdle);
          final i2 = await listingPageInfo(page);
          expect(i2.totalCount, 75);
          expect(i2.packageNames, [
            'flutter_pkg_51',
            'pkg_13',
            'pkg_62',
            'pkg_34',
            'pkg_94',
            'flutter_pkg_66',
            'flutter_pkg_0',
            'pkg_73',
            'pkg_88',
            'flutter_pkg_84',
          ]);
          expect(i2.openSections, isEmpty);
          expect(page.url, '$origin/packages?q=platform%3Aandroid');

          // Open SDKs section
          final flutterCB3 = await page.$('#search-form-checkbox-sdk-flutter');
          expect(await flutterCB3.boundingBox, isNull);
          await page.click('.search-form-section[data-section-tag="sdks"]');
          await Future.delayed(Duration(seconds: 1));
          expect(await flutterCB3.boundingBox, isNotNull);

          // click Flutter
          await flutterCB3.click();
          await page.waitForNavigation(wait: Until.networkIdle);
          final i3 = await listingPageInfo(page);
          expect(i3.totalCount, 32);
          expect(i3.packageNames, [
            'flutter_pkg_51',
            'flutter_pkg_66',
            'flutter_pkg_0',
            'flutter_pkg_84',
            'flutter_pkg_36',
            'flutter_pkg_33',
            'flutter_pkg_45',
            'flutter_pkg_63',
            'flutter_pkg_93',
            'flutter_pkg_54',
          ]);
          expect(
              page.url, '$origin/packages?q=platform%3Aandroid+sdk%3Aflutter');
          expect(i3.openSections, ['sdks']);

          // unclick Flutter
          final flutterCB4 = await page.$('#search-form-checkbox-sdk-flutter');
          final flutterLink = await flutterCB4.$x('../following-sibling::*');
          await flutterLink.single.click();
          await page.waitForNavigation(wait: Until.networkIdle);
          final i4 = await listingPageInfo(page);
          expect(i4.totalCount, i2.totalCount);
          expect(i4.packageNames, i2.packageNames);
          expect(i4.openSections, i3.openSections); // keeps SDK section open
          expect(page.url, '$origin/packages?q=platform%3Aandroid');

          // prohibit Flutter
          await page.focus('input[name="q"]');
          await page.keyboard.press(Key.arrowDown);
          await page.keyboard.type(' -sdk:flutter pkg');
          await page.keyboard.press(Key.enter);
          await page.waitForNavigation(wait: Until.networkIdle);
          final i5 = await listingPageInfo(page);
          expect(i5.totalCount, i2.totalCount - i3.totalCount);
          expect(i5.packageNames, [
            'pkg_13',
            'pkg_62',
            'pkg_34',
            'pkg_94',
            'pkg_73',
            'pkg_88',
            'pkg_91',
            'pkg_53',
            'pkg_2',
            'pkg_98',
          ]);
          expect(i5.openSections, ['sdks']);
          expect(page.url,
              '$origin/packages?q=platform%3Aandroid+-sdk%3Aflutter+pkg');
          final flutterCB5 = await page.$('#search-form-checkbox-sdk-flutter');
          expect(await flutterCB5.attributeValue('data-indeterminate'), 'true');

          // clear Flutter
          await flutterCB5.click();
          await page.waitForNavigation(wait: Until.networkIdle);
          final i6 = await listingPageInfo(page);
          expect(i6.totalCount, i2.totalCount);
          expect(i6.openSections, i5.openSections);
          expect(page.url, '$origin/packages?q=platform%3Aandroid+pkg');

          // include discontinued
          await page.click('.search-form-section[data-section-tag="advanced"]');
          await Future.delayed(Duration(seconds: 1));
          await page.click('#search-form-checkbox-discontinued');
          await page.waitForNavigation(wait: Until.networkIdle);
          final i7 = await listingPageInfo(page);
          expect(i7.totalCount, i6.totalCount);
          expect(i7.openSections, ['sdks', 'advanced']);
          expect(page.url,
              '$origin/packages?q=platform%3Aandroid+pkg&discontinued=1');
        },
      );
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
