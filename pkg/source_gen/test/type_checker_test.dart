// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Increase timeouts on this test which resolves source code and can be slow.
@Timeout.factor(2.0)
import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build_test/build_test.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

void main() {
  // Resolved top-level types from dart:core and dart:collection.
  InterfaceType staticUri;
  DartType staticMap;
  DartType staticHashMap;
  DartType staticUnmodifiableListView;
  TypeChecker staticIterableChecker;
  TypeChecker staticMapChecker;
  TypeChecker staticHashMapChecker;

  // Resolved top-level types from package:source_gen.
  DartType staticGenerator;
  DartType staticGeneratorForAnnotation;
  TypeChecker staticGeneratorChecker;
  TypeChecker staticGeneratorForAnnotationChecker;

  setUpAll(() async {
    LibraryElement core;
    LibraryElement collection;
    LibraryReader sourceGen;
    await resolveSource(r'''
      export 'package:source_gen/source_gen.dart';
    ''', (resolver) async {
      core = await resolver.findLibraryByName('dart.core');
      collection = await resolver.findLibraryByName('dart.collection');
      sourceGen =
          new LibraryReader(await resolver.findLibraryByName('source_gen'));
    });

    var staticIterable = core.getType('Iterable').type;
    staticIterableChecker = new TypeChecker.fromStatic(staticIterable);
    staticUri = core.getType('Uri').type;
    staticMap = core.getType('Map').type;
    staticMapChecker = new TypeChecker.fromStatic(staticMap);

    staticHashMap = collection.getType('HashMap').type;
    staticHashMapChecker = new TypeChecker.fromStatic(staticHashMap);
    staticUnmodifiableListView =
        collection.getType('UnmodifiableListView').type;

    staticGenerator = sourceGen.findType('Generator').type;
    staticGeneratorChecker = new TypeChecker.fromStatic(staticGenerator);
    staticGeneratorForAnnotation =
        sourceGen.findType('GeneratorForAnnotation').type;
    staticGeneratorForAnnotationChecker =
        new TypeChecker.fromStatic(staticGeneratorForAnnotation);
  });

  // Run a common set of type comparison checks with various implementations.
  void commonTests({
    @required TypeChecker checkIterable(),
    @required TypeChecker checkMap(),
    @required TypeChecker checkHashMap(),
    @required TypeChecker checkGenerator(),
    @required TypeChecker checkGeneratorForAnnotation(),
  }) {
    group('(Iterable)', () {
      test('should be assignable from dart:collection#UnmodifiableListView',
          () {
        expect(checkIterable().isAssignableFromType(staticUnmodifiableListView),
            true);
      });
    });

    group('(Map)', () {
      test('should equal dart:core#Map', () {
        expect(checkMap().isExactlyType(staticMap), isTrue,
            reason: '${checkMap()} != $staticMap');
      });

      test('should not be a super type of dart:core#Map', () {
        expect(checkMap().isSuperTypeOf(staticMap), isFalse);
      });

      test('should not equal dart:core#HashMap', () {
        expect(checkMap().isExactlyType(staticHashMap), isFalse,
            reason: '${checkMap()} == $staticHashMapChecker');
      });

      test('should be a super type of dart:collection#HashMap', () {
        expect(checkMap().isSuperTypeOf(staticHashMap), isFalse);
      });

      test('should be assignable from dart:collection#HashMap', () {
        expect(checkMap().isAssignableFromType(staticHashMap), isTrue);
      });

      // Ensure we're consistent WRT generic types
      test('should be assignable from Map<String, String>', () {
        // Using Uri.queryParameters to get a Map<String, String>
        var stringStringMapType =
            staticUri.getGetter('queryParameters').returnType;

        expect(checkMap().isAssignableFromType(stringStringMapType), isTrue);
        expect(checkMap().isExactlyType(stringStringMapType), isTrue);
      });
    });

    group('(HashMap)', () {
      test('should equal dart:collection#HashMap', () {
        expect(checkHashMap().isExactlyType(staticHashMap), isTrue,
            reason: '${checkHashMap()} != $staticHashMapChecker');
      });

      test('should not be a super type of dart:core#Map', () {
        expect(checkHashMap().isSuperTypeOf(staticMap), isFalse);
      });

      test('should not assignable from type dart:core#Map', () {
        expect(checkHashMap().isAssignableFromType(staticMap), isFalse);
      });
    });

    group('(Generator)', () {
      test('should equal Generator', () {
        expect(checkGenerator().isExactlyType(staticGenerator), isTrue,
            reason: '${checkGenerator()} != $staticGenerator');
      });

      test('should not be a super type of Generator', () {
        expect(checkGenerator().isSuperTypeOf(staticGenerator), isFalse,
            reason: '${checkGenerator()} is super of $staticGenerator');
      });

      test('should be a super type of GeneratorForAnnotation', () {
        expect(checkGenerator().isSuperTypeOf(staticGeneratorForAnnotation),
            isTrue,
            reason:
                '${checkGenerator()} is not super of $staticGeneratorForAnnotation');
      });

      test('should be assignable from GeneratorForAnnotation', () {
        expect(
            checkGenerator().isAssignableFromType(staticGeneratorForAnnotation),
            isTrue,
            reason:
                '${checkGenerator()} is not assignable from $staticGeneratorForAnnotation');
      });
    });
  }

  group('TypeChecker.forRuntime', () {
    commonTests(
        checkIterable: () => const TypeChecker.fromRuntime(Iterable),
        checkMap: () => const TypeChecker.fromRuntime(Map),
        checkHashMap: () => const TypeChecker.fromRuntime(HashMap),
        checkGenerator: () => const TypeChecker.fromRuntime(Generator),
        checkGeneratorForAnnotation: () =>
            const TypeChecker.fromRuntime(GeneratorForAnnotation));
  });

  group('TypeChecker.forStatic', () {
    commonTests(
        checkIterable: () => staticIterableChecker,
        checkMap: () => staticMapChecker,
        checkHashMap: () => staticHashMapChecker,
        checkGenerator: () => staticGeneratorChecker,
        checkGeneratorForAnnotation: () => staticGeneratorForAnnotationChecker);
  });

  group('TypeChecker.fromUrl', () {
    commonTests(
        checkIterable: () => const TypeChecker.fromUrl('dart:core#Iterable'),
        checkMap: () => const TypeChecker.fromUrl('dart:core#Map'),
        checkHashMap: () =>
            const TypeChecker.fromUrl('dart:collection#HashMap'),
        checkGenerator: () => const TypeChecker.fromUrl(
            'package:source_gen/src/generator.dart#Generator'),
        checkGeneratorForAnnotation: () => const TypeChecker.fromUrl(
            'package:source_gen/src/generator_for_annotation.dart#GeneratorForAnnotation'));
  });

  test('should fail gracefully when something is not resolvable', () async {
    final library = await resolveSource(r'''
      library _test;

      @depracated // Intentionally mispelled.
      class X {}
    ''', (resolver) => resolver.findLibraryByName('_test'));
    final classX = library.getType('X');
    final $deprecated = const TypeChecker.fromRuntime(Deprecated);

    expect(() => $deprecated.annotationsOf(classX), throwsStateError,
        reason: 'deprecated was spelled wrong; no annotation can be resolved');
  });

  test('should check multiple checkers', () {
    final listOrMap = const TypeChecker.any(const [
      const TypeChecker.fromRuntime(List),
      const TypeChecker.fromRuntime(Map),
    ]);
    expect(listOrMap.isExactlyType(staticMap), isTrue);
  });

  group('should find annotations', () {
    TypeChecker $A;
    TypeChecker $B;
    TypeChecker $C;

    ClassElement $ExampleOfA;
    ClassElement $ExampleOfMultiA;
    ClassElement $ExampleOfAPlusB;
    ClassElement $ExampleOfBPlusC;

    setUpAll(() async {
      final library = await resolveSource(r'''
      library _test;

      @A()
      class ExampleOfA {}

      @A()
      @A()
      class ExampleOfMultiA {}

      @A()
      @B()
      class ExampleOfAPlusB {}

      @B()
      @C()
      class ExampleOfBPlusC {}

      class A {
        const A();
      }

      class B {
        const B();
      }

      class C extends B {
        const C();
      }
    ''', (resolver) => resolver.findLibraryByName('_test'));
      $A = new TypeChecker.fromStatic(library.getType('A').type);
      $B = new TypeChecker.fromStatic(library.getType('B').type);
      $C = new TypeChecker.fromStatic(library.getType('C').type);
      $ExampleOfA = library.getType('ExampleOfA');
      $ExampleOfMultiA = library.getType('ExampleOfMultiA');
      $ExampleOfAPlusB = library.getType('ExampleOfAPlusB');
      $ExampleOfBPlusC = library.getType('ExampleOfBPlusC');
    });

    test('of a single @A', () {
      expect($A.hasAnnotationOf($ExampleOfA), isTrue);
      final aAnnotation = $A.firstAnnotationOf($ExampleOfA);
      expect(aAnnotation.type.name, 'A');
      expect($B.annotationsOf($ExampleOfA), isEmpty);
      expect($C.annotationsOf($ExampleOfA), isEmpty);
    });

    test('of a multiple @A', () {
      final aAnnotations = $A.annotationsOf($ExampleOfMultiA);
      expect(aAnnotations.map((a) => a.type.name), ['A', 'A']);
      expect($B.annotationsOf($ExampleOfA), isEmpty);
      expect($C.annotationsOf($ExampleOfA), isEmpty);
    });

    test('of a single @A + single @B', () {
      final aAnnotations = $A.annotationsOf($ExampleOfAPlusB);
      expect(aAnnotations.map((a) => a.type.name), ['A']);
      final bAnnotations = $B.annotationsOf($ExampleOfAPlusB);
      expect(bAnnotations.map((a) => a.type.name), ['B']);
      expect($C.annotationsOf($ExampleOfAPlusB), isEmpty);
    });

    test('of a single @B + single @C', () {
      final cAnnotations = $C.annotationsOf($ExampleOfBPlusC);
      expect(cAnnotations.map((a) => a.type.name), ['C']);
      final bAnnotations = $B.annotationsOf($ExampleOfBPlusC);
      expect(bAnnotations.map((a) => a.type.name), ['B', 'C']);
      expect($B.hasAnnotationOfExact($ExampleOfBPlusC), isTrue);
      final bExact = $B.annotationsOfExact($ExampleOfBPlusC);
      expect(bExact.map((a) => a.type.name), ['B']);
    });
  });

  group('unresolved annotations', () {
    TypeChecker $A;
    ClassElement $ExampleOfA;

    setUpAll(() async {
      final library = await resolveSource(r'''
      library _test;

      // Put the missing annotation first so it throws.
      @B()
      @A()
      class ExampleOfA {}

      class A {
        const A();
      }
    ''', (resolver) => resolver.findLibraryByName('_test'));
      $A = new TypeChecker.fromStatic(library.getType('A').type);
      $ExampleOfA = library.getType('ExampleOfA');
    });

    test('should throw by default', () {
      expect(() => $A.firstAnnotationOf($ExampleOfA), throwsStateError);
      expect(() => $A.annotationsOf($ExampleOfA), throwsStateError);
      expect(() => $A.firstAnnotationOfExact($ExampleOfA), throwsStateError);
      expect(() => $A.annotationsOfExact($ExampleOfA), throwsStateError);
    });

    test('should not throw if `throwOnUnresolved` == false', () {
      expect(
          $A.firstAnnotationOf($ExampleOfA, throwOnUnresolved: false).type.name,
          'A');
      expect(
          $A
              .annotationsOf($ExampleOfA, throwOnUnresolved: false)
              .map((a) => a.type.name),
          ['A']);
      expect(
          $A
              .firstAnnotationOfExact($ExampleOfA, throwOnUnresolved: false)
              .type
              .name,
          'A');
      expect(
          $A
              .annotationsOfExact($ExampleOfA, throwOnUnresolved: false)
              .map((a) => a.type.name),
          ['A']);
    });
  });
}
