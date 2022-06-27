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
      packageCreated: json['packageCreated'] == null
          ? null
          : DateTime.parse(json['packageCreated'] as String),
      packageVersionCreated: json['packageVersionCreated'] == null
          ? null
          : DateTime.parse(json['packageVersionCreated'] as String),
      flags:
          (json['flags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      dartdocReport: json['dartdocReport'] == null
          ? null
          : DartdocReport.fromJson(
              json['dartdocReport'] as Map<String, dynamic>),
      panaReport: json['panaReport'] == null
          ? null
          : PanaReport.fromJson(json['panaReport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScoreCardDataToJson(ScoreCardData instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'runtimeVersion': instance.runtimeVersion,
      'updated': instance.updated?.toIso8601String(),
      'packageCreated': instance.packageCreated?.toIso8601String(),
      'packageVersionCreated':
          instance.packageVersionCreated?.toIso8601String(),
      'flags': instance.flags,
      'dartdocReport': instance.dartdocReport,
      'panaReport': instance.panaReport,
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
      flags:
          (json['flags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      urlProblems: (json['urlProblems'] as List<dynamic>?)
          ?.map((e) => UrlProblem.fromJson(e as Map<String, dynamic>))
          .toList(),
      screenshots: (json['screenshots'] as List<dynamic>?)
          ?.map((e) => ProcessedScreenshot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PanaReportToJson(PanaReport instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  writeNotNull('panaRuntimeInfo', instance.panaRuntimeInfo);
  writeNotNull('reportStatus', instance.reportStatus);
  writeNotNull('derivedTags', instance.derivedTags);
  writeNotNull('allDependencies', instance.allDependencies);
  writeNotNull('licenses', instance.licenses);
  writeNotNull('report', instance.report);
  writeNotNull('result', instance.result);
  writeNotNull('screenshots', instance.screenshots);
  writeNotNull('flags', instance.flags);
  writeNotNull('urlProblems', instance.urlProblems);
  return val;
}

DartdocReport _$DartdocReportFromJson(Map<String, dynamic> json) =>
    DartdocReport(
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      reportStatus: json['reportStatus'] as String?,
      dartdocEntry: json['dartdocEntry'] == null
          ? null
          : DartdocEntry.fromJson(json['dartdocEntry'] as Map<String, dynamic>),
      documentationSection: json['documentationSection'] == null
          ? null
          : ReportSection.fromJson(
              json['documentationSection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DartdocReportToJson(DartdocReport instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'reportStatus': instance.reportStatus,
      'dartdocEntry': instance.dartdocEntry,
      'documentationSection': instance.documentationSection,
    };
