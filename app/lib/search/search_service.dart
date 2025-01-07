// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' show max;

import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pub_dev/shared/utils.dart';

part 'search_service.g.dart';

const int _minSearchLimit = 10;
const int searchIndexNotReadyCode = 600;
const String searchIndexNotReadyText = 'Not ready yet.';

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

  IndexInfo({
    required this.isReady,
    required this.packageCount,
    required this.lastUpdated,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'isReady': isReady,
        'packageCount': packageCount,
        'lastUpdated': lastUpdated?.toIso8601String(),
        if (lastUpdated != null)
          'lastUpdateDelta': clock.now().difference(lastUpdated!).toString(),
      };

  factory IndexInfo.fromJson(Map<String, dynamic> map) {
    final lastUpdated = map['lastUpdated'] as String?;
    return IndexInfo(
      isReady: map['isReady'] == true,
      packageCount: map['packageCount'] as int,
      lastUpdated: lastUpdated == null ? null : DateTime.parse(lastUpdated),
    );
  }
}

/// Package search index and lookup.
abstract class SearchIndex {
  FutureOr<bool> isReady();
  FutureOr<PackageSearchResult> search(ServiceSearchQuery query);
  FutureOr<IndexInfo> indexInfo();
}

/// A summary information about a package that goes into the search index.
@JsonSerializable()
class PackageDocument {
  final String package;
  final String? version;
  final String? description;
  final DateTime created;
  final DateTime updated;
  final String? readme;

  final List<String> tags;

  final int downloadCount;

  /// The normalized score between [0.0-1.0] (1.0 being the most downloaded package).
  double? downloadScore;

  final int likeCount;

  /// The normalized score between [0.0-1.0] (1.0 being the most liked package).
  double? likeScore;

  final int grantedPoints;
  final int maxPoints;

  /// The normalized overall score between [0.0-1.0] for default package listing.
  double? overallScore;

  final Map<String, String> dependencies;

  final List<ApiDocPage>? apiDocPages;

  /// The creation timestamp of this document.
  final DateTime timestamp;

  /// The last updated timestamp of the source entities.
  final DateTime? sourceUpdated;

  PackageDocument({
    required this.package,
    this.version,
    this.description,
    DateTime? created,
    DateTime? updated,
    this.readme = '',
    List<String>? tags,
    int? downloadCount,
    this.downloadScore,
    int? likeCount,
    this.likeScore,
    int? grantedPoints,
    int? maxPoints,
    this.dependencies = const {},
    this.apiDocPages = const [],
    DateTime? timestamp,
    this.sourceUpdated,
  })  : created = created ?? clock.now(),
        updated = updated ?? clock.now(),
        downloadCount = downloadCount ?? 0,
        likeCount = likeCount ?? 0,
        grantedPoints = grantedPoints ?? 0,
        maxPoints = maxPoints ?? 0,
        tags = tags ?? const <String>[],
        timestamp = timestamp ?? clock.now();

  factory PackageDocument.fromJson(Map<String, dynamic> json) =>
      _$PackageDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDocumentToJson(this);

  late final packageNameLowerCased = package.toLowerCase();
}

/// A reference to an API doc page
@JsonSerializable()
class ApiDocPage {
  final String relativePath;
  final List<String>? symbols;

  ApiDocPage({
    required this.relativePath,
    this.symbols,
  });

  factory ApiDocPage.fromJson(Map<String, dynamic> json) =>
      _$ApiDocPageFromJson(json);

  Map<String, dynamic> toJson() => _$ApiDocPageToJson(this);
}

class ServiceSearchQuery {
  final String? query;
  final ParsedQueryText parsedQuery;
  final TagsPredicate tagsPredicate;

  final String? publisherId;

  final int? minPoints;

  /// The value of the `sort` URL query parameter.
  final SearchOrder? order;
  final int? offset;
  final int? limit;

  ServiceSearchQuery._({
    this.query,
    TagsPredicate? tagsPredicate,
    String? publisherId,
    required this.minPoints,
    this.order,
    this.offset,
    this.limit,
  })  : parsedQuery = ParsedQueryText.parse(query),
        tagsPredicate = tagsPredicate ?? TagsPredicate(),
        publisherId = publisherId?.trimToNull();

