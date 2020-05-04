// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:meta/meta.dart';

import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/shared/utils.dart';

import '../../package/models.dart';
import '../../search/search_service.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '../request_context.dart';

import '_cache.dart';
import '_consts.dart';
import '_utils.dart';
import 'layout.dart';
import 'misc.dart';

/// Renders the `views/shared/pagination.mustache` template.
String renderPagination(PageLinks pageLinks) {
  final values = {
    'page_links': pageLinks.hrefPatterns(),
  };
  return templateCache.renderTemplate('shared/pagination', values);
}

/// Renders the `views/pkg/package_list.mustache` template.
String renderPackageList(
  List<PackageView> packages, {
  SearchQuery searchQuery,
}) {
  final packagesJson = [];
  for (int i = 0; i < packages.length; i++) {
    final view = packages[i];
    String externalType;
    bool isSdk = false;
    if (view.isExternal && view.url.startsWith(urls.httpsApiDartDev)) {
      externalType = 'Dart core library';
      isSdk = true;
    }
    String scoreBoxHtml;
    if (isSdk) {
      scoreBoxHtml = renderSdkScoreBox();
    } else if (!view.isExternal) {
      scoreBoxHtml = renderScoreBox(view);
    }
    final addedXAgo = _renderXAgo(view.created);
    packagesJson.add({
      'url': view.url ?? urls.pkgPageUrl(view.name),
      'name': view.name,
      'is_external': view.isExternal,
      'external_type': externalType,
      'version': view.version,
      'show_dev_version': view.devVersion != null,
      'dev_version': view.devVersion,
      'dev_version_url': urls.pkgPageUrl(view.name, version: view.devVersion),
      'is_new': addedXAgo != null,
      'added_x_ago': addedXAgo,
      'last_uploaded': view.shortUpdated,
      'desc': view.ellipsizedDescription,
      'is_flutter_favorite': view.tags.contains(PackageTags.isFlutterFavorite),
      'publisher_id': view.publisherId,
      'publisher_url':
          view.publisherId == null ? null : urls.publisherUrl(view.publisherId),
      'tags_html': renderTags(
        package: view,
        searchQuery: searchQuery,
      ),
      'like_score_html': _renderLabeledScore('likes', view.likes, ''),
      'popularity_score_html':
          _renderLabeledScore('popularity', view.popularity, '%'),
      'health_score_html': _renderLabeledScore('health', view.health, '%'),
      'has_api_pages': view.apiPages != null && view.apiPages.isNotEmpty,
      'api_pages': view.apiPages
          ?.map((page) => {
                'title': page.title ?? page.path,
                'href': page.url ??
                    urls.pkgDocUrl(view.name,
                        isLatest: true, relativePath: page.path),
              })
          ?.toList(),
      // TODO(3246): remove the keys below after we have migrated to the new design
      'score_box_html': scoreBoxHtml,
      'show_metadata': !view.isExternal,
    });
  }
  return templateCache.renderTemplate('pkg/package_list', {
    'packages': packagesJson,
  });
}

/// Renders the `views/pkg/labeled_score.mustache` template.
String _renderLabeledScore(String label, int value, String sign) {
  return templateCache.renderTemplate('pkg/labeled_score', {
    'label': label,
    'has_value': value != null,
    'value': value ?? '--',
    'sign': sign,
  });
}

String _renderXAgo(DateTime value) {
  if (value == null) return null;
  final age = DateTime.now().difference(value);
  if (age.inDays > 30) return null;
  if (age.inDays > 1) return '${age.inDays} days ago';
  if (age.inHours > 1) return '${age.inHours} hours ago';
  return 'in the last hour';
}

/// Renders the `views/pkg/liked_package_list.mustache` template.
String renderMyLikedPackagesList(List<LikeData> likes) {
  final packagesJson = [];
  for (final like in likes) {
    final package = like.package;
    packagesJson.add({
      'url': urls.pkgPageUrl(package),
      'name': package,
      'liked_date': shortDateFormat.format(like.created),
    });
  }
  return templateCache
      .renderTemplate('pkg/liked_package_list', {'packages': packagesJson});
}

