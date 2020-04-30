// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:client_data/page_data.dart';
import 'package:meta/meta.dart';

import '../../account/backend.dart';
import '../../account/models.dart' show SearchPreference;
import '../../search/search_service.dart';
import '../../shared/configuration.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '../request_context.dart';
import '../static_files.dart';

import '_cache.dart';
import '_consts.dart';
import '_utils.dart';

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
  @required String title,
  String pageDescription,
  String faviconUrl,

  /// The canonical content link that will be put in the header.
  /// https://support.google.com/webmasters/answer/139066?hl=en
  String canonicalUrl,

  /// The page's URL that will be used in social share metadata.
  String shareUrl,
  String sdk,
  String publisherId,
  SearchQuery searchQuery,
  bool includeSurvey = true,
  bool noIndex = false,
  PageData pageData,
  String searchPlaceHolder,
  List<String> mainClasses,
}) {
  mainClasses ??= ['container'];
  final isRoot = type == PageType.landing && sdk == null;
  final pageDataEncoded = pageData == null
      ? null
      : htmlAttrEscape.convert(pageDataJsonCodec.encode(pageData.toJson()));
  final bodyClasses = [
    if (type == PageType.standalone) 'page-standalone',
    if (type == PageType.landing) 'page-landing',
    requestContext.isExperimental ? 'experimental' : 'non-experimental',
  ];
  final searchBannerHtml = _renderSearchBanner(
    type: type,
    publisherId: publisherId,
    searchQuery: searchQuery,
    searchPlaceholder: searchPlaceHolder,
  );
  final values = {
    'is_experimental': requestContext.isExperimental,
    'is_landing': type == PageType.landing,
    'pub_site_root': urls.siteRoot,
    'dart_site_root': urls.dartSiteRoot,
    'oauth_client_id': activeConfiguration.pubSiteAudience,
    'body_class': bodyClasses.join(' '),
    'main_class': mainClasses.join(' '),
    'no_index': noIndex,
    'favicon': faviconUrl ?? staticUrls.smallDartFavicon,
    'canonicalUrl': canonicalUrl,
    'share_url': shareUrl,
    'pageDescription': pageDescription == null
        ? _defaultPageDescriptionEscaped
        : htmlEscape.convert(pageDescription),
    'title': htmlEscape.convert(title),
    'landing_blurb_html': defaultLandingBlurbHtml,
    'site_header_html': _renderSiteHeader(type),
    // This is not escaped as it is already escaped by the caller.
    'content_html': contentHtml,
    'include_survey': includeSurvey,
    'include_highlight': type == PageType.package,
    'show_search_banner': !requestContext.isExperimental ||
        (type != PageType.package && type != PageType.standalone),
    'search_banner_html': searchBannerHtml,
    'schema_org_searchaction_json':
        isRoot ? encodeScriptSafeJson(_schemaOrgSearchAction) : null,
    'page_data_encoded': pageDataEncoded,
  };

  return templateCache.renderTemplate('shared/layout', values);
}

String _renderSiteHeader(PageType pageType) {
  final userSession = userSessionData == null
      ? null
      : {
          'email': userSessionData.email,
          'has_name': userSessionData.name != null,
          'name': userSessionData.name,
          'image_url': userSessionData.imageUrlOfSize(30),
        };

  return templateCache.renderTemplate('shared/site_header', {
    'show_site_logo': pageType != PageType.landing,
    'dart_site_root': urls.dartSiteRoot,
    'site_logo_url': staticUrls.pubDevLogo2xPng,
    'is_logged_in': userSession != null,
    'user_session': userSession,
    'my_packages_url': urls.myPackagesUrl(),
    'my_liked_packages_url': urls.myLikedPackagesUrl(),
    'my_publishers_url': urls.myPublishersUrl(),
    'create_publisher_url': urls.createPublisherUrl(),
  });
}

