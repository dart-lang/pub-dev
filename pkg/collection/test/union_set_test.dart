// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:test/test.dart";

import "package:collection/collection.dart";

void main() {
  group("with an empty outer set", () {
    var set;
    setUp(() {
      set = new UnionSet<int>(new Set());
    });

    test("length returns 0", () {
      expect(set.length, equals(0));
    });

    test("contains() returns false", () {
      expect(set.contains(0), isFalse);
      expect(set.contains(null), isFalse);
      expect(set.contains("foo"), isFalse);
    });

    test("lookup() returns null", () {
      expect(set.lookup(0), isNull);
      expect(set.lookup(null), isNull);
      expect(set.lookup("foo"), isNull);
    });

    test("toSet() returns an empty set", () {
      expect(set.toSet(), isEmpty);
      expect(set.toSet(), isNot(same(set)));
    });

    test("map() doesn't run on any elements", () {
      expect(set.map(expectAsync1((_) {}, count: 0)), isEmpty);
    });
  });

  group("with multiple disjoint sets", () {
    var set;
    setUp(() {
      set = new UnionSet<int>.from([
        new Set.from([1, 2]),
        new Set.from([3, 4]),
        new Set.from([5]),
        new Set()
      ], disjoint: true);
    });

    test("length returns the total length", () {
      expect(set.length, equals(5));
    });

    test("contains() returns whether any set contains the element", () {
      expect(set.contains(1), isTrue);
      expect(set.contains(4), isTrue);
      expect(set.contains(5), isTrue);
      expect(set.contains(6), isFalse);
    });

    test("lookup() returns elements that are in any set", () {
      expect(set.lookup(1), equals(1));
      expect(set.lookup(4), equals(4));
      expect(set.lookup(5), equals(5));
      expect(set.lookup(6), isNull);
    });

    test("toSet() returns the union of all the sets", () {
      expect(set.toSet(), unorderedEquals([1, 2, 3, 4, 5]));
      expect(set.toSet(), isNot(same(set)));
    });

    test("map() maps the elements", () {
      expect(set.map((i) => i * 2), unorderedEquals([2, 4, 6, 8, 10]));
    });
  });

  group("with multiple overlapping sets", () {
    var set;
    setUp(() {
      set = new UnionSet<int>.from([
        new Set.from([1, 2, 3]),
        new Set.from([3, 4]),
        new Set.from([5, 1]),
        new Set()
      ]);
    });

    test("length returns the total length", () {
      expect(set.length, equals(5));
    });

    test("contains() returns whether any set contains the element", () {
      expect(set.contains(1), isTrue);
      expect(set.contains(4), isTrue);
      expect(set.contains(5), isTrue);
      expect(set.contains(6), isFalse);
    });

    test("lookup() returns elements that are in any set", () {
      expect(set.lookup(1), equals(1));
      expect(set.lookup(4), equals(4));
      expect(set.lookup(5), equals(5));
      expect(set.lookup(6), isNull);
    });

    test("lookup() returns the first element in an ordered context", () {
      var duration1 = new Duration(seconds: 0);
      var duration2 = new Duration(seconds: 0);
      expect(duration1, equals(duration2));
      expect(duration1, isNot(same(duration2)));

      var set = new UnionSet.from([
        new Set.from([duration1]),
        new Set.from([duration2])
      ]);

      expect(set.lookup(new Duration(seconds: 0)), same(duration1));
    });

    test("toSet() returns the union of all the sets", () {
      expect(set.toSet(), unorderedEquals([1, 2, 3, 4, 5]));
      expect(set.toSet(), isNot(same(set)));
    });

    test("map() maps the elements", () {
      expect(set.map((i) => i * 2), unorderedEquals([2, 4, 6, 8, 10]));
    });
  });

  group("after an inner set was modified", () {
    var set;
    setUp(() {
      var innerSet = new Set<int>.from([3, 7]);
      set = new UnionSet<int>.from([
        new Set.from([1, 2]),
        new Set.from([5]),
        innerSet
      ]);

      innerSet.add(4);
      innerSet.remove(7);
    });

    test("length returns the total length", () {
      expect(set.length, equals(5));
    });

    test("contains() returns true for a new element", () {
      expect(set.contains(4), isTrue);
    });

    test("contains() returns false for a removed element", () {
      expect(set.contains(7), isFalse);
    });

    test("lookup() returns a new element", () {
      expect(set.lookup(4), equals(4));
    });

    test("lookup() doesn't returns a removed element", () {
      expect(set.lookup(7), isNull);
    });

    test("toSet() returns the union of all the sets", () {
      expect(set.toSet(), unorderedEquals([1, 2, 3, 4, 5]));
      expect(set.toSet(), isNot(same(set)));
    });

    test("map() maps the elements", () {
      expect(set.map((i) => i * 2), unorderedEquals([2, 4, 6, 8, 10]));
    });
  });

  group("after the outer set was modified", () {
    var set;
    setUp(() {
      var innerSet = new Set.from([6]);
      var outerSet = new Set<Set<int>>.from([
        new Set.from([1, 2]),
        new Set.from([5]),
        innerSet
      ]);

      set = new UnionSet<int>(outerSet);
      outerSet.remove(innerSet);
      outerSet.add(new Set.from([3, 4]));
    });

    test("length returns the total length", () {
      expect(set.length, equals(5));
    });

    test("contains() returns true for a new element", () {
      expect(set.contains(4), isTrue);
    });

    test("contains() returns false for a removed element", () {
      expect(set.contains(6), isFalse);
    });

    test("lookup() returns a new element", () {
      expect(set.lookup(4), equals(4));
    });

    test("lookup() doesn't returns a removed element", () {
      expect(set.lookup(6), isNull);
    });

    test("toSet() returns the union of all the sets", () {
      expect(set.toSet(), unorderedEquals([1, 2, 3, 4, 5]));
      expect(set.toSet(), isNot(same(set)));
    });

    test("map() maps the elements", () {
      expect(set.map((i) => i * 2), unorderedEquals([2, 4, 6, 8, 10]));
    });
  });
}
