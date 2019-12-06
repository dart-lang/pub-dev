// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Tag prefixes that are allowed.
///
/// Whether a tag is assigned by pub-administrator, package owner, or derived
/// by pana it must have a prefix listed here. Otherwise, it should be ignore
/// or an error should be returned to the caller.
const allowedTagPrefixes = [
  'is:',
  'platform:',
  'runtime:',
  'sdk:',
];

/// Collection of package-related tags.
abstract class PackageTags {
  /// Package is marked discontinued.
  static const String isDiscontinued = 'is:discontinued';

  /// Package is marked notAdvertized - won't be displayed on the landing page.
  static const String isNotAdvertized = 'is:not-advertized';

  /// The first version of the package was published less than 30 days ago.
  static const String isRecent = 'is:recent';

  /// Package is marked with Flutter Favorite.
  static const String isFlutterFavorite = 'is:flutter-favorite';
}

/// Collection of version-related tags.
abstract class PackageVersionTags {
  /// PackageVersion supports only legacy (Dart 1) SDK.
  static const String isLegacy = 'is:legacy';
}

/// Collection of SDK tags (with prefix and value).
abstract class SdkTag {
  static const String sdkDart = 'sdk:${SdkTagValue.dart}';
  static const String sdkFlutter = 'sdk:${SdkTagValue.flutter}';
}

/// Collection of SDK tag values.
abstract class SdkTagValue {
  static const String dart = 'dart';
  static const String flutter = 'flutter';
  static const String any = 'any';
}

/// Collection of Dart SDK runtime tags (with prefix and value).
abstract class DartSdkTag {
  static const String runtimeNativeJit = 'runtime:${DartSdkRuntime.nativeJit}';
  static const String runtimeWeb = 'runtime:${DartSdkRuntime.web}';
}

/// Collection of Dart SDK runtime values.
abstract class DartSdkRuntime {
  static const String nativeJit = 'native-jit';
  static const String web = 'web';
}

/// Collection of Flutter SDK platform tags (with prefix and value).
abstract class FlutterSdkTag {
  static const String platformAndroid =
      'platform:${FlutterSdkPlatform.android}';
  static const String platformIos = 'platform:${FlutterSdkPlatform.ios}';
  static const String platformWeb = 'platform:${FlutterSdkPlatform.web}';
}

/// Collection of Flutter SDK platform values.
abstract class FlutterSdkPlatform {
  static const String android = 'android';
  static const String ios = 'ios';
  static const String web = 'web';
}
