// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides
library pub_dartlang_org.shared.search_service;

import 'dart:async';
import 'dart:math' show max;

import 'package:json_annotation/json_annotation.dart';

import 'platform.dart';

part 'search_service.g.dart';

const int defaultSearchLimit = 100;
const int minSearchLimit = 10;
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
class PackageDocument extends Object with _$PackageDocumentSerializerMixin {
  final String package;
  final String version;
  final String devVersion;
  final String description;
  final DateTime created;
  final DateTime updated;
  final String readme;

  final List<String> platforms;

  final double health;
  final double popularity;
  final double maintenance;

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
    this.platforms,
    this.health,
    this.popularity,
    this.maintenance,
    this.timestamp,
  });

  factory PackageDocument.fromJson(Map<String, dynamic> json) =>
      _$PackageDocumentFromJson(json);
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

class SearchQuery {
  final String text;
  final PlatformPredicate platformPredicate;
  final String packagePrefix;
  final SearchOrder order;
  final int offset;
  final int limit;

  SearchQuery(
    this.text, {
    this.platformPredicate,
    this.packagePrefix,
    this.order,
    this.offset: 0,
    this.limit: 10,
  });

  factory SearchQuery.fromServiceUrl(Uri uri) {
    final String text = uri.queryParameters['q'];
    final platform = new PlatformPredicate.fromUri(uri);
    String type = uri.queryParameters['type'];
    if (type != null && type.isEmpty) type = null;
    String packagePrefix = uri.queryParameters['pkg-prefix'];
    if (packagePrefix != null && packagePrefix.isEmpty) packagePrefix = null;
    final SearchOrder order = parseSearchOrder(
      uri.queryParameters['order'],
      defaultsTo: SearchOrder.top,
    );
    int offset =
        int.parse(uri.queryParameters['offset'] ?? '0', onError: (_) => 0);
    int limit = int.parse(uri.queryParameters['limit'] ?? '0',
        onError: (_) => defaultSearchLimit);

    offset = max(0, offset);
    limit = max(minSearchLimit, limit);

    return new SearchQuery(
      text,
      platformPredicate: platform,
      packagePrefix: packagePrefix,
      order: order,
      offset: offset,
      limit: limit,
    );
  }

  SearchQuery change({
    String text,
    PlatformPredicate platformPredicate,
    String packagePrefix,
    SearchOrder order,
    int offset,
    int limit,
  }) =>
      new SearchQuery(
        text ?? this.text,
        platformPredicate: platformPredicate ?? this.platformPredicate,
        packagePrefix: packagePrefix ?? this.packagePrefix,
        order: order ?? this.order,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
      );

  Map<String, String> toServiceQueryParameters() {
    final Map<String, String> map = <String, String>{
      'q': text,
      'platforms': platformPredicate?.toQueryParamValue(),
      'offset': offset?.toString(),
      'limit': limit?.toString(),
    };
    if (order != null) {
      map['order'] = serializeSearchOrder(order);
    }
    if (packagePrefix != null) {
      map['pkg-prefix'] = packagePrefix;
    }
    return map;
  }

  /// Sanity check, whether the query object is to be expected a valid result.
  bool get isValid {
    final bool hasText = text != null && text.isNotEmpty;
    final bool hasNonTextOrdering = order != SearchOrder.text;
    final bool isEmpty = !hasText &&
        order == null &&
        packagePrefix == null &&
        (platformPredicate == null || !platformPredicate.isNotEmpty);
    if (isEmpty) return false;

    return hasText || hasNonTextOrdering;
  }

  String toSearchLink({int page}) {
    final Map<String, String> params = {'q': text};
    if (platformPredicate != null && platformPredicate.isNotEmpty) {
      params['platforms'] = platformPredicate.toQueryParamValue();
    }
    if (packagePrefix != null && packagePrefix.isNotEmpty) {
      params['pkg-prefix'] = packagePrefix;
    }
    if (order != null) {
      params['order'] = serializeSearchOrder(order);
    }
    if (page != null) {
      params['page'] = page.toString();
    }
    return new Uri(path: '/search', queryParameters: params).toString();
  }
}

@JsonSerializable()
class PackageSearchResult extends Object
    with _$PackageSearchResultSerializerMixin {
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
}

@JsonSerializable()
class PackageScore extends Object with _$PackageScoreSerializerMixin {
  final String package;

  @JsonKey(includeIfNull: false)
  final double score;

  PackageScore({
    this.package,
    this.score,
  });

  factory PackageScore.fromJson(Map<String, dynamic> json) =>
      _$PackageScoreFromJson(json);
}
