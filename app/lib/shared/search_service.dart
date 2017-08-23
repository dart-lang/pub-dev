// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides
library pub_dartlang_org.shared.search_service;

import 'dart:async';
import 'dart:math' show min, max;

import 'package:json_serializable/annotations.dart';

part 'search_service.g.dart';

const int defaultSearchLimit = 100;
const int minSearchLimit = 10;
const int maxSearchResults = 500;
const int searchIndexNotReadyCode = 600;
const String searchIndexNotReadyText = 'Not ready yet.';

/// Package search index and lookup.
abstract class PackageIndex {
  bool get isReady;
  Future add(PackageDocument doc);
  Future addAll(Iterable<PackageDocument> documents);
  Future removeUrl(String url);
  Future merge();
  Future<PackageSearchResult> search(PackageQuery query);
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
  final String lastUpdated;
  final String readme;

  final List<String> detectedTypes;

  final double health;
  final double popularity;

  PackageDocument({
    this.url,
    this.package,
    this.version,
    this.devVersion,
    this.description,
    this.lastUpdated,
    this.readme,
    this.detectedTypes,
    this.health,
    this.popularity,
  });

  factory PackageDocument.fromJson(Map<String, dynamic> json) =>
      _$PackageDocumentFromJson(json);
}

class PackageQuery {
  final String text;
  final String type;
  final String packagePrefix;
  final int offset;
  final int limit;

  PackageQuery(
    this.text, {
    this.type,
    this.packagePrefix,
    this.offset,
    this.limit,
  });

  factory PackageQuery.fromServiceQueryParameters(Map<String, String> params) {
    final String text = params['q'];
    String type = params['type'];
    if (type != null && type.isEmpty) type = null;
    String packagePrefix = params['pkg-prefix'];
    if (packagePrefix != null && packagePrefix.isEmpty) packagePrefix = null;
    int offset = int.parse(params['offset'] ?? '0', onError: (_) => 0);
    int limit =
        int.parse(params['limit'] ?? '0', onError: (_) => defaultSearchLimit);

    offset = min(maxSearchResults - minSearchLimit, offset);
    offset = max(0, offset);
    limit = max(minSearchLimit, limit);

    return new PackageQuery(text,
        type: type, packagePrefix: packagePrefix, offset: offset, limit: limit);
  }

  Map<String, String> toServiceQueryParameters() {
    final Map<String, String> map = <String, String>{
      'q': text,
      'offset': offset?.toString(),
      'limit': limit?.toString(),
    };
    if (type != null) {
      map['type'] = type;
    }
    if (packagePrefix != null) {
      map['pkg-prefix'] = packagePrefix;
    }
    return map;
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
  final String version;
  final String devVersion;
  final double score;

  PackageScore(
      {this.url, this.package, this.version, this.devVersion, this.score});

  factory PackageScore.fromJson(Map<String, dynamic> json) =>
      _$PackageScoreFromJson(json);
}
