// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/package/name_tracker.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('json', () {
    final nameTracker = NameTracker(null);
    // main package
    nameTracker.add(TrackedPackage.simple('json'));
    // package was added before publishing was blocked.
    nameTracker.add(TrackedPackage.simple('j_son'));

    test('new package can be published', () async {
      expect(await nameTracker.accept('new_package'), isNull);
    });

    test('existing package is accepted and can be published again', () async {
      expect(await nameTracker.accept('json'), isNull);
      expect(await nameTracker.accept('j_son'), isNull);
    });

    test('conflicting package: same name', () async {
      expect(await nameTracker.accept('j_s_o_n'), 'json');
      expect(await nameTracker.accept('js_on'), 'json');
      expect(await nameTracker.accept('jso_n'), 'json');
      expect(await nameTracker.accept('json_'), 'json');
      expect(await nameTracker.accept('_json'), 'json');
      expect(await nameTracker.accept('_json_'), 'json');
      expect(await nameTracker.accept('_j_s_o_n_'), 'json');
    });

    test('conflicting package: plural', () async {
      expect(await nameTracker.accept('jsons'), 'json');
      expect(await nameTracker.accept('json__s'), 'json');
    });
  });

  group('isolate', () {
    final nameTracker = NameTracker(null);
    nameTracker.add(TrackedPackage.simple('isolates'));

    test('conflicting package: singular', () async {
      expect(await nameTracker.accept('isolate'), 'isolates');
      expect(await nameTracker.accept('iso_late'), 'isolates');
    });
  });

  group('m vs rn', () {
    final nameTracker = NameTracker(null);
    nameTracker.add(TrackedPackage.simple('morning'));

    test('morning', () async {
      expect(await nameTracker.accept('moming'), 'morning');
      expect(await nameTracker.accept('rnoming'), 'morning');
      expect(await nameTracker.accept('rnorning'), 'morning');
    });
  });

  group('vv vs w', () {
    final nameTracker = NameTracker(null);
    nameTracker.add(TrackedPackage.simple('webb'));

    test('morning', () async {
      expect(await nameTracker.accept('vvebb'), 'webb');
      expect(await nameTracker.accept('vvvebb'), isNull);
    });
  });

  group('time and version', () {
    test('earlier time does not override the entry', () {
      final nameTracker = NameTracker(null);
      nameTracker.add(
        TrackedPackage(
          package: 'a',
          updated: DateTime(2021, 10, 18),
          latestVersion: '2.0.0',
          lastPublished: DateTime(2021, 10, 18),
          isVisible: true,
        ),
      );
      nameTracker.add(
        TrackedPackage(
          package: 'a',
          updated: DateTime(2021, 10, 17),
          latestVersion: '1.0.0',
          lastPublished: DateTime(2021, 10, 17),
          isVisible: true,
        ),
      );
      expect(
          nameTracker
              .visiblePackagesOrderedByLastPublished.single.latestVersion,
          '2.0.0');
    });

    test('later time does override the entry', () {
      final nameTracker = NameTracker(null);
      nameTracker.add(
        TrackedPackage(
          package: 'a',
          updated: DateTime(2021, 10, 18),
          latestVersion: '1.0.0',
          lastPublished: DateTime(2021, 10, 18),
          isVisible: true,
        ),
      );
      nameTracker.add(
        TrackedPackage(
          package: 'b',
          updated: DateTime(2021, 10, 19),
          latestVersion: '2.0.0',
          lastPublished: DateTime(2021, 10, 19),
          isVisible: true,
        ),
      );
      expect(
        nameTracker.visiblePackagesOrderedByLastPublished
            .map((e) => '${e.package}/${e.latestVersion}')
            .toList(),
        ['b/2.0.0', 'a/1.0.0'],
      );
      nameTracker.add(
        TrackedPackage(
          updated: DateTime(2021, 10, 20),
          package: 'a',
          latestVersion: '3.0.0',
          lastPublished: DateTime(2021, 10, 20),
          isVisible: true,
        ),
      );
      expect(
        nameTracker.visiblePackagesOrderedByLastPublished
            .map((e) => '${e.package}/${e.latestVersion}')
            .toList(),
        ['a/3.0.0', 'b/2.0.0'],
      );
    });
  });

  group('moderated package names', () {
    testWithProfile(
      'aaa_bbb deleted, aaa_bbbs plural',
      testProfile: TestProfile(
        packages: [TestPackage(name: 'aaa_bbb')],
        defaultUser: 'user@pub.dev',
      ),
      fn: () async {
        final tracker = NameTracker(dbService);
        await tracker.scanDatastore();
        // new version is accepted
        expect(await tracker.accept('aaa_bbb'), isNull);
        // plural and alternatives are rejected
        expect(await tracker.accept('aaa_bbbs'), 'aaa_bbb');
        expect(await tracker.accept('aaabbb'), 'aaa_bbb');
        expect(await tracker.accept('aa_ab_bb'), 'aaa_bbb');

        await accountBackend.withBearerToken(
            siteAdminToken, () => adminBackend.removePackage('aaa_bbb'));
        await tracker.scanDatastore();

        // same package name is rejected
        expect(await tracker.accept('aaa_bbb'), 'aaa_bbb');
        // plural form is accepted
        expect(await tracker.accept('aaa_bbbs'), isNull);
        // alternative forms are accepted
        expect(await tracker.accept('aaabbb'), isNull);
        expect(await tracker.accept('aa_ab_bb'), isNull);
      },
    );
  });
}
