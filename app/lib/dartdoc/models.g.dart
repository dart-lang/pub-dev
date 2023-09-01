// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResolvedDocUrlVersion _$ResolvedDocUrlVersionFromJson(
        Map<String, dynamic> json) =>
    ResolvedDocUrlVersion(
      version: json['version'] as String,
      segment: json['segment'] as String,
    );

Map<String, dynamic> _$ResolvedDocUrlVersionToJson(
        ResolvedDocUrlVersion instance) =>
    <String, dynamic>{
      'version': instance.version,
      'segment': instance.segment,
    };
