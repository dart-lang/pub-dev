// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import '../../shared/search_service.dart';
import '../../shared/urls.dart' as urls;

import '../models.dart';

import '_cache.dart';
import '_consts.dart';
import '_utils.dart';
import 'layout.dart';
import 'misc.dart';

/// Renders the `views/pagination.mustache` template.
String renderPagination(PageLinks pageLinks) {
  final values = {
    'page_links': pageLinks.hrefPatterns(),
  };
  return templateCache.renderTemplate('pagination', values,
      escapeValues: false);
}

/// Renders the `views/pkg/index.mustache` template.
String renderPkgIndexPage(
    List<PackageView> packages, PageLinks links, String currentPlatform,
    {SearchQuery searchQuery, int totalCount}) {
  final packagesJson = [];
  for (int i = 0; i < packages.length; i++) {
    final view = packages[i];
    final overallScore = view.overallScore;
    String externalType;
    bool isSdk = false;
    if (view.isExternal && view.url.startsWith('https://api.dartlang.org/')) {
      externalType = 'Dart core library';
      isSdk = true;
    }
    String scoreBoxHtml;
    if (isSdk) {
      scoreBoxHtml = renderSdkScoreBox();
    } else if (!view.isExternal) {
      scoreBoxHtml = renderScoreBox(overallScore,
          isSkipped: view.isSkipped,
          isNewPackage: view.isNewPackage,
          package: view.name);
    }
    packagesJson.add({
      'url': view.url ?? urls.pkgPageUrl(view.name),
      'name': view.name,
      'is_external': view.isExternal,
      'external_type': externalType,
      'show_metadata': !view.isExternal,
      'version': view.version,
      'show_dev_version': view.devVersion != null,
      'dev_version': view.devVersion,
      'dev_version_url': urls.pkgPageUrl(view.name, version: view.devVersion),
      'last_uploaded': view.shortUpdated,
      'desc': view.ellipsizedDescription,
      'tags_html': renderTags(
        view.platforms,
        isAwaiting: view.isAwaiting,
        isDiscontinued: view.isDiscontinued,
        isLegacy: view.isLegacy,
        isObsolete: view.isObsolete,
        packageName: view.name,
      ),
      'score_box_html': scoreBoxHtml,
      'has_api_pages': view.apiPages != null && view.apiPages.isNotEmpty,
      'api_pages': view.apiPages
          ?.map((page) => {
                'title': page.title ?? page.path,
                'href': page.url ??
                    urls.pkgDocUrl(view.name,
                        isLatest: true, relativePath: page.path),
              })
          ?.toList(),
    });
  }

  final PlatformDict platformDict = getPlatformDict(currentPlatform);
  final isSearch = searchQuery != null && searchQuery.hasQuery;
  final unsupportedQualifier =
      isSearch && (searchQuery.parsedQuery.text?.contains(':') ?? false);
  final String sortValue = serializeSearchOrder(searchQuery?.order) ??
      (isSearch ? 'search_relevance' : 'listing_relevance');
  final SortDict sortDict = getSortDict(sortValue);
  final values = {
    'sort_value': sortValue,
    'sort_name': sortDict.label,
    'ranking_tooltip_html': sortDict.tooltip,
    'is_search': isSearch,
    'unsupported_qualifier': unsupportedQualifier,
    'title': platformDict.topPlatformPackages,
    'packages': packagesJson,
    'has_packages': packages.isNotEmpty,
    'pagination': renderPagination(links),
    'search_query': searchQuery?.query,
    'total_count': totalCount,
  };
  final content = templateCache.renderTemplate('pkg/index', values);

  String pageTitle = platformDict.topPlatformPackages;
  if (isSearch) {
    pageTitle = 'Search results for ${searchQuery.query}.';
  } else {
    if (links.rightmostPage > 1) {
      pageTitle = 'Page ${links.currentPage} | $pageTitle';
    }
  }
  return renderLayoutPage(
    PageType.listing,
    content,
    title: pageTitle,
    platform: currentPlatform,
    searchQuery: searchQuery,
    noIndex: true,
  );
}

class PageLinks {
  final int offset;
  final int count;
  final SearchQuery _searchQuery;

  PageLinks(this.offset, this.count, {SearchQuery searchQuery})
      : _searchQuery = searchQuery;

  PageLinks.empty()
      : offset = 1,
        count = 1,
        _searchQuery = null;

  int get leftmostPage => max(currentPage - maxPages ~/ 2, 1);

  int get currentPage => 1 + offset ~/ resultsPerPage;

  int get rightmostPage {
    final int fromSymmetry = currentPage + maxPages ~/ 2;
    final int fromCount = 1 + ((count - 1) ~/ resultsPerPage);
    return min(fromSymmetry, max(currentPage, fromCount));
  }

  List<Map> hrefPatterns() {
    final List<Map> results = [];

    final bool hasPrevious = currentPage > 1;
    results.add({
      'disabled': !hasPrevious,
      'render_link': hasPrevious,
      'href': htmlAttrEscape.convert(formatHref(currentPage - 1)),
      'text': '&laquo;',
    });

    for (int page = leftmostPage; page <= rightmostPage; page++) {
      final bool isCurrent = page == currentPage;
      results.add({
        'active': isCurrent,
        'render_link': !isCurrent,
        'href': htmlAttrEscape.convert(formatHref(page)),
        'text': '$page',
        'rel_prev': currentPage == page + 1,
        'rel_next': currentPage == page - 1,
      });
    }

    final bool hasNext = currentPage < rightmostPage;
    results.add({
      'disabled': !hasNext,
      'render_link': hasNext,
      'href': htmlAttrEscape.convert(formatHref(currentPage + 1)),
      'text': '&raquo;',
    });

    // should not happen
    assert(!results
        .any((map) => map['disabled'] == true && map['active'] == true));
    return results;
  }

  String formatHref(int page) {
    if (_searchQuery == null) {
      return urls.searchUrl(page: page);
    } else {
      return _searchQuery.toSearchLink(page: page);
    }
  }
}
