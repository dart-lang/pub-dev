// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library package_popularity;

import 'package:json_annotation/json_annotation.dart';

part 'popularity.g.dart';

@JsonSerializable()
class PackagePopularity extends Object with _$PackagePopularitySerializerMixin {
  static const int version = 3;

  static final String popularityFileName = 'v$version/popularity.json.gz';

  @JsonKey(name: 'date_first', nullable: false)
  @override
  final DateTime dateFirst;

  @JsonKey(name: 'date_last', nullable: false)
  @override
  final DateTime dateLast;

  @JsonKey(nullable: false)
  @override
  final Map<String, VoteTotals> items;

  PackagePopularity(this.dateFirst, this.dateLast, this.items);

  factory PackagePopularity.fromJson(Map<String, dynamic> json) =>
      _$PackagePopularityFromJson(json);
}

@JsonSerializable()
class VoteTotals extends Object
    with _$VoteTotalsSerializerMixin
    implements VoteData {
  @JsonKey(nullable: false)
  @override
  final VoteData flutter;
  @JsonKey(nullable: false)
  @override
  final VoteData notFlutter;

  @override
  int get direct => flutter.direct + notFlutter.direct;

  @override
  int get dev => flutter.dev + notFlutter.dev;

  @override
  int get total => flutter.total + notFlutter.total;

  @override
  int get score => VoteData._score(this);

  VoteTotals(this.flutter, this.notFlutter);

  factory VoteTotals.fromJson(Map<String, dynamic> json) =>
      _$VoteTotalsFromJson(json);
}

@JsonSerializable()
class VoteData extends Object with _$VoteDataSerializerMixin {
  @JsonKey(name: 'votes_direct', nullable: false)
  @override
  final int direct;

  @JsonKey(name: 'votes_dev', nullable: false)
  @override
  final int dev;

  @JsonKey(name: 'votes_total', nullable: false)
  @override
  final int total;

  int get score => _score(this);

  VoteData(this.direct, this.dev, this.total) {
    assert(this.direct >= 0 && this.direct <= this.total);
    assert(this.dev >= 0 && this.dev <= this.total);
  }

  factory VoteData.fromJson(Map<String, dynamic> json) =>
      _$VoteDataFromJson(json);

  static int _score(VoteData data) => data.direct * 10 + data.dev;
}
