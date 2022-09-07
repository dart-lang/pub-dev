// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadTaskResultResponse _$UploadTaskResultResponseFromJson(
        Map<String, dynamic> json) =>
    UploadTaskResultResponse(
      dartdocBlobId: json['dartdocBlobId'] as String,
      panaLogId: json['panaLogId'] as String,
      dartdocBlob:
          UploadInfo.fromJson(json['dartdocBlob'] as Map<String, dynamic>),
      dartdocIndex:
          UploadInfo.fromJson(json['dartdocIndex'] as Map<String, dynamic>),
      panaLog: UploadInfo.fromJson(json['panaLog'] as Map<String, dynamic>),
      panaReport:
          UploadInfo.fromJson(json['panaReport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UploadTaskResultResponseToJson(
        UploadTaskResultResponse instance) =>
    <String, dynamic>{
      'dartdocBlobId': instance.dartdocBlobId,
      'panaLogId': instance.panaLogId,
      'dartdocBlob': instance.dartdocBlob,
      'dartdocIndex': instance.dartdocIndex,
      'panaLog': instance.panaLog,
      'panaReport': instance.panaReport,
    };
