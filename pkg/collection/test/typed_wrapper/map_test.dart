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
    setUp(() {
      wrapper = DelegatingMap.typed<String, int>(
          <Object, Object>{"foo": 1, "bar": 2, "baz": 3, "bang": 4});
      emptyWrapper = DelegatingMap.typed<String, int>(<Object, Object>{});
    });

    test("[]", () {
      expect(wrapper["foo"], equals(1));
      expect(wrapper["bar"], equals(2));
      expect(wrapper["qux"], isNull);
      expect(wrapper[1], isNull);
    });

    test("[]=", () {
      wrapper["foo"] = 5;
      expect(wrapper, equals({"foo": 5, "bar": 2, "baz": 3, "bang": 4}));

      wrapper["qux"] = 6;
      expect(
          wrapper, equals({"foo": 5, "bar": 2, "baz": 3, "bang": 4, "qux": 6}));
    });

    test("addAll()", () {
      wrapper.addAll({"bar": 5, "qux": 6});
      expect(
          wrapper, equals({"foo": 1, "bar": 5, "baz": 3, "bang": 4, "qux": 6}));
    });

    test("clear()", () {
      wrapper.clear();
      expect(wrapper, isEmpty);
    });

    test("containsKey()", () {
      expect(wrapper.containsKey("foo"), isTrue);
      expect(wrapper.containsKey("qux"), isFalse);
      expect(wrapper.containsKey(1), isFalse);
    });

    test("containsValue()", () {
      expect(wrapper.containsValue(1), isTrue);
      expect(wrapper.containsValue(7), isFalse);
      expect(wrapper.containsValue("foo"), isFalse);
    });

    test("forEach()", () {
      var results = [];
      wrapper.forEach((key, value) => results.add([key, value]));
      expect(
          results,
          unorderedEquals([
            ["foo", 1],
            ["bar", 2],
            ["baz", 3],
            ["bang", 4]
          ]));

      emptyWrapper.forEach(expectAsync2((_, __) {}, count: 0));
    });

    test("isEmpty", () {
      expect(wrapper.isEmpty, isFalse);
      expect(emptyWrapper.isEmpty, isTrue);
    });

    test("isNotEmpty", () {
      expect(wrapper.isNotEmpty, isTrue);
      expect(emptyWrapper.isNotEmpty, isFalse);
    });

    test("keys", () {
      expect(wrapper.keys, unorderedEquals(["foo", "bar", "baz", "bang"]));
      expect(emptyWrapper.keys, isEmpty);
    });

    test("length", () {
      expect(wrapper.length, equals(4));
      expect(emptyWrapper.length, equals(0));
    });

    test("putIfAbsent()", () {
      expect(wrapper.putIfAbsent("foo", expectAsync1((_) => null, count: 0)),
          equals(1));

      expect(wrapper.putIfAbsent("qux", () => 6), equals(6));
      expect(
          wrapper, equals({"foo": 1, "bar": 2, "baz": 3, "bang": 4, "qux": 6}));
    });

    test("remove()", () {
      expect(wrapper.remove("foo"), equals(1));
      expect(wrapper, equals({"bar": 2, "baz": 3, "bang": 4}));

      expect(wrapper.remove("foo"), isNull);
      expect(wrapper.remove(3), isNull);
    });

    test("values", () {
      expect(wrapper.values, unorderedEquals([1, 2, 3, 4]));
      expect(emptyWrapper.values, isEmpty);
    });

    test("toString()", () {
      expect(
          wrapper.toString(),
          allOf([
            startsWith("{"),
            contains("foo: 1"),
            contains("bar: 2"),
            contains("baz: 3"),
            contains("bang: 4"),
            endsWith("}")
          ]));
    });
  });

  group("with invalid key types", () {
    var inner;
    var wrapper;
    setUp(() {
      inner = <Object, Object>{1: 1, 2: 2, 3: 3, 4: 4};
      wrapper = DelegatingMap.typed<String, int>(inner);
    });

    group("throws a CastError for", () {
      test("forEach()", () {
        expect(() => wrapper.forEach(expectAsync2((_, __) {}, count: 0)),
            throwsCastError);
      });

      test("keys", () {
        var lazy = wrapper.keys;
        expect(() => lazy.first, throwsCastError);
      });
    });

    group("doesn't throw a CastError for", () {
      test("[]", () {
        expect(wrapper["foo"], isNull);
        expect(wrapper[1], equals(1));
        expect(wrapper[7], isNull);
      });

      test("[]=", () {
        wrapper["foo"] = 5;
        expect(inner, equals({"foo": 5, 1: 1, 2: 2, 3: 3, 4: 4}));
      });

      test("addAll()", () {
        wrapper.addAll({"foo": 1, "bar": 2});
        expect(inner, equals({"foo": 1, "bar": 2, 1: 1, 2: 2, 3: 3, 4: 4}));
      });

      test("clear()", () {
        wrapper.clear();
        expect(wrapper, isEmpty);
      });

      test("containsKey()", () {
        expect(wrapper.containsKey(1), isTrue);
        expect(wrapper.containsKey(7), isFalse);
        expect(wrapper.containsKey("foo"), isFalse);
      });

      test("containsValue()", () {
        expect(wrapper.containsValue(1), isTrue);
        expect(wrapper.containsValue(7), isFalse);
        expect(wrapper.containsValue("foo"), isFalse);
      });

      test("isEmpty", () {
        expect(wrapper.isEmpty, isFalse);
      });

      test("isNotEmpty", () {
        expect(wrapper.isNotEmpty, isTrue);
      });

      test("length", () {
        expect(wrapper.length, equals(4));
      });

      test("putIfAbsent()", () {
        expect(wrapper.putIfAbsent("foo", () => 1), equals(1));
        expect(inner, equals({"foo": 1, 1: 1, 2: 2, 3: 3, 4: 4}));
      });

      test("remove()", () {
        expect(wrapper.remove(1), equals(1));
        expect(inner, equals({2: 2, 3: 3, 4: 4}));

        expect(wrapper.remove("foo"), isNull);
        expect(wrapper.remove(7), isNull);
      });

      test("values", () {
        expect(wrapper.values, unorderedEquals([1, 2, 3, 4]));
      });

      test("toString()", () {
        expect(
            wrapper.toString(),
            allOf([
              startsWith("{"),
              contains("1: 1"),
              contains("2: 2"),
              contains("3: 3"),
              contains("4: 4"),
              endsWith("}")
            ]));
      });
    });
  }, skip: "Re-enable this when test can run DDC (test#414).");

  group("with invalid value types", () {
    var inner;
    var wrapper;
    setUp(() {
      inner = <Object, Object>{"foo": "bar", "baz": "bang"};
      wrapper = DelegatingMap.typed<String, int>(inner);
    });

    group("throws a CastError for", () {
      test("forEach()", () {
        expect(() => wrapper.forEach(expectAsync2((_, __) {}, count: 0)),
            throwsCastError);
      });

      test("[]", () {
        expect(() => wrapper["foo"], throwsCastError);
        expect(wrapper["qux"], isNull);
      });

      test("putIfAbsent()", () {
        expect(() => wrapper.putIfAbsent("foo", () => 1), throwsCastError);
      });

      test("remove()", () {
        expect(() => wrapper.remove("foo"), throwsCastError);
      });

      test("values", () {
        var lazy = wrapper.values;
        expect(() => lazy.first, throwsCastError);
      });
    });

    group("doesn't throw a CastError for", () {
      test("[]=", () {
        wrapper["foo"] = 5;
        expect(inner, equals({"foo": 5, "baz": "bang"}));
      });

      test("addAll()", () {
        wrapper.addAll({"foo": 1, "qux": 2});
        expect(inner, equals({"foo": 1, "baz": "bang", "qux": 2}));
      });

      test("clear()", () {
        wrapper.clear();
        expect(wrapper, isEmpty);
      });

      test("containsKey()", () {
        expect(wrapper.containsKey("foo"), isTrue);
        expect(wrapper.containsKey(1), isFalse);
        expect(wrapper.containsKey("qux"), isFalse);
      });

      test("containsValue()", () {
        expect(wrapper.containsValue("bar"), isTrue);
        expect(wrapper.containsValue(1), isFalse);
        expect(wrapper.containsValue("foo"), isFalse);
      });

      test("isEmpty", () {
        expect(wrapper.isEmpty, isFalse);
      });

      test("isNotEmpty", () {
        expect(wrapper.isNotEmpty, isTrue);
      });

      test("keys", () {
        expect(wrapper.keys, unorderedEquals(["foo", "baz"]));
      });

      test("length", () {
        expect(wrapper.length, equals(2));
      });

      test("putIfAbsent()", () {
        expect(wrapper.putIfAbsent("qux", () => 1), equals(1));
        expect(inner, equals({"foo": "bar", "baz": "bang", "qux": 1}));
      });

      test("remove()", () {
        expect(wrapper.remove("qux"), isNull);
        expect(wrapper.remove(7), isNull);
      });

      test("toString()", () {
        expect(
            wrapper.toString(),
            allOf([
              startsWith("{"),
              contains("foo: bar"),
              contains("baz: bang"),
              endsWith("}")
            ]));
      });
    });
  }, skip: "Re-enable this when test can run DDC (test#414).");
}
