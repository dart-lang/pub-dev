// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:_pub_shared/search/search_form.dart';
import 'package:collection/collection.dart';

import '../../package/search_adapter.dart';
import '../../search/search_service.dart';
import '../../shared/urls.dart' as urls;
import '../dom/dom.dart' as d;

import '_consts.dart';
import 'layout.dart';

import 'views/pkg/index.dart';
import 'views/pkg/package_list.dart';
import 'views/shared/listing_info.dart';
import 'views/shared/pagination.dart';
import 'views/shared/sort_control.dart';

export 'views/shared/pagination.dart';

/// Renders the list of packages template.
d.Node packageList(SearchResultPage searchResultPage) {
  return listOfPackagesNode(
    searchForm: searchResultPage.form,
    sdkLibraryHits: searchResultPage.sdkLibraryHits,
    packageHits: searchResultPage.packageHits,
  );
}

/// Renders the package listing template.
String renderPkgIndexPage(
  SearchResultPage searchResultPage,
  PageLinks links, {
  required SearchForm searchForm,
  Set<String>? openSections,
}) {
  final topPackages = getSdkDict(null).topSdkPackages;
  final isSearch = searchForm.hasQuery;

  final content = packageListingNode(
    searchForm: searchForm,
    listingInfo: listingInfo(
      searchForm: searchForm,
      totalCount: searchResultPage.totalCount,
      title: topPackages,
      messageFromBackend: searchResultPage.errorMessage,
    ),
    nameMatches: _nameMatches(searchForm, searchResultPage.nameMatches),
    packageList: packageList(searchResultPage),
    pagination: searchResultPage.hasHit ? paginationNode(links) : null,
    openSections: openSections,
  );

  String pageTitle = topPackages;
  if (isSearch) {
    pageTitle = 'Search results for ${searchForm.query}';
  } else {
    if (links.rightmostPage > 1) {
      pageTitle = 'Page ${links.currentPage} | $pageTitle';
    }
  }
  return renderLayoutPage(
    PageType.listing,
    content,
    title: pageTitle,
    searchForm: searchForm,
    canonicalUrl: searchForm.toSearchLink(),
    noIndex: true,
    mainClasses: [],
  );
}

/// Renders the listing info of the search result.
d.Node listingInfo({
  required SearchForm searchForm,
  required int totalCount,
  String? title,
  String? ownedBy,
  required String? messageFromBackend,
}) {
  return listingInfoNode(
    totalCount: totalCount,
    ownedBy: ownedBy,
    sortControlNode: _renderSortControl(searchForm),
    messageMarkdown: messageFromBackend,
  );
}

d.Node _renderSortControl(SearchForm form) {
  final isSearch = form.hasQuery;
  final options = getSortDicts(isSearch);
  final sortValue =
      form.order?.name ?? (isSearch ? 'search_relevance' : 'listing_relevance');
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
      : searchForm = SearchForm(),
        count = 1;

  int get leftmostPage => max(currentPage! - maxPageLinks ~/ 2, 1);

  int? get currentPage => searchForm.currentPage;

  int get rightmostPage {
    final int fromSymmetry = currentPage! + maxPageLinks ~/ 2;
    final int fromCount = 1 + ((count - 1) ~/ searchForm.pageSize!);
    return min(fromSymmetry, max(currentPage!, fromCount));
  }
}

d.Node? _nameMatches(SearchForm form, List<String>? matches) {
  if (matches == null || matches.isEmpty) {
    return null;
  }
  final singular = matches.length == 1;
  final isExactNameMatch = singular && form.parsedQuery.text == matches.single;
  final nameMatchLabel = isExactNameMatch
      ? 'Exact package name match: '
      : 'Matching package ${singular ? 'name' : 'names'}: ';

  return d.p(children: [
    d.text(nameMatchLabel),
    ...matches.expandIndexed((i, name) {
      return [
        if (i > 0) d.text(', '),
        d.a(
          href: urls.pkgPageUrl(name),
          child: d.b(text: name),
        ),
      ];
    }),
  ]);
}
