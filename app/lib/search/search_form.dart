// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import '../shared/tags.dart';
import '../shared/urls.dart';

import 'search_service.dart';

export 'search_service.dart' show SearchOrder, TagsPredicate;

/// The <form> data from the app frontend.
class SearchForm {
  final String query;
  final ParsedQueryText parsedQuery;

  final TagsPredicate tagsPredicate;

  /// The query will match packages where the owners of the package have
  /// non-empty intersection with the provided list of owners.
  ///
  /// Values of this list can be email addresses (usually a single on) or
  /// publisher ids (may be multiple).
  final List<String> uploaderOrPublishers;

  final String publisherId;
  final SearchOrder order;

  /// The visible index of the current page (and offset position).
  /// Starts with 1.
  final int currentPage;

  /// The number of search results per page.
  final int pageSize;

  /// True, if packages with is:discontinued tag should be included.
  final bool includeDiscontinued;

  /// True, if packages with is:unlisted tag should be included.
  final bool includeUnlisted;

  /// True, if null safe package should be listed.
  final bool nullSafe;

  SearchForm._({
    this.query,
    TagsPredicate tagsPredicate,
    List<String> uploaderOrPublishers,
    String publisherId,
    this.order,
    this.currentPage,
    this.pageSize,
    this.includeDiscontinued,
    this.includeUnlisted,
    this.nullSafe,
  })  : parsedQuery = ParsedQueryText.parse(query),
        tagsPredicate = tagsPredicate ?? TagsPredicate(),
        uploaderOrPublishers = _listToNull(uploaderOrPublishers),
        publisherId = _stringToNull(publisherId);

  factory SearchForm.parse({
    String query,
    String sdk,
    List<String> runtimes,
    List<String> platforms,
    TagsPredicate tagsPredicate,
    List<String> uploaderOrPublishers,
    String publisherId,
    SearchOrder order,
    int currentPage,
    int pageSize,
    bool includeDiscontinued = false,
    bool includeUnlisted = false,
    bool nullSafe = false,
  }) {
    currentPage ??= 1;
    pageSize ??= resultsPerPage;
    final q = _stringToNull(query?.trim());
    tagsPredicate ??= TagsPredicate();
    final requiredTags = <String>[];
    if (SdkTagValue.isNotAny(sdk)) {
      requiredTags.add('sdk:$sdk');
    }
    DartSdkRuntime.decodeQueryValues(runtimes)
        ?.map((v) => 'runtime:$v')
        ?.forEach(requiredTags.add);
    platforms
        ?.where((v) => v.isNotEmpty)
        ?.map((v) => 'platform:$v')
        ?.forEach(requiredTags.add);
    if (requiredTags.isNotEmpty) {
      tagsPredicate = tagsPredicate
          .appendPredicate(TagsPredicate(requiredTags: requiredTags));
    }
    return SearchForm._(
      query: q,
      tagsPredicate: tagsPredicate,
      uploaderOrPublishers: uploaderOrPublishers,
      publisherId: publisherId,
      order: order,
      currentPage: currentPage,
      pageSize: pageSize,
      includeDiscontinued: includeDiscontinued,
      includeUnlisted: includeUnlisted,
      nullSafe: nullSafe,
    );
  }

  SearchForm change({
    String query,
    String sdk,
    TagsPredicate tagsPredicate,
    List<String> uploaderOrPublishers,
    String publisherId,
    SearchOrder order,
    int currentPage,
    int pageSize,
  }) {
    if (sdk != null) {
      tagsPredicate ??= this.tagsPredicate ?? TagsPredicate();
      if (!tagsPredicate.isRequiredTag('sdk:$sdk')) {
        tagsPredicate = tagsPredicate
            .removePrefix('sdk:')
            .withoutTag(PackageTags.isFlutterFavorite);
        if (SdkTagValue.isNotAny(sdk)) {
          tagsPredicate = tagsPredicate
              .appendPredicate(TagsPredicate(requiredTags: ['sdk:$sdk']));
        }
        if (sdk != SdkTagValue.dart) {
          tagsPredicate = tagsPredicate.removePrefix('runtime:');
        }
        if (sdk != SdkTagValue.flutter) {
          tagsPredicate = tagsPredicate.removePrefix('platform:');
        }
      }
    }
    return SearchForm._(
      query: query ?? this.query,
      tagsPredicate: tagsPredicate ?? this.tagsPredicate,
      uploaderOrPublishers: uploaderOrPublishers ?? this.uploaderOrPublishers,
      publisherId: publisherId ?? this.publisherId,
      order: order ?? this.order,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      includeDiscontinued: includeDiscontinued,
      includeUnlisted: includeUnlisted,
      nullSafe: nullSafe,
    );
  }

