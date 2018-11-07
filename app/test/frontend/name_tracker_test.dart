// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/name_tracker.dart';

void main() {
  final nameTracker = new NameTracker();
  nameTracker.add('json');
  nameTracker.add('j_son');

  test('new package', () {
    expect(nameTracker.accept('new_package'), isTrue);
  });

  test('existing package', () {
    expect(nameTracker.accept('json'), isTrue);
    expect(nameTracker.accept('j_son'), isTrue);
  });

  test('conflicting package', () {
    expect(nameTracker.accept('js_on'), isFalse);
    expect(nameTracker.accept('jso_n'), isFalse);
  });
}
