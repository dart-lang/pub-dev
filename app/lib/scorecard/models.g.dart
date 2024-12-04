// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreCardData _$ScoreCardDataFromJson(Map<String, dynamic> json) =>
    ScoreCardData(
      packageName: json['packageName'] as String?,
      packageVersion: json['packageVersion'] as String?,
      runtimeVersion: json['runtimeVersion'] as String?,
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
      dartdocReport: json['dartdocReport'] == null
          ? null
          : DartdocReport.fromJson(
              json['dartdocReport'] as Map<String, dynamic>),
      panaReport: json['panaReport'] == null
          ? null
          : PanaReport.fromJson(json['panaReport'] as Map<String, dynamic>),
      taskStatus: $enumDecodeNullable(
          _$PackageVersionStatusEnumMap, json['taskStatus']),
    );

Map<String, dynamic> _$ScoreCardDataToJson(ScoreCardData instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'runtimeVersion': instance.runtimeVersion,
      'updated': instance.updated?.toIso8601String(),
      'dartdocReport': instance.dartdocReport,
      'panaReport': instance.panaReport,
      'taskStatus': _$PackageVersionStatusEnumMap[instance.taskStatus],
    };

const _$PackageVersionStatusEnumMap = {
  PackageVersionStatus.pending: 'pending',
  PackageVersionStatus.running: 'running',
  PackageVersionStatus.completed: 'completed',
  PackageVersionStatus.failed: 'failed',
};

PanaReport _$PanaReportFromJson(Map<String, dynamic> json) => PanaReport(
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      panaRuntimeInfo: json['panaRuntimeInfo'] == null
          ? null
          : PanaRuntimeInfo.fromJson(
              json['panaRuntimeInfo'] as Map<String, dynamic>),
      reportStatus: json['reportStatus'] as String?,
      derivedTags: (json['derivedTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      allDependencies: (json['allDependencies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      licenses: (json['licenses'] as List<dynamic>?)
          ?.map((e) => License.fromJson(e as Map<String, dynamic>))
          .toList(),
      report: json['report'] == null
          ? null
          : Report.fromJson(json['report'] as Map<String, dynamic>),
      result: json['result'] == null
          ? null
          : AnalysisResult.fromJson(json['result'] as Map<String, dynamic>),
      urlProblems: (json['urlProblems'] as List<dynamic>?)
          ?.map((e) => UrlProblem.fromJson(e as Map<String, dynamic>))
          .toList(),
      screenshots: (json['screenshots'] as List<dynamic>?)
          ?.map((e) => ProcessedScreenshot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PanaReportToJson(PanaReport instance) =>
    <String, dynamic>{
      if (instance.timestamp?.toIso8601String() case final value?)
        'timestamp': value,
      if (instance.panaRuntimeInfo case final value?) 'panaRuntimeInfo': value,
      if (instance.reportStatus case final value?) 'reportStatus': value,
      if (instance.derivedTags case final value?) 'derivedTags': value,
      if (instance.allDependencies case final value?) 'allDependencies': value,
      if (instance.licenses case final value?) 'licenses': value,
      if (instance.report case final value?) 'report': value,
      if (instance.result case final value?) 'result': value,
      if (instance.screenshots case final value?) 'screenshots': value,
      if (instance.urlProblems case final value?) 'urlProblems': value,
    };

DartdocReport _$DartdocReportFromJson(Map<String, dynamic> json) =>
    DartdocReport(
      reportStatus: json['reportStatus'] as String?,
    );

Map<String, dynamic> _$DartdocReportToJson(DartdocReport instance) =>
    <String, dynamic>{
      'reportStatus': instance.reportStatus,
    };
