// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:meta/meta.dart';

import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/shared/markdown.dart';
import 'package:pub_dev/shared/utils.dart';

import '../../package/models.dart';
import '../../search/search_form.dart';
import '../../search/search_service.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '_cache.dart';
import '_consts.dart';
import '_utils.dart';
import 'layout.dart';
import 'package_misc.dart';

import 'views/shared/search_tabs.dart';

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
  SearchForm searchForm,
}) {
  final packagesJson = [];
  for (int i = 0; i < packages.length; i++) {
    final view = packages[i];
    String externalType;
    if (view.isExternal && view.url.startsWith(urls.httpsApiDartDev)) {
      externalType = 'Dart core library';
    }
    final addedXAgo = _renderXAgo(view.created);
    final apiPages = view.apiPages
        ?.map((page) => {
              'title': page.title ?? page.path,
              'href': page.url ??
                  urls.pkgDocUrl(view.name,
                      isLatest: true, relativePath: page.path),
            })
        ?.toList();
    final hasApiPages = apiPages != null && apiPages.isNotEmpty;
    final hasMoreThanOneApiPages = hasApiPages && apiPages.length > 1;
    final flutterFavoriteBadgeHtml =
        view.tags.contains(PackageTags.isFlutterFavorite)
            ? renderFlutterFavoriteBadge()
            : null;
    final isNullSafe = view.tags.contains(PackageVersionTags.isNullSafe);
    final nullSafeBadgeHtml = isNullSafe ? renderNullSafeBadge() : null;
    packagesJson.add({
      'url': view.url ?? urls.pkgPageUrl(view.name),
      'name': view.name,
      'is_external': view.isExternal,
      'external_type': externalType,
      'version': view.version,
      'show_prerelease_version': view.prereleaseVersion != null,
      'prerelease_version': view.prereleaseVersion,
      'prerelease_version_url':
          urls.pkgPageUrl(view.name, version: view.prereleaseVersion),
      'show_preview_version': view.previewVersion != null,
      'preview_version': view.previewVersion,
      'preview_version_url':
          urls.pkgPageUrl(view.name, version: view.previewVersion),
      'is_new': addedXAgo != null,
      'added_x_ago': addedXAgo,
      'last_uploaded':
          view.updated == null ? null : shortDateFormat.format(view.updated),
      'desc': view.ellipsizedDescription,
      'flutter_favorite_badge_html': flutterFavoriteBadgeHtml,
      'null_safe_badge_html': nullSafeBadgeHtml,
      'publisher_id': view.publisherId,
      'publisher_url':
          view.publisherId == null ? null : urls.publisherUrl(view.publisherId),
      'tags_html': renderTags(package: view),
      'labeled_scores_html': renderLabeledScores(view),
      'has_api_pages': hasApiPages,
      'has_more_api_pages': hasMoreThanOneApiPages,
      'first_api_page': hasApiPages ? apiPages.first : null,
      'remaining_api_pages': hasApiPages ? apiPages.skip(1).toList() : null,
    });
  }
  return templateCache.renderTemplate('pkg/package_list', {
    'packages': packagesJson,
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
  SearchForm searchForm,
  int totalCount,
  String searchPlaceholder,
  String messageFromBackend,
}) {
  final topPackages = getSdkDict(sdk).topSdkPackages;
  final isSearch = searchForm != null && searchForm.hasQuery;
  final includeDiscontinued = searchForm?.includeDiscontinued ?? false;
  final includeUnlisted = searchForm?.includeUnlisted ?? false;
  final nullSafe = searchForm?.nullSafe ?? false;
  final subSdkLayout = _calculateLayout(searchForm);
  final hasActiveAdvanced = includeDiscontinued || includeUnlisted || nullSafe;
  final values = {
    'has_active_advanced': hasActiveAdvanced,
    'sdk_tabs_html': renderSdkTabs(searchForm: searchForm),
    'has_subsdk_options': subSdkLayout.hasOptions,
    'subsdk_label': _subSdkLabel(searchForm),
    'subsdk_filter_buttons_html': _renderFilterButtons(
        searchForm: searchForm, options: subSdkLayout.options),
    'is_search': isSearch,
    'listing_info_html': renderListingInfo(
      searchForm: searchForm,
      totalCount: totalCount,
      title: title ?? topPackages,
      messageFromBackend: messageFromBackend,
    ),
    'package_list_html': renderPackageList(packages, searchForm: searchForm),
    'has_packages': packages.isNotEmpty,
    'pagination': renderPagination(links),
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
  @required SearchForm searchForm,
  @required int totalCount,
  String title,
  String ownedBy,
  @required String messageFromBackend,
}) {
  final isSearch = searchForm != null && searchForm.hasQuery;
  return templateCache.renderTemplate('shared/listing_info', {
    'sort_control_html': renderSortControl(searchForm),
    'total_count': totalCount,
    'package_or_packages': totalCount == 1 ? 'package' : 'packages',
    'has_search_query': isSearch,
    'search_query': searchForm?.query,
    'has_owned_by': ownedBy != null,
    'owned_by': ownedBy,
    'has_message_from_backend': messageFromBackend != null,
    'message_from_backend_html': markdownToHtml(messageFromBackend),
  });
}

String _subSdkLabel(SearchForm sq) {
  if (sq?.sdk == SdkTagValue.dart) {
    return 'Runtime';
  } else if (sq?.sdk == SdkTagValue.flutter) {
    return 'Platform';
  } else {
    return null;
  }
}

/// Renders the `views/shared/sort_control.mustache` template.
String renderSortControl(SearchForm form) {
  final isSearch = form != null && form.hasQuery;
  final options = getSortDicts(isSearch);
  final selectedValue = serializeSearchOrder(form?.order) ??
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
    'ranking_tooltip': sortDict.tooltip,
    'selected_label': selectedOption.label,
  });
}

