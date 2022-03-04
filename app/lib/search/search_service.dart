// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' show max;

import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';

import '../shared/tags.dart';

part 'search_service.g.dart';

const int _minSearchLimit = 10;
const int searchIndexNotReadyCode = 600;
const String searchIndexNotReadyText = 'Not ready yet.';

/// The number of packages we are going to display on a search page.
const int resultsPerPage = 10;

/// The number of page links we display, e.g. on page 10, we display direct
/// links from page 5 to page 15.
const int maxPageLinks = 10;

/// The maximum length of the search query's text phrase that we'll try to serve.
const _maxQueryLength = 256;

/// Statistics about the index content.
class IndexInfo {
  final bool isReady;
  final int packageCount;
  final DateTime? lastUpdated;
  final List<String> updatedPackages;

  IndexInfo({
    required this.isReady,
    required this.packageCount,
    required this.lastUpdated,
    required this.updatedPackages,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'isReady': isReady,
        'packageCount': packageCount,
        'lastUpdated': lastUpdated?.toIso8601String(),
        if (lastUpdated != null)
          'lastUpdateDelta': clock.now().difference(lastUpdated!).toString(),
        'updatedPackages': updatedPackages,
      };
}

/// Package search index and lookup.
abstract class PackageIndex {
  Future<void> addPackage(PackageDocument doc);
  Future<void> addPackages(Iterable<PackageDocument> documents);
  Future<void> removePackage(String package);
  Future<PackageSearchResult> search(ServiceSearchQuery query);

  /// A package index may be accessed while the initialization phase is still
  /// running. Once the initialization is done (either via a snapshot or a
  /// `Package`-scan completes), the updater should call this method to indicate
  /// to the frontend load-balancer that the instance now accepts requests.
  Future<void> markReady();
  Future<IndexInfo> indexInfo();
}

/// A summary information about a package that goes into the search index.
///
/// It is also part of the data structure returned by a search query, except for
/// the [readme] and [popularity] fields, which are excluded when returning the
/// results.
@JsonSerializable()
class PackageDocument {
  final String package;
  final String? version;
  final String? description;
  final DateTime? created;
  final DateTime? updated;
  final String? readme;

  final List<String> tags;

  final double? popularity;
  final int? likeCount;

  final int? grantedPoints;
  final int? maxPoints;

  final Map<String, String> dependencies;

  /// The publisher id of the package
  final String? publisherId;

  final List<ApiDocPage>? apiDocPages;

  /// The creation timestamp of this document.
  final DateTime timestamp;

  PackageDocument({
    required this.package,
    this.version,
    this.description,
    this.created,
    this.updated,
    this.readme = '',
    List<String>? tags,
    this.popularity = 0,
    this.likeCount = 0,
    this.grantedPoints = 0,
    this.maxPoints = 0,
    this.dependencies = const {},
    this.publisherId,
    this.apiDocPages = const [],
    DateTime? timestamp,
  })  : tags = tags ?? const <String>[],
        timestamp = timestamp ?? clock.now();

  factory PackageDocument.fromJson(Map<String, dynamic> json) =>
      _$PackageDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDocumentToJson(this);
}

/// A reference to an API doc page
@JsonSerializable()
class ApiDocPage {
  final String relativePath;
  final List<String>? symbols;
  final List<String>? textBlocks;

  ApiDocPage({
    required this.relativePath,
    this.symbols,
    this.textBlocks,
  });

  factory ApiDocPage.fromJson(Map<String, dynamic> json) =>
      _$ApiDocPageFromJson(json);

  Map<String, dynamic> toJson() => _$ApiDocPageToJson(this);
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

final RegExp _whitespacesRegExp = RegExp(r'\s+');
final RegExp _packageRegexp =
    RegExp('package:([_a-z0-9]+)', caseSensitive: false);
final RegExp _publisherRegexp =
    RegExp(r'publisher:([_a-z0-9\.]+)', caseSensitive: false);
final RegExp _refDependencyRegExp =
    RegExp('dependency:([_a-z0-9]+)', caseSensitive: false);
final RegExp _allDependencyRegExp =
    RegExp(r'dependency\*:([_a-z0-9]+)', caseSensitive: false);
final _tagRegExp =
    RegExp(r'([\+|\-]?[a-z0-9]+:[a-z0-9\-_\.]+)', caseSensitive: false);

String? _stringToNull(String? v) => (v == null || v.isEmpty) ? null : v;

class ServiceSearchQuery {
  final String? query;
  final ParsedQueryText parsedQuery;
  final TagsPredicate tagsPredicate;

  final String? publisherId;

  final int? minPoints;
  final int? updatedInDays;

  final SearchOrder? order;
  final int? offset;
  final int? limit;

  ServiceSearchQuery._({
    this.query,
    TagsPredicate? tagsPredicate,
    String? publisherId,
    required this.minPoints,
    this.updatedInDays,
    this.order,
    this.offset,
    this.limit,
  })  : parsedQuery = ParsedQueryText.parse(query),
        tagsPredicate = tagsPredicate ?? TagsPredicate(),
        publisherId = _stringToNull(publisherId);

