// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import "package:collection/collection.dart";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  group("with valid types, forwards", () {
    var wrapper;
    var emptyWrapper;
    setUp(() {
      wrapper = DelegatingList.typed<int>(<Object>[1, 2, 3, 4, 5]);
      emptyWrapper = DelegatingList.typed<int>(<Object>[]);
    });

    test("[]", () {
      expect(wrapper[0], equals(1));
      expect(wrapper[1], equals(2));
      expect(() => wrapper[-1], throwsRangeError);
      expect(() => wrapper[10], throwsRangeError);
    });

    test("[]=", () {
      wrapper[1] = 10;
      wrapper[3] = 15;
      expect(wrapper, equals([1, 10, 3, 15, 5]));
      expect(() => wrapper[-1] = 10, throwsRangeError);
      expect(() => wrapper[10] = 10, throwsRangeError);
    });

    test("add()", () {
      wrapper.add(6);
      wrapper.add(7);
      expect(wrapper, equals([1, 2, 3, 4, 5, 6, 7]));
    });

    test("addAll()", () {
      wrapper.addAll([6, 7, 8]);
      expect(wrapper, equals([1, 2, 3, 4, 5, 6, 7, 8]));
    });

    test("asMap()", () {
      expect(wrapper.asMap(), equals({0: 1, 1: 2, 2: 3, 3: 4, 4: 5}));
    });

    test("clear()", () {
      wrapper.clear();
      expect(wrapper, isEmpty);
    });

    test("fillRange()", () {
      wrapper.fillRange(2, 4);
      expect(wrapper, equals([1, 2, null, null, 5]));

      wrapper.fillRange(1, 2, 7);
      expect(wrapper, equals([1, 7, null, null, 5]));

      expect(() => wrapper.fillRange(-1, 2), throwsRangeError);
      expect(() => wrapper.fillRange(1, 10), throwsRangeError);
      expect(() => wrapper.fillRange(4, 2), throwsRangeError);
      expect(() => wrapper.fillRange(10, 12), throwsRangeError);
    });

    test("getRange()", () {
      expect(wrapper.getRange(2, 4), equals([3, 4]));
      expect(wrapper.getRange(1, 2), equals([2]));

      expect(() => wrapper.getRange(-1, 2), throwsRangeError);
      expect(() => wrapper.getRange(1, 10), throwsRangeError);
      expect(() => wrapper.getRange(4, 2), throwsRangeError);
      expect(() => wrapper.getRange(10, 12), throwsRangeError);
    });

    test("indexOf()", () {
      expect(wrapper.indexOf(4), equals(3));
      expect(wrapper.indexOf(10), equals(-1));
      expect(wrapper.indexOf(4, 2), equals(3));
      expect(wrapper.indexOf(4, 4), equals(-1));
    });

    test("insert()", () {
      wrapper.insert(3, 10);
      expect(wrapper, equals([1, 2, 3, 10, 4, 5]));

      wrapper.insert(0, 15);
      expect(wrapper, equals([15, 1, 2, 3, 10, 4, 5]));

      expect(() => wrapper.insert(-1, 0), throwsRangeError);
      expect(() => wrapper.insert(10, 0), throwsRangeError);
    });

    test("insertAll()", () {
      wrapper.insertAll(3, [10, 11, 12]);
      expect(wrapper, equals([1, 2, 3, 10, 11, 12, 4, 5]));

      wrapper.insertAll(0, [15, 16, 17]);
      expect(wrapper, equals([15, 16, 17, 1, 2, 3, 10, 11, 12, 4, 5]));

      expect(() => wrapper.insertAll(-1, []), throwsRangeError);
      expect(() => wrapper.insertAll(100, []), throwsRangeError);
    });

    test("lastIndexOf()", () {
      expect(wrapper.lastIndexOf(4), equals(3));
      expect(wrapper.lastIndexOf(10), equals(-1));
      expect(wrapper.lastIndexOf(4, 4), equals(3));
      expect(wrapper.lastIndexOf(4, 2), equals(-1));
    });

    test("length=", () {
      wrapper.length = 10;
      expect(wrapper, equals([1, 2, 3, 4, 5, null, null, null, null, null]));

      wrapper.length = 3;
      expect(wrapper, equals([1, 2, 3]));
    });

    test("remove()", () {
      expect(wrapper.remove(3), isTrue);
      expect(wrapper, equals([1, 2, 4, 5]));

      expect(wrapper.remove(3), isFalse);
      expect(wrapper.remove("foo"), isFalse);
    });

    test("removeAt()", () {
      expect(wrapper.removeAt(3), equals(4));
      expect(wrapper, equals([1, 2, 3, 5]));

      expect(() => wrapper.removeAt(-1), throwsRangeError);
      expect(() => wrapper.removeAt(10), throwsRangeError);
    });

    test("removeLast()", () {
      expect(wrapper.removeLast(), equals(5));
      expect(wrapper, equals([1, 2, 3, 4]));

      // See sdk#26087. We want this to pass with the current implementation and
      // with the fix.
      expect(() => emptyWrapper.removeLast(),
          anyOf(throwsStateError, throwsRangeError));
    });

    test("removeRange()", () {
      wrapper.removeRange(2, 4);
      expect(wrapper, equals([1, 2, 5]));

      expect(() => wrapper.removeRange(-1, 2), throwsRangeError);
      expect(() => wrapper.removeRange(1, 10), throwsRangeError);
      expect(() => wrapper.removeRange(4, 2), throwsRangeError);
      expect(() => wrapper.removeRange(10, 12), throwsRangeError);
    });

    test("removeWhere()", () {
      wrapper.removeWhere((i) => i.isOdd);
      expect(wrapper, equals([2, 4]));
    });

    test("replaceRange()", () {
      wrapper.replaceRange(2, 4, [10, 11, 12]);
      expect(wrapper, equals([1, 2, 10, 11, 12, 5]));

      expect(() => wrapper.replaceRange(-1, 2, []), throwsRangeError);
      expect(() => wrapper.replaceRange(1, 10, []), throwsRangeError);
      expect(() => wrapper.replaceRange(4, 2, []), throwsRangeError);
      expect(() => wrapper.replaceRange(10, 12, []), throwsRangeError);
    });

    test("retainWhere()", () {
      wrapper.retainWhere((i) => i.isOdd);
      expect(wrapper, equals([1, 3, 5]));
    });

    test("reversed", () {
      expect(wrapper.reversed, equals([5, 4, 3, 2, 1]));
    });

    test("setAll()", () {
      wrapper.setAll(2, [10, 11]);
      expect(wrapper, equals([1, 2, 10, 11, 5]));

      expect(() => wrapper.setAll(-1, []), throwsRangeError);
      expect(() => wrapper.setAll(10, []), throwsRangeError);
    });

    test("setRange()", () {
      wrapper.setRange(2, 4, [10, 11, 12]);
      expect(wrapper, equals([1, 2, 10, 11, 5]));

      wrapper.setRange(2, 4, [10, 11, 12], 1);
      expect(wrapper, equals([1, 2, 11, 12, 5]));

      expect(() => wrapper.setRange(-1, 2, []), throwsRangeError);
      expect(() => wrapper.setRange(1, 10, []), throwsRangeError);
      expect(() => wrapper.setRange(4, 2, []), throwsRangeError);
      expect(() => wrapper.setRange(10, 12, []), throwsRangeError);
      expect(() => wrapper.setRange(2, 4, []), throwsStateError);
    });

    test("shuffle()", () {
      wrapper.shuffle(new math.Random(1234));
      expect(wrapper, equals([1, 2, 3, 4, 5]..shuffle(new math.Random(1234))));
    });

    test("sort()", () {
      wrapper.sort((a, b) => b.compareTo(a));
      expect(wrapper, equals([5, 4, 3, 2, 1]));

      wrapper.sort();
      expect(wrapper, equals([1, 2, 3, 4, 5]));
    });

    test("sublist()", () {
      expect(wrapper.sublist(2), equals([3, 4, 5]));
      expect(wrapper.sublist(2, 4), equals([3, 4]));
    });
  });

  group("with invalid types", () {
    var inner;
    var wrapper;
    setUp(() {
      inner = <Object>["foo", "bar", "baz"];
      wrapper = DelegatingList.typed<int>(inner);
    });

    group("throws a CastError for", () {
      test("[]", () {
        expect(() => wrapper[0], throwsCastError);
      });

      test("asMap()", () {
        var map = wrapper.asMap();
        expect(() => map[1], throwsCastError);
      });

      test("getRange()", () {
        var lazy = wrapper.getRange(1, 2);
        expect(() => lazy.first, throwsCastError);
      });

      test("removeAt()", () {
        expect(() => wrapper.removeAt(2), throwsCastError);
      });

      test("removeLast()", () {
        expect(() => wrapper.removeLast(), throwsCastError);
      });

      test("removeWhere()", () {
        expect(() => wrapper.removeWhere(expectAsync1((_) => false, count: 0)),
            throwsCastError);
      });

      test("retainWhere()", () {
        expect(() => wrapper.retainWhere(expectAsync1((_) => false, count: 0)),
            throwsCastError);
      });

      test("reversed", () {
        var lazy = wrapper.reversed;
        expect(() => lazy.first, throwsCastError);
      });

      test("sort()", () {
        expect(() => wrapper.sort(expectAsync2((_, __) => 0, count: 0)),
            throwsCastError);
      });

      test("sublist()", () {
        var list = wrapper.sublist(1);
        expect(() => list[0], throwsCastError);
      });
    });

    group("doesn't throw a CastError for", () {
      test("[]", () {
        expect(() => wrapper[-1], throwsRangeError);
        expect(() => wrapper[10], throwsRangeError);
      });

      test("[]=", () {
        wrapper[1] = 10;
        expect(inner, equals(["foo", 10, "baz"]));
        expect(() => wrapper[-1] = 10, throwsRangeError);
        expect(() => wrapper[10] = 10, throwsRangeError);
      });

      test("add()", () {
        wrapper.add(6);
        wrapper.add(7);
        expect(inner, equals(["foo", "bar", "baz", 6, 7]));
      });

      test("addAll()", () {
        wrapper.addAll([6, 7, 8]);
        expect(inner, equals(["foo", "bar", "baz", 6, 7, 8]));
      });

      test("clear()", () {
        wrapper.clear();
        expect(wrapper, isEmpty);
      });

      test("fillRange()", () {
        wrapper.fillRange(1, 3, 7);
        expect(inner, equals(["foo", 7, 7]));

        expect(() => wrapper.fillRange(-1, 2), throwsRangeError);
        expect(() => wrapper.fillRange(1, 10), throwsRangeError);
        expect(() => wrapper.fillRange(4, 2), throwsRangeError);
        expect(() => wrapper.fillRange(10, 12), throwsRangeError);
      });

      test("getRange()", () {
        expect(() => wrapper.getRange(-1, 2), throwsRangeError);
        expect(() => wrapper.getRange(1, 10), throwsRangeError);
        expect(() => wrapper.getRange(4, 2), throwsRangeError);
        expect(() => wrapper.getRange(10, 12), throwsRangeError);
      });

      test("indexOf()", () {
        expect(wrapper.indexOf(4), equals(-1));
      });

      test("insert()", () {
        wrapper.insert(0, 15);
        expect(inner, equals([15, "foo", "bar", "baz"]));

        expect(() => wrapper.insert(-1, 0), throwsRangeError);
        expect(() => wrapper.insert(10, 0), throwsRangeError);
      });

      test("insertAll()", () {
        wrapper.insertAll(0, [15, 16, 17]);
        expect(inner, equals([15, 16, 17, "foo", "bar", "baz"]));

        expect(() => wrapper.insertAll(-1, []), throwsRangeError);
        expect(() => wrapper.insertAll(100, []), throwsRangeError);
      });

      test("lastIndexOf()", () {
        expect(wrapper.lastIndexOf(4), equals(-1));
      });

      test("length=", () {
        wrapper.length = 5;
        expect(inner, equals(["foo", "bar", "baz", null, null]));

        wrapper.length = 1;
        expect(inner, equals(["foo"]));
      });

      test("remove()", () {
        expect(wrapper.remove(3), isFalse);
        expect(wrapper.remove("foo"), isTrue);
        expect(inner, equals(["bar", "baz"]));
      });

      test("removeAt()", () {
        expect(() => wrapper.removeAt(-1), throwsRangeError);
        expect(() => wrapper.removeAt(10), throwsRangeError);
      });

      test("removeRange()", () {
        wrapper.removeRange(1, 3);
        expect(inner, equals(["foo"]));

        expect(() => wrapper.removeRange(-1, 2), throwsRangeError);
        expect(() => wrapper.removeRange(1, 10), throwsRangeError);
        expect(() => wrapper.removeRange(4, 2), throwsRangeError);
        expect(() => wrapper.removeRange(10, 12), throwsRangeError);
      });

      test("replaceRange()", () {
        wrapper.replaceRange(1, 2, [10, 11, 12]);
        expect(inner, equals(["foo", 10, 11, 12, "baz"]));

        expect(() => wrapper.replaceRange(-1, 2, []), throwsRangeError);
        expect(() => wrapper.replaceRange(1, 10, []), throwsRangeError);
        expect(() => wrapper.replaceRange(4, 2, []), throwsRangeError);
        expect(() => wrapper.replaceRange(10, 12, []), throwsRangeError);
      });

      test("setAll()", () {
        wrapper.setAll(1, [10, 11]);
        expect(inner, equals(["foo", 10, 11]));

        expect(() => wrapper.setAll(-1, []), throwsRangeError);
        expect(() => wrapper.setAll(10, []), throwsRangeError);
      });

      test("setRange()", () {
        wrapper.setRange(1, 2, [10, 11, 12]);
        expect(inner, equals(["foo", 10, "baz"]));

        expect(() => wrapper.setRange(-1, 2, []), throwsRangeError);
        expect(() => wrapper.setRange(1, 10, []), throwsRangeError);
        expect(() => wrapper.setRange(4, 2, []), throwsRangeError);
        expect(() => wrapper.setRange(10, 12, []), throwsRangeError);
        expect(() => wrapper.setRange(1, 2, []), throwsStateError);
      });

      test("shuffle()", () {
        wrapper.shuffle(new math.Random(1234));
        expect(inner,
            equals(["foo", "bar", "baz"]..shuffle(new math.Random(1234))));
      });

      test("sort()", () {
        wrapper.sort();
        expect(inner, equals(["bar", "baz", "foo"]));
      });
    });
  }, skip: "Re-enable this when test can run DDC (test#414).");
}
