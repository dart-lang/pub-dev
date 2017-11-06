// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../boolean_selector.dart';

/// A selector that matches all inputs.
class All implements BooleanSelector {
  final variables = const [];

  const All();

  bool evaluate(semantics) => true;

  BooleanSelector intersection(BooleanSelector other) => other;

  BooleanSelector union(BooleanSelector other) => this;

  void validate(bool isDefined(String variable)) {}

  String toString() => "<all>";
}
