// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/page_data.dart';
import 'package:pub_dev/frontend/templates/_utils.dart';

import '../../search/search_form.dart';
import '../../search/search_service.dart';
import '../../service/announcement/backend.dart';
import '../../shared/configuration.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '../dom/dom.dart' as d;
import '../static_files.dart';

import '_consts.dart';

import 'views/shared/layout.dart';
import 'views/shared/search_banner.dart';
import 'views/shared/search_tabs.dart';
import 'views/shared/site_header.dart';

enum PageType {
  error,
  account,
  landing,
  listing,
  package,
  publisher,
  standalone,
}

/// Renders the layout page template.
String renderLayoutPage(
  PageType type,
  d.Node contentNode, {
  required String title,
  String? pageDescription,
  String? faviconUrl,

  /// The canonical content link that will be put in the header.
  /// https://support.google.com/webmasters/answer/139066?hl=en
  String? canonicalUrl,
  String? sdk,
  String? publisherId,
  SearchForm? searchForm,
  bool noIndex = false,
  PageData? pageData,
  String? searchPlaceHolder,
  List<String>? mainClasses,
}) {
  // normalize canonical URL
  if (canonicalUrl != null && canonicalUrl.startsWith('/')) {
    canonicalUrl = '${urls.siteRoot}$canonicalUrl';
  }
  mainClasses ??= ['container'];
  final isRoot = type == PageType.landing && sdk == null;
  final bodyClasses = [
    if (type == PageType.standalone) 'page-standalone',
    if (type == PageType.landing) 'page-landing',
  ];
  final announcementBannerHtml = announcementBackend.getAnnouncementHtml();
  final showSearchBanner =
      type != PageType.package && type != PageType.standalone;
  return pageLayoutNode(
    title: title,
    description: pageDescription ?? _defaultPageDescription,
    canonicalUrl: canonicalUrl,
    faviconUrl: faviconUrl ?? staticUrls.smallDartFavicon,
    noIndex: noIndex,
    oauthClientId: activeConfiguration.pubSiteAudience,
    pageDataEncoded:
        pageData == null ? null : pageDataJsonCodec.encode(pageData.toJson()),
    bodyClasses: bodyClasses,
    siteHeader: siteHeaderNode(pageType: type),
    announcementBanner: announcementBannerHtml == null
        ? null
        : d.unsafeRawHtml(announcementBannerHtml),
    searchBanner: showSearchBanner
        ? _renderSearchBanner(
            type: type,
            publisherId: publisherId,
            searchForm: searchForm,
            searchPlaceholder: searchPlaceHolder,
          )
        : null,
    isLanding: type == PageType.landing,
    landingBlurb: defaultLandingBlurbNode,
    mainClasses: mainClasses,
    mainContent: contentNode,
    includeHighlightJs: type == PageType.package,
    schemaOrgSearchActionJson: isRoot ? _schemaOrgSearchAction : null,
  ).toString();
}

d.Node _renderSearchBanner({
  required PageType type,
  required String? publisherId,
  required SearchForm? searchForm,
  String? searchPlaceholder,
}) {
  final sdk = searchForm?.sdk ?? SdkTagValue.any;
  final queryText = searchForm?.query;
  bool includePreferencesAsHiddenFields = false;
  if (publisherId != null) {
    searchPlaceholder ??= 'Search $publisherId packages';
  } else if (type == PageType.account) {
    searchPlaceholder ??= 'Search your packages';
  } else {
    searchPlaceholder ??= getSdkDict(sdk).searchPackagesLabel;
    includePreferencesAsHiddenFields = true;
  }
  String searchFormUrl;
  if (publisherId != null) {
    searchFormUrl = SearchForm.parse(publisherId: publisherId).toSearchLink();
  } else if (type == PageType.account) {
    searchFormUrl = urls.myPackagesUrl();
  } else if (searchForm != null) {
    searchFormUrl = searchForm.toSearchFormPath();
  } else {
    searchFormUrl = SearchForm.parse().toSearchFormPath();
  }
  final searchSort = searchForm?.order == null
      ? null
      : serializeSearchOrder(searchForm!.order);
  final hiddenInputs = includePreferencesAsHiddenFields
      ? (searchForm ?? SearchForm.parse()).tagsPredicate.asSearchLinkParams()
      : null;
  return searchBannerNode(
    // When search is active (query text has a non-empty value) users may expect
    // to scroll through the results via keyboard. We should only autofocus the
    // search field when there is no active search.
    autofocus: queryText == null,
    showSearchFiltersButton: type == PageType.listing,
    formUrl: searchFormUrl,
    placeholder: searchPlaceholder,
    queryText: queryText,
    sortParam: searchSort,
    includeDiscontinued: searchForm?.includeDiscontinued ?? false,
    includeUnlisted: searchForm?.includeUnlisted ?? false,
    includeNullSafe: searchForm?.nullSafe ?? false,
    hiddenInputs: hiddenInputs,
  );
}

d.Node sdkTabsNode({
  SearchForm? searchForm,
}) {
  final isff = searchForm?.isFlutterFavorite ?? false;
  final currentSdk = isff ? null : searchForm?.sdk ?? SdkTagValue.any;
  SearchTab sdkTabData(String label, String tabSdk, String title) {
    String url;
    if (searchForm != null) {
      url = searchForm.change(sdk: tabSdk, currentPage: 1).toSearchLink();
    } else {
      url = urls.searchUrl(sdk: tabSdk);
    }
    return SearchTab(
      text: label,
      href: url,
      active: tabSdk == currentSdk,
      title: title,
    );
  }

  return searchTabsNode(
    [
      sdkTabData(
        'Dart',
        SdkTagValue.dart,
        'Packages compatible with the Dart SDK',
      ),
      sdkTabData(
        'Flutter',
        SdkTagValue.flutter,
        'Packages compatible with the Flutter SDK',
      ),
      sdkTabData(
        'Any',
        SdkTagValue.any,
        'Packages compatible with the any SDK',
      ),
    ],
  );
}

final String _defaultPageDescription =
    'Pub is the package manager for the Dart programming language, containing reusable '
    'libraries & packages for Flutter, AngularDart, and general Dart programs.';

const _schemaOrgSearchAction = {
  '@context': 'http://schema.org',
  '@type': 'WebSite',
  'url': '${urls.siteRoot}/',
  'potentialAction': {
    '@type': 'SearchAction',
    'target': '${urls.siteRoot}/packages?q={search_term_string}',
    'query-input': 'required name=search_term_string',
  },
};
