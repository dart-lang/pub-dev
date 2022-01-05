// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../shared/tags.dart';
import '../shared/urls.dart';

import 'search_service.dart';

export 'search_service.dart' show SearchOrder, TagsPredicate;

/// The <form> data from the app frontend.
class SearchForm {
  final SearchContext context;
  final String? query;
  late final parsedQuery = ParsedQueryText.parse(query);

  final List<String> runtimes;
  final List<String> platforms;

  final SearchOrder? order;

  /// The visible index of the current page (and offset position).
  /// Starts with 1.
  final int? currentPage;

  /// The number of search results per page.
  final int? pageSize;

  /// True, if packages with is:discontinued tag should be included.
  final bool includeDiscontinued;

  /// True, if packages with is:unlisted tag should be included.
  final bool includeUnlisted;

  /// True, if null safe package should be listed.
  final bool nullSafe;

  SearchForm._({
    required this.context,
    this.query,
    this.runtimes = const <String>[],
    this.platforms = const <String>[],
    this.order,
    this.currentPage,
    this.pageSize,
    required this.includeDiscontinued,
    required this.includeUnlisted,
    required this.nullSafe,
  });

  factory SearchForm({
    SearchContext? context,
    String? query,
    List<String> runtimes = const <String>[],
    List<String> platforms = const <String>[],
    SearchOrder? order,
    int? currentPage,
    int? pageSize,
    bool includeDiscontinued = false,
    bool includeUnlisted = false,
    bool nullSafe = false,
  }) {
    currentPage ??= 1;
    pageSize ??= resultsPerPage;
    final q = _stringToNull(query?.trim());
    runtimes = DartSdkRuntime.decodeQueryValues(runtimes);
    platforms = platforms.where((v) => v.isNotEmpty).toList();
    return SearchForm._(
      context: context ?? SearchContext.regular(),
      query: q,
      runtimes: runtimes,
      platforms: platforms,
      order: order,
      currentPage: currentPage,
      pageSize: pageSize,
      includeDiscontinued: includeDiscontinued,
      includeUnlisted: includeUnlisted,
      nullSafe: nullSafe,
    );
  }

  /// Parses the search query URL queryParameters for the parameters we expose on
  /// the frontend. The parameters and the values may be different from the ones
  /// we use in the search service backend.
  factory SearchForm.parse(
      SearchContext context, Map<String, String> queryParameters) {
    return _parseFrontendSearchForm(context, queryParameters);
  }

  SearchForm change({
    SearchContext? context,
    String? query,
    List<String>? runtimes,
    List<String>? platforms,
    int? currentPage,
  }) {
    runtimes ??= this.runtimes;
    platforms ??= this.platforms;
    if (context != null && context.sdk != this.context.sdk) {
      if (context.sdk != SdkTagValue.dart) {
        runtimes = const <String>[];
      }
      if (context.sdk != SdkTagValue.flutter) {
        platforms = const <String>[];
      }
    }
    return SearchForm._(
      context: context ?? this.context,
      query: query ?? this.query,
      runtimes: runtimes,
      platforms: platforms,
      order: order,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize,
      includeDiscontinued: includeDiscontinued,
      includeUnlisted: includeUnlisted,
      nullSafe: nullSafe,
    );
  }

  SearchForm toggleSdk(String sdk) {
    return toggleRequiredTag('sdk:$sdk');
  }

  SearchForm toggleRequiredTag(String tag) {
    return change(
      query: parsedQuery
          .change(tagsPredicate: parsedQuery.tagsPredicate.toggleRequired(tag))
          .toString(),
    );
  }

  SearchForm toggleRuntime(String runtime) {
    final runtimes = <String>[...this.runtimes];
    if (runtimes.contains(runtime)) {
      runtimes.remove(runtime);
    } else {
      runtimes.add(runtime);
    }
    return change(runtimes: runtimes);
  }

  SearchForm togglePlatform(String platform) {
    final platforms = <String>[...this.platforms];
    if (platforms.contains(platform)) {
      platforms.remove(platform);
    } else {
      platforms.add(platform);
    }
    return change(platforms: platforms);
  }

  ServiceSearchQuery toServiceQuery() {
    final prohibitLegacy = !context.includeAll &&
        !parsedQuery.tagsPredicate.anyTag((tag) =>
            tag == PackageVersionTags.isLegacy ||
            tag == PackageVersionTags.showLegacy ||
            tag == PackageTags.showHidden);
    final prohibitDiscontinued = !context.includeAll &&
        !includeDiscontinued &&
        !parsedQuery.tagsPredicate.anyTag((tag) =>
            tag == PackageTags.isDiscontinued ||
            tag == PackageTags.showDiscontinued ||
            tag == PackageTags.showHidden);
    final prohibitUnlisted = !context.includeAll &&
        !includeUnlisted &&
        !parsedQuery.tagsPredicate.anyTag((tag) =>
            tag == PackageTags.isUnlisted ||
            tag == PackageTags.showUnlisted ||
            tag == PackageTags.showHidden);
    final tagsPredicate = TagsPredicate(
      requiredTags: [
        if (nullSafe) PackageVersionTags.isNullSafe,
        if (context.isFlutterFavorites) PackageTags.isFlutterFavorite,
        if (SdkTagValue.isNotAny(context.sdk)) 'sdk:${context.sdk}',
        ...runtimes.map((v) => 'runtime:$v'),
        ...platforms.map((v) => 'platform:$v'),
      ],
      prohibitedTags: [
        if (prohibitDiscontinued) PackageTags.isDiscontinued,
        if (prohibitUnlisted) PackageTags.isUnlisted,
        if (prohibitLegacy) PackageVersionTags.isLegacy,
      ],
    );
    return ServiceSearchQuery.parse(
      query: query,
      tagsPredicate: tagsPredicate,
      uploaderOrPublishers: context.uploaderOrPublishers,
      publisherId: context.publisherId,
      offset: offset,
      limit: pageSize,
      order: order,
    );
  }