String _renderSearchBanner({
  @required PageType type,
  @required String publisherId,
  @required SearchQuery searchQuery,
  String searchPlaceholder,
}) {
  final sp = _sp(searchQuery);
  final queryText = searchQuery?.query;
  final escapedSearchQuery =
      queryText == null ? null : htmlAttrEscape.convert(queryText);
  bool includePreferencesAsHiddenFields = false;
  if (publisherId != null) {
    searchPlaceholder ??= 'Search $publisherId packages';
  } else if (type == PageType.account) {
    searchPlaceholder ??= 'Search your packages';
  } else {
    searchPlaceholder ??= getSdkDict(sp.sdk).searchPackagesLabel;
    includePreferencesAsHiddenFields = true;
  }
  String searchFormUrl;
  if (publisherId != null) {
    searchFormUrl = SearchQuery.parse(publisherId: publisherId).toSearchLink();
  } else if (type == PageType.account) {
    searchFormUrl = urls.myPackagesUrl();
  } else if (searchQuery != null) {
    searchFormUrl = searchQuery.toSearchFormPath();
  } else {
    searchFormUrl = sp.toSearchQuery().toSearchFormPath();
  }
  final searchSort = searchQuery?.order == null
      ? null
      : serializeSearchOrder(searchQuery.order);
  final hiddenInputs = includePreferencesAsHiddenFields
      ? sp
          .toSearchQuery()
          .tagsPredicate
          .asSearchLinkParams()
          .entries
          .map((e) => {'name': e.key, 'value': e.value})
          .toList()
      : null;
  String sdkTabsHtml;
  if (type == PageType.landing) {
    sdkTabsHtml = renderSdkTabs();
  } else if (type == PageType.listing) {
    sdkTabsHtml = renderSdkTabs(searchQuery: searchQuery);
  }
  final isExperimental = requestContext.isExperimental;
  return templateCache.renderTemplate('shared/search_banner', {
    // When search is active (query text has a non-empty value) users may expect
    // to scroll through the results via keyboard. We should only autofocus the
    // search field when there is no active search.
    'autofocus': queryText == null,
    'show_search_filters_btn': isExperimental && type == PageType.listing,
    'show_details': !isExperimental &&
        (type == PageType.listing || type == PageType.landing),
    'show_options': !isExperimental && type == PageType.listing,
    'search_form_url': searchFormUrl,
    'search_query_placeholder': searchPlaceholder,
    'search_query_html': escapedSearchQuery,
    'search_sort_param': searchSort,
    'legacy_search_enabled': searchQuery?.includeLegacy ?? false,
    'hidden_inputs': hiddenInputs,
    'sdk_tabs_html': isExperimental ? null : sdkTabsHtml,
    'show_legacy_checkbox': !isExperimental && sp.sdk == null,
    'secondary_tabs_html':
        isExperimental ? null : renderSubSdkTabsHtml(searchQuery: searchQuery),
  });
}

SearchPreference _sp(SearchQuery searchQuery) => searchQuery != null
    ? SearchPreference.fromSearchQuery(searchQuery)
    : (searchPreference ?? SearchPreference());

String renderSdkTabs({
  SearchQuery searchQuery,
}) {
  final sp = _sp(searchQuery);
  final currentSdk = sp.sdk ?? SdkTagValue.any;
  SearchTab sdkTabData(String label, String tabSdk, String title) {
    String url;
    if (searchQuery != null) {
      url = searchQuery.change(sdk: tabSdk).toSearchLink();
    } else {
      url = urls.searchUrl(sdk: tabSdk);
    }
    return SearchTab(
      text: label,
      href: htmlAttrEscape.convert(url),
      active: tabSdk == currentSdk,
      title: title,
    );
  }

  final searchTabs = SearchTabs(
    tabs: [
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
  return templateCache.renderTemplate(
      'shared/search_tabs', searchTabs.toJson());
}

class _FilterOption {
  final String label;
  final String tag;
  final String title;

  _FilterOption({
    @required this.label,
    @required this.tag,
    @required this.title,
  });
}

String renderSubSdkTabsHtml({@required SearchQuery searchQuery}) {
  if (searchQuery?.sdk == SdkTagValue.dart) {
    return _renderFilterTabs(
      searchQuery: searchQuery,
      options: [
        _FilterOption(
          label: 'native',
          tag: DartSdkTag.runtimeNativeJit,
          title:
              'Packages compatible with Dart running on a native platform (JIT/AOT)',
        ),
        _FilterOption(
          label: 'JS',
          tag: DartSdkTag.runtimeWeb,
          title: 'Packages compatible with Dart compiled for the web',
        ),
      ],
    );
  } else if (searchQuery?.sdk == SdkTagValue.flutter) {
    return _renderFilterTabs(
      searchQuery: searchQuery,
      options: [
        _FilterOption(
          label: 'Android',
          tag: FlutterSdkTag.platformAndroid,
          title: 'Packages compatible with Flutter on the Android platform',
        ),
        _FilterOption(
          label: 'iOS',
          tag: FlutterSdkTag.platformIos,
          title: 'Packages compatible with Flutter on the iOS platform',
        ),
        _FilterOption(
          label: 'Web',
          tag: FlutterSdkTag.platformWeb,
          title: 'Packages compatible with Flutter on the Web platform',
        ),
      ],
    );
  }
  return null;
}

String _renderFilterTabs({
  @required SearchQuery searchQuery,
  @required List<_FilterOption> options,
}) {
  final tp = searchQuery.tagsPredicate;
  String searchWithTagsLink(TagsPredicate tagsPredicate) {
    return searchQuery.change(tagsPredicate: tagsPredicate).toSearchLink();
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
              active: tp.isRequiredTag(option.tag),
            ))
        .toList(),
  );
  return templateCache.renderTemplate(
      'shared/search_tabs', searchTabs.toJson());
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
