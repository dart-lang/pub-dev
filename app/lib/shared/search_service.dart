// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides

import 'dart:async';
import 'dart:math' show max;

import 'package:json_annotation/json_annotation.dart';

part 'search_service.g.dart';

const int _minSearchLimit = 10;
const int searchIndexNotReadyCode = 600;
const String searchIndexNotReadyText = 'Not ready yet.';

/// Package search index and lookup.
abstract class PackageIndex {
  bool get isReady;
  Future<bool> containsPackage(String package,
      {String version, Duration maxAge});
  Future addPackage(PackageDocument doc);
  Future addPackages(Iterable<PackageDocument> documents);
  Future removePackage(String package);
  Future merge();
  Future<PackageSearchResult> search(SearchQuery query);
  Map<String, dynamic> get debugInfo;
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
  final String devVersion;
  final String description;
  final DateTime created;
  final DateTime updated;
  final String readme;
  final bool isDiscontinued;
  final bool doNotAdvertise;

  final List<String> platforms;

  final double health;
  final double popularity;
  final double maintenance;

  final Map<String, String> dependencies;
  final List<String> emails;

  final List<ApiDocPage> apiDocPages;

  /// The creation timestamp of this document.
  final DateTime timestamp;

  PackageDocument({
    this.package,
    this.version,
    this.devVersion,
    this.description,
    this.created,
    this.updated,
    this.readme,
    this.isDiscontinued,
    this.doNotAdvertise,
    this.platforms,
    this.health,
    this.popularity,
    this.maintenance,
    this.dependencies,
    this.emails,
    this.apiDocPages,
    this.timestamp,
  });

  factory PackageDocument.fromJson(Map<String, dynamic> json) =>
      _$PackageDocumentFromJson(json);

  PackageDocument intern(String internFn(String value)) {
    return new PackageDocument(
      package: internFn(package),
      version: version,
      devVersion: devVersion,
      description: description,
      created: created,
      updated: updated,
      readme: readme,
      isDiscontinued: isDiscontinued,
      doNotAdvertise: doNotAdvertise,
      platforms: platforms?.map(internFn)?.toList(),
      health: health,
      popularity: popularity,
      maintenance: maintenance,
      dependencies: dependencies == null
          ? null
          : new Map.fromIterable(
              dependencies.keys,
              key: (key) => internFn(key as String),
              value: (key) => internFn(dependencies[key]),
            ),
      emails: emails?.map(internFn)?.toList(),
      apiDocPages: apiDocPages?.map((p) => p.intern(internFn))?.toList(),
      timestamp: timestamp,
    );
  }

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

  ApiDocPage intern(String internFn(String value)) {
    return new ApiDocPage(
      relativePath: internFn(relativePath),
      symbols: symbols?.map(internFn)?.toList(),
      textBlocks: textBlocks,
    );
  }

  Map<String, dynamic> toJson() => _$ApiDocPageToJson(this);
}

/// How search results should be ordered.
enum SearchOrder {
  /// Search score should be a weighted value of [text], [popularity], [health]
  /// and [maintenance], ordered decreasing.
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

  /// Search order should be in decreasing health score.
  health,

  /// Search order should be in decreasing maintenance score.
  maintenance,
}

/// Returns null if [value] is not a recognized search order.
SearchOrder parseSearchOrder(String value, {SearchOrder defaultsTo}) {
  if (value != null) {
    switch (value) {
      // TODO: remove 'overall' after the prod services were migrated to the latest
      case 'overall':
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
      case 'health':
        return SearchOrder.health;
      case 'maintenance':
        return SearchOrder.maintenance;
    }
  }
  if (defaultsTo != null) return defaultsTo;
  throw new Exception('Unable to parse SearchOrder: $value');
}

String serializeSearchOrder(SearchOrder order) {
  if (order == null) return null;
  return order.toString().split('.').last;
}

final RegExp _whitespacesRegExp = new RegExp(r'\s+');
final RegExp _packageRegexp =
    new RegExp('package:([_a-z0-9]+)', caseSensitive: false);
final RegExp _emailRegexp =
    new RegExp(r'email:([_a-z0-9\@\-\.\+]+)', caseSensitive: false);
final RegExp _refDependencyRegExp =
    new RegExp('dependency:([_a-z0-9]+)', caseSensitive: false);
final RegExp _allDependencyRegExp =
    new RegExp(r'dependency\*:([_a-z0-9]+)', caseSensitive: false);

class SearchQuery {
  final String query;
  final ParsedQuery parsedQuery;
  final String platform;
  final SearchOrder order;
  final int offset;
  final int limit;
  final bool isAd;
  final bool isApiEnabled;

  SearchQuery._({
    this.query,
    String platform,
    this.order,
    this.offset,
    this.limit,
    this.isAd,
    this.isApiEnabled,
  })  : parsedQuery = new ParsedQuery._parse(query),
        platform = (platform == null || platform.isEmpty) ? null : platform;

  factory SearchQuery.parse({
    String query,
    String platform,
    SearchOrder order,
    int offset: 0,
    int limit: 10,
    bool isAd,
    bool apiEnabled,
  }) {
    final String q =
        query != null && query.trim().isNotEmpty ? query.trim() : null;
    return new SearchQuery._(
      query: q,
      platform: platform,
      order: order,
      offset: offset,
      limit: limit,
      isAd: isAd ?? false,
      isApiEnabled: apiEnabled ?? true,
    );
  }

