// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build/build.dart';

import 'library.dart';

/// A tool to generate Dart code based on a Dart library source.
///
/// During a build [generate] is called once per input library.
abstract class Generator {
  const Generator();

  /// Generates Dart code for an input Dart library.
  ///
  /// May create additional outputs through the `buildStep`, but the 'primary'
  /// output is Dart code returned through the Future. If there is nothing to
  /// generate for this library may return null, or a Future that resolves to
  /// null or the empty string.
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) => null;

  @override
  String toString() => this.runtimeType.toString();
}

/// May be thrown by generators during [Generator.generate].
class InvalidGenerationSourceError extends Error {
  /// What failure occurred.
  final String message;

  /// What could have been changed in the source code to resolve this error.
  ///
  /// May be an empty string if unknown.
  final String todo;

  InvalidGenerationSourceError(this.message, {String todo})
      : this.todo = todo == null ? '' : todo;

  @override
  String toString() => message;
}
