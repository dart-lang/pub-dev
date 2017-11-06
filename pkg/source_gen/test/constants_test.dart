// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:build_test/build_test.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

void main() {
  group('Constant', () {
    List<ConstantReader> constants;

    setUpAll(() async {
      final library = await resolveSource(r'''
        library test_lib;
        
        const aString = 'Hello';
        const aInt = 1234;
        const aBool = true;
        const aNull = null;
        const aList = const [1, 2, 3];
        const aMap = const {1: 'A', 2: 'B'};
        const aDouble = 1.23;
        const aSymbol = #shanna;
        const aType = DateTime;
        
        @aString    // [0]
        @aInt       // [1]
        @aBool      // [2]
        @aNull      // [3]
        @Example(   // [4]
          aString: aString,
          aInt: aInt,
          aBool: aBool,
          aNull: aNull,
          nested: const Example(),
        )
        @Super()    // [5]
        @aList      // [6]
        @aMap       // [7]
        @deprecated // [8]
        @aDouble    // [9]
        @aSymbol    // [10]
        @aType      // [11]
        class Example {
          final String aString;
          final int aInt;
          final bool aBool;
          final Example nested;
          
          const Example({this.aString, this.aInt, this.aBool, this.nested});
        }
        
        class Super extends Example {
          const Super() : super(aString: 'Super Hello');
        }
      ''', (resolver) => resolver.findLibraryByName('test_lib'));
      constants = library
          .getType('Example')
          .metadata
          .map((e) => new ConstantReader(e.computeConstantValue()))
          .toList();
    });

    test('should read a String', () {
      expect(constants[0].isString, isTrue);
      expect(constants[0].stringValue, 'Hello');
      expect(constants[0].isLiteral, isTrue);
      expect(constants[0].literalValue, 'Hello');
    });

    test('should read an Int', () {
      expect(constants[1].isInt, isTrue);
      expect(constants[1].intValue, 1234);
      expect(constants[1].isLiteral, isTrue);
      expect(constants[1].literalValue, 1234);
    });

    test('should read a Bool', () {
      expect(constants[2].isBool, isTrue);
      expect(constants[2].boolValue, isTrue);
      expect(constants[2].isLiteral, isTrue);
      expect(constants[2].literalValue, isTrue);
    });

    test('should read a Null', () {
      expect(constants[3].isNull, isTrue);
      expect(constants[3].isLiteral, isTrue);
      expect(constants[3].literalValue, isNull);
    });

    test('should read an arbitrary object', () {
      final constant = constants[4];

      expect(constant.isLiteral, isFalse);
      expect(() => constant.literalValue, throwsFormatException);

      expect(constant.read('aString').stringValue, 'Hello');
      expect(constant.read('aInt').intValue, 1234);
      expect(constant.read('aBool').boolValue, true);

      final nested = constant.read('nested');
      expect(nested.isNull, isFalse, reason: '$nested');
      expect(nested.read('aString').isNull, isTrue, reason: '$nested');
      expect(nested.read('aInt').isNull, isTrue);
      expect(nested.read('aBool').isNull, isTrue);
    });

    test('should read from a super object', () {
      final constant = constants[5];
      expect(constant.read('aString').stringValue, 'Super Hello');
    });

    test('should read a list', () {
      expect(constants[6].isList, isTrue, reason: '${constants[6]}');
      expect(constants[6].isLiteral, isTrue);
      expect(constants[6].listValue.map((c) => new ConstantReader(c).intValue),
          [1, 2, 3]);
    });

    test('should read a map', () {
      expect(constants[7].isMap, isTrue, reason: '${constants[7]}');
      expect(constants[7].isLiteral, isTrue);
      expect(
          mapMap<DartObject, DartObject, int, String>(constants[7].mapValue,
              key: (k, _) => new ConstantReader(k).intValue,
              value: (_, v) => new ConstantReader(v).stringValue),
          {1: 'A', 2: 'B'});
    });

    test('should read a double', () {
      expect(constants[9].isDouble, isTrue);
      expect(constants[9].doubleValue, 1.23);
      expect(constants[9].isLiteral, isTrue);
      expect(constants[9].literalValue, 1.23);
    });

    test('should read a Symbol', () {
      expect(constants[10].isSymbol, isTrue);
      expect(constants[10].isLiteral, isTrue);
      expect(constants[10].symbolValue, #shanna);
      expect(constants[10].literalValue, #shanna);
    });

    test('should read a Type', () {
      expect(constants[11].isType, isTrue);
      expect(constants[11].typeValue.name, 'DateTime');
      expect(constants[11].isLiteral, isFalse);
      expect(() => constants[11].literalValue, throwsFormatException);
    });

    test('should give back the underlying value', () {
      final object = constants[11].objectValue;
      expect(object, isNotNull);
      expect(object.toTypeValue(), isNotNull);
    });

    test('should fail reading from `null`', () {
      final $null = constants[3];
      expect($null.isNull, isTrue, reason: '${$null}');
      expect(() => $null.read('foo'), throwsUnsupportedError);
    });

    test('should not fail reading from `null` when using peek', () {
      final $null = constants[3];
      expect($null.isNull, isTrue, reason: '${$null}');
      expect($null.peek('foo'), isNull);
    });

    test('should fail reading a missing field', () {
      final $super = constants[5];
      expect(() => $super.read('foo'), throwsFormatException);
    });

    test('should compare using TypeChecker', () {
      final $deprecated = constants[8];
      final check = new TypeChecker.fromRuntime(Deprecated);
      expect($deprecated.instanceOf(check), isTrue, reason: '$deprecated');
    });
  });

  group('Reviable', () {
    List<ConstantReader> constants;

    setUpAll(() async {
      final library = await resolveSource(r'''
        library test_lib;
        
        @Int64Like.ZERO
        @Duration(seconds: 30)
        @Enum.field1
        @MapLike()
        @VisibleClass.secret()
        @fieldOnly
        class Example {}
        
        class Int64Like {
          static const Int64Like ZERO = const Int64Like._bits(0, 0, 0);
        
          final int _l;
          final int _m;
          final int _h;
          
          const Int64Like._bits(this._l, this._m, this._h);
        }
        
        enum Enum {
          field1,
          field2,
        }
        
        abstract class MapLike {
          const factory MapLike() = LinkedHashMapLike;
        }
        
        class LinkedHashMapLike implements MapLike {
          const LinkedHashMapLike();
        }
        
        class VisibleClass {
          const factory VisbileClass.secret() = _HiddenClass;
        }
        
        class _HiddenClass implements VisibleClass {
          const _HiddenClass();
        }
        
        class _FieldOnlyVisible {
          const _FieldOnlyVisible();
        }
        
        const fieldOnly = const _FieldOnlyVisible();
      ''', (resolver) => resolver.findLibraryByName('test_lib'));
      constants = library
          .getType('Example')
          .metadata
          .map((e) => new ConstantReader(e.computeConstantValue()))
          .toList();
    });

    test('should decode Int64Like.ZERO', () {
      final int64Like0 = constants[0].revive();
      expect(int64Like0.source.toString(), endsWith('#Int64Like'));
      expect(int64Like0.accessor, 'ZERO');
    });

    test('should decode Duration', () {
      final duration30s = constants[1].revive();
      expect(duration30s.source.toString(), 'dart:core#Duration');
      expect(duration30s.accessor, isEmpty);
      expect(
          mapMap(duration30s.namedArguments,
              value: (_, DartObject v) => new ConstantReader(v).literalValue),
          {
            'seconds': 30,
          });
    });

    test('should decode enums', () {
      final enumField1 = constants[2].revive();
      expect(enumField1.source.toString(), endsWith('#Enum'));
      expect(enumField1.accessor, 'field1');
    });

    test('should decode forwarding factories', () {
      final mapLike = constants[3].revive();
      expect(mapLike.source.toString(), endsWith('#MapLike'));
      expect(mapLike.accessor, isEmpty);
    });

    test('should decode forwarding factories to hidden classes', () {
      final hiddenClass = constants[4].revive();
      expect(hiddenClass.source.toString(), endsWith('#VisibleClass'));
      expect(hiddenClass.accessor, 'secret');
    });

    test('should decode top-level fields', () {
      final fieldOnly = constants[5].revive();
      expect(fieldOnly.source.fragment, isEmpty);
      expect(fieldOnly.accessor, 'fieldOnly');
    });
  });
}
