// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/pana.dart';

abstract class KnownPlatforms {
  static const String flutter = PlatformNames.flutter;
  static const String server = PlatformNames.server;
  static const String web = PlatformNames.web;
  static const List<String> all = const [flutter, server, web];

  static bool isKnownPlatform(String platform) => all.contains(platform);
}

List<String> indexDartPlatform(DartPlatform platform) {
  if (platform == null) {
    return null;
  }
  if (platform.worksEverywhere) {
    return KnownPlatforms.all;
  }
  if (platform.restrictedTo == null || platform.restrictedTo.isEmpty) {
    return null;
  }
  return new List.from(platform.restrictedTo);
}

class PlatformPredicate {
  final List<String> required;
  final List<String> prohibited;

  PlatformPredicate._(this.required, this.prohibited);

  factory PlatformPredicate({List<String> required, List<String> prohibited}) {
    List<String> reduce(List<String> platforms) {
      final list = platforms
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

  factory PlatformPredicate.fromUri(Uri uri) {
    final pluralStr = uri.queryParameters['platforms'];
    List<String> platforms;
    if (pluralStr != null && pluralStr.isNotEmpty) {
      platforms = pluralStr.split(',');
    } else {
      platforms = uri.queryParametersAll['platform'];
    }
    final required = <String>[];
    final prohibited = <String>[];
    platforms?.forEach((String p) {
      if (p.startsWith('-') || p.startsWith('!')) {
        prohibited.add(p.substring(1).trim());
      } else {
        required.add(p.trim());
      }
    });
    return new PlatformPredicate(required: required, prohibited: prohibited);
  }

  String get single {
    if (required == null || prohibited != null) return null;
    if (required.length != 1) return null;
    return required.single;
  }

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
    final parts = <String>[];
    required?.forEach(parts.add);
    prohibited?.forEach((p) => parts.add('!$p'));
    final value = parts.join(',');
    return value.isEmpty ? null : value;
  }
}
