// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library package_popularity;

import 'package:json_annotation/json_annotation.dart';

part 'popularity.g.dart';

@JsonSerializable()
class PackagePopularity extends Object with _$PackagePopularitySerializerMixin {
  @JsonKey(name: 'date_first')
  final DateTime dateFirst;

  @JsonKey(name: 'date_last')
  final DateTime dateLast;

  final List<PackageInfo> items;

  PackagePopularity(this.dateFirst, this.dateLast, this.items);

  factory PackagePopularity.fromJson(Map<String, dynamic> json) =>
      _$PackagePopularityFromJson(json);
}

@JsonSerializable()
class PackageInfo extends Object with _$PackageInfoSerializerMixin {
  final String pkg;

  @JsonKey(name: 'votes_direct')
  final int votesDirect;

  @JsonKey(name: 'votes_dev')
  final int votesDev;

  @JsonKey(name: 'votes_total')
  final int votesTotal;

  PackageInfo(this.pkg, this.votesDirect, this.votesDev, this.votesTotal);

  factory PackageInfo.fromJson(Map<String, dynamic> json) =>
      _$PackageInfoFromJson(json);
}
