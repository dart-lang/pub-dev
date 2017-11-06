// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:source_span/source_span.dart';

import 'ast.dart';
import 'visitor.dart';

typedef bool _IsDefined(String variable);

/// An AST visitor that ensures that all variables are valid.
class Validator extends RecursiveVisitor {
  final _IsDefined _isDefined;

  Validator(this._isDefined);

  void visitVariable(VariableNode node) {
    if (_isDefined(node.name)) return;
    throw new SourceSpanFormatException("Undefined variable.", node.span);
  }
}
