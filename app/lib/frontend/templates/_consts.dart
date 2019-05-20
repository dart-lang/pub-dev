// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:pana/models.dart' show SuggestionCode;

import '../../shared/platform.dart' show KnownPlatforms;
import '../../shared/urls.dart' as urls;

class PlatformDict {
  final String name;
  final String topPlatformPackages;
  final String morePlatformPackagesLabel;
  final String onlyPlatformPackagesLabel;
  final String onlyPlatformPackagesUrl;
  final String searchPlatformPackagesLabel;
  final String landingPageTitle;
  final String landingBlurb;
  final String landingUrl;
  final String listingUrl;
  final String tagTitle;

  PlatformDict({
    @required this.name,
    @required this.topPlatformPackages,
    @required this.morePlatformPackagesLabel,
    @required this.onlyPlatformPackagesLabel,
    @required this.onlyPlatformPackagesUrl,
    @required this.searchPlatformPackagesLabel,
    @required this.landingPageTitle,
    @required this.landingBlurb,
    @required this.landingUrl,
    @required this.listingUrl,
    @required this.tagTitle,
  });

  factory PlatformDict.forPlatform(
    String platform, {
    String tagTitle,
    String onlyPlatformPackagesUrl,
  }) {
    final formattedPlatform = _formattedPlatformName(platform);
    final hasOnly = onlyPlatformPackagesUrl != null;
    final hasCompatible = hasOnly || platform == KnownPlatforms.web;
    final platformCompatible =
        hasCompatible ? '$formattedPlatform-compatible' : formattedPlatform;
    final platformOnly =
        hasOnly ? '$formattedPlatform-only' : formattedPlatform;
    return PlatformDict(
      name: formattedPlatform,
      topPlatformPackages: 'Top $platformCompatible packages',
      morePlatformPackagesLabel: 'More $platformCompatible packages...',
      onlyPlatformPackagesLabel: hasOnly ? '$platformOnly packages...' : null,
      onlyPlatformPackagesUrl: onlyPlatformPackagesUrl,
      searchPlatformPackagesLabel: 'Search $platformCompatible packages',
      landingPageTitle: _landingPageTitle(platform),
      landingBlurb: _landingBlurb(platform),
      landingUrl: platform == null ? '/' : '/$platform',
      listingUrl: urls.searchUrl(platform: platform),
      tagTitle: tagTitle,
    );
  }
}

PlatformDict getPlatformDict(String platform, {bool nullIfMissing = false}) {
  final dict = _dictionaries[platform ?? 'default'];
  if (dict == null) {
    return nullIfMissing ? null : _dictionaries['default'];
  } else {
    return dict;
  }
}

final _dictionaries = <String, PlatformDict>{
  'default': PlatformDict.forPlatform(null),
  KnownPlatforms.flutter: PlatformDict.forPlatform(
    KnownPlatforms.flutter,
    tagTitle: 'Compatible with the Flutter platform.',
    onlyPlatformPackagesUrl: '/packages?q=dependency%3Aflutter',
  ),
  KnownPlatforms.web: PlatformDict.forPlatform(
    KnownPlatforms.web,
    tagTitle: 'Compatible with the web platform.',
  ),
  KnownPlatforms.other: PlatformDict(
    name: KnownPlatforms.other,
    tagTitle: 'Compatible with other platforms (terminal, server, etc.).',
    listingUrl: null, // no listing for platform tag
    topPlatformPackages: null, // no landing page
    morePlatformPackagesLabel: null, // no search filter for it
    onlyPlatformPackagesLabel: null, // no search filter for it
    onlyPlatformPackagesUrl: null, // no search filter for it
    searchPlatformPackagesLabel: null, // no search filter for it
    landingUrl: null,
    landingPageTitle: null,
    landingBlurb: null,
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
          '<a href="/web">web</a> apps with <a target="_blank" rel="noopener" href="${urls.dartSiteRoot}">Dart</a>.</p>',
  KnownPlatforms.flutter:
      '<p class="text"><a target="_blank" rel="noopener" href="https://flutter.io/">Flutter<sup><small>↗</small></sup></a> '
          'makes it easy and fast to build beautiful mobile apps<br/> for iOS and Android.</p>',
  KnownPlatforms.web:
      '<p class="text">Use Dart to create web applications that run on any modern browser.<br/> Start '
          'with <a target="_blank" rel="noopener" href="https://webdev.dartlang.org/angular">AngularDart<sup><small>↗</small></sup></a>.</p>'
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
  'listing_relevance': SortDict(
      label: 'listing relevance',
      tooltip:
          'Packages are sorted by the combination of their overall score and '
          'their specificity to the selected platform.'),
  'search_relevance': SortDict(
      label: 'search relevance',
      tooltip: 'Packages are sorted by the combination of the text match, '
          'their overall score and their specificity to the selected platform.'),
  'top': SortDict(
      label: 'overall score',
      tooltip: 'Packages are sorted by the overall score.'),
  'updated': SortDict(
      label: 'recently updated',
      tooltip: 'Packages are sorted by their updated time.'),
  'created': SortDict(
      label: 'newest package',
      tooltip: 'Packages are sorted by their created time.'),
  'popularity': SortDict(
      label: 'popularity',
      tooltip: 'Packages are sorted by their popularity score.'),
};

SortDict getSortDict(String sort) {
  final SortDict dict = _sortDicts[sort];
  if (dict != null) return dict;
  return SortDict(
    label: sort,
    tooltip: 'Packages are sort by $sort.',
  );
}

final _suggestionHelpMessages = <String, String>{
  SuggestionCode.analysisOptionsRenameRequired: 'Read more about the setup of '
      '<a href="${urls.dartSiteRoot}/guides/language/analysis-options#the-analysis-options-file">'
      '<code>analysis-options.yaml</code></a>.',
};

String getSuggestionHelpMessage(String code) {
  if (code == null) return null;
  return _suggestionHelpMessages[code];
}
