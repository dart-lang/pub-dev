// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:pana/models.dart' show SuggestionCode;

import '../../shared/tags.dart' show SdkTagValue;
import '../../shared/urls.dart' as urls;

class SdkDict {
  final String topSdkPackages;
  final String searchPackagesLabel;

  const SdkDict({
    @required this.topSdkPackages,
    @required this.searchPackagesLabel,
  });

  const SdkDict.any()
      : topSdkPackages = 'Top packages',
        searchPackagesLabel = 'Search packages';

  const SdkDict.dart()
      : topSdkPackages = 'Top Dart packages',
        searchPackagesLabel = 'Search Dart packages';

  const SdkDict.flutter()
      : topSdkPackages = 'Top Flutter packages',
        searchPackagesLabel = 'Search Flutter packages';
}

/// Returns the dictionary spec for [sdk].
SdkDict getSdkDict(String sdk) {
  if (sdk == SdkTagValue.dart) {
    return SdkDict.dart();
  } else if (sdk == SdkTagValue.flutter) {
    return SdkDict.flutter();
  } else {
    return SdkDict.any();
  }
}

final defaultLandingBlurbHtml =
    '<p class="text">Find and use packages to build <a target="_blank" rel="noopener" href="https://dart.dev/">Dart<sup><small>↗</small></sup></a> and '
    '<a target="_blank" rel="noopener" href="https://flutter.dev/">Flutter<sup><small>↗</small></sup></a> apps.</p>';

class SortDict {
  final String id;
  final String label;
  final String tooltip;

  const SortDict({this.id, this.label, String tooltip})
      : tooltip =
            '$tooltip More information on <a href="/help#ranking">ranking</a>.';
}

final _sortDicts = const <SortDict>[
  SortDict(
      id: 'listing_relevance',
      label: 'listing relevance',
      tooltip:
          'Packages are sorted by the combination of their overall score and '
          'their specificity to the selected platform.'),
  SortDict(
      id: 'search_relevance',
      label: 'search relevance',
      tooltip: 'Packages are sorted by the combination of the text match, '
          'their overall score and their specificity to the selected platform.'),
  SortDict(
      id: 'top',
      label: 'overall score',
      tooltip: 'Packages are sorted by the overall score.'),
  SortDict(
      id: 'updated',
      label: 'recently updated',
      tooltip: 'Packages are sorted by their updated time.'),
  SortDict(
      id: 'created',
      label: 'newest package',
      tooltip: 'Packages are sorted by their created time.'),
  SortDict(
      id: 'popularity',
      label: 'popularity',
      tooltip: 'Packages are sorted by their popularity score.'),
];

// TODO: move this as part of [_sortDicts] after finalization of the new UI.
final _likeSortDict = SortDict(
  id: 'like',
  label: 'most likes',
  tooltip: 'Packages are sorted by like count.',
);

List<SortDict> getSortDicts(bool isSearch, bool includeLike) {
  final removeId = isSearch ? 'listing_relevance' : 'search_relevance';
  return <SortDict>[
    ..._sortDicts.where((d) => d.id != removeId),
    if (includeLike) _likeSortDict,
  ];
}

SortDict getSortDict(String sort) {
  return _sortDicts.firstWhere(
    (d) => d.id == sort,
    orElse: () => SortDict(
      id: sort,
      label: sort,
      tooltip: 'Packages are sort by $sort.',
    ),
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
