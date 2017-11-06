// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Tests for GeneratedMessage methods.
library message_test;

import 'package:test/test.dart' show test, expect, predicate, throwsA;

import 'mock_util.dart' show MockMessage, mockInfo;

class Rec extends MockMessage {
  get info_ => _info;
  static final _info = mockInfo("Rec", () => new Rec());
}

throwsError(Type expectedType, String expectedMessage) =>
    throwsA(predicate((x) {
      expect(x.runtimeType, expectedType);
      expect(x.message, expectedMessage);
      return true;
    }));

main() {
  test('getField with invalid tag throws exception', () {
    var r = new Rec();
    expect(() {
      r.getField(123);
    }, throwsError(ArgumentError, "tag 123 not defined in Rec"));
  });

  test('getDefaultForField with invalid tag throws exception', () {
    var r = new Rec();
    expect(() {
      r.getDefaultForField(123);
    }, throwsError(ArgumentError, "tag 123 not defined in Rec"));
  });

  test('operator== and hashCode work for a simple record', () {
    var a = new Rec();
    expect(a == a, true);

    var b = new Rec();
    expect(a.info_ == b.info_, true, reason: "BuilderInfo should be the same");
    expect(a == b, true);
    expect(a.hashCode, b.hashCode);

    a.val = 123;
    expect(a == b, false);
    b.val = 123;
    expect(a == b, true);
    expect(a.hashCode, b.hashCode);

    a.child = new Rec();
    expect(a == b, false);
    b.child = new Rec();
    expect(a == b, true);
    expect(a.hashCode, b.hashCode);
  });
}
