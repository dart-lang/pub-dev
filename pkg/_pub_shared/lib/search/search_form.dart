// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'tags.dart';

/// The number of packages we are going to display on a search page.
const int resultsPerPage = 10;

final RegExp _whitespacesRegExp = RegExp(r'\s+');
final RegExp _packageRegexp =
    RegExp('package:([_a-z0-9]+)', caseSensitive: false);
final RegExp _refDependencyRegExp =
    RegExp('dependency:([_a-z0-9]+)', caseSensitive: false);
final RegExp _allDependencyRegExp =
    RegExp(r'dependency\*:([_a-z0-9]+)', caseSensitive: false);
final _sortRegExp = RegExp('sort:([a-z]+)');
final _tagRegExp =
    RegExp(r'([\+|\-]?[a-z0-9]+:[a-z0-9\-_\.]+)', caseSensitive: false);

/// The tag prefixes that we can detect in the user-provided search query.
final _detectedTagPrefixes = <String>{
  ...allowedTagPrefixes.expand((s) => [s, '-$s', '+$s']),
};

/// Extracts the 'page' query parameter from requested URL's [queryParameters].
///
/// Returns a valid positive integer.
int extractPageFromUrlParameters(Map<String, String> queryParameters) {
  final pageAsString = queryParameters['page'];
  final pageAsInt = int.tryParse(pageAsString ?? '1') ?? 1;
  return pageAsInt > 1 ? pageAsInt : 1;
}

/// How search results should be ordered.
enum SearchOrder {
  /// Search score should be a weighted value of [text], [popularity], [points]
  /// and [like], ordered decreasing.
  top,

  /// Search score should depend only on text match similarity, ordered
  /// decreasing.
  text,

  /// Search order should be in decreasing last package creation time.
  created,

  /// Search order should be in decreasing last package updated time.
  updated,

  /// Search order should be in decreasing popularity score.
  popularity,

  /// Search order should be in decreasing like count.
  like,

  /// Search order should be in decreasing pub points.
  points,
}

/// Returns null if [value] is not a recognized search order.
SearchOrder? parseSearchOrder(String? value) {
  if (value == null) {
    return null;
  }
  for (final v in SearchOrder.values) {
    if (v.name == value) return v;
  }
  return null;
}

/// Filter conditions on tags.
class TagsPredicate {
  /// tag -> {true = required | false = prohibited}
  final Map<String, bool> _values;

  TagsPredicate._(this._values);

  factory TagsPredicate(
      {List<String>? requiredTags, List<String>? prohibitedTags}) {
    final values = <String, bool>{};
    requiredTags?.forEach((tag) => values[tag] = true);
    prohibitedTags?.forEach((tag) => values[tag] = false);
    return TagsPredicate._(values);
  }

  /// Pre-populates the predicate with the default tags for regular search (e.g.
  /// typing in the search box on the landing page).
  factory TagsPredicate.regularSearch() => TagsPredicate(
        prohibitedTags: [
          PackageTags.isDiscontinued,
          PackageTags.isUnlisted,
          PackageVersionTags.isLegacy,
        ],
      );

  bool get isEmpty => _values.isEmpty;
  bool get isNotEmpty => _values.isNotEmpty;

  bool isRequiredTag(String tag) => _values[tag] == true;
  bool isProhibitedTag(String tag) => _values[tag] == false;
  bool hasTag(String tag) => _values.containsKey(tag);
  bool anyTag(bool Function(String key) fn) => _values.keys.any(fn);
  bool hasTagPrefix(String prefix) => anyTag((t) => t.startsWith(prefix));
  bool hasNoTagPrefix(String prefix) => !hasTagPrefix(prefix);

  /// Parses [values] passed via Uri.queryParameters
  factory TagsPredicate.parseQueryValues(List<String>? values) {
    final p = TagsPredicate();
    if (values == null) {
      return p;
    }
    for (var tag in values) {
      bool required = true;
      if (tag.startsWith('-')) {
        tag = tag.substring(1);
        required = false;
      } else if (tag.startsWith('+')) {
        tag = tag.substring(1);
      }
      p._values[tag] = required;
    }
    return p;
  }

