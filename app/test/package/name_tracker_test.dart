// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/package/name_tracker.dart';

void main() {
  final nameTracker = NameTracker(null);
  nameTracker.add('json');
  nameTracker.add('j_son');

  test('new package', () async {
    expect(await nameTracker.accept('new_package'), isTrue);
  });

  test('existing package', () async {
    expect(await nameTracker.accept('json'), isTrue);
    expect(await nameTracker.accept('j_son'), isTrue);
  });

  test('conflicting package', () async {
    expect(await nameTracker.accept('j_s_o_n'), isFalse);
    expect(await nameTracker.accept('js_on'), isFalse);
    expect(await nameTracker.accept('jso_n'), isFalse);
    expect(await nameTracker.accept('json_'), isFalse);
    expect(await nameTracker.accept('_json'), isFalse);
    expect(await nameTracker.accept('_json_'), isFalse);
    expect(await nameTracker.accept('_j_s_o_n_'), isFalse);
  });
}
