// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/testing.dart';
import 'package:pub_dev/package/name_tracker.dart';
import 'package:pub_dev/search/search_client.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';
import '_utils.dart';

void main() {
  group('old api', () {
    testWithProfile('/packages.json', fn: () async {
      await expectJsonResponse(
        await issueGet('/packages.json'),
        body: {
          'packages': [
            'https://pub.dev/packages/oxygen.json',
            'https://pub.dev/packages/flutter_titanium.json',
            'https://pub.dev/packages/neon.json',
          ],
          'next': null
        },
      );
    });

    testWithProfile('/packages/oxygen.json', fn: () async {
      await expectJsonResponse(
        await issueGet('/packages/oxygen.json'),
        body: {
          'name': 'oxygen',
          'versions': ['2.0.0-dev', '1.2.0', '1.0.0']
        },
      );
    });
  });

  group('ui', () {
    testWithProfile('/packages', fn: () async {
      await expectHtmlResponse(
        await issueGet('/packages'),
        present: [
          '/packages/oxygen',
          '/packages/neon',
          'oxygen is awesome',
        ],
        absent: [
          '/packages/http',
          '/packages/event_bus',
          'lightweight library for parsing',
        ],
      );
    });

    testWithProfile('/packages?q="oxygen is"', fn: () async {
      await expectHtmlResponse(
        await issueGet('/packages?q="oxygen is"'),
        present: [
          '/packages/oxygen',
          'oxygen is awesome',
        ],
        absent: [
          '/packages/neon',
          '/packages/http',
          '/packages/event_bus',
          'lightweight library for parsing',
        ],
      );
    });

    testWithProfile('/packages?q=oxyge without working search', fn: () async {
      registerSearchClient(
          SearchClient(MockClient((_) async => throw Exception())));
      await nameTracker.reloadFromDatastore();
      final content =
          await expectHtmlResponse(await issueGet('/packages?q=oxyge'));
      expect(content, contains('oxygen is awesome'));
    });

    testWithProfile('/packages?page=2',
        testProfile: TestProfile(
          defaultUser: 'admin@pub.dev',
          packages: List<TestPackage>.generate(
              15,
              (i) => TestPackage(
                  name: 'pkg$i', versions: [TestVersion(version: '1.0.0')])),
        ), fn: () async {
      final present = ['pkg5', 'pkg7', 'pkg11', 'pkg13', 'pkg14'];
      final absent = ['pkg0', 'pkg2', 'pkg3', 'pkg4', 'pkg6', 'pkg9', 'pkg10'];
      await expectHtmlResponse(
        await issueGet('/packages?page=2'),
        present: present.map((name) => '/packages/$name').toList(),
        absent: absent.map((name) => '/packages/$name').toList(),
      );
    });

    testWithProfile(
      '/flutter/packages',
      testProfile: TestProfile(
        packages: List.generate(3, (i) => TestPackage(name: 'package_$i')),
        defaultUser: 'admin@pub.dev',
      ),
      fn: () async {
        await expectHtmlResponse(
          await issueGet('/packages?q=sdk%3Aflutter'),
          present: [
            '/packages/package_0',
            '/packages/package_2',
          ],
          absent: [
            '/packages/package_1',
          ],
        );
      },
      processJobsWithFakeRunners: true,
    );

    testWithProfile(
      'Flutter listings',
      testProfile: TestProfile(
        packages: List<TestPackage>.generate(
          15,
          (i) => TestPackage(
            name: 'flutter_pkg$i',
            isFlutterFavorite: true,
          ),
        ),
        defaultUser: 'admin@pub.dev',
      ),
      fn: () async {
        final names = ['flutter_pkg2', 'flutter_pkg4'];
        await expectHtmlResponse(
          await issueGet('/packages?q=sdk%3Aflutter&page=2'),
          present: names.map((name) => '/packages/$name').toList(),
        );

        await expectHtmlResponse(
          await issueGet('/packages?q=is%3Aflutter-favorite'),
          present: ['/packages?q=is%3Aflutter-favorite&amp;page=2'],
        );
      },
      processJobsWithFakeRunners: true,
    );
  });

  group('Rejected queries', () {
    testWithProfile('too long', fn: () async {
      final longString = 'abcd1234+' * 30;
      await expectHtmlResponse(
        await issueGet('/packages?q=$longString'),
        present: ['Search query rejected. Query too long.'],
      );
    });
  });
}