  bool get hasQuery => query != null && query!.isNotEmpty;

  /// The zero-indexed offset for the search results.
  int get offset => (currentPage! - 1) * pageSize!;

  /// Whether any of the advanced options is active.
  bool get hasActiveAdvanced =>
      includeDiscontinued || includeUnlisted || nullSafe;

  /// Whether any of the non-query settings are non-default
  /// (e.g. clicking on any platforms, SDKs, or advanced filters).
  bool get hasActiveNonQuery =>
      parsedQuery.tagsPredicate.isNotEmpty ||
      platforms.isNotEmpty ||
      hasActiveAdvanced;

  /// Converts the query to a user-facing link that (after frontend parsing) will
  /// re-create an identical search query object.
  String toSearchLink({int? page}) {
    page ??= currentPage;
    final params = <String, dynamic>{};
    if (query != null && query!.isNotEmpty) {
      params['q'] = query;
    }
    params.addAll(hiddenFields());
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
        path: context.toSearchFormPath(),
        queryParameters: params.isEmpty ? null : params);
    return uri.toString();
  }

  /// Helper method for emitting hidden fields in the search <form>
  /// TODO: eventually remove this and use explicit values
  Map<String, String> hiddenFields() {
    final encodedRuntimes = DartSdkRuntime.encodeRuntimeTags(runtimes);
    return {
      if (encodedRuntimes.isNotEmpty) 'runtime': encodedRuntimes.join(' '),
      if (platforms.isNotEmpty) 'platform': platforms.join(' '),
    };
  }
}

/// The context of the search, e.g. (all | publisher | my-) packages.
class SearchContext {
  /// Whether the search query is in the Flutter Favorites context.
  final bool isFlutterFavorites;

  /// Whether the search query is in the Dart or Flutter SDK context.
  final String? sdk;

  /// The query will match packages where the owners of the package have
  /// non-empty intersection with the provided list of owners.
  ///
  /// Values of this list can be email addresses (usually a single on) or
  /// publisher ids (may be multiple).
  final List<String>? uploaderOrPublishers;

  final String? publisherId;

  /// True, if all packages should be part of the results, including:
  /// - discontinued
  /// - unlisted
  /// - legacy
  final bool includeAll;

  SearchContext._({
    this.isFlutterFavorites = false,
    this.sdk,
    List<String>? uploaderOrPublishers,
    String? publisherId,
    this.includeAll = false,
  })  : uploaderOrPublishers = _listToNull(uploaderOrPublishers),
        publisherId = _stringToNull(publisherId);

  /// Include all packages, including discontinued, unlisted and legacy.
  factory SearchContext.all() => SearchContext._(includeAll: true);

  /// Regular search, not displaying discontinued, unlisted or legacy packages.
  factory SearchContext.regular() => SearchContext._();

  /// Regular search on the Dart SDK.
  factory SearchContext.dart() => SearchContext._(sdk: SdkTagValue.dart);

  /// Regular search on the Flutter SDK.
  factory SearchContext.flutter() => SearchContext._(sdk: SdkTagValue.flutter);

  /// Regular search on Flutter Favorites.
  factory SearchContext.flutterFavorites() =>
      SearchContext._(isFlutterFavorites: true);

  /// All packages listed for a publisher.
  factory SearchContext.publisher(String publisherId) =>
      SearchContext._(publisherId: publisherId, includeAll: true);

  /// All packages listed for the current user.
  factory SearchContext.myPackages(List<String>? uploaderOrPublishers) =>
      SearchContext._(
        uploaderOrPublishers: uploaderOrPublishers,
        includeAll: true,
      );

  /// Converts the query to a user-facing link that the search form can use as
  /// the base path of its `action` parameter.
  String toSearchFormPath() {
    String path = '/packages';
    if (sdk != null && SdkTagValue.isNotAny(sdk)) {
      path = '/$sdk/packages';
    }
    if (isFlutterFavorites) {
      path = '/flutter/favorites';
    }
    if (publisherId != null && publisherId!.isNotEmpty) {
      path = '/publishers/$publisherId/packages';
    }
    if (uploaderOrPublishers != null && uploaderOrPublishers!.isNotEmpty) {
      path = myPackagesUrl();
    }
    return path;
  }
}

SearchForm _parseFrontendSearchForm(
    SearchContext context, Map<String, String> queryParameters) {
  final currentPage = extractPageFromUrlParameters(queryParameters);
  final String queryText = queryParameters['q'] ?? '';
  final String? sortParam = queryParameters['sort'];
  final SearchOrder? sortOrder = parseSearchOrder(sortParam);
  List<String>? runtimes;
  if (queryParameters.containsKey('runtime')) {
    runtimes = queryParameters['runtime']!.split(' ');
  }
  List<String>? platforms;
  if (queryParameters.containsKey('platform')) {
    platforms = queryParameters['platform']!.split(' ');
  }
  return SearchForm(
    context: context,
    query: queryText,
    runtimes: runtimes ?? const <String>[],
    platforms: platforms ?? const <String>[],
    order: sortOrder,
    currentPage: currentPage,
    includeDiscontinued: queryParameters['discontinued'] == '1',
    includeUnlisted: queryParameters['unlisted'] == '1',
    nullSafe: queryParameters['prerelease-null-safe'] == '1' ||
        queryParameters['null-safe'] == '1',
  );
}

String? _stringToNull(String? v) => (v == null || v.isEmpty) ? null : v;
List<String>? _listToNull(List<String>? list) =>
    (list == null || list.isEmpty) ? null : list;
