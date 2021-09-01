// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import '../../package/search_adapter.dart';
import '../../search/search_form.dart';
import '../../search/search_service.dart';
import '../../shared/tags.dart';
import '../dom/dom.dart' as d;

import '_cache.dart';
import '_consts.dart';
import 'layout.dart';

import 'views/pkg/package_list.dart';
import 'views/shared/listing_info.dart';
import 'views/shared/pagination.dart';
import 'views/shared/search_tabs.dart';
import 'views/shared/sort_control.dart';

export 'views/shared/pagination.dart';

/// Renders the list of packages template.
String renderPackageList(SearchResultPage searchResultPage) {
  return listOfPackagesNode(
    highlightedHit: searchResultPage.highlightedHit,
    sdkLibraryHits: searchResultPage.sdkLibraryHits,
    packageHits: searchResultPage.packageHits,
  ).toString();
}

/// Renders the `views/pkg/index.mustache` template.
String renderPkgIndexPage(
  SearchResultPage searchResultPage,
  PageLinks links, {
  String? sdk,
  String? title,
  required SearchForm searchForm,
  String? searchPlaceholder,
  String? messageFromBackend,
}) {
  final topPackages = getSdkDict(sdk).topSdkPackages;
  final isSearch = searchForm.hasQuery;
  final includeDiscontinued = searchForm.includeDiscontinued ?? false;
  final includeUnlisted = searchForm.includeUnlisted ?? false;
  final nullSafe = searchForm.nullSafe ?? false;
  final searchTabs = _calculateSearchTabs(searchForm);
  final hasActiveAdvanced = includeDiscontinued || includeUnlisted || nullSafe;
  final values = {
    'has_active_advanced': hasActiveAdvanced,
    'sdk_tabs_html': renderSdkTabs(searchForm: searchForm),
    'has_subsdk_options': searchTabs.isNotEmpty,
    'subsdk_label': _subSdkLabel(searchForm),
    'subsdk_filter_buttons_html':
        searchTabs.isNotEmpty ? searchTabsNode(searchTabs).toString() : null,
    'is_search': isSearch,
    'listing_info_html': renderListingInfo(
      searchForm: searchForm,
      totalCount: searchResultPage.totalCount,
      title: title ?? topPackages,
      messageFromBackend: messageFromBackend,
    ),
    'package_list_html': renderPackageList(searchResultPage),
    'has_packages': searchResultPage.hasHit,
    'pagination': paginationNode(links).toString(),
    'include_discontinued': includeDiscontinued,
    'include_unlisted': includeUnlisted,
    'null_safe': nullSafe,
  };
  final content = templateCache.renderTemplate('pkg/index', values);

  String pageTitle = title ?? topPackages;
  if (isSearch) {
    pageTitle = 'Search results for ${searchForm.query}.';
  } else {
    if (links.rightmostPage > 1) {
      pageTitle = 'Page ${links.currentPage} | $pageTitle';
    }
  }
  return renderLayoutPage(
    PageType.listing,
    content,
    title: pageTitle,
    sdk: sdk,
    searchForm: searchForm,
    canonicalUrl: searchForm.toSearchLink(),
    noIndex: true,
    searchPlaceHolder: searchPlaceholder,
    mainClasses: [],
  );
}

/// Renders the `views/shared/listing_info.mustache` template.
String renderListingInfo({
  required SearchForm searchForm,
  required int totalCount,
  String? title,
  String? ownedBy,
  required String? messageFromBackend,
}) {
  return listingInfoNode(
    totalCount: totalCount,
    searchQuery: searchForm.query,
    ownedBy: ownedBy,
    sortControlNode: _renderSortControl(searchForm),
    messageMarkdown: messageFromBackend,
  ).toString();
}

String? _subSdkLabel(SearchForm sq) {
  if (sq.sdk == SdkTagValue.dart) {
    return 'Runtime';
  } else if (sq.sdk == SdkTagValue.flutter) {
    return 'Platform';
  } else {
    return null;
  }
}

d.Node _renderSortControl(SearchForm form) {
  final isSearch = form.hasQuery;
  final options = getSortDicts(isSearch);
  final sortValue = serializeSearchOrder(form.order) ??
      (isSearch ? 'search_relevance' : 'listing_relevance');
  final selected = options.firstWhere(
    (o) => o.id == sortValue,
    orElse: () => options.first,
  );
  return sortControlNode(options: options, selected: selected);
}

class PageLinks {
  final SearchForm searchForm;
  final int count;

  PageLinks(this.searchForm, this.count);

  PageLinks.empty()
      : searchForm = SearchForm.parse(),
        count = 1;

  int get leftmostPage => max(currentPage! - maxPageLinks ~/ 2, 1);

  int? get currentPage => searchForm.currentPage;

  int get rightmostPage {
    final int fromSymmetry = currentPage! + maxPageLinks ~/ 2;
    final int fromCount = 1 + ((count - 1) ~/ searchForm.pageSize!);
    return min(fromSymmetry, max(currentPage!, fromCount));
  }
}

/// `Linux`, `macOS`, `Windows` platforms are not yet stable, and we want
/// to display them only when the user has already opted-in to get them
/// displayed.
List<SearchTab> _calculateSearchTabs(SearchForm searchForm) {
  SearchTab searchTab({
    required String label,
    required String tag,
    required String title,
  }) {
    final tp = searchForm.tagsPredicate;
    return SearchTab(
      text: label,
      href: searchForm
          .change(
            tagsPredicate: tp.isRequiredTag(tag)
                ? tp.withoutTag(tag)
                : tp.appendPredicate(TagsPredicate(requiredTags: [tag])),
          )
          .toSearchLink(),
      title: title,
      active: searchForm.tagsPredicate.isRequiredTag(tag),
    );
  }

  final sdk = searchForm.sdk;
  if (sdk == SdkTagValue.dart) {
    return <SearchTab>[
      searchTab(
        label: 'native',
        tag: DartSdkTag.runtimeNativeJit,
        title:
            'Packages compatible with Dart running on a native platform (JIT/AOT)',
      ),
      searchTab(
        label: 'JS',
        tag: DartSdkTag.runtimeWeb,
        title: 'Packages compatible with Dart compiled for the web',
      ),
    ];
  }
  if (sdk == SdkTagValue.flutter) {
    return <SearchTab>[
      searchTab(
        label: 'Android',
        tag: FlutterSdkTag.platformAndroid,
        title: 'Packages compatible with Flutter on the Android platform',
      ),
      searchTab(
        label: 'iOS',
        tag: FlutterSdkTag.platformIos,
        title: 'Packages compatible with Flutter on the iOS platform',
      ),
      searchTab(
        label: 'Web',
        tag: FlutterSdkTag.platformWeb,
        title: 'Packages compatible with Flutter on the Web platform',
      ),
      searchTab(
        label: 'Linux',
        tag: FlutterSdkTag.platformLinux,
        title: 'Packages compatible with Flutter on the Linux platform',
      ),
      searchTab(
        label: 'macOS',
        tag: FlutterSdkTag.platformMacos,
        title: 'Packages compatible with Flutter on the macOS platform',
      ),
      searchTab(
        label: 'Windows',
        tag: FlutterSdkTag.platformWindows,
        title: 'Packages compatible with Flutter on the Windows platform',
      ),
    ];
  }
  return const <SearchTab>[];
}
