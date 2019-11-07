// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Collection of package-related tags.
abstract class PackageTags {
  /// Package is marked discontinued.
  static const String isDiscontinued = 'is:discontinued';

  /// Package is marked notAdvertized - won't be displayed on the landing page.
  static const String isNotAdvertized = 'is:not-advertized';

  /// The first version of the package was published less than 30 days ago.
  static const String isRecent = 'is:recent';
}

/// Collection of version-related tags.
abstract class PackageVersionTags {
  /// PackageVersion supports only legacy (Dart 1) SDK.
  static const String isLegacy = 'is:legacy';
}
