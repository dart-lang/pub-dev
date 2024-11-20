// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageVersionStateInfo _$PackageVersionStateInfoFromJson(
        Map<String, dynamic> json) =>
    PackageVersionStateInfo(
      scheduled: DateTime.parse(json['scheduled'] as String),
      attempts: (json['attempts'] as num).toInt(),
      secretToken: json['secretToken'] as String?,
      zone: json['zone'] as String?,
      instance: json['instance'] as String?,
      docs: json['docs'] as bool? ?? false,
      pana: json['pana'] as bool? ?? false,
      finished: json['finished'] as bool? ?? false,
    );

Map<String, dynamic> _$PackageVersionStateInfoToJson(
        PackageVersionStateInfo instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'pana': instance.pana,
      'finished': instance.finished,
      'scheduled': instance.scheduled.toIso8601String(),
      'attempts': instance.attempts,
      'zone': instance.zone,
      'instance': instance.instance,
      'secretToken': instance.secretToken,
    };

PackageStateInfo _$PackageStateInfoFromJson(Map<String, dynamic> json) =>
    PackageStateInfo(
      runtimeVersion: json['runtimeVersion'] as String?,
      package: json['package'] as String,
      versions: (json['versions'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, PackageVersionStateInfo.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$PackageStateInfoToJson(PackageStateInfo instance) =>
    <String, dynamic>{
      'runtimeVersion': instance.runtimeVersion,
      'package': instance.package,
      'versions': instance.versions,
    };

AbortedTokenInfo _$AbortedTokenInfoFromJson(Map<String, dynamic> json) =>
    AbortedTokenInfo(
      token: json['token'] as String,
      expires: DateTime.parse(json['expires'] as String),
    );

Map<String, dynamic> _$AbortedTokenInfoToJson(AbortedTokenInfo instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expires': instance.expires.toIso8601String(),
    };
