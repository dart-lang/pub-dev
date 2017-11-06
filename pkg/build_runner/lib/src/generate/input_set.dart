// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:glob/glob.dart';

/// Represents a set of files in a package which should be used as primary
/// inputs to a `Builder`.
class InputSet {
  /// The package that the [globs] should be ran on.
  final String package;

  /// The [Glob]s for files from [package] to use as inputs.
  ///
  /// Note: If the [package] is a package dependency, then only files under
  /// `lib` will be available, but for the application package any files can be
  /// listed.
  final List<Glob> globs;

  InputSet(this.package, Iterable<String> globs)
      : this.globs =
            new List.unmodifiable(globs.map((pattern) => new Glob(pattern)));

  @override
  String toString() {
    var buffer = new StringBuffer()
      ..write('InputSet: package `$package` with globs');
    for (var glob in globs) {
      buffer.write(' `${glob.pattern}`');
    }
    buffer.writeln('');
    return buffer.toString();
  }
}
