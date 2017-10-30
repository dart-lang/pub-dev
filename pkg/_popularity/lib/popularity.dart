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
  final Map<String, PackageInfo> items;

  PackagePopularity(this.dateFirst, this.dateLast, this.items);

  factory PackagePopularity.fromJson(Map<String, dynamic> json) =>
      _$PackagePopularityFromJson(json);
}

@JsonSerializable()
class PackageInfo extends Object with _$PackageInfoSerializerMixin {
  @JsonKey(name: 'votes_direct', nullable: false)
  final int votesDirect;

  @JsonKey(name: 'votes_dev', nullable: false)
  final int votesDev;

  @JsonKey(name: 'votes_total', nullable: false)
  final int votesTotal;

  PackageInfo(this.votesDirect, this.votesDev, this.votesTotal);

  factory PackageInfo.fromJson(Map<String, dynamic> json) =>
      _$PackageInfoFromJson(json);
}