  factory ServiceSearchQuery.parse({
    String? query,
    TagsPredicate? tagsPredicate,
    String? publisherId,
    SearchOrder? order,
    int? minPoints,
    int? updatedInDays,
    int offset = 0,
    int? limit = 10,
  }) {
    final q = _stringToNull(query?.trim());
    return ServiceSearchQuery._(
      query: q,
      tagsPredicate: tagsPredicate,
      publisherId: publisherId,
      minPoints: minPoints,
      updatedInDays: updatedInDays,
      order: order,
      offset: offset,
      limit: limit,
    );
  }

  factory ServiceSearchQuery.fromServiceUrl(Uri uri) {
    final q = uri.queryParameters['q'];
    final tagsPredicate =
        TagsPredicate.parseQueryValues(uri.queryParametersAll['tags']);
    final publisherId = uri.queryParameters['publisherId'];
    final String? orderValue = uri.queryParameters['order'];
    final SearchOrder? order = parseSearchOrder(orderValue);

    final minPoints =
        int.tryParse(uri.queryParameters['minPoints'] ?? '0') ?? 0;
    final updatedInDays =
        int.tryParse(uri.queryParameters['updatedInDays'] ?? '');
    final offset = int.tryParse(uri.queryParameters['offset'] ?? '0') ?? 0;
    final limit = int.tryParse(uri.queryParameters['limit'] ?? '0') ?? 0;

    return ServiceSearchQuery.parse(
      query: q,
      tagsPredicate: tagsPredicate,
      publisherId: publisherId,
      order: order,
      minPoints: minPoints,
      updatedInDays: updatedInDays,
      offset: max(0, offset),
      limit: max(_minSearchLimit, limit),
    );
  }

