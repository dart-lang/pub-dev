// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' show max;

import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../shared/tags.dart';
import '../shared/urls.dart';

part 'search_service.g.dart';

const int _minSearchLimit = 10;
const int searchIndexNotReadyCode = 600;
const String searchIndexNotReadyText = 'Not ready yet.';

/// The number of packages we are going to display on a search page.
const int resultsPerPage = 10;

/// The number of page links we display, e.g. on page 10, we display direct
/// links from page 5 to page 15.
const int maxPages = 10;

/// The maximum length of the search query's text phrase that we'll try to serve.
const _maxQueryLength = 256;

/// The tag prefixes that we can detect in the user-provided search query.
final _detectedTagPrefixes = <String>{
  ...allowedTagPrefixes.expand((s) => [s, '-$s', '+$s']),
};

final _logger = Logger('search.search_service');

/// Statistics about the index content.
class IndexInfo {
  final bool isReady;
  final int packageCount;
  final DateTime lastUpdated;

  IndexInfo({
    @required this.isReady,
    @required this.packageCount,
    @required this.lastUpdated,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'isReady': isReady,
        'packageCount': packageCount,
        'lastUpdated': lastUpdated?.toIso8601String(),
        if (lastUpdated != null)
          'lastUpdateDelta': DateTime.now().difference(lastUpdated).toString(),
      };
}

/// Package search index and lookup.
abstract class PackageIndex {
  Future<void> addPackage(PackageDocument doc);
  Future<void> addPackages(Iterable<PackageDocument> documents);
  Future<void> removePackage(String package);
  Future<PackageSearchResult> search(SearchQuery query);

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
  final String version;
  final String description;
  final DateTime created;
  final DateTime updated;
  final String readme;

  final List<String> tags;

  final double popularity;
  final int likeCount;

  final int grantedPoints;
  final int maxPoints;

  final Map<String, String> dependencies;

  /// The publisher id of the package
  final String publisherId;

  /// The current uploader emails of the package.
  final List<String> uploaderEmails;

  final List<ApiDocPage> apiDocPages;

  /// The creation timestamp of this document.
  final DateTime timestamp;

  PackageDocument({
    this.package,
    this.version,
    this.description,
    this.created,
    this.updated,
    this.readme = '',
    List<String> tags,
    this.popularity = 0,
    this.likeCount = 0,
    this.grantedPoints = 0,
    this.maxPoints = 0,
    this.dependencies = const {},
    this.publisherId,
    this.uploaderEmails = const [],
    this.apiDocPages = const [],
    DateTime timestamp,
  })  : tags = tags ?? const <String>[],
        timestamp = timestamp ?? DateTime.now();

  factory PackageDocument.fromJson(Map<String, dynamic> json) =>
      _$PackageDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDocumentToJson(this);
}

/// A reference to an API doc page
@JsonSerializable()
class ApiDocPage {
  final String relativePath;
  final List<String> symbols;
  final List<String> textBlocks;

  ApiDocPage({this.relativePath, this.symbols, this.textBlocks});

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
SearchOrder parseSearchOrder(String value) {
  if (value == null) {
    return null;
  }
  switch (value) {
    case 'top':
      return SearchOrder.top;
    case 'text':
      return SearchOrder.text;
    case 'created':
      return SearchOrder.created;
    case 'updated':
      return SearchOrder.updated;
    case 'popularity':
      return SearchOrder.popularity;
    case 'like':
      return SearchOrder.like;
    case 'points':
      return SearchOrder.points;
  }
  return null;
}

String serializeSearchOrder(SearchOrder order) {
  if (order == null) return null;
  return order.toString().split('.').last;
}

final RegExp _whitespacesRegExp = RegExp(r'\s+');
final RegExp _packageRegexp =
    RegExp('package:([_a-z0-9]+)', caseSensitive: false);
final RegExp _publisherRegexp =
    RegExp(r'publisher:([_a-z0-9\.]+)', caseSensitive: false);
final RegExp _emailRegexp =
    RegExp(r'email:([_a-z0-9\@\-\.\+]+)', caseSensitive: false);
final RegExp _refDependencyRegExp =
    RegExp('dependency:([_a-z0-9]+)', caseSensitive: false);
final RegExp _allDependencyRegExp =
    RegExp(r'dependency\*:([_a-z0-9]+)', caseSensitive: false);
final _tagRegExp =
    RegExp(r'([\+|\-]?[a-z0-9]+:[a-z0-9\-_\.]+)', caseSensitive: false);

String _stringToNull(String v) => (v == null || v.isEmpty) ? null : v;
List<String> _listToNull(List<String> list) =>
    (list == null || list.isEmpty) ? null : list;

class SearchQuery {
  final String query;
  final ParsedQuery parsedQuery;

