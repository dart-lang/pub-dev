// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/name_tracker.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/search/search_client.dart';
import 'package:pub_dev/search/updater.dart';
import 'package:pub_dev/shared/tags.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_models.dart';
import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFilesIfNeeded());

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
          'uploaders': ['admin@pub.dev'],
          'versions': ['2.0.0-dev', '1.0.0', '1.2.0']
        },
      );
    });
  });

  group('ui', () {
    testWithServices('/packages', () async {
      await expectHtmlResponse(
        await issueGet('/packages'),
        present: [
          '/packages/helium',
          '/packages/hydrogen',
          'hydrogen is a Dart package',
        ],
        absent: [
          '/packages/http',
          '/packages/event_bus',
          'lightweight library for parsing',
        ],
      );
    });

    testWithServices('/packages?q="hydrogen is"', () async {
      await expectHtmlResponse(
        await issueGet('/packages?q="hydrogen is"'),
        present: [
          '/packages/hydrogen',
          'hydrogen is a Dart package',
        ],
        absent: [
          '/packages/helium',
          '/packages/http',
          '/packages/event_bus',
          'lightweight library for parsing',
        ],
      );
    });

    testWithServices('/packages?q=heliu without working search', () async {
      registerSearchClient(
          SearchClient(MockClient((_) async => throw Exception())));
      await nameTracker.scanDatastore();
      final content =
          await expectHtmlResponse(await issueGet('/packages?q=heliu'));
      expect(content, contains('helium is a Dart package'));
    });

    testWithServices('/packages?page=2', () async {
      for (int i = 0; i < 15; i++) {
        final bundle = generateBundle('pkg$i', ['1.0.0']);
        await dbService.commit(inserts: [
          bundle.package,
          ...bundle.versions,
          ...bundle.infos,
          ...bundle.assets,
        ]);
      }
      await indexUpdater.updateAllPackages();

      final names = ['pkg0', 'pkg3', 'pkg10'];
      final list = await packageBackend.latestPackageVersions(offset: 10);
      expect(list.map((p) => p.package).toList(), containsAll(names));

      await expectHtmlResponse(
        await issueGet('/packages?page=2'),
        present: names.map((name) => '/packages/$name').toList(),
      );
    });

    testWithServices('/flutter/packages', () async {
      await expectHtmlResponse(
        await issueGet('/flutter/packages'),
        present: [
// TODO: fix, package should be present on the page.
//          '/packages/helium',
        ],
        absent: [
          '/packages/hydrogen',
          'hydrogen is a Dart package',
          '/packages/http',
          '/packages/event_bus',
          'lightweight library for parsing',
        ],
      );
    });

    testWithServices('/flutter/packages&page=2', () async {
      for (int i = 0; i < 15; i++) {
        final bundle = generateBundle(
          'pkg$i',
          ['1.0.0'],
          pubspecExtraContent: '''
flutter:
  plugin:
    class: SomeClass
''',
        );
        await dbService.commit(inserts: [
          bundle.package,
          ...bundle.versions,
          ...bundle.infos,
          ...bundle.assets,
        ]);
      }
      await indexUpdater.updateAllPackages();

      final names = ['pkg0', 'pkg3', 'pkg10'];
      final list = await packageBackend.latestPackageVersions(offset: 10);
      expect(list.map((p) => p.package).toList(), containsAll(names));

      await expectHtmlResponse(
        await issueGet('/packages?page=2'),
        present: names.map((name) => '/packages/$name').toList(),
      );
    });

    testWithServices('/flutter/favorites: link to 2nd page', () async {
      for (int i = 0; i < 15; i++) {
        final bundle = generateBundle(
          'pkg$i',
          ['1.0.0'],
        );
        bundle.package.assignedTags ??= <String>[];
        bundle.package.assignedTags.add(PackageTags.isFlutterFavorite);
        await dbService.commit(inserts: [
          bundle.package,
          ...bundle.versions,
          ...bundle.infos,
          ...bundle.assets,
        ]);
      }
      await indexUpdater.updateAllPackages();

      await expectHtmlResponse(
        await issueGet('/flutter/favorites'),
        present: ['/flutter/favorites?page=2'],
      );
    });
  });

  group('Rejected queries', () {
    testWithProfile('too long', fn: () async {
      final longString = 'abcd1234+' * 30;
      await expectHtmlResponse(
        await issueGet('/packages?q=$longString'),
        present: ['Search query rejected. Query too long.'],
      );
    });

    testWithProfile('invalid override', fn: () async {
      await expectHtmlResponse(
        await issueGet('/flutter/packages?q=-sdk:flutter'),
        present: [
          'Search query rejected. Tag conflict with search filters: <code>sdk:flutter</code>.'
        ],
      );
    });
  });
}
