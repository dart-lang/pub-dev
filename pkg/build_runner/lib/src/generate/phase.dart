// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:build/build.dart';

import 'input_set.dart';

class BuildAction {
  final Builder builder;
  final InputSet inputSet;

  BuildAction._(this.builder, this.inputSet);

  BuildAction(this.builder, String package,
      {List<String> inputs = const ['**']})
      : inputSet = new InputSet(package, inputs);

  @override
  String toString() => '$builder on $inputSet';
}
