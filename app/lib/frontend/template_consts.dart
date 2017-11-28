// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dartlang_org/shared/platform.dart' show KnownPlatforms;

class PlatformDict {
  final String name;
  final String landingBlurb;
  final String landingUrl;
  final String listingUrl;

  PlatformDict({
    this.name,
    this.landingBlurb,
    this.landingUrl,
    this.listingUrl,
  });

  factory PlatformDict.forPlatform(String platform) {
    return new PlatformDict(
      name: _formattedPlatformName(platform),
      landingBlurb: _landingBlurb(platform),
      landingUrl:
          platform == null ? '/experimental' : '/experimental/$platform',
      listingUrl: platform == null
          ? '/experimental/packages'
          : '/experimental/$platform/packages',
    );
  }
}

PlatformDict getPlatformDict(String platform, {bool nullIfMissing: false}) {
  final dict = _dictionaries[platform ?? 'default'];
  if (dict == null) {
    return nullIfMissing ? null : _dictionaries['default'];
  } else {
    return dict;
  }
}

final _dictionaries = <String, PlatformDict>{
  'default': new PlatformDict.forPlatform(null),
  KnownPlatforms.flutter: new PlatformDict.forPlatform(KnownPlatforms.flutter),
  KnownPlatforms.server: new PlatformDict.forPlatform(KnownPlatforms.server),
  KnownPlatforms.web: new PlatformDict.forPlatform(KnownPlatforms.web),
};

String _formattedPlatformName(String platform) {
  if (platform == null) {
    return 'Dart';
  }
  switch (platform) {
    case KnownPlatforms.flutter:
      return 'Flutter';
    default:
      return platform;
  }
}

final Map<String, String> _landingBlurbs = const {
  'default':
      '<p class="text">Find and use packages to build <a href="/experimental/flutter">Flutter</a>, '
      '<a href="/experimental/web">web</a> and <a href="/experimental/server">server</a> apps '
      'with <a target="_blank" href="https://www.dartlang.org">Dart</a>.</p>',
  KnownPlatforms.flutter:
      '<p class="text"><a href="https://flutter.io/">Flutter<sup><small>↗</small></sup></a> '
      'makes it easy and fast to build beautiful mobile apps<br/> for iOS and Android.</p>',
  KnownPlatforms.server:
      '<p class="text">Use Dart to create command line and server applications.<br/> Start with the '
      '<a href="https://www.dartlang.org/tutorials/dart-vm/get-started">Dart VM tutorial<sup><small>↗</small></sup></a>.</p>',
  KnownPlatforms.web:
      '<p class="text">Use Dart to create web applications that run on any modern browser.<br/> Start '
      'with <a href="https://webdev.dartlang.org/angular">AngularDart<sup><small>↗</small></sup></a>.</p>'
};

String _landingBlurb(String platform) =>
    _landingBlurbs[platform ?? 'default'] ?? _landingBlurbs['default'];