/// Renders the `views/pkg/index.mustache` template.
String renderPkgIndexPage(
  List<PackageView> packages,
  PageLinks links, {
  String sdk,
  String title,
  SearchQuery searchQuery,
  int totalCount,
  String searchPlaceholder,
}) {
  final topPackages = getSdkDict(sdk).topSdkPackages;
  final isSearch = searchQuery != null && searchQuery.hasQuery;
  final values = {
    'sdk_tabs_html': renderSdkTabs(searchQuery: searchQuery),
    'subsdk_label': _subSdkLabel(searchQuery),
    'subsdk_tabs_html': renderSubSdkTabsHtml(searchQuery: searchQuery),
    'is_search': isSearch,
    'listing_info_html': renderListingInfo(
      searchQuery: searchQuery,
      totalCount: totalCount,
      title: title ?? topPackages,
    ),
    'package_list_html': renderPackageList(packages, searchQuery: searchQuery),
    'has_packages': packages.isNotEmpty,
    'pagination': renderPagination(links),
    'legacy_search_enabled': searchQuery?.includeLegacy ?? false,
  };
  final content = templateCache.renderTemplate('pkg/index', values);

  String pageTitle = title ?? topPackages;
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
    sdk: sdk,
    searchQuery: searchQuery,
    noIndex: true,
    searchPlaceHolder: searchPlaceholder,
    mainClasses: requestContext.isExperimental ? [] : null,
  );
}

/// Renders the `views/shared/listing_info.mustache` template.
String renderListingInfo({
  @required SearchQuery searchQuery,
  @required int totalCount,
  String title,
  String ownedBy,
}) {
  final isSearch = searchQuery != null && searchQuery.hasQuery;
  return templateCache.renderTemplate('shared/listing_info', {
    'sort_control_html': renderSortControl(searchQuery),
    'total_count': totalCount,
    'package_or_packages': totalCount == 1 ? 'package' : 'packages',
    'has_search_query': isSearch,
    'search_query': searchQuery?.query,
    'has_owned_by': ownedBy != null,
    'owned_by': ownedBy,
    // TODO(3246): remove the keys below after we have migrated to the new design
    'is_search': isSearch,
    'has_title': !isSearch && title != null,
    'title': title,
  });
}

String _subSdkLabel(SearchQuery sq) {
  if (sq?.sdk == SdkTagValue.dart) {
    return 'Runtime';
  } else if (sq?.sdk == SdkTagValue.flutter) {
    return 'Platform';
  } else {
    return null;
  }
}

/// Renders the `views/shared/sort_control.mustache` template.
String renderSortControl(SearchQuery query) {
  final isSearch = query != null && query.hasQuery;
  final options = getSortDicts(isSearch, requestContext.isExperimental);
  final selectedValue = serializeSearchOrder(query?.order) ??
      (isSearch ? 'search_relevance' : 'listing_relevance');
  final selectedOption = options.firstWhere(
    (o) => o.id == selectedValue,
    orElse: () => options.first,
  );
  final sortDict = getSortDict(selectedValue);
  return templateCache.renderTemplate('shared/sort_control', {
    'options': options
        .map((d) => {
              'value': d.id,
              'label': d.label,
              'selected': d.id == selectedValue,
            })
        .toList(),
    'selected_label': selectedOption.label,
    // TODO(3246): remove after we have migrated to the new design
    'ranking_tooltip_html': sortDict.tooltip,
  });
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
      'active': false,
      'disabled': !hasPrevious,
      'render_link': hasPrevious,
      'href': htmlAttrEscape.convert(formatHref(currentPage - 1)),
      'text': '&laquo;',
      'rel_prev': true,
      'rel_next': false,
    });

    for (int page = leftmostPage; page <= rightmostPage; page++) {
      final bool isCurrent = page == currentPage;
      results.add({
        'active': isCurrent,
        'disabled': false,
        'render_link': !isCurrent,
        'href': htmlAttrEscape.convert(formatHref(page)),
        'text': '$page',
        'rel_prev': currentPage == page + 1,
        'rel_next': currentPage == page - 1,
      });
    }

    final bool hasNext = currentPage < rightmostPage;
    results.add({
      'active': false,
      'disabled': !hasNext,
      'render_link': hasNext,
      'href': htmlAttrEscape.convert(formatHref(currentPage + 1)),
      'text': '&raquo;',
      'rel_prev': false,
      'rel_next': true,
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
