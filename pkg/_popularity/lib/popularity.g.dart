// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of package_popularity;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

PackagePopularity _$PackagePopularityFromJson(Map<String, dynamic> json) =>
    new PackagePopularity(
        DateTime.parse(json['date_first'] as String),
        DateTime.parse(json['date_last'] as String),
        new Map<String, VoteData>.fromIterables(
            (json['items'] as Map<String, dynamic>).keys,
            (json['items'] as Map)
                .values
                .map((e) => new VoteData.fromJson(e as Map<String, dynamic>))));

abstract class _$PackagePopularitySerializerMixin {
  DateTime get dateFirst;
  DateTime get dateLast;
  Map<String, VoteData> get items;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'date_first': dateFirst.toIso8601String(),
        'date_last': dateLast.toIso8601String(),
        'items': items
      };
}

VoteData _$VoteDataFromJson(Map<String, dynamic> json) => new VoteData(
    json['votes_direct'] as int,
    json['votes_dev'] as int,
    json['votes_total'] as int);

abstract class _$VoteDataSerializerMixin {
  int get direct;
  int get dev;
  int get total;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'votes_direct': direct,
        'votes_dev': dev,
        'votes_total': total
      };
}
