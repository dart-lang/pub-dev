// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadTaskResultResponse _$UploadTaskResultResponseFromJson(
        Map<String, dynamic> json) =>
    UploadTaskResultResponse(
      blobId: json['blobId'] as String,
      blob: UploadInfo.fromJson(json['blob'] as Map<String, dynamic>),
      index: UploadInfo.fromJson(json['index'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UploadTaskResultResponseToJson(
        UploadTaskResultResponse instance) =>
    <String, dynamic>{
      'blobId': instance.blobId,
      'blob': instance.blob,
      'index': instance.index,
    };
