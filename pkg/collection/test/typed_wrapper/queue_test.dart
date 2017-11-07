// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:collection";

import "package:collection/collection.dart";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  group("with valid types, forwards", () {
    var wrapper;
    var emptyWrapper;
    setUp(() {
      wrapper =
          DelegatingQueue.typed<int>(new Queue<Object>.from([1, 2, 3, 4, 5]));
      emptyWrapper = DelegatingQueue.typed<int>(new Queue<Object>());
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

    test("addFirst()", () {
      wrapper.addFirst(6);
      wrapper.addFirst(7);
      expect(wrapper, equals([7, 6, 1, 2, 3, 4, 5]));
    });

    test("addLast()", () {
      wrapper.addLast(6);
      wrapper.addLast(7);
      expect(wrapper, equals([1, 2, 3, 4, 5, 6, 7]));
    });

    test("clear()", () {
      wrapper.clear();
      expect(wrapper, isEmpty);
    });

    test("remove()", () {
      expect(wrapper.remove(3), isTrue);
      expect(wrapper, equals([1, 2, 4, 5]));

      expect(wrapper.remove(3), isFalse);
      expect(wrapper.remove("foo"), isFalse);
    });

    test("removeWhere()", () {
      wrapper.removeWhere((i) => i.isOdd);
      expect(wrapper, equals([2, 4]));
    });

    test("retainWhere()", () {
      wrapper.retainWhere((i) => i.isOdd);
      expect(wrapper, equals([1, 3, 5]));
    });

    test("removeLast()", () {
      expect(wrapper.removeLast(), equals(5));
      expect(wrapper, equals([1, 2, 3, 4]));

      expect(() => emptyWrapper.removeLast(), throwsStateError);
    });

    test("removeFirst()", () {
      expect(wrapper.removeFirst(), equals(1));
      expect(wrapper, equals([2, 3, 4, 5]));

      expect(() => emptyWrapper.removeFirst(), throwsStateError);
    });
  });

  group("with invalid types", () {
    var inner;
    var wrapper;
    setUp(() {
      inner = new Queue<Object>.from(["foo", "bar", "baz"]);
      wrapper = DelegatingQueue.typed<int>(inner);
    });

    group("throws a CastError for", () {
      test("removeLast()", () {
        expect(() => wrapper.removeLast(), throwsCastError);
      });

      test("removeFirst()", () {
        expect(() => wrapper.removeFirst(), throwsCastError);
      });

      test("removeWhere()", () {
        expect(() => wrapper.removeWhere(expectAsync1((_) => false, count: 0)),
            throwsCastError);
      });

      test("retainWhere()", () {
        expect(() => wrapper.retainWhere(expectAsync1((_) => false, count: 0)),
            throwsCastError);
      });
    });

    group("doesn't throw a CastError for", () {
      test("add()", () {
        wrapper.add(6);
        wrapper.add(7);
        expect(inner, equals(["foo", "bar", "baz", 6, 7]));
      });

      test("addAll()", () {
        wrapper.addAll([6, 7, 8]);
        expect(inner, equals(["foo", "bar", "baz", 6, 7, 8]));
      });

      test("addFirst()", () {
        wrapper.addFirst(6);
        wrapper.addFirst(7);
        expect(inner, equals([7, 6, "foo", "bar", "baz"]));
      });

      test("addLast()", () {
        wrapper.addLast(6);
        wrapper.addLast(7);
        expect(inner, equals(["foo", "bar", "baz", 6, 7]));
      });

      test("clear()", () {
        wrapper.clear();
        expect(wrapper, isEmpty);
      });
    });
  }, skip: "Re-enable this when test can run DDC (test#414).");
}
