// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DartdocEntry _$DartdocEntryFromJson(Map<String, dynamic> json) => DartdocEntry(
      uuid: json['uuid'] as String,
      packageName: json['packageName'] as String,
      packageVersion: json['packageVersion'] as String,
      isLatest: json['isLatest'] as bool? ?? false,
      isObsolete: json['isObsolete'] as bool?,
      usesFlutter: json['usesFlutter'] as bool?,
      runtimeVersion: json['runtimeVersion'] as String,
      sdkVersion: json['sdkVersion'] as String?,
      dartdocVersion: json['dartdocVersion'] as String?,
      flutterVersion: json['flutterVersion'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      runDuration: json['runDuration'] == null
          ? null
          : Duration(microseconds: json['runDuration'] as int),
      depsResolved: json['depsResolved'] as bool?,
      hasContent: json['hasContent'] as bool? ?? false,
      archiveSize: json['archiveSize'] as int?,
      totalSize: json['totalSize'] as int?,
      blobSize: json['blobSize'] as int?,
      blobIndexSize: json['blobIndexSize'] as int?,
    );

Map<String, dynamic> _$DartdocEntryToJson(DartdocEntry instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'isLatest': instance.isLatest,
      'isObsolete': instance.isObsolete,
      'usesFlutter': instance.usesFlutter,
      'runtimeVersion': instance.runtimeVersion,
      'sdkVersion': instance.sdkVersion,
      'dartdocVersion': instance.dartdocVersion,
      'flutterVersion': instance.flutterVersion,
      'timestamp': instance.timestamp?.toIso8601String(),
      'runDuration': instance.runDuration?.inMicroseconds,
      'depsResolved': instance.depsResolved,
      'hasContent': instance.hasContent,
      'archiveSize': instance.archiveSize,
      'totalSize': instance.totalSize,
      'blobSize': instance.blobSize,
      'blobIndexSize': instance.blobIndexSize,
    };

FileInfo _$FileInfoFromJson(Map<String, dynamic> json) => FileInfo(
      lastModified: DateTime.parse(json['lastModified'] as String),
      etag: json['etag'] as String,
      blobId: json['blobId'] as String?,
      blobOffset: json['blobOffset'] as int?,
      blobLength: json['blobLength'] as int?,
      contentLength: json['contentLength'] as int?,
    );

Map<String, dynamic> _$FileInfoToJson(FileInfo instance) => <String, dynamic>{
      'lastModified': instance.lastModified.toIso8601String(),
      'etag': instance.etag,
      'blobId': instance.blobId,
      'blobOffset': instance.blobOffset,
      'blobLength': instance.blobLength,
      'contentLength': instance.contentLength,
    };
