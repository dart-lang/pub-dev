// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Tag prefixes that are allowed.
///
/// Whether a tag is assigned by pub-administrator, package owner, or derived
/// by pana it must have a prefix listed here. Otherwise, it should be ignore
/// or an error should be returned to the caller.
const allowedTagPrefixes = [
  'is:',
  'license:',
  'platform:',
  'publisher:',
  'runtime:',
  'sdk:',
  'show:',
  'has:',
  'topic:'
];

/// Collection of package-related tags.
abstract class PackageTags {
  /// Package is shown, regardless of its hidden status.
  static const String showHidden = 'show:hidden';

  /// Package is marked discontinued.
  static const String isDiscontinued = 'is:discontinued';

  /// Package is shown, regardless of its discontinued status.
  static const String showDiscontinued = 'show:discontinued';

  /// Package is marked unlisted, discontinued, or is a legacy package.
  static const String isUnlisted = 'is:unlisted';

  /// Package is shown, regardless of its unlisted status.
  static const String showUnlisted = 'show:unlisted';

  /// The first version of the package was published less than 30 days ago.
  static const String isRecent = 'is:recent';

  /// Package is marked with Flutter Favorite.
  static const String isFlutterFavorite = 'is:flutter-favorite';

  /// The `publisher:<publisherId>` tag.
  static String publisherTag(String publisherId) => 'publisher:$publisherId';
}

/// Collection of version-related tags.
abstract class PackageVersionTags {
  /// PackageVersion supports only legacy (Dart 1) SDK.
  static const String isLegacy = 'is:legacy';

  /// Package is shown, regardless of its legacy status.
  static const String showLegacy = 'show:legacy';

  /// PackageVersion is older than 2 years old and Package has a newer version.
  static const String isObsolete = 'is:obsolete';

  /// PackageVersion is a Flutter plugin.
  static const String isPlugin = 'is:plugin';

  /// The PackageVersion is null-safe.
  ///
  /// See definition at `_NullSafetyViolationFinder` in
  /// https://github.com/dart-lang/pana/blob/master/lib/src/tag_detection.dart
  static const String isNullSafe = 'is:null-safe';

  /// The `pubspec.yaml` has one or more `funding` link.
  static const String hasFundingLink = 'has:funding-link';

  /// pana encountered errors during analysis.
  static const String hasError = 'has:error';

  /// Package version has a screenshot that we can display.
  static const String hasScreenshot = 'has:screenshot';

  /// Package version is compatible with Dart 3.
  /// TODO: remove after the next release gets stable
  static const String isDart3Ready = 'is:dart3-ready';

  /// Package version is compatible with Dart 3.
  static const String isDart3Compatible = 'is:dart3-compatible';

  /// Version tags that provide a positive, forward-looking property
  /// of a prerelease or preview version.
  ///
  /// Other version-specific tags are not included to prevent search
  /// regressions where we would downrank and/or hide the package in
  /// search results (e.g. a version may have compatibilty errors or
  /// get `is:legacy` classification).
  static const _futurePackageVersionTags = {
    PackageVersionTags.isNullSafe,
    PackageVersionTags.isPlugin,
    PackageVersionTags.hasFundingLink,
    PackageVersionTags.hasScreenshot,
    PackageVersionTags.isDart3Compatible,
  };
}

/// Collection of SDK tags (with prefix and value).
abstract class SdkTag {
  static const String sdkDart = 'sdk:${SdkTagValue.dart}';
  static const String sdkFlutter = 'sdk:${SdkTagValue.flutter}';

  static const _allSdkTags = {
    sdkDart,
    sdkFlutter,
  };
}

/// Collection of SDK tag values.
abstract class SdkTagValue {
  static const String dart = 'dart';
  static const String flutter = 'flutter';

  static bool isValidSdk(String value) => value == dart || value == flutter;
}

/// Collection of platform tags (with prefix and value).
abstract class PlatformTag {
  static const String platformAndroid = 'platform:${PlatformTagValue.android}';
  static const String platformIos = 'platform:${PlatformTagValue.ios}';
  static const String platformMacos = 'platform:${PlatformTagValue.macos}';
  static const String platformLinux = 'platform:${PlatformTagValue.linux}';
  static const String platformWeb = 'platform:${PlatformTagValue.web}';
  static const String platformWindows = 'platform:${PlatformTagValue.windows}';

  static const _allPlatformTags = {
    platformAndroid,
    platformIos,
    platformMacos,
    platformLinux,
    platformWeb,
    platformWindows,
  };
}

/// Collection of platform tag values.
abstract class PlatformTagValue {
  static const String android = 'android';
  static const String ios = 'ios';
  static const String linux = 'linux';
  static const String macos = 'macos';
  static const String web = 'web';
  static const String windows = 'windows';
}

/// Tags that may be relevant in search for packages that have preview or
/// prerelease version published.
const _futureVersionTags = <String>{
  ...SdkTag._allSdkTags,
  ...PlatformTag._allPlatformTags,
  ...PackageVersionTags._futurePackageVersionTags,
};

/// Returns whether a [tag] is relevant to the package search,
/// if it is a value from a preview or prerelease version.
bool isFutureVersionTag(String tag) {
  return _futureVersionTags.contains(tag) || tag.startsWith('runtime:');
}
