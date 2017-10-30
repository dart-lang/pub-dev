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
        new Map<String, PackageInfo>.fromIterables(
            (json['items'] as Map<String, dynamic>).keys,
            (json['items'] as Map).values.map(
                (e) => new PackageInfo.fromJson(e as Map<String, dynamic>))));

abstract class _$PackagePopularitySerializerMixin {
  DateTime get dateFirst;
  DateTime get dateLast;
  Map<String, PackageInfo> get items;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'date_first': dateFirst.toIso8601String(),
        'date_last': dateLast.toIso8601String(),
        'items': items
      };
}

PackageInfo _$PackageInfoFromJson(Map<String, dynamic> json) => new PackageInfo(
    json['votes_direct'] as int,
    json['votes_dev'] as int,
    json['votes_total'] as int);

abstract class _$PackageInfoSerializerMixin {
  int get votesDirect;
  int get votesDev;
  int get votesTotal;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'votes_direct': votesDirect,
        'votes_dev': votesDev,
        'votes_total': votesTotal
      };
}