  /// Update the predicates by using their canonical version (if there is any available).
  /// Does not change the predicates status (unless the canonical one is also present,
  /// in this case the behavior is undefined).
  ///
  /// Returns `null` if no update was needed.
  TagsPredicate? canonicalizeKeys(String? Function(String key) fn) {
    final newValues = <String, bool>{};
    for (final e in _values.entries) {
      newValues[fn(e.key) ?? e.key] = e.value;
    }
    if (_values.length != newValues.length ||
        newValues.entries.any((e) => _values[e.key] != e.value)) {
      return TagsPredicate._(newValues);
    } else {
      return null;
    }
  }

  /// Appends [other] predicate to the current set of tags, and returns a new
  /// [TagsPredicate] instance.
  ///
  /// If there are conflicting tag predicates, the [other] takes precedence over
  /// this [TagsPredicate].
  TagsPredicate appendPredicate(TagsPredicate other) {
    final p = TagsPredicate();
    p._values.addAll(_values);
    p._values.addAll(other._values);
    return p;
  }

  /// Evaluate this predicate against the list of supplied [tags].
  /// Returns true if the predicate matches the [tags], false otherwise.
  bool matches(Iterable<String> tags) {
    for (final entry in _values.entries) {
      final tag = entry.key;
      final required = entry.value;
      final present = tags.contains(tag);
      if (required && !present) return false;
      if (!required && present) return false;
    }
    return true;
  }

  /// Toggles [tag] between required and absent status.
  TagsPredicate toggleRequired(String tag) {
    final current = _values[tag];
    return _change(tag, current == null ? true : null);
  }

  TagsPredicate _change(String tag, bool? value) {
    final current = _values[tag];
    if (current == value) {
      return this;
    }
    final newValues = Map<String, bool>.of(_values);
    if (value == null) {
      newValues.remove(tag);
    } else {
      newValues[tag] = value;
    }
    return TagsPredicate._(newValues);
  }

  /// Returns the list of tag values that can be passed to search service URL.
  List<String> toQueryParameters() {
    return _values.entries.map((e) => e.value ? e.key : '-${e.key}').toList();
  }
}

class ParsedQueryText {
  final String? text;
  final String? packagePrefix;

  /// Dependency match for direct or dev dependency.
  final List<String> refDependencies;

  /// Dependency match for all dependencies, including transitive ones.
  final List<String> allDependencies;

  /// Detected tags in the user-provided query.
  TagsPredicate tagsPredicate;

  final SearchOrder? order;

  ParsedQueryText._(
    this.text,
    this.packagePrefix,
    this.refDependencies,
    this.allDependencies,
    this.tagsPredicate,
    this.order,
  );

  factory ParsedQueryText.parse(String? q) {
    String? queryText = q ?? '';
    queryText = ' $queryText ';
    String? packagePrefix;
    final Match? pkgMatch = _packageRegexp.firstMatch(queryText);
    if (pkgMatch != null) {
      packagePrefix = pkgMatch.group(1);
      queryText = queryText.replaceFirst(_packageRegexp, ' ');
    }

    List<String> extractRegExp(RegExp regExp, {bool Function(String?)? where}) {
      final values = regExp
          .allMatches(queryText!)
          .map((Match m) => m.group(1))
          .where((s) => where == null || where(s))
          .cast<String>()
          .toList();
      if (values.isNotEmpty) {
        queryText = queryText!.replaceAll(regExp, ' ');
      }
      return values;
    }

    final List<String> dependencies = extractRegExp(_refDependencyRegExp);
    final List<String> allDependencies = extractRegExp(_allDependencyRegExp);
    final orderValues = extractRegExp(_sortRegExp);
    final order =
        orderValues.isEmpty ? null : parseSearchOrder(orderValues.last);

    final tagValues = extractRegExp(
      _tagRegExp,
      where: (tag) => _detectedTagPrefixes.any((p) => tag!.startsWith(p)),
    );
    final tagsPredicate = TagsPredicate.parseQueryValues(tagValues);

    queryText = queryText!.replaceAll(_whitespacesRegExp, ' ').trim();
    if (queryText!.isEmpty) {
      queryText = null;
    }

    return ParsedQueryText._(
      queryText,
      packagePrefix,
      dependencies,
      allDependencies,
      tagsPredicate,
      order,
    );
  }

  ParsedQueryText change({
    TagsPredicate? tagsPredicate,
  }) {
    return ParsedQueryText._(
      text,
      packagePrefix,
      refDependencies,
      allDependencies,
      tagsPredicate ?? this.tagsPredicate,
      order,
    );
  }

