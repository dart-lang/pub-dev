// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_dartlang_org/shared/platform.dart' show KnownPlatforms;

import '../shared/urls.dart' as urls;

class PlatformDict {
  final String name;
  final String pageTitle;
  final String landingPageTitle;
  final String landingBlurb;
  final String landingUrl;
  final String listingUrl;
  final String tagTitle;

  PlatformDict({
    this.name,
    String pageTitle,
    this.landingPageTitle,
    this.landingBlurb,
    this.landingUrl,
    this.listingUrl,
    this.tagTitle,
  }) : this.pageTitle = pageTitle ?? 'Top $name packages';

  factory PlatformDict.forPlatform(String platform, {String tagTitle}) {
    return new PlatformDict(
      name: _formattedPlatformName(platform),
      landingPageTitle: _landingPageTitle(platform),
      landingBlurb: _landingBlurb(platform),
      landingUrl: platform == null ? '/' : '/$platform',
      listingUrl: urls.searchUrl(platform: platform),
      tagTitle: tagTitle,
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
  KnownPlatforms.flutter: new PlatformDict.forPlatform(
    KnownPlatforms.flutter,
    tagTitle: 'Compatible with the Flutter platform.',
  ),
  KnownPlatforms.web: new PlatformDict.forPlatform(
    KnownPlatforms.web,
    tagTitle: 'Compatible with the web platform.',
  ),
  KnownPlatforms.other: new PlatformDict(
    name: KnownPlatforms.other,
    tagTitle: 'Compatible with other platforms (terminal, server, etc.).',
  ),
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

String _landingPageTitle(String platform) {
  if (platform == KnownPlatforms.flutter) {
    return 'Flutter Packages';
  } else if (platform == KnownPlatforms.web) {
    return 'Dart Packages for Web';
  }
  return 'Dart Packages';
}

final Map<String, String> _landingBlurbs = const {
  'default':
      '<p class="text">Find and use packages to build <a href="/flutter">Flutter</a> and '
      '<a href="/web">web</a> apps with <a target="_blank" href="https://www.dartlang.org">Dart</a>.</p>',
  KnownPlatforms.flutter:
      '<p class="text"><a href="https://flutter.io/">Flutter<sup><small>↗</small></sup></a> '
      'makes it easy and fast to build beautiful mobile apps<br/> for iOS and Android.</p>',
  KnownPlatforms.web:
      '<p class="text">Use Dart to create web applications that run on any modern browser.<br/> Start '
      'with <a href="https://webdev.dartlang.org/angular">AngularDart<sup><small>↗</small></sup></a>.</p>'
};

String _landingBlurb(String platform) =>
    _landingBlurbs[platform ?? 'default'] ?? _landingBlurbs['default'];

class SortDict {
  final String label;
  final String tooltip;

  const SortDict({this.label, String tooltip})
      : this.tooltip =
            '$tooltip More information on <a href="/help#ranking">ranking</a>.';
}

// Synchronize with `script.dart`'s dropdown.
final _sortDicts = const <String, SortDict>{
  'listing_relevance': const SortDict(
      label: 'listing relevance',
      tooltip:
          'Packages are sorted by the combination of their overall score and '
          'their specificity to the selected platform.'),
  'search_relevance': const SortDict(
      label: 'search relevance',
      tooltip: 'Packages are sorted by the combination of the text match, '
          'their overall score and their specificity to the selected platform.'),
  'top': const SortDict(
      label: 'overall score',
      tooltip: 'Packages are sorted by the overall score.'),
  'updated': const SortDict(
      label: 'recently updated',
      tooltip: 'Packages are sorted by their updated time.'),
  'created': const SortDict(
      label: 'newest package',
      tooltip: 'Packages are sorted by their created time.'),
  'popularity': const SortDict(
      label: 'popularity',
      tooltip: 'Packages are sorted by their popularity score.'),
};

SortDict getSortDict(String sort) {
  final SortDict dict = _sortDicts[sort];
  if (dict != null) return dict;
  return new SortDict(
    label: sort,
    tooltip: 'Packages are sort by $sort.',
  );
}

final String defaultPageDescriptionEscaped = htmlEscape.convert(
    'Pub is the package manager for the Dart programming language, containing reusable '
    'libraries & packages for Flutter, AngularDart, and general Dart programs.');

String flutterSpecificPackagesHtml =
    '<a href="/packages?q=dependency%3Aflutter">Flutter-specific packages...</a>';
