// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:source_span/source_span.dart';

/// A platform on which the user has chosen to run tests.
class PlatformSelection {
  /// The name of the platform.
  final String name;

  /// The location in the configuration file of this platform string, or `null`
  /// if it was defined outside a configuration file (for example, on the
  /// command line).
  final SourceSpan span;

  PlatformSelection(this.name, [this.span]);

  bool operator ==(other) => other is PlatformSelection && other.name == name;

  int get hashCode => name.hashCode;
}