  bool get hasAnyDependency =>
      refDependencies.isNotEmpty || allDependencies.isNotEmpty;

  bool get hasOnlyFreeText =>
      text != null &&
      text!.isNotEmpty &&
      packagePrefix == null &&
      !hasAnyDependency &&
      tagsPredicate.isEmpty;

  @override
  String toString() {
    if (hasOnlyFreeText) return text!;
    return <String>[
      if (packagePrefix != null) 'package:$packagePrefix',
      ...refDependencies.map((d) => 'dependency:$d'),
      ...allDependencies.map((d) => 'dependency*:$d'),
      ...tagsPredicate.toQueryParameters(),
      if (order != null) 'sort:${order!.name}',
      if (text != null && text!.isNotEmpty) text!,
    ].join(' ');
  }
}

/// The <form> data from the app frontend.
class SearchForm {
  final String? query;
  late final parsedQuery = ParsedQueryText.parse(query);

  final SearchOrder? order;

  /// The visible index of the current page (and offset position).
  /// Starts with 1.
  final int? currentPage;

  /// The number of search results per page.
  final int? pageSize;

  SearchForm._({
    this.query,
    this.order,
    this.currentPage,
    this.pageSize,
  });

  factory SearchForm({
    String? query,
    SearchOrder? order,
    int? currentPage,
    int? pageSize,
  }) {
    currentPage ??= 1;
    pageSize ??= resultsPerPage;
    final q = _stringToNull(query?.trim());
    return SearchForm._(
      query: q,
      order: order,
      currentPage: currentPage,
      pageSize: pageSize,
    );
  }

  /// Parses the search query URL queryParameters for the parameters we expose on
  /// the frontend. The parameters and the values may be different from the ones
  /// we use in the search service backend.
  factory SearchForm.parse(Map<String, String> queryParameters) {
    return SearchForm(
      query: queryParameters['q'] ?? '',
      order: parseSearchOrder(queryParameters['sort']),
      currentPage: extractPageFromUrlParameters(queryParameters),
    );
  }

  SearchForm change({String? query}) {
    return SearchForm._(
      query: query ?? this.query,
      order: order,
      currentPage: currentPage,
      pageSize: pageSize,
    );
  }

  SearchForm toggleRequiredTag(String tag) {
    return change(
      query: parsedQuery
          .change(tagsPredicate: parsedQuery.tagsPredicate.toggleRequired(tag))
          .toString(),
    );
  }

  SearchForm addRequiredTagIfAbsent(String tag) {
    if (parsedQuery.tagsPredicate.hasTag(tag)) {
      return this;
    } else {
      return change(
        query: parsedQuery
            .change(
                tagsPredicate: parsedQuery.tagsPredicate.toggleRequired(tag))
            .toString(),
      );
    }
  }

  bool get hasQuery => query != null && query!.isNotEmpty;

  /// The zero-indexed offset for the search results.
  int get offset => (currentPage! - 1) * pageSize!;

  /// Whether any of the license options may be active.
  bool get hasActiveLicense =>
      parsedQuery.tagsPredicate.hasTagPrefix('license:');

  /// Whether any of the advanced options is active.
  bool get hasActiveAdvanced =>
      parsedQuery.tagsPredicate.hasTag(PackageTags.isFlutterFavorite) ||
      parsedQuery.tagsPredicate.hasTag(PackageTags.showUnlisted) ||
      parsedQuery.tagsPredicate.hasTag(PackageVersionTags.isNullSafe) ||
      parsedQuery.tagsPredicate.hasTag(PackageVersionTags.hasScreenshot) ||
      parsedQuery.tagsPredicate.hasTag(PackageVersionTags.isDart3Compatible) ||
      parsedQuery.tagsPredicate.hasTag(PackageVersionTags.isPlugin) ||
      parsedQuery.tagsPredicate.hasTag(PackageVersionTags.isWasmReady);

  /// Whether any of the non-query settings are non-default
  /// (e.g. clicking on any platforms, SDKs, or advanced filters).
  bool get hasActiveNonQuery => parsedQuery.tagsPredicate.isNotEmpty;

  /// Wether the form has anything other than default values.
  bool get isNotEmpty =>
      hasQuery || order != null || (currentPage != null && currentPage != 1);

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
      path: '/packages',
      queryParameters: params.isEmpty ? null : params,
    ).toString();
  }
}

String? _stringToNull(String? v) => (v == null || v.isEmpty) ? null : v;
