// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

/// Generates a single-line comment for each class
class CommentGenerator extends Generator {
  final bool forClasses, forLibrary;

  const CommentGenerator({this.forClasses: true, this.forLibrary: false});

  @override
  Future<String> generate(LibraryReader library, _) async {
    var output = new StringBuffer();
    if (forLibrary) {
      output.writeln('// Code for "${library.element}"');
    }
    if (forClasses) {
      for (var classElement
          in library.allElements.where((e) => e is ClassElement)) {
        if (classElement.displayName.contains('GoodError')) {
          throw new InvalidGenerationSourceError(
              "Don't use classes with the word 'Error' in the name",
              todo: 'Rename ${classElement.displayName} to something else.');
        }
        output.writeln('// Code for "$classElement"');
      }
    }
    return '$output';
  }

  @override
  String toString() => 'CommentGenerator';
}
