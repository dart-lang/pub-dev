// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// An annotation for platform-specific customizations for a test suite.
///
/// See [the README][onPlatform].
///
/// [onPlatform]: https://github.com/dart-lang/test/blob/master/README.md#platform-specific-configuration
class OnPlatform {
  final Map<String, dynamic> annotationsByPlatform;

  const OnPlatform(this.annotationsByPlatform);
}
