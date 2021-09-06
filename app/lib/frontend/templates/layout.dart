// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:client_data/page_data.dart';

import '../../account/backend.dart';
import '../../search/search_form.dart';
import '../../search/search_service.dart';
import '../../service/announcement/backend.dart';
import '../../shared/configuration.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '../dom/dom.dart' as d;
import '../static_files.dart';

import '_cache.dart';
import '_consts.dart';
import '_utils.dart';

import 'views/shared/search_banner.dart';
import 'views/shared/search_tabs.dart';

enum PageType {
  error,
  account,
  landing,
  listing,
  package,
  publisher,
  standalone,
}

/// Renders the `views/shared/layout.mustache` template.
String renderLayoutPage(
  PageType type,
  String contentHtml, {
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
  final pageDataEncoded = pageData == null
      ? null
      : htmlAttrEscape.convert(pageDataJsonCodec.encode(pageData.toJson()));
  final bodyClasses = [
    if (type == PageType.standalone) 'page-standalone',
    if (type == PageType.landing) 'page-landing',
  ];
  final searchBannerHtml = _renderSearchBanner(
    type: type,
    publisherId: publisherId,
    searchForm: searchForm,
    searchPlaceholder: searchPlaceHolder,
  );
  final announcementBannerHtml = announcementBackend.getAnnouncementHtml();
  final values = {
    'is_landing': type == PageType.landing,
    'pub_site_root': urls.siteRoot,
    'dart_site_root': urls.dartSiteRoot,
    'oauth_client_id': activeConfiguration.pubSiteAudience,
    'body_class': bodyClasses.join(' '),
    'main_class': mainClasses.join(' '),
    'no_index': noIndex,
    'favicon': faviconUrl ?? staticUrls.smallDartFavicon,
    'canonical_url':
        canonicalUrl == null ? null : htmlAttrEscape.convert(canonicalUrl),
    // emit if the page is indexed and has canonical URL
    'share_url': noIndex || canonicalUrl == null
        ? null
        : htmlAttrEscape.convert(canonicalUrl),
    'pageDescription': pageDescription == null
        ? _defaultPageDescriptionEscaped
        : htmlEscape.convert(pageDescription),
    'title': htmlEscape.convert(title),
    'landing_blurb_html': defaultLandingBlurbHtml,
    'site_header_html': _renderSiteHeader(type),
    // This is not escaped as it is already escaped by the caller.
    'content_html': contentHtml,
    'include_highlight': type == PageType.package,
    'show_search_banner':
        type != PageType.package && type != PageType.standalone,
    'search_banner_html': searchBannerHtml,
    'schema_org_searchaction_json':
        isRoot ? encodeScriptSafeJson(_schemaOrgSearchAction) : null,
    'page_data_encoded': pageDataEncoded,
    'has_announcement_banner': announcementBannerHtml != null,
    'announcement_banner_html': announcementBannerHtml,
  };

  return templateCache.renderTemplate('shared/layout', values);
}

String _renderSiteHeader(PageType pageType) {
  final userSession = userSessionData == null
      ? null
      : {
          'email': userSessionData!.email,
          'has_name': userSessionData!.name != null,
          'name': userSessionData!.name,
          'image_url': userSessionData!.imageUrlOfSize(30),
        };

  final showHeaderSearch =
      pageType == PageType.package || pageType == PageType.standalone;
  return templateCache.renderTemplate('shared/site_header', {
    'show_site_logo': pageType != PageType.landing,
    'show_header_search': showHeaderSearch,
    'dart_site_root': urls.dartSiteRoot,
    'site_logo_url': staticUrls.pubDevLogo2xPng,
    'is_logged_in': userSession != null,
    'user_session': userSession,
    'my_packages_url': urls.myPackagesUrl(),
    'my_liked_packages_url': urls.myLikedPackagesUrl(),
    'my_publishers_url': urls.myPublishersUrl(),
    'my_activity_log_url': urls.myActivityLogUrl(),
    'create_publisher_url': urls.createPublisherUrl(),
  });
}

String _renderSearchBanner({
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
  ).toString();
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

final String _defaultPageDescriptionEscaped = htmlEscape.convert(
    'Pub is the package manager for the Dart programming language, containing reusable '
    'libraries & packages for Flutter, AngularDart, and general Dart programs.');

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
