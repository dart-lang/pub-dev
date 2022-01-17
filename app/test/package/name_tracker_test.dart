// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/package/name_tracker.dart';
import 'package:test/test.dart';

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

  group('time and version', () {
    test('earlier time does not override the entry', () {
      final nameTracker = NameTracker(null);
      nameTracker.add(
        TrackedPackage(
          package: 'a',
          latestVersion: '2.0.0',
          lastPublished: DateTime(2021, 10, 18),
          isVisible: true,
        ),
      );
      nameTracker.add(
        TrackedPackage(
          package: 'a',
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
          latestVersion: '1.0.0',
          lastPublished: DateTime(2021, 10, 18),
          isVisible: true,
        ),
      );
      nameTracker.add(
        TrackedPackage(
          package: 'b',
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
}
