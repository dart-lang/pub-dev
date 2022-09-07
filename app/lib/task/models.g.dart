// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageVersionState _$PackageVersionStateFromJson(Map<String, dynamic> json) =>
    PackageVersionState(
      scheduled: DateTime.parse(json['scheduled'] as String),
      attempts: json['attempts'] as int,
      secretToken: json['secretToken'] as String?,
      zone: json['zone'] as String?,
      instance: json['instance'] as String?,
    );

Map<String, dynamic> _$PackageVersionStateToJson(
        PackageVersionState instance) =>
    <String, dynamic>{
      'scheduled': instance.scheduled.toIso8601String(),
      'attempts': instance.attempts,
      'zone': instance.zone,
      'instance': instance.instance,
      'secretToken': instance.secretToken,
    };
