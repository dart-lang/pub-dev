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

final _whitelistedOverride = 'Whitelisted platform override.';
DartPlatform _webOnly() => new DartPlatform.fromComponents(
      [ComponentNames.html],
      reason: _whitelistedOverride,
    );

final _packagePlatformOverrides = <String, DartPlatform>{
  // categorized as "flutter, web, other", override to "web"
  'browser': _webOnly(),
  // categorized as "flutter, other", override to "web"
  'dart_to_js_script_rewriter': _webOnly(),
};

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

Summary applyPlatformOverride(Summary summary) {
  final platform = _packagePlatformOverrides[summary.packageName];
  if (platform == null) return summary;
  return new Summary(
      summary.runtimeInfo,
      summary.packageName,
      summary.packageVersion,
      summary.pubspec,
      summary.pkgResolution,
      summary.dartFiles,
      platform,
      summary.licenses,
      summary.fitness,
      summary.maintenance,
      summary.suggestions);
}
