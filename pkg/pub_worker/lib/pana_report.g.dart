// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pana_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PanaReport _$PanaReportFromJson(Map<String, dynamic> json) => PanaReport(
      logId: json['logId'] as String,
      summary: json['summary'] == null
          ? null
          : Summary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PanaReportToJson(PanaReport instance) =>
    <String, dynamic>{
      'logId': instance.logId,
      'summary': instance.summary,
    };
