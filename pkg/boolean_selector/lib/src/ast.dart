// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:source_span/source_span.dart';

import 'visitor.dart';

/// The superclass of nodes in the boolean selector abstract syntax tree.
abstract class Node {
  /// The span indicating where this node came from.
  ///
  /// This is a [FileSpan] because the nodes are parsed from a single continuous
  /// string, but the string itself isn't actually a file. It might come from a
  /// statically-parsed annotation or from a parameter.
  ///
  /// This may be `null` for nodes without source information.
  FileSpan get span;

  /// All the variables in this node, in the order they appear.
  Iterable<String> get variables;

  /// Calls the appropriate [Visitor] method on [this] and returns the result.
  accept(Visitor visitor);
}

/// A single variable.
class VariableNode implements Node {
  final FileSpan span;

  /// The variable name.
  final String name;

  Iterable<String> get variables => [name];

  VariableNode(this.name, [this.span]);

  accept(Visitor visitor) => visitor.visitVariable(this);

  String toString() => name;

  bool operator==(other) => other is VariableNode && name == other.name;

  int get hashCode => name.hashCode;
}

/// A negation expression.
class NotNode implements Node {
  final FileSpan span;

  /// The expression being negated.
  final Node child;

  Iterable<String> get variables => child.variables;

  NotNode(this.child, [this.span]);

  accept(Visitor visitor) => visitor.visitNot(this);

  String toString() => child is VariableNode || child is NotNode
      ? "!$child"
      : "!($child)";

  bool operator==(other) => other is NotNode && child == other.child;

  int get hashCode => ~child.hashCode;
}

/// An or expression.
class OrNode implements Node {
  FileSpan get span => _expandSafe(left.span, right.span);

  /// The left-hand branch of the expression.
  final Node left;

  /// The right-hand branch of the expression.
  final Node right;

  Iterable<String> get variables sync* {
    yield* left.variables;
    yield* right.variables;
  }

  OrNode(this.left, this.right);

  accept(Visitor visitor) => visitor.visitOr(this);

  String toString() {
    var string1 = left is AndNode || left is ConditionalNode
        ? "($left)"
        : left;
    var string2 = right is AndNode || right is ConditionalNode
        ? "($right)"
        : right;

    return "$string1 || $string2";
  }

  bool operator==(other) =>
      other is OrNode && left == other.left && right == other.right;

  int get hashCode => left.hashCode ^ right.hashCode;
}

/// An and expression.
class AndNode implements Node {
  FileSpan get span => _expandSafe(left.span, right.span);

  /// The left-hand branch of the expression.
  final Node left;

  /// The right-hand branch of the expression.
  final Node right;

  Iterable<String> get variables sync* {
    yield* left.variables;
    yield* right.variables;
  }

  AndNode(this.left, this.right);

  accept(Visitor visitor) => visitor.visitAnd(this);

  String toString() {
    var string1 = left is OrNode || left is ConditionalNode
        ? "($left)"
        : left;
    var string2 = right is OrNode || right is ConditionalNode
        ? "($right)"
        : right;

    return "$string1 && $string2";
  }

  bool operator==(other) =>
      other is AndNode && left == other.left && right == other.right;

  int get hashCode => left.hashCode ^ right.hashCode;
}

/// A ternary conditional expression.
class ConditionalNode implements Node {
  FileSpan get span => _expandSafe(condition.span, whenFalse.span);

  /// The condition expression to check.
  final Node condition;

  /// The branch to run if the condition is true.
  final Node whenTrue;

  /// The branch to run if the condition is false.
  final Node whenFalse;

  Iterable<String> get variables sync* {
    yield* condition.variables;
    yield* whenTrue.variables;
    yield* whenFalse.variables;
  }

  ConditionalNode(this.condition, this.whenTrue, this.whenFalse);

  accept(Visitor visitor) => visitor.visitConditional(this);

  String toString() {
    var conditionString =
        condition is ConditionalNode ? "($condition)" : condition;
    var trueString = whenTrue is ConditionalNode ? "($whenTrue)" : whenTrue;
    return "$conditionString ? $trueString : $whenFalse";
  }

  bool operator==(other) =>
      other is ConditionalNode &&
      condition == other.condition &&
      whenTrue == other.whenTrue &&
      whenFalse == other.whenFalse;

  int get hashCode =>
      condition.hashCode ^ whenTrue.hashCode ^ whenFalse.hashCode;
}

/// Like [FileSpan.expand], except if [start] and [end] are `null` or from
/// different files it returns `null` rather than throwing an error.
FileSpan _expandSafe(FileSpan start, FileSpan end) {
  if (start == null || end == null) return null;
  if (start.file != end.file) return null;
  return start.expand(end);
}
