// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library package_popularity;

import 'package:json_annotation/json_annotation.dart';

part 'popularity.g.dart';

@JsonSerializable()
class PackagePopularity extends Object with _$PackagePopularitySerializerMixin {
  static const int version = 2;

  static String bucketName(bool dev) =>
      dev ? 'dartlang-pub-dev--popularity' : 'dartlang-pub--popularity';

  static final String popularityFileName = 'v$version/popularity.json.gz';

  @JsonKey(name: 'date_first', nullable: false)
  final DateTime dateFirst;

  @JsonKey(name: 'date_last', nullable: false)
  final DateTime dateLast;

  @JsonKey(nullable: false)
  final Map<String, VoteData> items;

  PackagePopularity(this.dateFirst, this.dateLast, this.items);

  factory PackagePopularity.fromJson(Map<String, dynamic> json) =>
      _$PackagePopularityFromJson(json);
}

@JsonSerializable()
class VoteData extends Object with _$VoteDataSerializerMixin {
  @JsonKey(name: 'votes_direct', nullable: false)
  final int direct;

  @JsonKey(name: 'votes_dev', nullable: false)
  final int dev;

  @JsonKey(name: 'votes_total', nullable: false)
  final int total;

  int get score => direct * 25 + dev * 5 + total;

  VoteData(this.direct, this.dev, this.total);

  factory VoteData.fromJson(Map<String, dynamic> json) =>
      _$VoteDataFromJson(json);
}
