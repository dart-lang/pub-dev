// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'build_step.dart';

/// The basic builder class, used to build new files from existing ones.
abstract class Builder {
  /// Generates the outputs for a given [BuildStep].
  Future build(BuildStep buildStep);

  /// Mapping from input file extension to output file extensions.
  ///
  /// All input sources matching any key in this map will be passed as build
  /// step to this builder. Only files with the same basename and an extension
  /// from the values in this map are expected as outputs.
  ///
  /// - If an empty key exists, all inputs are considered matching.
  /// - A builder must always return the same configuration. Typically this will
  /// be `const` but may vary based on build arguments.
  /// - Most builders will use a single input extension and one or more output
  /// extensions.
  Map<String, List<String>> get buildExtensions;
}