  ServiceSearchQuery toServiceQuery() {
    var tagsPredicate = this.tagsPredicate;
    if (includeDiscontinued &&
        tagsPredicate.isProhibitedTag(PackageTags.isDiscontinued)) {
      tagsPredicate = tagsPredicate.withoutTag(PackageTags.isDiscontinued);
    }
    if (includeUnlisted &&
        tagsPredicate.isProhibitedTag(PackageTags.isUnlisted)) {
      tagsPredicate = tagsPredicate.withoutTag(PackageTags.isUnlisted);
    }
    // Only parse query texts when a quick text match indicates the presence of
    // `is:legacy` override.
    if (tagsPredicate.isProhibitedTag(PackageVersionTags.isLegacy) &&
        hasQuery &&
        query.contains(PackageVersionTags.isLegacy)) {
      final parsed = ParsedQueryText.parse(query);
      if (parsed.tagsPredicate != null &&
          parsed.tagsPredicate.isRequiredTag(PackageVersionTags.isLegacy)) {
        tagsPredicate = tagsPredicate
            .withoutTag(PackageVersionTags.isLegacy)
            .appendPredicate(
                TagsPredicate(requiredTags: [PackageVersionTags.isLegacy]));
      }
    }
    if (nullSafe) {
      tagsPredicate =
          tagsPredicate.appendPredicate(TagsPredicate(requiredTags: [
        PackageTags.convertToPrereleaseTag(PackageVersionTags.isNullSafe),
      ]));
    }
    return ServiceSearchQuery.parse(
      query: query,
      tagsPredicate: tagsPredicate,
      uploaderOrPublishers: uploaderOrPublishers,
      publisherId: publisherId,
      offset: offset,
      limit: pageSize,
      order: order,
    );
  }

  bool get hasQuery => query != null && query.isNotEmpty;

  /// The zero-indexed offset for the search results.
  int get offset => (currentPage - 1) * pageSize;

  String get sdk {
    final values = tagsPredicate.tagPartsWithPrefix('sdk', value: true);
    return values.isEmpty ? null : values.first;
  }

  /// Returns whether the search is on Flutter Favorites.
  bool get isFlutterFavorite =>
      tagsPredicate.isRequiredTag(PackageTags.isFlutterFavorite);

  /// Converts the query to a user-facing link that the search form can use as
  /// the base path of its `action` parameter.
  String toSearchFormPath() {
    String path = '/packages';
    if (sdk != null) {
      path = '/$sdk/packages';
    }
    if (isFlutterFavorite) {
      path = '/flutter/favorites';
    }
    if (publisherId != null && publisherId.isNotEmpty) {
      path = '/publishers/$publisherId/packages';
    }
    if (uploaderOrPublishers != null && uploaderOrPublishers.isNotEmpty) {
      path = myPackagesUrl();
    }
    return path;
  }

  /// Converts the query to a user-facing link that (after frontend parsing) will
  /// re-create an identical search query object.
  String toSearchLink({int page}) {
    page ??= currentPage;
    final params = <String, dynamic>{};
    if (query != null && query.isNotEmpty) {
      params['q'] = query;
    }
    params.addAll(tagsPredicate.asSearchLinkParams());
    if (order != null) {
      final String paramName = 'sort';
      params[paramName] = serializeSearchOrder(order);
    }
    if (includeDiscontinued) {
      params['discontinued'] = '1';
    }
    if (includeUnlisted) {
      params['unlisted'] = '1';
    }
    if (nullSafe) {
      params['null-safe'] = '1';
    }
    if (page != null && page > 1) {
      params['page'] = page.toString();
    }
    final uri = Uri(
        path: toSearchFormPath(),
        queryParameters: params.isEmpty ? null : params);
    return uri.toString();
  }
}

/// Parses the search query URL queryParameters for the parameters we expose on
/// the frontend. The parameters and the values may be different from the ones
/// we use in the search service backend.
SearchForm parseFrontendSearchForm(
  Map<String, String> queryParameters, {
  String platform,
  String sdk,
  List<String> uploaderOrPublishers,
  String publisherId,
  @required TagsPredicate tagsPredicate,
}) {
  final currentPage = extractPageFromUrlParameters(queryParameters);
  final String queryText = queryParameters['q'] ?? '';
  final String sortParam = queryParameters['sort'];
  final SearchOrder sortOrder = parseSearchOrder(sortParam);
  List<String> runtimes;
  if (queryParameters.containsKey('runtime')) {
    runtimes = queryParameters['runtime'].split(' ');
  }
  List<String> platforms;
  if (queryParameters.containsKey('platform')) {
    platforms = queryParameters['platform'].split(' ');
  }
  return SearchForm.parse(
    query: queryText,
    sdk: sdk,
    runtimes: runtimes,
    platforms: platforms,
    uploaderOrPublishers: uploaderOrPublishers,
    publisherId: publisherId,
    order: sortOrder,
    currentPage: currentPage,
    includeDiscontinued: queryParameters['discontinued'] == '1',
    includeUnlisted: queryParameters['unlisted'] == '1',
    nullSafe: queryParameters['prerelease-null-safe'] == '1' ||
        queryParameters['null-safe'] == '1',
    tagsPredicate: tagsPredicate,
  );
}

String _stringToNull(String v) => (v == null || v.isEmpty) ? null : v;
List<String> _listToNull(List<String> list) =>
    (list == null || list.isEmpty) ? null : list;
