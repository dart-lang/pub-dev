// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/pana.dart';

abstract class KnownPlatforms {
  static const String flutter = PlatformNames.flutter;
  static const String web = PlatformNames.web;
  static const String other = PlatformNames.other;
  static const List<String> all = const [flutter, web, other];

  static bool isKnownPlatform(String platform) => all.contains(platform);
}

List<String> indexDartPlatform(DartPlatform platform) {
  if (platform == null || platform.uses == null || platform.hasConflict) {
    return null;
  }
  if (platform.worksEverywhere) {
    return KnownPlatforms.all;
  }
  return KnownPlatforms.all.where((p) {
    final PlatformUse use = platform.uses[p];
    return use == PlatformUse.allowed || use == PlatformUse.used;
  }).toList();
}

class PlatformPredicate {
  final List<String> required;
  final List<String> prohibited;

  PlatformPredicate._(this.required, this.prohibited);

  factory PlatformPredicate({List<String> required, List<String> prohibited}) {
    List<String> reduce(List<String> platforms) {
      final List<String> list = platforms
          ?.where((p) => p != null && p.isNotEmpty)
          ?.where(KnownPlatforms.isKnownPlatform)
          ?.toList();
      return (list != null && list.isNotEmpty) ? list : null;
    }

    return new PlatformPredicate._(reduce(required), reduce(prohibited));
  }

  factory PlatformPredicate.only(String platform) {
    return new PlatformPredicate(
      required: [platform],
      prohibited: new List.from(KnownPlatforms.all)..remove(platform),
    );
  }

  factory PlatformPredicate._compose(List<String> platforms) {
    final List<String> required = <String>[];
    final List<String> prohibited = <String>[];
    platforms?.forEach((String p) {
      if (p.startsWith('-') || p.startsWith('!')) {
        prohibited.add(p.substring(1).trim());
      } else {
        required.add(p.trim());
      }
    });
    return new PlatformPredicate(required: required, prohibited: prohibited);
  }

  factory PlatformPredicate.fromUri(Uri uri) {
    final String pluralStr = uri.queryParameters['platforms'];
    List<String> platforms;
    if (pluralStr != null && pluralStr.isNotEmpty) {
      platforms = pluralStr.split(',');
    } else {
      platforms = uri.queryParametersAll['platform'];
    }
    return new PlatformPredicate._compose(platforms);
  }

  factory PlatformPredicate.parse(String platform) =>
      new PlatformPredicate._compose(platform.split(','));

  bool get isSingle =>
      !(required == null || prohibited != null || required.length != 1);

  String get single => isSingle ? required.single : null;

  bool get isNotEmpty => required != null || prohibited != null;

  bool matches(List<String> platforms) {
    if (required != null) {
      if (platforms == null || platforms.isEmpty) return false;
      if (required.any((p) => !platforms.contains(p))) return false;
    }
    if (prohibited != null &&
        platforms != null &&
        prohibited.any(platforms.contains)) {
      return false;
    }
    return true;
  }

  String toQueryParamValue() {
    final List<String> parts = <String>[];
    required?.forEach(parts.add);
    prohibited?.forEach((p) => parts.add('!$p'));
    final String value = parts.join(',');
    return value.isEmpty ? null : value;
  }
}
