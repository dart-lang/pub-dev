// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../shared/tags.dart';

import 'search_service.dart';

export 'search_service.dart' show SearchOrder, TagsPredicate;

/// The <form> data from the app frontend.
class SearchForm {
  final SearchContext context;
  final String? query;
  late final parsedQuery = ParsedQueryText.parse(query);

  final SearchOrder? order;

  /// The visible index of the current page (and offset position).
  /// Starts with 1.
  final int? currentPage;

  /// The number of search results per page.
  final int? pageSize;

  SearchForm._({
    required this.context,
    this.query,
    this.order,
    this.currentPage,
    this.pageSize,
  });

  factory SearchForm({
    SearchContext? context,
    String? query,
    SearchOrder? order,
    int? currentPage,
    int? pageSize,
  }) {
    currentPage ??= 1;
    pageSize ??= resultsPerPage;
    final q = _stringToNull(query?.trim());
    return SearchForm._(
      context: context ?? SearchContext.regular(),
      query: q,
      order: order,
      currentPage: currentPage,
      pageSize: pageSize,
    );
  }

  /// Parses the search query URL queryParameters for the parameters we expose on
  /// the frontend. The parameters and the values may be different from the ones
  /// we use in the search service backend.
  factory SearchForm.parse(
      SearchContext context, Map<String, String> queryParameters) {
    return SearchForm(
      context: context,
      query: queryParameters['q'] ?? '',
      order: parseSearchOrder(queryParameters['sort']),
      currentPage: extractPageFromUrlParameters(queryParameters),
    );
  }

  SearchForm _change({String? query}) {
    return SearchForm._(
      context: context,
      query: query ?? this.query,
      order: order,
      currentPage: currentPage,
      pageSize: pageSize,
    );
  }

  SearchForm toggleRequiredTag(String tag) {
    return _change(
      query: parsedQuery
          .change(tagsPredicate: parsedQuery.tagsPredicate.toggleRequired(tag))
          .toString(),
    );
  }

  ServiceSearchQuery toServiceQuery() {
    final prohibitLegacy = !context.includeAll &&
        !parsedQuery.tagsPredicate.anyTag((tag) =>
            tag == PackageVersionTags.isLegacy ||
            tag == PackageVersionTags.showLegacy ||
            tag == PackageTags.showHidden);
    final prohibitDiscontinued = !context.includeAll &&
        !parsedQuery.tagsPredicate.anyTag((tag) =>
            tag == PackageTags.isDiscontinued ||
            tag == PackageTags.showDiscontinued ||
            tag == PackageTags.showHidden);
    final prohibitUnlisted = !context.includeAll &&
        !parsedQuery.tagsPredicate.anyTag((tag) =>
            tag == PackageTags.isUnlisted ||
            tag == PackageTags.showUnlisted ||
            tag == PackageTags.showHidden);
    final tagsPredicate = TagsPredicate(
      prohibitedTags: [
        if (prohibitDiscontinued) PackageTags.isDiscontinued,
        if (prohibitUnlisted) PackageTags.isUnlisted,
        if (prohibitLegacy) PackageVersionTags.isLegacy,
      ],
    );
    return ServiceSearchQuery.parse(
      query: query,
      tagsPredicate: tagsPredicate,
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
      parsedQuery.tagsPredicate.hasTag(PackageTags.isFlutterFavorite) ||
      parsedQuery.tagsPredicate.hasTag(PackageTags.showHidden) ||
      parsedQuery.tagsPredicate.hasTag(PackageVersionTags.isNullSafe);

  /// Whether any of the non-query settings are non-default
  /// (e.g. clicking on any platforms, SDKs, or advanced filters).
  bool get hasActiveNonQuery => parsedQuery.tagsPredicate.isNotEmpty;

  /// Converts the query to a user-facing link that (after frontend parsing) will
  /// re-create an identical search query object.
  String toSearchLink({int? page}) {
    page ??= currentPage;
    final params = <String, dynamic>{
      if (query != null && query!.isNotEmpty) 'q': query,
      if (order != null) 'sort': order!.name,
      if (page != null && page > 1) 'page': page.toString(),
    };
    return Uri(
      path: context.toSearchFormPath(),
      queryParameters: params.isEmpty ? null : params,
    ).toString();
  }
}

/// The context of the search, e.g. (all | publisher | my-) packages.
class SearchContext {
  final String? publisherId;

  /// True, if all packages should be part of the results, including:
  /// - discontinued
  /// - unlisted
  /// - legacy
  final bool includeAll;

  SearchContext._({
    String? publisherId,
    this.includeAll = false,
  }) : publisherId = _stringToNull(publisherId);

  /// Regular search, not displaying discontinued, unlisted or legacy packages.
  factory SearchContext.regular() => SearchContext._();

  /// All packages listed for a publisher.
  factory SearchContext.publisher(String publisherId) =>
      SearchContext._(publisherId: publisherId, includeAll: true);

  /// Converts the query to a user-facing link that the search form can use as
  /// the base path of its `action` parameter.
  String toSearchFormPath() {
    if (publisherId != null && publisherId!.isNotEmpty) {
      return '/publishers/$publisherId/packages';
    }
    return '/packages';
  }
}

String? _stringToNull(String? v) => (v == null || v.isEmpty) ? null : v;
