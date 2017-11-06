// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'generator.dart';

class GeneratedOutput {
  final String output;
  final Generator generator;
  final error;
  final StackTrace stackTrace;

  bool get isError => error != null;

  GeneratedOutput(this.generator, this.output)
      : error = null,
        stackTrace = null;

  GeneratedOutput.fromError(this.generator, Object error, [this.stackTrace])
      : this.output = _outputFromError(error),
        this.error = error;
}

String _outputFromError(Object error) {
  if (error == null) {
    throw new ArgumentError.notNull('error');
  }

  var buffer = new StringBuffer();

  _commentWithHeader(_errorHeader, error.toString(), buffer);

  if (error is InvalidGenerationSourceError && error.todo.isNotEmpty) {
    _commentWithHeader(_todoHeader, error.todo, buffer);
  }

  return buffer.toString();
}

void _commentWithHeader(String header, String content, StringSink buffer) {
  var lines = const LineSplitter().convert(content);

  buffer.writeAll([_commentPrefix, header, lines.first]);
  buffer.writeln();

  var blankPrefix = ''.padLeft(header.length, ' ');
  for (var i = 1; i < lines.length; i++) {
    buffer.writeAll([_commentPrefix, blankPrefix, lines[i]]);
    buffer.writeln();
  }
}

const _commentPrefix = '// ';
const _errorHeader = 'Error: ';
const _todoHeader = 'TODO: ';
