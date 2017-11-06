// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

import 'ast.dart';
import 'visitor.dart';

typedef bool _Semantics(String variable);

/// A visitor for evaluating boolean selectors against a specific set of
/// semantics.
class Evaluator implements Visitor<bool> {
  /// The semantics to evaluate against.
  final _Semantics _semantics;

  Evaluator(semantics)
      : _semantics = semantics is Iterable
            ? DelegatingIterable.typed(semantics.toSet()).contains
            : semantics as _Semantics;

  bool visitVariable(VariableNode node) => _semantics(node.name);

  bool visitNot(NotNode node) => !node.child.accept(this);

  bool visitOr(OrNode node) =>
      node.left.accept(this) || node.right.accept(this);

  bool visitAnd(AndNode node) =>
      node.left.accept(this) && node.right.accept(this);

  bool visitConditional(ConditionalNode node) => node.condition.accept(this)
      ? node.whenTrue.accept(this)
      : node.whenFalse.accept(this);
}
