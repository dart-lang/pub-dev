// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:collection/collection.dart";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  group("with valid types, forwards", () {
    var wrapper;
    setUp(() {
      wrapper = DelegatingSet.typed<int>(new Set<Object>.from([1, 2, 3, 4, 5]));
    });

    test("add()", () {
      wrapper.add(1);
      wrapper.add(6);
      expect(wrapper, unorderedEquals([1, 2, 3, 4, 5, 6]));
    });

    test("addAll()", () {
      wrapper.addAll([1, 6, 7]);
      expect(wrapper, unorderedEquals([1, 2, 3, 4, 5, 6, 7]));
    });

    test("clear()", () {
      wrapper.clear();
      expect(wrapper, isEmpty);
    });

    test("containsAll()", () {
      expect(wrapper.containsAll([1, 3, 5]), isTrue);
      expect(wrapper.containsAll([1, 3, 6]), isFalse);
      expect(wrapper.containsAll([1, 3, "foo"]), isFalse);
    });

    test("difference()", () {
      expect(wrapper.difference(new Set.from([1, 3, 6])),
          unorderedEquals([2, 4, 5]));
    });

    test("intersection()", () {
      expect(wrapper.intersection(new Set.from([1, 3, 6, "foo"])),
          unorderedEquals([1, 3]));
    });

    test("lookup()", () {
      expect(wrapper.lookup(1), equals(1));
      expect(wrapper.lookup(7), isNull);
      expect(wrapper.lookup("foo"), isNull);
    });

    test("remove()", () {
      expect(wrapper.remove(3), isTrue);
      expect(wrapper, unorderedEquals([1, 2, 4, 5]));

      expect(wrapper.remove(3), isFalse);
      expect(wrapper.remove("foo"), isFalse);
    });

    test("removeAll()", () {
      wrapper.removeAll([1, 3, 6, "foo"]);
      expect(wrapper, unorderedEquals([2, 4, 5]));
    });

    test("removeWhere()", () {
      wrapper.removeWhere((i) => i.isOdd);
      expect(wrapper, unorderedEquals([2, 4]));
    });

    test("retainAll()", () {
      wrapper.retainAll([1, 3, 6, "foo"]);
      expect(wrapper, unorderedEquals([1, 3]));
    });

    test("retainWhere()", () {
      wrapper.retainWhere((i) => i.isOdd);
      expect(wrapper, unorderedEquals([1, 3, 5]));
    });

    test("union()", () {
      expect(wrapper.union(new Set.from([5, 6, 7])),
          unorderedEquals([1, 2, 3, 4, 5, 6, 7]));
    });
  });

  group("with invalid types", () {
    var inner;
    var wrapper;
    setUp(() {
      inner = new Set<Object>.from(["foo", "bar", "baz"]);
      wrapper = DelegatingSet.typed<int>(inner);
    });

    group("throws a CastError for", () {
      test("difference()", () {
        var result = wrapper.difference(new Set.from([1, 3, 6]));
        expect(() => result.first, throwsCastError);
      });

      test("intersection()", () {
        var result = wrapper.intersection(new Set.from([1, 3, 6, "foo"]));
        expect(() => result.first, throwsCastError);
      });

      test("lookup()", () {
        expect(() => wrapper.lookup("foo"), throwsCastError);
      });

      test("removeWhere()", () {
        expect(() => wrapper.removeWhere(expectAsync1((_) => false, count: 0)),
            throwsCastError);
      });

      test("retainWhere()", () {
        expect(() => wrapper.retainWhere(expectAsync1((_) => false, count: 0)),
            throwsCastError);
      });

      test("union()", () {
        var result = wrapper.union(new Set.from([5, 6, 7]));
        expect(() => result.first, throwsCastError);
      });
    });

    group("doesn't throw a CastError for", () {
      test("add()", () {
        wrapper.add(6);
        expect(inner, unorderedEquals(["foo", "bar", "baz", 6]));
      });

      test("addAll()", () {
        wrapper.addAll([6, 7]);
        expect(inner, unorderedEquals(["foo", "bar", "baz", 6, 7]));
      });

      test("clear()", () {
        wrapper.clear();
        expect(wrapper, isEmpty);
      });

      test("containsAll()", () {
        expect(wrapper.containsAll(["foo", "bar"]), isTrue);
        expect(wrapper.containsAll(["foo", "bar", 1]), isFalse);
      });

      test("lookup()", () {
        expect(wrapper.lookup(1), isNull);
        expect(wrapper.lookup("zap"), isNull);
      });

      test("remove()", () {
        expect(wrapper.remove("foo"), isTrue);
        expect(inner, unorderedEquals(["bar", "baz"]));

        expect(wrapper.remove(3), isFalse);
        expect(wrapper.remove("foo"), isFalse);
      });

      test("removeAll()", () {
        wrapper.removeAll([1, "foo", "baz"]);
        expect(inner, unorderedEquals(["bar"]));
      });

      test("retainAll()", () {
        wrapper.retainAll([1, "foo", "baz"]);
        expect(inner, unorderedEquals(["foo", "baz"]));
      });
    });
  }, skip: "Re-enable this when test can run DDC (test#414).");
}