class PageLinks {
  final SearchForm searchForm;
  final int count;

  PageLinks(this.searchForm, this.count);

  PageLinks.empty()
      : searchForm = SearchForm.parse(),
        count = 1;

  int get leftmostPage => max(currentPage - maxPageLinks ~/ 2, 1);

  int get currentPage => searchForm.currentPage;

  int get rightmostPage {
    final int fromSymmetry = currentPage + maxPageLinks ~/ 2;
    final int fromCount = 1 + ((count - 1) ~/ searchForm.pageSize);
    return min(fromSymmetry, max(currentPage, fromCount));
  }

  List<Map> hrefPatterns() {
    final List<Map> results = [];

    final bool hasPrevious = currentPage > 1;
    results.add({
      'active': false,
      'disabled': !hasPrevious,
      'render_link': hasPrevious,
      'href': htmlAttrEscape
          .convert(searchForm.toSearchLink(page: currentPage - 1)),
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
        'href': htmlAttrEscape.convert(searchForm.toSearchLink(page: page)),
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
      'href': htmlAttrEscape
          .convert(searchForm.toSearchLink(page: currentPage + 1)),
      'text': '&raquo;',
      'rel_prev': false,
      'rel_next': true,
    });

    // should not happen
    assert(!results
        .any((map) => map['disabled'] == true && map['active'] == true));
    return results;
  }
}

String _renderFilterButtons({
  @required SearchForm searchForm,
  @required List<_FilterOption> options,
}) {
  if (options == null || options.isEmpty) return null;
  final tp = searchForm.tagsPredicate;
  String searchWithTagsLink(TagsPredicate tagsPredicate) {
    return searchForm.change(tagsPredicate: tagsPredicate).toSearchLink();
  }

  final searchTabs = SearchTabs(
    tabs: options
        .map((option) => SearchTab(
              title: option.title,
              text: option.label,
              href: htmlAttrEscape.convert(searchWithTagsLink(
                tp.isRequiredTag(option.tag)
                    ? tp.withoutTag(option.tag)
                    : tp.appendPredicate(TagsPredicate(
                        requiredTags: [option.tag],
                      )),
              )),
              active: option.isActive,
            ))
        .toList(),
  );
  return templateCache.renderTemplate(
      'shared/search_tabs', searchTabs.toJson());
}

/// `Linux`, `macOS`, `Windows` platforms are not yet stable, and we want
/// to display them only when the user has already opted-in to get them
/// displayed.
_SubSdkLayout _calculateLayout(SearchForm searchForm) {
  List<_FilterOption> options;

  _FilterOption option({
    @required String label,
    @required String tag,
    @required String title,
  }) {
    return _FilterOption(
      label: label,
      tag: tag,
      title: title,
      isActive: searchForm?.tagsPredicate?.isRequiredTag(tag) ?? false,
    );
  }

  final sdk = searchForm?.sdk;
  if (sdk == SdkTagValue.dart) {
    options = [
      option(
        label: 'native',
        tag: DartSdkTag.runtimeNativeJit,
        title:
            'Packages compatible with Dart running on a native platform (JIT/AOT)',
      ),
      option(
        label: 'JS',
        tag: DartSdkTag.runtimeWeb,
        title: 'Packages compatible with Dart compiled for the web',
      ),
    ];
  }
  if (sdk == SdkTagValue.flutter) {
    options = [
      option(
        label: 'Android',
        tag: FlutterSdkTag.platformAndroid,
        title: 'Packages compatible with Flutter on the Android platform',
      ),
      option(
        label: 'iOS',
        tag: FlutterSdkTag.platformIos,
        title: 'Packages compatible with Flutter on the iOS platform',
      ),
      option(
        label: 'Web',
        tag: FlutterSdkTag.platformWeb,
        title: 'Packages compatible with Flutter on the Web platform',
      ),
      option(
        label: 'Linux',
        tag: FlutterSdkTag.platformLinux,
        title: 'Packages compatible with Flutter on the Linux platform',
      ),
      option(
        label: 'macOS',
        tag: FlutterSdkTag.platformMacos,
        title: 'Packages compatible with Flutter on the macOS platform',
      ),
      option(
        label: 'Windows',
        tag: FlutterSdkTag.platformWindows,
        title: 'Packages compatible with Flutter on the Windows platform',
      ),
    ];
  }
  return _SubSdkLayout(options: options);
}

class _SubSdkLayout {
  final List<_FilterOption> options;

  _SubSdkLayout({
    @required this.options,
  });

  bool get hasOptions => options != null && options.isNotEmpty;
}

class _FilterOption {
  final String label;
  final String tag;
  final String title;
  final bool isActive;

  _FilterOption({
    @required this.label,
    @required this.tag,
    @required this.title,
    @required this.isActive,
  });
}
