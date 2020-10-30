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

  /// Package is marked unlisted.
  static const String isUnlisted = 'is:unlisted';

  /// The first version of the package was published less than 30 days ago.
  static const String isRecent = 'is:recent';

  /// Package is marked with Flutter Favorite.
  static const String isFlutterFavorite = 'is:flutter-favorite';

  /// The `publisher:<publisherId>` tag.
  static String publisherTag(String publisherId) => 'publisher:$publisherId';

  /// Transforms the tag with the suffix of `-in-prerelease`.
  static String convertToPrereleaseTag(String tag) => '$tag-in-prerelease';
}

/// Collection of version-related tags.
abstract class PackageVersionTags {
  /// Package is marked with Flutter plugin.
  static const String isFlutterPlugin = 'is:flutter-plugin';

  /// PackageVersion supports only legacy (Dart 1) SDK.
  static const String isLegacy = 'is:legacy';

  /// The PackageVersion is null-safe.
  ///
  /// See definition at `_NullSafetyViolationFinder` in
  /// https://github.com/dart-lang/pana/blob/master/lib/src/tag_detection.dart
  static const String isNullSafe = 'is:null-safe';
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

  static bool isAny(String value) => value == null || value == any;
  static bool isNotAny(String value) => !isAny(value);
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

  /// human-readable identifiers mapped to runtime tags
  static const _decodeMap = <String, List<String>>{
    'native': [nativeJit],
    'js': [web],
  };

  // runtime tags mapped to human-readable identifiers
  static const _encodeMap = <String, List<String>>{
    nativeJit: ['native'],
    web: ['js'],
  };

  /// Decodes the human-readable [values] and returns [DartSdkRuntime] tag values.
  ///
  /// The decoding may change the value, omit values, or emit more values.
  static List<String> decodeQueryValues(List<String> values) {
    if (values == null) return null;
    final set = values.toSet();
    DartSdkRuntime._decodeMap.forEach((key, values) {
      if (set.remove(key)) set.addAll(values);
    });
    return set.toList()..sort();
  }

  /// Encodes the [DartSdkRuntime] tag values into human-readable format that
  /// will be used in links.
  ///
  /// The encoding may change the value, omit values, or emit more values.
  static List<String> encodeRuntimeTags(List<String> values) {
    if (values == null) return null;

    final set = values.toSet();
    DartSdkRuntime._encodeMap.forEach((key, values) {
      if (set.remove(key)) set.addAll(values);
    });
    return set.toList()..sort();
  }
}

/// Collection of Flutter SDK platform tags (with prefix and value).
abstract class FlutterSdkTag {
  static const String platformAndroid =
      'platform:${FlutterSdkPlatform.android}';
  static const String platformIos = 'platform:${FlutterSdkPlatform.ios}';
  static const String platformMacos = 'platform:${FlutterSdkPlatform.macos}';
  static const String platformLinux = 'platform:${FlutterSdkPlatform.linux}';
  static const String platformWeb = 'platform:${FlutterSdkPlatform.web}';
  static const String platformWindows =
      'platform:${FlutterSdkPlatform.windows}';
}

/// Collection of Flutter SDK platform values.
abstract class FlutterSdkPlatform {
  static const String android = 'android';
  static const String ios = 'ios';
  static const String linux = 'linux';
  static const String macos = 'macos';
  static const String web = 'web';
  static const String windows = 'windows';
}
