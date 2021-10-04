// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/package/name_tracker.dart';
import 'package:test/test.dart';

void main() {
  group('json', () {
    final nameTracker = NameTracker(null);
    // main package
    nameTracker.add('json');
    // package was added before publishing was blocked.
    nameTracker.add('j_son');

    test('new package can be published', () async {
      expect(await nameTracker.accept('new_package'), isTrue);
    });

    test('existing package is accepted and can be published again', () async {
      expect(await nameTracker.accept('json'), isTrue);
      expect(await nameTracker.accept('j_son'), isTrue);
    });

    test('conflicting package: same name', () async {
      expect(await nameTracker.accept('j_s_o_n'), isFalse);
      expect(await nameTracker.accept('js_on'), isFalse);
      expect(await nameTracker.accept('jso_n'), isFalse);
      expect(await nameTracker.accept('json_'), isFalse);
      expect(await nameTracker.accept('_json'), isFalse);
      expect(await nameTracker.accept('_json_'), isFalse);
      expect(await nameTracker.accept('_j_s_o_n_'), isFalse);
    });

    test('conflicting package: plural', () async {
      expect(await nameTracker.accept('jsons'), isFalse);
      expect(await nameTracker.accept('json__s'), isFalse);
    });
  });

  group('isolate', () {
    final nameTracker = NameTracker(null);
    nameTracker.add('isolates');

    test('conflicting package: singular', () async {
      expect(await nameTracker.accept('isolate'), isFalse);
      expect(await nameTracker.accept('iso_late'), isFalse);
    });
  });
}