  factory ServiceSearchQuery.parse({
    String? query,
    TagsPredicate? tagsPredicate,
    String? publisherId,
    SearchOrder? order,
    int? minPoints,
    int offset = 0,
    int? limit = 10,
  }) {
    final q = query?.trimToNull();
    return ServiceSearchQuery._(
      query: q,
      tagsPredicate: tagsPredicate,
      publisherId: publisherId,
      minPoints: minPoints,
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
    final offset = int.tryParse(uri.queryParameters['offset'] ?? '0') ?? 0;
    final limit = int.tryParse(uri.queryParameters['limit'] ?? '0') ?? 0;

    return ServiceSearchQuery.parse(
      query: q,
      tagsPredicate: tagsPredicate,
      publisherId: publisherId,
      order: order,
      minPoints: minPoints,
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
      'limit': limit?.toString(),
      'order': order?.name,
    };
    map.removeWhere((k, v) => v == null);
    return map;
  }

  /// The effective sort order to use:
  /// - input text query's order takes precedence
  /// - URL query sort [order] is used as a fallback.
  ///
  /// TODO: remove this field when [order] is removed.
  late final effectiveOrder = parsedQuery.order ?? order;
  bool get _hasQuery => query != null && query!.isNotEmpty;
  bool get _hasOnlyFreeText => _hasQuery && parsedQuery.hasOnlyFreeText;
  bool get _isNaturalOrder =>
      effectiveOrder == null ||
      effectiveOrder == SearchOrder.top ||
      effectiveOrder == SearchOrder.text;
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

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class PackageSearchResult {
  final DateTime timestamp;
  final int totalCount;

  /// Package names that are exact name matches or close to (e.g. names that
  /// would be considered as blocker for publishing).
  final List<String>? nameMatches;

  /// Topic names that are exact name matches or close to the queried text.
  final List<String>? topicMatches;
  final List<SdkLibraryHit> sdkLibraryHits;
  final List<PackageHit> packageHits;

  /// An optional message from the search service / client library, in case
  /// the query was not processed entirely.
  final String? errorMessage;

  final int? statusCode;

  PackageSearchResult({
    required this.timestamp,
    required this.totalCount,
    this.nameMatches,
    this.topicMatches,
    List<SdkLibraryHit>? sdkLibraryHits,
    List<PackageHit>? packageHits,
    this.errorMessage,
    this.statusCode,
  })  : packageHits = packageHits ?? <PackageHit>[],
        sdkLibraryHits = sdkLibraryHits ?? <SdkLibraryHit>[];

  factory PackageSearchResult.empty() => PackageSearchResult(
        timestamp: clock.now(),
        totalCount: 0,
        packageHits: [],
      );

  PackageSearchResult.error({
    required this.errorMessage,
    required this.statusCode,
  })  : timestamp = clock.now().toUtc(),
        totalCount = 0,
        nameMatches = null,
        topicMatches = null,
        sdkLibraryHits = <SdkLibraryHit>[],
        packageHits = <PackageHit>[];

  factory PackageSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PackageSearchResultFromJson(json);

  Duration get age => clock.now().difference(timestamp);

  Map<String, dynamic> toJson() => _$PackageSearchResultToJson(this);

  bool get isEmpty => packageHits.isEmpty && sdkLibraryHits.isEmpty;

  PackageSearchResult change({
    List<SdkLibraryHit>? sdkLibraryHits,
  }) {
    return PackageSearchResult(
      timestamp: timestamp,
      totalCount: totalCount,
      nameMatches: nameMatches,
      topicMatches: topicMatches,
      sdkLibraryHits: sdkLibraryHits ?? this.sdkLibraryHits,
      packageHits: packageHits,
      errorMessage: errorMessage,
      statusCode: statusCode,
    );
  }
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
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

@JsonSerializable(includeIfNull: false, explicitToJson: true)
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

@JsonSerializable(includeIfNull: false, explicitToJson: true)
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

abstract class DependencyTypes {
  static const dev = 'dev';
  static const direct = 'direct';
  static const transitive = 'transitive';
}

extension SearchFormExt on SearchForm {
  ServiceSearchQuery toServiceQuery() {
    final prohibitLegacy = !parsedQuery.tagsPredicate.anyTag((tag) =>
        tag == PackageVersionTags.isLegacy ||
        tag == PackageVersionTags.showLegacy ||
        tag == PackageTags.isUnlisted ||
        tag == PackageTags.showUnlisted ||
        tag == PackageTags.showHidden);
    final prohibitDiscontinued = !parsedQuery.tagsPredicate.anyTag((tag) =>
        tag == PackageTags.isDiscontinued ||
        tag == PackageTags.showDiscontinued ||
        tag == PackageTags.isUnlisted ||
        tag == PackageTags.showUnlisted ||
        tag == PackageTags.showHidden);
    final prohibitUnlisted = !parsedQuery.tagsPredicate.anyTag((tag) =>
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
      offset: offset,
      limit: pageSize,
      order: order,
    );
  }
}
