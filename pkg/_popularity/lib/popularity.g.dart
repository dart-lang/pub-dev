// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of package_popularity;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagePopularity _$PackagePopularityFromJson(Map<String, dynamic> json) {
  return new PackagePopularity(
      DateTime.parse(json['date_first'] as String),
      DateTime.parse(json['date_last'] as String),
      (json['items'] as Map<String, dynamic>).map((k, e) =>
          new MapEntry(k, new VoteTotals.fromJson(e as Map<String, dynamic>))));
}

abstract class _$PackagePopularitySerializerMixin {
  DateTime get dateFirst;
  DateTime get dateLast;
  Map<String, VoteTotals> get items;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'date_first': dateFirst.toIso8601String(),
        'date_last': dateLast.toIso8601String(),
        'items': items
      };
}

VoteTotals _$VoteTotalsFromJson(Map<String, dynamic> json) {
  return new VoteTotals(
      new VoteData.fromJson(json['flutter'] as Map<String, dynamic>),
      new VoteData.fromJson(json['notFlutter'] as Map<String, dynamic>));
}

abstract class _$VoteTotalsSerializerMixin {
  VoteData get flutter;
  VoteData get notFlutter;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'flutter': flutter, 'notFlutter': notFlutter};
}

VoteData _$VoteDataFromJson(Map<String, dynamic> json) {
  return new VoteData(json['votes_direct'] as int, json['votes_dev'] as int,
      json['votes_total'] as int);
}

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
