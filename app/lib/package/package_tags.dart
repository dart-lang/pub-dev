// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Collection of package-related tags.
abstract class PackageTags {
  /// Package is marked discontinued.
  static const String isDiscontinued = 'is:discontinued';

  /// The first version of the package was published less than 30 days ago.
  static const String isRecent = 'is:recent';
}
