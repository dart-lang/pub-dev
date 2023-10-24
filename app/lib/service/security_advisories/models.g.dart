// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecurityAdvisoryData _$SecurityAdvisoryDataFromJson(
        Map<String, dynamic> json) =>
    SecurityAdvisoryData(
      OSV.fromJson(json['advisory'] as Map<String, dynamic>),
      DateTime.parse(json['syncTime'] as String),
    );

Map<String, dynamic> _$SecurityAdvisoryDataToJson(
        SecurityAdvisoryData instance) =>
    <String, dynamic>{
      'advisory': instance.advisory,
      'syncTime': instance.syncTime.toIso8601String(),
    };
