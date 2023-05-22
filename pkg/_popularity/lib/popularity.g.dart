// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popularity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagePopularity _$PackagePopularityFromJson(Map<String, dynamic> json) =>
    PackagePopularity(
      DateTime.parse(json['date_first'] as String),
      DateTime.parse(json['date_last'] as String),
      (json['items'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, VoteTotals.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$PackagePopularityToJson(PackagePopularity instance) =>
    <String, dynamic>{
      'date_first': instance.dateFirst.toIso8601String(),
      'date_last': instance.dateLast.toIso8601String(),
      'items': instance.items,
    };

VoteTotals _$VoteTotalsFromJson(Map<String, dynamic> json) => VoteTotals(
      VoteData.fromJson(json['flutter'] as Map<String, dynamic>),
      VoteData.fromJson(json['notFlutter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VoteTotalsToJson(VoteTotals instance) =>
    <String, dynamic>{
      'flutter': instance.flutter,
      'notFlutter': instance.notFlutter,
    };

VoteData _$VoteDataFromJson(Map<String, dynamic> json) => VoteData(
      json['votes_direct'] as int,
      json['votes_dev'] as int,
      json['votes_total'] as int,
    );

Map<String, dynamic> _$VoteDataToJson(VoteData instance) => <String, dynamic>{
      'votes_direct': instance.direct,
      'votes_dev': instance.dev,
      'votes_total': instance.total,
    };
