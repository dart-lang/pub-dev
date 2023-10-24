// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecurityAdvisoryData _$AdvisoryFromJson(Map<String, dynamic> json) =>
    SecurityAdvisoryData(
      OSV.fromJson(json['advisory'] as Map<String, dynamic>),
      DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$AdvisoryToJson(SecurityAdvisoryData instance) =>
    <String, dynamic>{
      'advisory': instance.advisory,
      'updated': instance.syncTime.toIso8601String(),
    };
