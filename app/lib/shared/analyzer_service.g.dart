// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyzer_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisData _$AnalysisDataFromJson(Map<String, dynamic> json) {
  return AnalysisData(
      packageName: json['packageName'] as String,
      packageVersion: json['packageVersion'] as String,
      analysis: json['analysis'] as int,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      runtimeVersion: json['runtimeVersion'] as String,
      panaVersion: json['panaVersion'] as String,
      flutterVersion: json['flutterVersion'] as String,
      analysisStatus:
          _$enumDecodeNullable(_$AnalysisStatusEnumMap, json['analysisStatus']),
      analysisContent: json['analysisContent'] as Map<String, dynamic>,
      maintenanceScore: (json['maintenanceScore'] as num)?.toDouble());
}

Map<String, dynamic> _$AnalysisDataToJson(AnalysisData instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'analysis': instance.analysis,
      'timestamp': instance.timestamp?.toIso8601String(),
      'runtimeVersion': instance.runtimeVersion,
      'panaVersion': instance.panaVersion,
      'flutterVersion': instance.flutterVersion,
      'analysisStatus': _$AnalysisStatusEnumMap[instance.analysisStatus],
      'maintenanceScore': instance.maintenanceScore,
      'analysisContent': instance.analysisContent
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$AnalysisStatusEnumMap = <AnalysisStatus, dynamic>{
  AnalysisStatus.aborted: 'aborted',
  AnalysisStatus.failure: 'failure',
  AnalysisStatus.discontinued: 'discontinued',
  AnalysisStatus.outdated: 'outdated',
  AnalysisStatus.legacy: 'legacy',
  AnalysisStatus.success: 'success'
};

AnalysisExtract _$AnalysisExtractFromJson(Map<String, dynamic> json) {
  return AnalysisExtract(
      analysisStatus:
          _$enumDecodeNullable(_$AnalysisStatusEnumMap, json['analysisStatus']),
      health: (json['health'] as num)?.toDouble(),
      maintenance: (json['maintenance'] as num)?.toDouble(),
      popularity: (json['popularity'] as num)?.toDouble(),
      platforms: (json['platforms'] as List)?.map((e) => e as String)?.toList(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String));
}

Map<String, dynamic> _$AnalysisExtractToJson(AnalysisExtract instance) =>
    <String, dynamic>{
      'analysisStatus': _$AnalysisStatusEnumMap[instance.analysisStatus],
      'health': instance.health,
      'maintenance': instance.maintenance,
      'popularity': instance.popularity,
      'platforms': instance.platforms,
      'timestamp': instance.timestamp?.toIso8601String()
    };
