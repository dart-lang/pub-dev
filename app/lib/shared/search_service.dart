// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' show min, max;

const int defaultSearchLimit = 100;
const int minSearchLimit = 10;
const int maxSearchResults = 500;
const int searchIndexNotReadyCode = 600;
const String searchIndexNotReadyText = 'Not ready yet.';

/// Package search index and lookup.
abstract class PackageIndex {
  bool get isReady;
  Future<int> indexSize();
  Future add(PackageDocument doc);
  Future addAll(Iterable<PackageDocument> documents);
  Future contains(String url, String version, String devVersion);
  Future removeUrl(String url);
  Future merge();
  Future<PackageSearchResult> search(PackageQuery query);
}

/// A summary information about a package that goes into the search index.
///
/// It is also part of the data structure returned by a search query, except for
/// the [readme] and [popularity] fields, which are excluded when returning the
/// results.
class PackageDocument {
  final String url;
  final String package;
  final String version;
  final String devVersion;
  final String description;
  final String lastUpdated;
  final String readme;

  final List<String> detectedTypes;
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
    this.popularity,
  });

  factory PackageDocument.fromJson(Map json) => new PackageDocument(
        url: json['url'],
        package: json['package'],
        version: json['version'],
        devVersion: json['devVersion'],
        description: json['description'],
        lastUpdated: json['lastUpdated'],
        readme: json['readme'],
        detectedTypes: json['detectedTypes'],
        popularity: json['popularity'],
      );

  Map toJson() => {
        'url': url,
        'package': package,
        'version': version,
        'devVersion': devVersion,
        'description': description,
        'lastUpdated': lastUpdated,
        'readme': readme,
        'detectedTypes': detectedTypes,
        'popularity': popularity,
      };
}

class PackageQuery {
  final String text;
  final String type;
  final int offset;
  final int limit;

  PackageQuery(this.text, {this.type, this.offset, this.limit});

  factory PackageQuery.fromServiceQueryParameters(Map<String, String> params) {
    final String text = params['q'];
    String type = params['type'];
    if (type != null && type.isEmpty) type = null;
    int offset = int.parse(params['offset'] ?? '0', onError: (_) => 0);
    int limit =
        int.parse(params['limit'] ?? '0', onError: (_) => defaultSearchLimit);

    offset = min(maxSearchResults - minSearchLimit, offset);
    offset = max(0, offset);
    limit = max(minSearchLimit, limit);

    return new PackageQuery(text, type: type, offset: offset, limit: limit);
  }

  Map<String, String> toServiceQueryParameters() => {
        'q': text,
        'type': type,
        'offset': offset?.toString(),
        'limit': limit?.toString(),
      };
}

class PackageSearchResult {
  /// The last update of the search index.
  final String indexUpdated;
  final int totalCount;
  final List<PackageScore> packages;

  PackageSearchResult({this.indexUpdated, this.totalCount, this.packages});

  PackageSearchResult.notReady()
      : indexUpdated = null,
        totalCount = 0,
        packages = [];

  factory PackageSearchResult.fromJson(Map json) => new PackageSearchResult(
        indexUpdated: json['indexUpdated'],
        totalCount: json['totalCount'],
        packages: (json['packages'] ?? [])
            .map((Map m) => new PackageScore.fromJson(m))
            .toList(),
      );

  /// Whether the search service has already updated its index after a startup.
  bool get isLegit => indexUpdated != null;

  Map toJson() => {
        'indexUpdated': indexUpdated,
        'totalCount': totalCount,
        'packages': packages,
      };
}

class PackageScore {
  final String url;
  final String package;
  final String version;
  final String devVersion;
  final double score;

  PackageScore(
      {this.url, this.package, this.version, this.devVersion, this.score});

  factory PackageScore.fromJson(Map json) => new PackageScore(
        url: json['url'],
        package: json['package'],
        version: json['version'],
        devVersion: json['devVersion'],
        score: json['score'],
      );

  Map toJson() => {
        'url': url,
        'package': package,
        'version': version,
        'devVersion': devVersion,
        'score': score,
      };
}
