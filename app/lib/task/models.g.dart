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

PackageStatus _$PackageStatusFromJson(Map<String, dynamic> json) =>
    PackageStatus(
      package: json['package'] as String,
      versions: (json['versions'] as List<dynamic>)
          .map((e) => PackageVersionStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageStatusToJson(PackageStatus instance) =>
    <String, dynamic>{
      'package': instance.package,
      'versions': instance.versions,
    };

PackageVersionStatus _$PackageVersionStatusFromJson(
        Map<String, dynamic> json) =>
    PackageVersionStatus(
      version: json['version'] as String,
      status: $enumDecode(_$TaskPackageVersionStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$PackageVersionStatusToJson(
        PackageVersionStatus instance) =>
    <String, dynamic>{
      'version': instance.version,
      'status': _$TaskPackageVersionStatusEnumMap[instance.status]!,
    };

const _$TaskPackageVersionStatusEnumMap = {
  TaskPackageVersionStatus.pending: 'pending',
  TaskPackageVersionStatus.running: 'running',
  TaskPackageVersionStatus.completed: 'completed',
  TaskPackageVersionStatus.failed: 'failed',
};
