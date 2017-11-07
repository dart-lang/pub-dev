// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:collection/collection.dart";
import "package:test/test.dart";

import '../utils.dart';

void main() {
  group("with valid types, forwards", () {
    var wrapper;
    var emptyWrapper;
    var singleWrapper;
    setUp(() {
      wrapper =
          DelegatingIterable.typed<int>(<Object>[1, 2, 3, 4, 5].map((i) => i));
      emptyWrapper = DelegatingIterable.typed<int>(<Object>[].map((i) => i));
      singleWrapper = DelegatingIterable.typed<int>(<Object>[1].map((i) => i));
    });

    test("any()", () {
      expect(wrapper.any((i) => i > 3), isTrue);
      expect(wrapper.any((i) => i > 5), isFalse);
    });

    test("contains()", () {
      expect(wrapper.contains(2), isTrue);
      expect(wrapper.contains(6), isFalse);
      expect(wrapper.contains("foo"), isFalse);
    });

    test("elementAt()", () {
      expect(wrapper.elementAt(1), equals(2));
      expect(wrapper.elementAt(4), equals(5));
      expect(() => wrapper.elementAt(5), throwsRangeError);
      expect(() => wrapper.elementAt(-1), throwsRangeError);
    });

    test("every()", () {
      expect(wrapper.every((i) => i < 6), isTrue);
      expect(wrapper.every((i) => i > 3), isFalse);
    });

    test("expand()", () {
      expect(wrapper.expand((i) => [i]), equals([1, 2, 3, 4, 5]));
      expect(wrapper.expand((i) => [i, i]),
          equals([1, 1, 2, 2, 3, 3, 4, 4, 5, 5]));
    });

    test("first", () {
      expect(wrapper.first, equals(1));
      expect(() => emptyWrapper.first, throwsStateError);
    });

    test("firstWhere()", () {
      expect(wrapper.firstWhere((i) => i > 3), equals(4));
      expect(() => wrapper.firstWhere((i) => i > 5), throwsStateError);
      expect(wrapper.firstWhere((i) => i > 5, orElse: () => -1), equals(-1));
    });

    test("fold()", () {
      expect(wrapper.fold("", (previous, i) => previous + i.toString()),
          equals("12345"));
      expect(emptyWrapper.fold(null, (previous, i) => previous + i), isNull);
    });

    test("forEach()", () {
      var results = [];
      wrapper.forEach(results.add);
      expect(results, equals([1, 2, 3, 4, 5]));

      emptyWrapper.forEach(expectAsync1((_) {}, count: 0));
    });

    test("isEmpty", () {
      expect(wrapper.isEmpty, isFalse);
      expect(emptyWrapper.isEmpty, isTrue);
    });

    test("isNotEmpty", () {
      expect(wrapper.isNotEmpty, isTrue);
      expect(emptyWrapper.isNotEmpty, isFalse);
    });

    test("iterator", () {
      var iterator = wrapper.iterator;
      expect(iterator.current, isNull);
      expect(iterator.moveNext(), isTrue);
      expect(iterator.current, equals(1));
      expect(iterator.moveNext(), isTrue);
      expect(iterator.current, equals(2));
      expect(iterator.moveNext(), isTrue);
      expect(iterator.current, equals(3));
      expect(iterator.moveNext(), isTrue);
      expect(iterator.current, equals(4));
      expect(iterator.moveNext(), isTrue);
      expect(iterator.current, equals(5));
      expect(iterator.moveNext(), isFalse);
      expect(iterator.current, isNull);
    });

    test("join()", () {
      expect(wrapper.join(), "12345");
      expect(wrapper.join("-"), "1-2-3-4-5");
    });

    test("last", () {
      expect(wrapper.last, equals(5));
      expect(() => emptyWrapper.last, throwsStateError);
    });

    test("lastWhere()", () {
      expect(wrapper.lastWhere((i) => i > 3), equals(5));
      expect(() => wrapper.lastWhere((i) => i > 5), throwsStateError);
      expect(wrapper.lastWhere((i) => i > 5, orElse: () => -1), equals(-1));
    });

    test("length", () {
      expect(wrapper.length, equals(5));
      expect(emptyWrapper.length, equals(0));
    });

    test("map()", () {
      expect(wrapper.map((i) => i + 1), equals([2, 3, 4, 5, 6]));
      expect(wrapper.map((i) => i / 2), equals([0.5, 1.0, 1.5, 2.0, 2.5]));
    });

    test("reduce()", () {
      expect(wrapper.reduce((value, i) => value + i), equals(15));
      expect(
          () => emptyWrapper.reduce((value, i) => value + i), throwsStateError);
    });

    test("single", () {
      expect(() => wrapper.single, throwsStateError);
      expect(singleWrapper.single, equals(1));
    });

    test("singleWhere()", () {
      expect(() => wrapper.singleWhere((i) => i.isOdd), throwsStateError);
      expect(singleWrapper.singleWhere((i) => i.isOdd), equals(1));
      expect(
          () => singleWrapper.singleWhere((i) => i.isEven), throwsStateError);
    });

    test("skip()", () {
      expect(wrapper.skip(3), equals([4, 5]));
      expect(wrapper.skip(10), isEmpty);
      expect(() => wrapper.skip(-1), throwsRangeError);
    });

    test("skipWhile()", () {
      expect(wrapper.skipWhile((i) => i < 3), equals([3, 4, 5]));
      expect(wrapper.skipWhile((i) => i < 10), isEmpty);
    });

    test("take()", () {
      expect(wrapper.take(3), equals([1, 2, 3]));
      expect(wrapper.take(10), equals([1, 2, 3, 4, 5]));
      expect(() => wrapper.take(-1), throwsRangeError);
    });

    test("takeWhile()", () {
      expect(wrapper.takeWhile((i) => i < 3), equals([1, 2]));
      expect(wrapper.takeWhile((i) => i < 10), equals([1, 2, 3, 4, 5]));
    });

    test("toList()", () {
      expect(wrapper.toList(), equals([1, 2, 3, 4, 5]));
      expect(wrapper.toList(growable: false), equals([1, 2, 3, 4, 5]));
      expect(
          () => wrapper.toList(growable: false).add(6), throwsUnsupportedError);
    });

    test("toSet()", () {
      expect(wrapper.toSet(), unorderedEquals([1, 2, 3, 4, 5]));
      expect(DelegatingIterable.typed<int>(<Object>[1, 1, 2, 2]).toSet(),
          unorderedEquals([1, 2]));
    });

    test("where()", () {
      expect(wrapper.where((i) => i.isOdd), equals([1, 3, 5]));
      expect(wrapper.where((i) => i.isEven), equals([2, 4]));
    });

    test("toString()", () {
      expect(wrapper.toString(), equals("(1, 2, 3, 4, 5)"));
      expect(emptyWrapper.toString(), equals("()"));
    });
  });

  group("with invalid types", () {
    var wrapper;
    var singleWrapper;
    setUp(() {
      wrapper = DelegatingIterable
          .typed<int>(<Object>["foo", "bar", "baz"].map((element) => element));
      singleWrapper = DelegatingIterable
          .typed<int>(<Object>["foo"].map((element) => element));
    });

    group("throws a CastError for", () {
      test("any()", () {
        expect(() => wrapper.any(expectAsync1((_) => false, count: 0)),
            throwsCastError);
      });

      test("elementAt()", () {
        expect(() => wrapper.elementAt(1), throwsCastError);
      });

      test("every()", () {
        expect(() => wrapper.every(expectAsync1((_) => false, count: 0)),
            throwsCastError);
      });

      test("expand()", () {
        var lazy = wrapper.expand(expectAsync1((_) => [], count: 0));
        expect(() => lazy.first, throwsCastError);
      });

      test("first", () {
        expect(() => wrapper.first, throwsCastError);
      });

      test("firstWhere()", () {
        expect(() => wrapper.firstWhere(expectAsync1((_) => false, count: 0)),
            throwsCastError);
      });

      test("fold()", () {
        expect(
            () => wrapper.fold(null, expectAsync2((_, __) => null, count: 0)),
            throwsCastError);
      });

      test("forEach()", () {
        expect(() => wrapper.forEach(expectAsync1((_) {}, count: 0)),
            throwsCastError);
      });

      test("iterator", () {
        var iterator = wrapper.iterator;
        expect(iterator.current, isNull);
        expect(() => iterator.moveNext(), throwsCastError);
      });

      test("last", () {
        expect(() => wrapper.last, throwsCastError);
      });

      test("lastWhere()", () {
        expect(() => wrapper.lastWhere(expectAsync1((_) => false, count: 0)),
            throwsCastError);
      });

      test("map()", () {
        var lazy = wrapper.map(expectAsync1((_) => null, count: 0));
        expect(() => lazy.first, throwsCastError);
      });

      test("reduce()", () {
        expect(() => wrapper.reduce(expectAsync2((_, __) => null, count: 0)),
            throwsCastError);
      });

      test("single", () {
        expect(() => singleWrapper.single, throwsCastError);
      });

      test("singleWhere()", () {
        expect(() {
          singleWrapper.singleWhere(expectAsync1((_) => false, count: 0));
        }, throwsCastError);
      });

      test("skip()", () {
        var lazy = wrapper.skip(1);
        expect(() => lazy.first, throwsCastError);
      });

      test("skipWhile()", () {
        var lazy = wrapper.skipWhile(expectAsync1((_) => false, count: 0));
        expect(() => lazy.first, throwsCastError);
      });

      test("take()", () {
        var lazy = wrapper.take(1);
        expect(() => lazy.first, throwsCastError);
      });

      test("takeWhile()", () {
        var lazy = wrapper.takeWhile(expectAsync1((_) => false, count: 0));
        expect(() => lazy.first, throwsCastError);
      });

      test("toList()", () {
        var list = wrapper.toList();
        expect(() => list.first, throwsCastError);
      });

      test("toSet()", () {
        var asSet = wrapper.toSet();
        expect(() => asSet.first, throwsCastError);
      });

      test("where()", () {
        var lazy = wrapper.where(expectAsync1((_) => false, count: 0));
        expect(() => lazy.first, throwsCastError);
      });
    });

    group("doesn't throw a CastError for", () {
      test("contains()", () {
        expect(wrapper.contains(1), isFalse);
        expect(wrapper.contains("foo"), isTrue);
      });

      test("elementAt()", () {
        expect(() => wrapper.elementAt(-1), throwsRangeError);
        expect(() => wrapper.elementAt(10), throwsRangeError);
      });

      test("isEmpty", () {
        expect(wrapper.isEmpty, isFalse);
      });

      test("isNotEmpty", () {
        expect(wrapper.isNotEmpty, isTrue);
      });

      test("join()", () {
        expect(wrapper.join(), "foobarbaz");
      });

      test("length", () {
        expect(wrapper.length, equals(3));
      });

      test("single", () {
        expect(() => wrapper.single, throwsStateError);
      });

      test("skip()", () {
        expect(() => wrapper.skip(-1), throwsRangeError);
      });

      test("toString()", () {
        expect(wrapper.toString(), equals("(foo, bar, baz)"));
      });
    });
  }, skip: "Re-enable this when test can run DDC (test#414).");
}
