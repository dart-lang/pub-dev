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
      //
      // The test profile import uses a fake analysis by default, which
      // assigns tags with a pseudorandom process (based on the hash of the
      // package's name and sometimes the version), with a few hardcoded
      // patterns, e.g. `flutter_*` packages will get `sdk:flutter` tag assigned.
      //
      // This imports 100 packages with these semi-random tags, and adding and
      // removing filters works because of the number of packages and their
      // tags are kind of random.
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

      // start browser
      headlessEnv = HeadlessEnv(testName: 'search-update', origin: origin);
      await headlessEnv.startBrowser();

      // listing page
      await headlessEnv.withPage(
        fn: (page) async {
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
          expect(i2.totalCount, 78);
          expect(i2.packageNames, [
            'pkg_11',
            'flutter_pkg_51',
            'pkg_13',
            'pkg_62',
            'pkg_28',
            'flutter_pkg_66',
            'flutter_pkg_0',
            'pkg_37',
            'flutter_pkg_84',
            'pkg_91',
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
          expect(i3.totalCount, 68);
          expect(i3.packageNames, [
            'flutter_pkg_51',
            'pkg_13',
            'pkg_62',
            'flutter_pkg_0',
            'pkg_37',
            'flutter_pkg_84',
            'pkg_91',
            'pkg_53',
            'flutter_pkg_36',
            'pkg_2',
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
            'pkg_11',
            'pkg_28',
            'flutter_pkg_66',
            'pkg_77',
            'pkg_43',
            'pkg_23',
            'flutter_pkg_69',
            'pkg_19',
            'pkg_68',
            'pkg_49',
          ]);
          expect(i5.openSections, ['sdks']);
          expect(page.url,
              '$origin/packages?q=platform%3Aandroid+-sdk%3Aflutter+pkg');
          final flutterCB5 = await page.$('#search-form-checkbox-sdk-flutter');
          expect(await flutterCB5.attributeValue('data-indeterminate'), 'true');

          // clear Flutter with a row-level click
          final flutterRow = await flutterCB5.$x('../../..');
          await flutterRow.single.click();
          await page.waitForNavigation(wait: Until.networkIdle);
          final i6 = await listingPageInfo(page);
          expect(i6.totalCount, i2.totalCount);
          expect(i6.openSections, i5.openSections);
          expect(page.url, '$origin/packages?q=platform%3Aandroid+pkg');

          // show hidden
          await page.click('.search-form-section[data-section-tag="advanced"]');
          await Future.delayed(Duration(seconds: 1));
          await page.click('#search-form-checkbox-show-hidden');
          await page.waitForNavigation(wait: Until.networkIdle);
          final i7 = await listingPageInfo(page);
          expect(i7.totalCount, i6.totalCount);
          expect(i7.openSections, ['sdks', 'advanced']);
          expect(page.url,
              '$origin/packages?q=platform%3Aandroid+show%3Ahidden+pkg');

          // remove discontinued
          await page.click('#search-form-checkbox-show-hidden');
          await page.waitForNavigation(wait: Until.networkIdle);
          expect(page.url, '$origin/packages?q=platform%3Aandroid+pkg');

          Future<void> toggleMore(String tagPrefix, String tagPostfix) async {
            await page.click('#search-form-checkbox-$tagPrefix-$tagPostfix');
            await page.waitForNavigation(wait: Until.networkIdle);
            expect(page.url,
                '$origin/packages?q=platform%3Aandroid+$tagPrefix%3A$tagPostfix+pkg');
            await page.click('#search-form-checkbox-$tagPrefix-$tagPostfix');
            await page.waitForNavigation(wait: Until.networkIdle);
            expect(page.url, '$origin/packages?q=platform%3Aandroid+pkg');
          }

          await toggleMore('is', 'null-safe');
          await toggleMore('is', 'flutter-favorite');
        },
      );

      // type + multiple checkbox clicks
      await headlessEnv.withPage(
        fn: (page) async {
          await page.gotoOrigin('/packages');

          await page.focus('input[name="q"]');
          await page.keyboard.type('pkg');
          final sequence = ['android', 'windows', 'web', 'windows', 'ios'];
          for (final platform in sequence) {
            // check the existence of the click target twice, with a little delay
            final targetSelector = '#search-form-checkbox-platform-$platform';
            await page.waitForSelector(targetSelector, visible: true);
            await Future.delayed(Duration(milliseconds: 50));
            await page.waitForSelector(targetSelector, visible: true);
            await page.click(targetSelector);
          }
          await page.waitForNavigation(wait: Until.networkIdle);
          expect(
              page.url,
              allOf(
                contains('pkg'),
                contains('android'),
                contains('web'),
                contains('ios'),
              ));
          expect(page.url, isNot(contains('windows')));
          expect(await page.propertyValue('input[name="q"]', 'value'),
              'platform:android platform:web platform:ios pkg');

          await page.click('#search-form-checkbox-platform-windows');
          await page.waitForNavigation(wait: Until.networkIdle);
          expect(
              page.url,
              allOf(
                contains('pkg'),
                contains('android'),
                contains('web'),
                contains('ios'),
                contains('windows'),
              ));
          expect(await page.propertyValue('input[name="q"]', 'value'),
              'platform:android platform:web platform:ios platform:windows pkg');
        },
      );

      // licenses
      await headlessEnv.withPage(
        fn: (page) async {
          await page.gotoOrigin('/packages');

          // OSI approved
          await page.click('.search-form-section[data-section-tag="license"]');
          await Future.delayed(Duration(seconds: 1));
          await page.click('#search-form-checkbox-license-osi-approved');
          await page.waitForNavigation(wait: Until.networkIdle);

          expect(await page.propertyValue('input[name="q"]', 'value'),
              'license:osi-approved');
          final pageInfo = await listingPageInfo(page);
          expect(pageInfo.totalCount, greaterThan(0));
          expect(pageInfo.openSections, ['license']);
        },
      );

      // back button working with checkboxes
      await headlessEnv.withPage(
        fn: (page) async {
          await page.gotoOrigin('/packages');

          await page.focus('input[name="q"]');
          await page.keyboard.type('pkg');
          await page.keyboard.press(Key.enter);
          await page.waitForNavigation(wait: Until.networkIdle);
          expect(page.url, '$origin/packages?q=pkg');
          expect(await page.propertyValue('input[name="q"]', 'value'), 'pkg');

          await page.click('#search-form-checkbox-platform-android');
          await page.waitForNavigation(wait: Until.networkIdle);
          expect(page.url, '$origin/packages?q=platform%3Aandroid+pkg');
          expect(await page.propertyValue('input[name="q"]', 'value'),
              'platform:android pkg');

          await page.goBack(wait: Until.networkIdle);
          expect(page.url, '$origin/packages?q=pkg');
          expect(await page.propertyValue('input[name="q"]', 'value'), 'pkg');
        },
      );

      // back button updating the URL and the input text
      await headlessEnv.withPage(
        fn: (page) async {
          await page.gotoOrigin('/packages');

          await page.focus('input[name="q"]');
          await page.keyboard.type('pkg');
          await page.keyboard.press(Key.enter);
          await page.waitForNavigation(wait: Until.networkIdle);
          expect(page.url, '$origin/packages?q=pkg');
          expect(await page.propertyValue('input[name="q"]', 'value'), 'pkg');

          await page.focus('input[name="q"]');
          await page.keyboard.press(Key.arrowDown);
          await page.keyboard.press(Key.backspace);
          await page.keyboard.press(Key.backspace);
          await page.keyboard.press(Key.enter);
          await page.waitForNavigation(wait: Until.networkIdle);
          expect(page.url, '$origin/packages?q=p');
          expect(await page.propertyValue('input[name="q"]', 'value'), 'p');

          await page.goBack(wait: Until.networkIdle);
          expect(page.url, '$origin/packages?q=pkg');
          expect(await page.propertyValue('input[name="q"]', 'value'), 'pkg');
        },
      );

      // Clicking on a tag keeps the search context.
      await headlessEnv.withPage(fn: (page) async {
        await page.gotoOrigin('/packages?q=pkg+platform:android');
        // clicking on the first package's first sub-tag, which is `sdk:dart`
        await page.click('.tag-badge-sub');
        await page.waitForNavigation(wait: Until.networkIdle);
        expect(
            page.url, '$origin/packages?q=platform%3Aandroid+sdk%3Adart+pkg');
      });
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
