// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreCardData _$ScoreCardDataFromJson(Map<String, dynamic> json) {
  return ScoreCardData(
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
    grantedPubPoints: json['grantedPubPoints'] as int?,
    maxPubPoints: json['maxPubPoints'] as int?,
    popularityScore: (json['popularityScore'] as num?)?.toDouble(),
    derivedTags: (json['derivedTags'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    flags: (json['flags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    reportTypes: (json['reportTypes'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    dartdocReport: json['dartdocReport'] == null
        ? null
        : DartdocReport.fromJson(json['dartdocReport'] as Map<String, dynamic>),
    panaReport: json['panaReport'] == null
        ? null
        : PanaReport.fromJson(json['panaReport'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ScoreCardDataToJson(ScoreCardData instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'runtimeVersion': instance.runtimeVersion,
      'updated': instance.updated?.toIso8601String(),
      'packageCreated': instance.packageCreated?.toIso8601String(),
      'packageVersionCreated':
          instance.packageVersionCreated?.toIso8601String(),
      'grantedPubPoints': instance.grantedPubPoints,
      'maxPubPoints': instance.maxPubPoints,
      'popularityScore': instance.popularityScore,
      'derivedTags': instance.derivedTags,
      'flags': instance.flags,
      'reportTypes': instance.reportTypes,
      'dartdocReport': instance.dartdocReport,
      'panaReport': instance.panaReport,
    };

PanaReport _$PanaReportFromJson(Map<String, dynamic> json) {
  return PanaReport(
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
    licenseFile: json['licenseFile'] == null
        ? null
        : LicenseFile.fromJson(json['licenseFile'] as Map<String, dynamic>),
    report: json['report'] == null
        ? null
        : Report.fromJson(json['report'] as Map<String, dynamic>),
    flags: (json['flags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$PanaReportToJson(PanaReport instance) {
  final val = <String, dynamic>{
    'timestamp': instance.timestamp?.toIso8601String(),
    'panaRuntimeInfo': instance.panaRuntimeInfo,
    'reportStatus': instance.reportStatus,
    'derivedTags': instance.derivedTags,
    'allDependencies': instance.allDependencies,
    'licenseFile': instance.licenseFile,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('report', instance.report);
  writeNotNull('flags', instance.flags);
  return val;
}

DartdocReport _$DartdocReportFromJson(Map<String, dynamic> json) {
  return DartdocReport(
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
}

Map<String, dynamic> _$DartdocReportToJson(DartdocReport instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'reportStatus': instance.reportStatus,
      'dartdocEntry': instance.dartdocEntry,
      'documentationSection': instance.documentationSection,
    };
