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

  SearchRequestData({
    this.query,
    this.tags,
    this.publisherId,
    this.minPoints,
    this.order,
    this.offset,
    this.limit,
    this.textMatchExtent,
  });

  factory SearchRequestData.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRequestDataToJson(this);
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
