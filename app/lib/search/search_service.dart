// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' show max;

import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';

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
@JsonSerializable()
class PackageDocument {
  final String package;
  final String? version;
  final String? description;
  final DateTime? created;
  final DateTime? updated;
  final String? readme;

  final List<String> tags;

  final int? likeCount;

  final int? grantedPoints;
  final int? maxPoints;

  final Map<String, String> dependencies;

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
    this.likeCount = 0,
    this.grantedPoints = 0,
    this.maxPoints = 0,
    this.dependencies = const {},
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

@JsonSerializable(includeIfNull: false, explicitToJson: true)
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
        tag == PackageTags.showHidden);
    final prohibitDiscontinued = !parsedQuery.tagsPredicate.anyTag((tag) =>
        tag == PackageTags.isDiscontinued ||
        tag == PackageTags.showDiscontinued ||
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