  final TagsPredicate tagsPredicate;

  /// The query will match packages where the owners of the package have
  /// non-empty intersection with the provided list of owners.
  ///
  /// Values of this list can be email addresses (usually a single on) or
  /// publisher ids (may be multiple).
  final List<String> uploaderOrPublishers;

  final String publisherId;
  final SearchOrder order;
  final int offset;
  final int limit;

  /// True, if packages with is:unlisted tag should be included.
  /// This parameter is set and used only on the frontend service, not on search.
  final bool includeUnlisted;

  /// True, if packages which only support dart 1.x should be included.
  final bool includeLegacy;

  SearchQuery._({
    this.query,
    TagsPredicate tagsPredicate,
    List<String> uploaderOrPublishers,
    String publisherId,
    this.order,
    this.offset,
    this.limit,
    this.includeUnlisted,
    this.includeLegacy,
  })  : parsedQuery = ParsedQuery._parse(query),
        tagsPredicate = tagsPredicate ?? TagsPredicate(),
        uploaderOrPublishers = _listToNull(uploaderOrPublishers),
        publisherId = _stringToNull(publisherId);

  factory SearchQuery.parse({
    String query,
    String sdk,
    List<String> runtimes,
    List<String> platforms,
    TagsPredicate tagsPredicate,
    List<String> uploaderOrPublishers,
    String publisherId,
    SearchOrder order,
    int offset = 0,
    int limit = 10,
    bool includeUnlisted = false,
    bool includeLegacy = false,
  }) {
    final q = _stringToNull(query?.trim());
    tagsPredicate ??= TagsPredicate();
    final requiredTags = <String>[];
    if (sdk != null && sdk != SdkTagValue.any) {
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
    return SearchQuery._(
      query: q,
      tagsPredicate: tagsPredicate,
      uploaderOrPublishers: uploaderOrPublishers,
      publisherId: publisherId,
      order: order,
      offset: offset,
      limit: limit,
      includeUnlisted: includeUnlisted,
      includeLegacy: includeLegacy,
    );
  }

  factory SearchQuery.fromServiceUrl(Uri uri) {
    final q = uri.queryParameters['q'];
    final tagsPredicate =
        TagsPredicate.parseQueryValues(uri.queryParametersAll['tags']);
    final uploaderOrPublishers = uri.queryParametersAll['uploaderOrPublishers'];
    final publisherId = uri.queryParameters['publisherId'];
    final String orderValue = uri.queryParameters['order'];
    final SearchOrder order = parseSearchOrder(orderValue);

    final offset = int.tryParse(uri.queryParameters['offset'] ?? '0') ?? 0;
    final limit = int.tryParse(uri.queryParameters['limit'] ?? '0') ?? 0;

    return SearchQuery.parse(
      query: q,
      tagsPredicate: tagsPredicate,
      uploaderOrPublishers: uploaderOrPublishers,
      publisherId: publisherId,
      order: order,
      offset: max(0, offset),
      limit: max(_minSearchLimit, limit),
      includeLegacy: uri.queryParameters['legacy'] == '1',
    );
  }

  SearchQuery change({
    String query,
    String sdk,
    TagsPredicate tagsPredicate,
    List<String> uploaderOrPublishers,
    String publisherId,
    SearchOrder order,
    int offset,
    int limit,
    bool includeLegacy,
    bool randomize,
  }) {
    if (sdk != null) {
      tagsPredicate ??= TagsPredicate();
      tagsPredicate = tagsPredicate.removePrefix('sdk:');
      if (sdk != SdkTagValue.any) {
        tagsPredicate = tagsPredicate
            .appendPredicate(TagsPredicate(requiredTags: ['sdk:$sdk']));
      }
    }
    return SearchQuery._(
      query: query ?? this.query,
      tagsPredicate: tagsPredicate ?? this.tagsPredicate,
      uploaderOrPublishers: uploaderOrPublishers ?? this.uploaderOrPublishers,
      publisherId: publisherId ?? this.publisherId,
      order: order ?? this.order,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      includeUnlisted: includeUnlisted,
      includeLegacy: includeLegacy ?? this.includeLegacy,
    );
  }

  Map<String, dynamic> toServiceQueryParameters() {
    var tagsPredicate = this.tagsPredicate;
    if (includeUnlisted &&
        tagsPredicate.isProhibitedTag(PackageTags.isUnlisted)) {
      tagsPredicate = tagsPredicate.withoutTag(PackageTags.isUnlisted);
    }
    if (includeLegacy &&
        tagsPredicate.isProhibitedTag(PackageVersionTags.isLegacy)) {
      tagsPredicate = tagsPredicate.withoutTag(PackageVersionTags.isLegacy);
    }
    final map = <String, dynamic>{
      'q': query,
      'tags': tagsPredicate.toQueryParameters(),
      'uploaderOrPublishers': uploaderOrPublishers,
      'publisherId': publisherId,
      'offset': offset?.toString(),
      'limit': limit?.toString(),
      'order': serializeSearchOrder(order),
      // TODO: remove after search backend no longer depends on it
      'legacy': '1',
    };
    map.removeWhere((k, v) => v == null);
    return map;
  }

  bool get hasQuery => query != null && query.isNotEmpty;

  String get sdk {
    final values = tagsPredicate._values.entries
        .where((e) => e.key.startsWith('sdk:') && e.value == true)
        .map((e) => e.key.split(':')[1]);
    return values.isEmpty ? null : values.first;
  }

  /// Returns the validity status of the query.
  QueryValidity evaluateValidity() {
    // Block search on unreasonably long search queries (when the free-form
    // text part is longer than one would enter via the search input field).
    final queryLength = parsedQuery?.text?.length ?? 0;
    if (queryLength > _maxQueryLength) {
      return QueryValidity.reject(rejectReason: 'Query too long.');
    }

    // Consolidate the query to the state that the search service backend will
    // recieve:
    final backendQuery = SearchQuery.fromServiceUrl(
        Uri(queryParameters: toServiceQueryParameters()));

    // Do not allow override of search filter tags. (E.g. search scope would
    // require sdk:flutter, do not allow -sdk:flutter to override it).
    final conflictingTags = backendQuery.tagsPredicate
        ._getConflictingTags(backendQuery.parsedQuery.tagsPredicate);
    if (conflictingTags.isNotEmpty) {
      return QueryValidity.reject(
          rejectReason:
              'Tag conflict with search filters: `${conflictingTags.join(', ')}`.');
    }
    return QueryValidity.accept();
  }

  /// Converts the query to a user-facing link that the search form can use as
  /// the base path of its `action` parameter.
  String toSearchFormPath() {
    String path = '/packages';
    if (sdk != null) {
      path = '/$sdk/packages';
    }
    if (tagsPredicate.isRequiredTag('is:flutter-favorite')) {
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
    final params = <String, dynamic>{};
    if (query != null && query.isNotEmpty) {
      params['q'] = query;
    }
    params.addAll(tagsPredicate.asSearchLinkParams());
    if (order != null) {
      final String paramName = 'sort';
      params[paramName] = serializeSearchOrder(order);
    }
    if (includeUnlisted) {
      params['unlisted'] = '1';
    }
    if (includeLegacy) {
      params['legacy'] = '1';
    }
    if (page != null && page > 1) {
      params['page'] = page.toString();
    }
    final path = toSearchFormPath();
    if (params.isEmpty) {
      return path;
    } else {
      return Uri(path: path, queryParameters: params).toString();
    }
  }
}

class QueryValidity {
  final String rejectReason;

  QueryValidity.accept() : rejectReason = null;
  QueryValidity.reject({@required this.rejectReason});

  bool get isRejected => rejectReason != null;
}

/// Filter conditions on tags.
class TagsPredicate {
  /// tag -> {true = required | false = prohibited}
  final _values = <String, bool>{};

  TagsPredicate({List<String> requiredTags, List<String> prohibitedTags}) {
    requiredTags?.forEach((tag) => _values[tag] = true);
    prohibitedTags?.forEach((tag) => _values[tag] = false);
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

  factory TagsPredicate.advertisement({List<String> requiredTags}) =>
      TagsPredicate(
        prohibitedTags: [
          PackageTags.isDiscontinued,
          PackageTags.isUnlisted,
          PackageTags.isNotAdvertized,
          PackageVersionTags.isLegacy,
        ],
        requiredTags: requiredTags,
      );

  /// Pre-populates the predicate with the default tags for all package listings
  /// (e.g. "My packages").
  factory TagsPredicate.allPackages() => TagsPredicate();

  bool get isNotEmpty => _values.isNotEmpty;

  bool isRequiredTag(String tag) => _values[tag] == true;
  bool isProhibitedTag(String tag) => _values[tag] == false;
  bool hasTag(String tag) => _values.containsKey(tag);

  /// Parses [values] passed via Uri.queryParameters
  factory TagsPredicate.parseQueryValues(List<String> values) {
    final p = TagsPredicate();
    for (String tag in values ?? const <String>[]) {
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

  /// Returns the list of tags that override the current tag predicates.
  ///
  /// Returns an empty list when no tags overrides an existing value.
  List<String> _getConflictingTags(TagsPredicate other) {
    final tags = <String>[];
    for (final e in other._values.entries) {
      if (_values.containsKey(e.key) &&
          _values[e.key] != other._values[e.key]) {
        tags.add(e.key);
      }
    }
    return tags;
  }

  /// Appends [other] predicate to the current set of tags, and returns a new
  /// [TagsPredicate] instance.
  ///
  /// If there are conflicting tag predicates, the [other] takes precedence over
  /// this [TagsPredicate].
  TagsPredicate appendPredicate(TagsPredicate other) {
    // Ideally we want to throw an ArgumentError here, but to make sure we don't
    // break the site, let's just log it first.
    // TODO: throw exception instead of logging
    final conflictingTags = _getConflictingTags(other);
    if (conflictingTags.isNotEmpty) {
      _logger.warning('Invalid append detected: ${conflictingTags.join(', ')}',
          StackTrace.current);
    }
    final p = TagsPredicate();
    p._values.addAll(_values);
    p._values.addAll(other._values);
    return p;
  }

  /// Create a new [TagsPredicate] from this [TagsPredicate] without any
  /// constraints on [tag].
  TagsPredicate withoutTag(String tag) {
    final p = TagsPredicate();
    p._values.addAll(_values);
    p._values.remove(tag);
    return p;
  }

  /// Creates a new instance with the current values except the ones starting
  /// with [prefix].
  TagsPredicate removePrefix(String prefix) {
    final p = TagsPredicate();
    _values.entries.forEach((e) {
      if (!e.key.startsWith(prefix)) {
        p._values[e.key] = e.value;
      }
    });
    return p;
  }

  /// Evaluate this predicate against the list of supplied [tags].
  /// Returns true if the predicate matches the [tags], false otherwise.
  bool matches(List<String> tags) {
    tags ??= const <String>[];
    for (String tag in _values.keys) {
      final present = tags.contains(tag);
      final required = _values[tag];
      if (required && !present) return false;
      if (!required && present) return false;
    }
    return true;
  }

  /// Returns the list of tag values that can be passed to search service URL.
  List<String> toQueryParameters() {
    return _values.entries.map((e) => e.value ? e.key : '-${e.key}').toList();
  }

  /// Returns the tag values that can be passed query parameters of the
  /// user-facing search query.
  Map<String, String> asSearchLinkParams() {
    final runtimeTagParts = tagPartsWithPrefix('runtime', value: true);
    final params = <String, String>{
      'runtime': DartSdkRuntime.encodeRuntimeTags(runtimeTagParts).join(' '),
      'platform': tagPartsWithPrefix('platform', value: true).join(' '),
    };
    params.removeWhere((k, v) => v.isEmpty);
    return params;
  }

  /// Returns the second part of the tags matching [prefix] and [value].
  List<String> tagPartsWithPrefix(String prefix, {bool value}) {
    return _values.keys
        .where((k) =>
            k.startsWith('$prefix:') && (value == null || _values[k] == value))
        .map((k) => k.substring(prefix.length + 1))
        .toList();
  }
}

class ParsedQuery {
  final String text;
  final String packagePrefix;

  /// Dependency match for direct or dev dependency.
  final List<String> refDependencies;

  /// Dependency match for all dependencies, including transitive ones.
  final List<String> allDependencies;

  /// Match the publisher of the package.
  final String publisher;

  /// Match uploader emails.
  final List<String> emails;

  /// Detected tags in the user-provided query.
  TagsPredicate tagsPredicate;

  ParsedQuery._(
    this.text,
    this.packagePrefix,
    this.refDependencies,
    this.allDependencies,
    this.publisher,
    this.emails,
    this.tagsPredicate,
  );

  factory ParsedQuery._parse(String q) {
    String queryText = q ?? '';
    queryText = ' $queryText ';
    String packagePrefix;
    final Match pkgMatch = _packageRegexp.firstMatch(queryText);
    if (pkgMatch != null) {
      packagePrefix = pkgMatch.group(1);
      queryText = queryText.replaceFirst(_packageRegexp, ' ');
    }

    List<String> extractRegExp(RegExp regExp, {bool Function(String) where}) {
      final values = regExp
          .allMatches(queryText)
          .map((Match m) => m.group(1))
          .where((s) => where == null || where(s))
          .toList();
      if (values.isNotEmpty) {
        queryText = queryText.replaceAll(regExp, ' ');
      }
      return values;
    }

    final List<String> dependencies = extractRegExp(_refDependencyRegExp);
    final List<String> allDependencies = extractRegExp(_allDependencyRegExp);
    final List<String> emails = extractRegExp(_emailRegexp);
    final allPublishers = extractRegExp(_publisherRegexp);
    final publisher = allPublishers.isEmpty ? null : allPublishers.first;

    final tagValues = extractRegExp(
      _tagRegExp,
      where: (tag) => _detectedTagPrefixes.any((p) => tag.startsWith(p)),
    );
    final tagsPredicate = TagsPredicate.parseQueryValues(tagValues);

    queryText = queryText.replaceAll(_whitespacesRegExp, ' ').trim();
    if (queryText.isEmpty) {
      queryText = null;
    }

    return ParsedQuery._(
      queryText,
      packagePrefix,
      dependencies,
      allDependencies,
      publisher,
      emails,
      tagsPredicate,
    );
  }

  bool get hasAnyDependency =>
      refDependencies.isNotEmpty || allDependencies.isNotEmpty;
}

@JsonSerializable(includeIfNull: false)
class PackageSearchResult {
  /// The last update of the search index.
  final DateTime indexUpdated;
  final DateTime timestamp;
  final int totalCount;
  final List<PackageScore> packages;

  /// An optional message from the search service / client library, in case
  /// the query was not processed entirely.
  final String message;

  PackageSearchResult({
    this.indexUpdated,
    @required this.timestamp,
    this.totalCount,
    List<PackageScore> packages,
    this.message,
  }) : packages = packages ?? [];

  PackageSearchResult.empty({this.message})
      : indexUpdated = null,
        timestamp = DateTime.now().toUtc(),
        totalCount = 0,
        packages = [];

  factory PackageSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PackageSearchResultFromJson(json);

  Duration get age => DateTime.now().difference(timestamp);

  /// Whether the search service has already updated its index after a startup.
  bool get isLegit => indexUpdated != null;

  Map<String, dynamic> toJson() => _$PackageSearchResultToJson(this);
}

@JsonSerializable()
class PackageScore {
  final String package;

  @JsonKey(includeIfNull: false)
  final double score;

  @JsonKey(includeIfNull: false)
  final String url;

  @JsonKey(includeIfNull: false)
  final String version;

  @JsonKey(includeIfNull: false)
  final String description;

  @JsonKey(includeIfNull: false)
  final List<ApiPageRef> apiPages;

  PackageScore({
    this.package,
    this.score,
    this.url,
    this.version,
    this.description,
    this.apiPages,
  });

  factory PackageScore.fromJson(Map<String, dynamic> json) =>
      _$PackageScoreFromJson(json);

  PackageScore change({
    double score,
    String url,
    String version,
    String description,
    List<ApiPageRef> apiPages,
  }) {
    return PackageScore(
      package: package,
      score: score ?? this.score,
      url: url ?? this.url,
      version: version ?? this.version,
      description: description ?? this.description,
      apiPages: apiPages ?? this.apiPages,
    );
  }

  PackageScore onlyPackageName() => PackageScore(package: package);

  bool get isExternal => url != null && version != null && description != null;

  Map<String, dynamic> toJson() => _$PackageScoreToJson(this);
}

@JsonSerializable()
class ApiPageRef {
  final String title;
  final String path;

  @JsonKey(includeIfNull: false)
  final String url;

  ApiPageRef({this.title, this.path, this.url});

  factory ApiPageRef.fromJson(Map<String, dynamic> json) =>
      _$ApiPageRefFromJson(json);

  ApiPageRef change({String title, String url}) {
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

/// Parses the search query URL queryParameters for the parameters we expose on
/// the frontend. The parameters and the values may be different from the ones
/// we use in the search service backend.
SearchQuery parseFrontendSearchQuery(
  Map<String, String> queryParameters, {
  String platform,
  String sdk,
  List<String> uploaderOrPublishers,
  String publisherId,
  @required TagsPredicate tagsPredicate,
}) {
  final int page = extractPageFromUrlParameters(queryParameters);
  final int offset = resultsPerPage * (page - 1);
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
  return SearchQuery.parse(
    query: queryText,
    sdk: sdk,
    runtimes: runtimes,
    platforms: platforms,
    uploaderOrPublishers: uploaderOrPublishers,
    publisherId: publisherId,
    order: sortOrder,
    offset: offset,
    limit: resultsPerPage,
    includeUnlisted: queryParameters['unlisted'] == '1',
    includeLegacy: queryParameters['legacy'] == '1',
    tagsPredicate: tagsPredicate,
  );
}
