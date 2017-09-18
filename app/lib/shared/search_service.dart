// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides
library pub_dartlang_org.shared.search_service;

import 'dart:async';
import 'dart:math' show min, max;

import 'package:json_serializable/annotations.dart';

import 'platform.dart';

part 'search_service.g.dart';

const int defaultSearchLimit = 100;
const int minSearchLimit = 10;
const int maxSearchResults = 500;
const int searchIndexNotReadyCode = 600;
const String searchIndexNotReadyText = 'Not ready yet.';

/// Package search index and lookup.
abstract class PackageIndex {
  bool get isReady;
  Future<bool> containsPackage(String package,
      {String version, Duration maxAge});
  Future add(PackageDocument doc);
  Future addAll(Iterable<PackageDocument> documents);
  Future removeUrl(String url);
  Future merge();
  Future<PackageSearchResult> search(SearchQuery query);
}

/// A summary information about a package that goes into the search index.
///
/// It is also part of the data structure returned by a search query, except for
/// the [readme] and [popularity] fields, which are excluded when returning the
/// results.
@JsonSerializable()
class PackageDocument extends Object with _$PackageDocumentSerializerMixin {
  final String url;
  final String package;
  final String version;
  final String devVersion;
  final String description;
  final DateTime updated;
  final String readme;

  final List<String> platforms;

  final double health;
  final double popularity;

  /// The creation timestamp of this document.
  final DateTime timestamp;

  PackageDocument({
    this.url,
    this.package,
    this.version,
    this.devVersion,
    this.description,
    this.updated,
    this.readme,
    this.platforms,
    this.health,
    this.popularity,
    this.timestamp,
  });

  factory PackageDocument.fromJson(Map<String, dynamic> json) =>
      _$PackageDocumentFromJson(json);
}

class SearchQuery {
  final String text;
  final PlatformPredicate platformPredicate;
  final String packagePrefix;
  final int offset;
  final int limit;

  SearchQuery(
    this.text, {
    this.platformPredicate,
    this.packagePrefix,
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
    int offset =
        int.parse(uri.queryParameters['offset'] ?? '0', onError: (_) => 0);
    int limit = int.parse(uri.queryParameters['limit'] ?? '0',
        onError: (_) => defaultSearchLimit);

    offset = min(maxSearchResults - minSearchLimit, offset);
    offset = max(0, offset);
    limit = max(minSearchLimit, limit);

    return new SearchQuery(
      text,
      platformPredicate: platform,
      packagePrefix: packagePrefix,
      offset: offset,
      limit: limit,
    );
  }

  Map<String, String> toServiceQueryParameters() {
    final Map<String, String> map = <String, String>{
      'q': text,
      'platforms': platformPredicate?.toQueryParamValue(),
      'offset': offset?.toString(),
      'limit': limit?.toString(),
    };
    if (packagePrefix != null) {
      map['pkg-prefix'] = packagePrefix;
    }
    return map;
  }

  /// Sanity check, whether the query object is to be expected a valid result.
  bool get isValid {
    final bool hasText = text != null && text.isNotEmpty;
    final bool hasPackagePrefix =
        packagePrefix != null && packagePrefix.isNotEmpty;
    return hasText || hasPackagePrefix;
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
  final String url;
  final String package;
  final double score;

  PackageScore({
    this.url,
    this.package,
    this.score,
  });

  factory PackageScore.fromJson(Map<String, dynamic> json) =>
      _$PackageScoreFromJson(json);
}

String pubUrlOfPackage(String package) =>
    'https://pub.dartlang.org/packages/$package';
