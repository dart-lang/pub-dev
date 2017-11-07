#!/usr/bin/env dart
// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library readonly_message_test;

import 'package:test/test.dart' show test, expect, throwsA, predicate;

import 'package:protobuf/protobuf.dart'
    show GeneratedMessage, ReadonlyMessageMixin, BuilderInfo;

throwsError(Type expectedType, String expectedMessage) =>
    throwsA(predicate((x) {
      expect(x.runtimeType, expectedType);
      expect(x.message, expectedMessage);
      return true;
    }));

class Rec extends GeneratedMessage with ReadonlyMessageMixin {
  @override
  BuilderInfo info_ = new BuilderInfo("rec");
  @override
  clone() => throw new UnimplementedError();
}

main() {
  test("can write a read-only message", () {
    expect(new Rec().writeToBuffer(), []);
    expect(new Rec().writeToJson(), "{}");
  });

  test("can't merge to a read-only message", () {
    expect(
        () => new Rec().mergeFromJson("{}"),
        throwsError(UnsupportedError,
            "attempted to call mergeFromJson on a read-only message (rec)"));
  });

  test("can't set a field on a read-only message", () {
    expect(
        () => new Rec().setField(123, 456),
        throwsError(UnsupportedError,
            "attempted to call setField on a read-only message (rec)"));
  });

  test("can't clear a read-only message", () {
    expect(
        () => new Rec().clear(),
        throwsError(UnsupportedError,
            "attempted to call clear on a read-only message (rec)"));
  });

  test("can't modify unknown fields on a read-only message", () {
    expect(
        () => new Rec().unknownFields.clear(),
        throwsError(UnsupportedError,
            "attempted to call clear on a read-only UnknownFieldSet"));
  });
}
