// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library package_popularity;

import 'package:json_annotation/json_annotation.dart';

part 'popularity.g.dart';

@JsonSerializable()
class PackagePopularity {
  static const int version = 3;

  static final String popularityFileName = 'v$version/popularity.json.gz';

  @JsonKey(name: 'date_first', nullable: false)
  final DateTime dateFirst;

  @JsonKey(name: 'date_last', nullable: false)
  final DateTime dateLast;

  @JsonKey(nullable: false)
  final Map<String, VoteTotals> items;

  PackagePopularity(this.dateFirst, this.dateLast, this.items);

  factory PackagePopularity.fromJson(Map<String, dynamic> json) =>
      _$PackagePopularityFromJson(json);

  Map<String, dynamic> toJson() => _$PackagePopularityToJson(this);
}

@JsonSerializable()
class VoteTotals implements VoteData {
  @JsonKey(nullable: false)
  final VoteData flutter;
  @JsonKey(nullable: false)
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

  @override
  Map<String, dynamic> toJson() => _$VoteTotalsToJson(this);
}

@JsonSerializable()
class VoteData {
  @JsonKey(name: 'votes_direct', nullable: false)
  final int direct;

  @JsonKey(name: 'votes_dev', nullable: false)
  final int dev;

  @JsonKey(name: 'votes_total', nullable: false)
  final int total;

  int get score => _score(this);

  VoteData(this.direct, this.dev, this.total) {
    assert(direct >= 0 && direct <= total);
    assert(dev >= 0 && dev <= total);
  }

  factory VoteData.fromJson(Map<String, dynamic> json) =>
      _$VoteDataFromJson(json);

  Map<String, dynamic> toJson() => _$VoteDataToJson(this);

  static int _score(VoteData data) => data.direct * 10 + data.dev;
}
