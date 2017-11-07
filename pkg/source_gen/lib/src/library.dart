// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/standard_resolution_map.dart';
import 'package:analyzer/dart/element/element.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/resolver/scope.dart';

import 'constants/reader.dart';
import 'type_checker.dart';

/// Result of finding an [annotation] on [element] through [LibraryReader].
class AnnotatedElement {
  final ConstantReader annotation;
  final Element element;

  const AnnotatedElement(this.annotation, this.element);
}

/// A high-level wrapper API with common functionality for [LibraryElement].
class LibraryReader {
  final LibraryElement element;

  Namespace _namespaceCache;

  LibraryReader(this.element);

  Namespace get _namespace => _namespaceCache ??=
      new NamespaceBuilder().createExportNamespaceForLibrary(element);

  /// Returns a top-level [ClassElement] publicly visible in by [name].
  ///
  /// Unlike [LibraryElement.getType], this also correctly traverses identifiers
  /// that are accessible via one or more `export` directives.
  ClassElement findType(String name) =>
      element.getType(name) ?? _namespace.get(name) as ClassElement;

  /// All of the declarations in this library.
  Iterable<Element> get allElements sync* {
    for (var cu in element.units) {
      for (var compUnitMember in cu.unit.declarations) {
        yield* _getElements(compUnitMember);
      }
    }
  }

  /// All of the declarations in this library annotated with [checker].
  Iterable<AnnotatedElement> annotatedWith(TypeChecker checker,
      {bool throwOnUnresolved}) sync* {
    for (final element in allElements) {
      final annotation = checker.firstAnnotationOf(element,
          throwOnUnresolved: throwOnUnresolved);
      if (annotation != null) {
        yield new AnnotatedElement(new ConstantReader(annotation), element);
      }
    }
  }

  /// All of the declarations in this library annotated with exactly [checker].
  Iterable<AnnotatedElement> annotatedWithExact(TypeChecker checker,
      {bool throwOnUnresolved}) sync* {
    for (final element in allElements) {
      final annotation = checker.firstAnnotationOfExact(element,
          throwOnUnresolved: throwOnUnresolved);
      if (annotation != null) {
        yield new AnnotatedElement(new ConstantReader(annotation), element);
      }
    }
  }

  /// All of the `class` elements in this library.
  Iterable<ClassElement> get classElements =>
      element.definingCompilationUnit.types;

  Iterable<Element> _getElements(CompilationUnitMember member) {
    if (member is TopLevelVariableDeclaration) {
      return member.variables.variables
          .map(resolutionMap.elementDeclaredByVariableDeclaration);
    }
    var element = resolutionMap.elementDeclaredByDeclaration(member);

    if (element == null) {
      print([member, member.runtimeType, member.element]);
      throw new Exception('Could not find any elements for the provided unit.');
    }

    return [element];
  }
}
