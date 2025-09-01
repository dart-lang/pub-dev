// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_request_data.g.dart';

@JsonSerializable()
class SearchRequestData {
  final String? query;
  final List<String>? tags;
  final String? publisherId;
  final int? minPoints;
  final SearchOrder? order;
  final int? offset;
  final int? limit;
  final TextMatchExtent? textMatchExtent;
  final List<String>? packages;

  SearchRequestData({
    String? query,
    this.tags,
    String? publisherId,
    this.minPoints,
    this.order,
    this.offset,
    this.limit,
    this.textMatchExtent,
    this.packages,
  })  : query = _trimToNull(query),
        publisherId = _trimToNull(publisherId);

  factory SearchRequestData.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRequestDataToJson(this);

  factory SearchRequestData.fromServiceUrl(Uri uri) {
    final q = uri.queryParameters['q'];
    final tags = uri.queryParametersAll['tags'];
    final publisherId = uri.queryParameters['publisherId'];
    final String? orderValue = uri.queryParameters['order'];
    final SearchOrder? order = parseSearchOrder(orderValue);

    final minPoints =
        int.tryParse(uri.queryParameters['minPoints'] ?? '0') ?? 0;
    final offset = int.tryParse(uri.queryParameters['offset'] ?? '0') ?? 0;
    final limit = int.tryParse(uri.queryParameters['limit'] ?? '0') ?? 0;
    final textMatchExtentValue =
        uri.queryParameters['textMatchExtent']?.trim() ?? '';
    TextMatchExtent? textMatchExtent;
    for (final extent in TextMatchExtent.values) {
      if (extent.name == textMatchExtentValue) {
        textMatchExtent = extent;
        break;
      }
    }
    final packages = uri.queryParametersAll['packages'];

    return SearchRequestData(
      query: q,
      tags: tags,
      publisherId: publisherId,
      order: order,
      minPoints: minPoints,
      offset: offset,
      limit: limit,
      textMatchExtent: textMatchExtent,
      packages: packages,
    );
  }

  Map<String, dynamic> toUriQueryParameters() {
    final map = <String, dynamic>{
      'q': query,
      'tags': tags,
      'publisherId': publisherId,
      'offset': (offset ?? 0).toString(),
      if (minPoints != null && minPoints! > 0)
        'minPoints': minPoints.toString(),
      'limit': (limit ?? 10).toString(),
      'order': order?.name,
      if (textMatchExtent != null) 'textMatchExtent': textMatchExtent!.name,
      if (packages != null && packages!.isNotEmpty) 'packages': packages,
    };
    map.removeWhere((k, v) => v == null);
    return map;
  }

  /// Creates a new instance with fields being replaced (if provided).
  SearchRequestData replace({
    String? query,
    List<String>? tags,
    List<String>? packages,
    TextMatchExtent? textMatchExtent,
  }) {
    return SearchRequestData(
      query: query ?? this.query,
      minPoints: minPoints,
      publisherId: publisherId,
      tags: tags ?? this.tags,
      packages: packages ?? this.packages,
      order: order,
      offset: offset,
      limit: limit,
      textMatchExtent: textMatchExtent ?? this.textMatchExtent,
    );
  }
}

/// The scope (depth) of the text matching.
enum TextMatchExtent {
  /// No text search is done.
  /// Requests with text queries will return a failure message.
  none,

  /// Text search is on package names.
  name,

  /// Text search is on package names, descriptions and topic tags.
  description,

  /// Text search is on names, descriptions, topic tags and readme content.
  readme,

  /// Text search is on names, descriptions, topic tags, readme content and API symbols.
  api,
  ;

  /// Text search is on package names.
  bool shouldMatchName() => index >= name.index;

  /// Text search is on package names, descriptions and topic tags.
  bool shouldMatchDescription() => index >= description.index;

  /// Text search is on names, descriptions, topic tags and readme content.
  bool shouldMatchReadme() => index >= readme.index;

  /// Text search is on names, descriptions, topic tags, readme content and API symbols.
  bool shouldMatchApi() => index >= api.index;
}

String? _trimToNull(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}