  factory SearchQuery.fromServiceUrl(Uri uri) {
    final String q = uri.queryParameters['q'];
    final String platform =
        uri.queryParameters['platform'] ?? uri.queryParameters['platforms'];
    final String orderValue = uri.queryParameters['order'];
    final SearchOrder order =
        orderValue == null ? null : parseSearchOrder(orderValue);

    int offset = int.tryParse(uri.queryParameters['offset'] ?? '0') ?? 0;
    int limit = int.tryParse(uri.queryParameters['limit'] ?? '0') ?? 0;
    offset = max(0, offset);
    limit = max(_minSearchLimit, limit);

    final isAd = (uri.queryParameters['ad'] ?? '0') == '1';
    final apiEnabled = uri.queryParameters['api'] != '0';

    return new SearchQuery.parse(
      query: q,
      platform: platform,
      order: order,
      offset: offset,
      limit: limit,
      isAd: isAd,
      apiEnabled: apiEnabled,
    );
  }

  SearchQuery change({
    String query,
    String platform,
    SearchOrder order,
    int offset,
    int limit,
    bool isAd,
    bool apiEnabled,
  }) {
    return new SearchQuery._(
      query: query ?? this.query,
      platform: platform ?? this.platform,
      order: order ?? this.order,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      isAd: isAd ?? this.isAd,
      isApiEnabled: apiEnabled ?? this.isApiEnabled,
    );
  }

  Map<String, String> toServiceQueryParameters() {
    final Map<String, String> map = <String, String>{
      'q': query,
      'platform': platform,
      'offset': offset?.toString(),
      'limit': limit?.toString(),
      'order': serializeSearchOrder(order),
      'ad': isAd ? '1' : null,
      'api': isApiEnabled ? null : '0',
    };
    map.removeWhere((k, v) => v == null);
    return map;
  }

  bool get hasQuery => query != null && query.isNotEmpty;

  /// Sanity check, whether the query object is to be expected a valid result.
  bool get isValid {
    final bool hasText =
        parsedQuery.text != null && parsedQuery.text.isNotEmpty;
    final bool hasNonTextOrdering = order != SearchOrder.text;
    final bool isEmpty = !hasText &&
        order == null &&
        parsedQuery.packagePrefix == null &&
        (platform == null || platform.isEmpty);
    if (isEmpty) return false;

    return hasText || hasNonTextOrdering;
  }

  // TODO: move this to shared/urls.dart after simplifying platformPredicate
  String toSearchLink({int page}) {
    String path = '/packages';
    final Map<String, String> params = {};
    if (query != null && query.isNotEmpty) {
      params['q'] = query;
    }
    if (platform != null && platform.isNotEmpty) {
      path = '/$platform/packages';
    }
    if (order != null) {
      final String paramName = 'sort';
      params[paramName] = serializeSearchOrder(order);
    }
    if (!isApiEnabled) {
      params['api'] = '0';
    }
    if (page != null) {
      params['page'] = page.toString();
    }
    if (params.isEmpty) {
      return path;
    } else {
      return new Uri(path: path, queryParameters: params).toString();
    }
  }
}

class ParsedQuery {
  final String text;
  final String packagePrefix;

  /// Dependency match for direct or dev dependency.
  final List<String> refDependencies;

  /// Dependency match for all dependencies, including transitive ones.
  final List<String> allDependencies;

  /// Match authors and uploaders.
  final List<String> emails;

  /// Enable experimental API search.
  final bool isApiEnabled;

  ParsedQuery._(
    this.text,
    this.packagePrefix,
    this.refDependencies,
    this.allDependencies,
    this.emails,
    this.isApiEnabled,
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

    List<String> extractRegExp(RegExp regExp) {
      final List<String> values =
          regExp.allMatches(queryText).map((Match m) => m.group(1)).toList();
      if (values.isNotEmpty) {
        queryText = queryText.replaceAll(regExp, ' ');
      }
      return values;
    }

    final List<String> dependencies = extractRegExp(_refDependencyRegExp);
    final List<String> allDependencies = extractRegExp(_allDependencyRegExp);
    final List<String> emails = extractRegExp(_emailRegexp);

    final bool isApiEnabled = queryText.contains(' !!api ');
    if (isApiEnabled) {
      queryText = queryText.replaceFirst(' !!api ', ' ');
    }

    queryText = queryText.replaceAll(_whitespacesRegExp, ' ').trim();
    if (queryText.isEmpty) {
      queryText = null;
    }

    return new ParsedQuery._(
      queryText,
      packagePrefix,
      dependencies,
      allDependencies,
      emails,
      isApiEnabled,
    );
  }

  bool get hasAnyDependency =>
      refDependencies.isNotEmpty || allDependencies.isNotEmpty;
}

@JsonSerializable()
class PackageSearchResult {
  /// The last update of the search index.
  final String indexUpdated;
  final int totalCount;
  final List<PackageScore> packages;

  PackageSearchResult(
      {this.indexUpdated, this.totalCount, List<PackageScore> packages})
      : this.packages = packages ?? [];

  PackageSearchResult.notReady()
      : indexUpdated = null,
        totalCount = 0,
        packages = [];

  factory PackageSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PackageSearchResultFromJson(json);

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
    return new PackageScore(
      package: package,
      score: score ?? this.score,
      url: url ?? this.url,
      version: version ?? this.version,
      description: description ?? this.description,
      apiPages: apiPages ?? this.apiPages,
    );
  }

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
    return new ApiPageRef(
      title: title ?? this.title,
      path: path,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toJson() => _$ApiPageRefToJson(this);
}
