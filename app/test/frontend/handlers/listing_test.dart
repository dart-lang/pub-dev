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
    testWithServices('/packages.json', () async {
      await expectJsonResponse(await issueGet('/packages.json'), body: {
        'packages': [
          'https://pub.dev/packages/foobar_pkg.json',
          'https://pub.dev/packages/lithium.json',
          'https://pub.dev/packages/helium.json',
          'https://pub.dev/packages/hydrogen.json',
        ],
        'next': null
      });
    });

    testWithServices('/packages/foobar_pkg.json', () async {
      await expectJsonResponse(await issueGet('/packages/foobar_pkg.json'),
          body: {
            'name': 'foobar_pkg',
            'uploaders': ['hans@juergen.com'],
            'versions': ['0.2.0-dev', '0.1.1+5'],
          });
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
          ...bundle.versions.map(pvModels).expand((m) => m),
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
          ...bundle.versions.map(pvModels).expand((m) => m),
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
          ...bundle.versions.map(pvModels).expand((m) => m),
        ]);
      }
      await indexUpdater.updateAllPackages();

      await expectHtmlResponse(
        await issueGet('/flutter/favorites'),
        present: ['/flutter/favorites?page=2'],
      );
    });
  });
}