  ServiceSearchQuery change({
    String? query,
    TagsPredicate? tagsPredicate,
    String? publisherId,
    SearchOrder? order,
    int? offset,
    int? limit,
  }) {
    return ServiceSearchQuery._(
      query: query ?? this.query,
      tagsPredicate: tagsPredicate ?? this.tagsPredicate,
      publisherId: publisherId ?? this.publisherId,
      order: order ?? this.order,
      minPoints: minPoints,
      updatedInDays: updatedInDays,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toUriQueryParameters() {
    final map = <String, dynamic>{
      'q': query,
      'tags': tagsPredicate.toQueryParameters(),
      'publisherId': publisherId,
      'offset': offset?.toString(),
      if (minPoints != null && minPoints! > 0)
        'minPoints': minPoints.toString(),
      if (updatedInDays != null && updatedInDays! > 0)
        'updatedInDays': updatedInDays.toString(),
      'limit': limit?.toString(),
      'order': order?.name,
    };
    map.removeWhere((k, v) => v == null);
    return map;
  }

  bool get _hasQuery => query != null && query!.isNotEmpty;
  bool get _hasOnlyFreeText => _hasQuery && parsedQuery.hasOnlyFreeText;
  bool get _isNaturalOrder =>
      order == null || order == SearchOrder.top || order == SearchOrder.text;
  bool get _hasNoOwnershipScope => publisherId == null;
  bool get _isFlutterFavorite =>
      tagsPredicate.hasTag(PackageTags.isFlutterFavorite);

  bool get includeSdkResults =>
      offset == 0 &&
      _hasOnlyFreeText &&
      _isNaturalOrder &&
      _hasNoOwnershipScope &&
      !_isFlutterFavorite;

  bool get considerHighlightedHit => _hasOnlyFreeText && _hasNoOwnershipScope;
  bool get includeHighlightedHit => considerHighlightedHit && offset == 0;

  /// Returns the validity status of the query.
  QueryValidity evaluateValidity() {
    // Block search on unreasonably long search queries (when the free-form
    // text part is longer than one would enter via the search input field).
    final queryLength = parsedQuery.text?.length ?? 0;
    if (queryLength > _maxQueryLength) {
      return QueryValidity.reject(rejectReason: 'Query too long.');
    }

    return QueryValidity.accept();
  }
}

class QueryValidity {
  final String? rejectReason;

  QueryValidity.accept() : rejectReason = null;
  QueryValidity.reject({required this.rejectReason});

  bool get isRejected => rejectReason != null;
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
      if (required) {
        p._values[tag] = true;
      } else {
        p._values[tag] = false;
      }
    }
    return p;
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
  bool matches(List<String> tags) {
    for (String? tag in _values.keys) {
      final present = tags.contains(tag);
      final required = _values[tag]!;
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
    final newValues = Map<String, bool>.from(_values);
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

  /// Match the publisher of the package.
  final String? publisher;

  /// Detected tags in the user-provided query.
  TagsPredicate tagsPredicate;

  ParsedQueryText._(
    this.text,
    this.packagePrefix,
    this.refDependencies,
    this.allDependencies,
    this.publisher,
    this.tagsPredicate,
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

    List<String> extractRegExp(RegExp regExp) {
      final values = regExp
          .allMatches(queryText!)
          .map((Match m) => m.group(1))
          .cast<String>()
          .toList();
      if (values.isNotEmpty) {
        queryText = queryText!.replaceAll(regExp, ' ');
      }
      return values;
    }

    final List<String> dependencies = extractRegExp(_refDependencyRegExp);
    final List<String> allDependencies = extractRegExp(_allDependencyRegExp);
    final allPublishers = extractRegExp(_publisherRegexp);
    final publisher = allPublishers.isEmpty ? null : allPublishers.first;

    final tagValues = extractRegExp(_tagRegExp);
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
      publisher,
      tagsPredicate,
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
      publisher,
      tagsPredicate ?? this.tagsPredicate,
    );
  }

  bool get hasAnyDependency =>
      refDependencies.isNotEmpty || allDependencies.isNotEmpty;

  bool get hasOnlyFreeText =>
      text != null &&
      text!.isNotEmpty &&
      packagePrefix == null &&
      !hasAnyDependency &&
      publisher == null &&
      tagsPredicate.isEmpty;

  @override
  String toString() {
    if (hasOnlyFreeText) return text!;
    return <String>[
      if (packagePrefix != null) 'package:$packagePrefix',
      ...refDependencies.map((d) => 'dependency:$d'),
      ...allDependencies.map((d) => 'dependency*:$d'),
      if (publisher != null) 'publisher:$publisher',
      ...tagsPredicate.toQueryParameters(),
      if (text != null && text!.isNotEmpty) text!,
    ].join(' ');
  }
}

@JsonSerializable(includeIfNull: false)
class PackageSearchResult {
  final DateTime? timestamp;
  final int totalCount;
  final PackageHit? highlightedHit;
  final List<SdkLibraryHit> sdkLibraryHits;
  final List<PackageHit> packageHits;

  /// An optional message from the search service / client library, in case
  /// the query was not processed entirely.
  final String? message;

  PackageSearchResult({
    required this.timestamp,
    required this.totalCount,
    this.highlightedHit,
    List<SdkLibraryHit>? sdkLibraryHits,
    List<PackageHit>? packageHits,
    this.message,
  })  : sdkLibraryHits = sdkLibraryHits ?? <SdkLibraryHit>[],
        packageHits = packageHits ?? <PackageHit>[];

  PackageSearchResult.empty({this.message})
      : timestamp = clock.now().toUtc(),
        totalCount = 0,
        highlightedHit = null,
        sdkLibraryHits = <SdkLibraryHit>[],
        packageHits = <PackageHit>[];

  factory PackageSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PackageSearchResultFromJson(json);

  Duration get age => clock.now().difference(timestamp!);

  Map<String, dynamic> toJson() => _$PackageSearchResultToJson(this);

  /// Lists all package hits, including the highlighted hit (if there is any).
  Iterable<PackageHit> get allPackageHits sync* {
    if (highlightedHit != null) yield highlightedHit!;
    if (packageHits.isNotEmpty) yield* packageHits;
  }

  bool get isEmpty =>
      highlightedHit == null && packageHits.isEmpty && sdkLibraryHits.isEmpty;
}

@JsonSerializable(includeIfNull: false)
class SdkLibraryHit {
  final String? sdk;
  final String? version;
  final String? library;
  final String? description;
  final String? url;
  final double score;
  final List<ApiPageRef>? apiPages;

  SdkLibraryHit({
    required this.sdk,
    required this.version,
    required this.library,
    required this.description,
    required this.url,
    required this.score,
    required this.apiPages,
  });

  factory SdkLibraryHit.fromJson(Map<String, dynamic> json) =>
      _$SdkLibraryHitFromJson(json);

  Map<String, dynamic> toJson() => _$SdkLibraryHitToJson(this);
}

@JsonSerializable(includeIfNull: false)
class PackageHit {
  final String package;
  final double? score;
  final List<ApiPageRef>? apiPages;

  PackageHit({
    required this.package,
    this.score,
    this.apiPages,
  });

  factory PackageHit.fromJson(Map<String, dynamic> json) =>
      _$PackageHitFromJson(json);

  Map<String, dynamic> toJson() => _$PackageHitToJson(this);

  PackageHit change({List<ApiPageRef>? apiPages}) {
    return PackageHit(
      package: package,
      score: score,
      apiPages: apiPages ?? this.apiPages,
    );
  }
}

@JsonSerializable()
class ApiPageRef {
  final String? title;
  final String? path;

  @JsonKey(includeIfNull: false)
  final String? url;

  ApiPageRef({this.title, this.path, this.url});

  factory ApiPageRef.fromJson(Map<String, dynamic> json) =>
      _$ApiPageRefFromJson(json);

  ApiPageRef change({String? title, String? url}) {
    return ApiPageRef(
      title: title ?? this.title,
      path: path,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toJson() => _$ApiPageRefToJson(this);
}

/// Extracts the 'page' query parameter from requested URL's [queryParameters].
///
/// Returns a valid positive integer.
int extractPageFromUrlParameters(Map<String, String> queryParameters) {
  final pageAsString = queryParameters['page'];
  final pageAsInt = int.tryParse(pageAsString ?? '1') ?? 1;
  return max(pageAsInt, 1);
}

abstract class DependencyTypes {
  static const dev = 'dev';
  static const direct = 'direct';
  static const transitive = 'transitive';
}
