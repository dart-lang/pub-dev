// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

import 'constants/reader.dart';
import 'generator.dart';
import 'library.dart';
import 'type_checker.dart';

/// A [Generator] that invokes [generateForAnnotatedElement] for every [T].
///
/// For example, this will allow code generated for all elements which are
/// annotated with `@Deprecated`:
///
/// ```dart
/// class DeprecatedGenerator extends GeneratorForAnnotation<Deprecated> {
///   @override
///   Future<String> generateForAnnotatedElement(
///       Element element,
///       ConstantReader annotation,
///       BuildStep buildStep) async {
///     // Return a string representing the code to emit.
///   }
/// }
/// ```
abstract class GeneratorForAnnotation<T> extends Generator {
  const GeneratorForAnnotation();

  TypeChecker get typeChecker => new TypeChecker.fromRuntime(T);

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    var elements = library.annotatedWith(typeChecker);
    var allOutput = await Future.wait(elements.map((e) async =>
        await generateForAnnotatedElement(e.element, e.annotation, buildStep)));
    // TODO interleave comments indicating which element produced the output?
    return allOutput.join('\n');
  }

  /// Override to return source code to generate for [element].
  ///
  /// This method is invoked based on finding elements annotated with an
  /// instance of [T]. The [annotation] is provided as a [ConstantReader].
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep);
}
