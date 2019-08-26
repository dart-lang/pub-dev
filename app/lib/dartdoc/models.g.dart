// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DartdocEntry _$DartdocEntryFromJson(Map<String, dynamic> json) {
  return DartdocEntry(
    uuid: json['uuid'] as String,
    packageName: json['packageName'] as String,
    packageVersion: json['packageVersion'] as String,
    isLatest: json['isLatest'] as bool,
    isObsolete: json['isObsolete'] as bool,
    usesFlutter: json['usesFlutter'] as bool,
    runtimeVersion: json['runtimeVersion'] as String,
    sdkVersion: json['sdkVersion'] as String,
    dartdocVersion: json['dartdocVersion'] as String,
    flutterVersion: json['flutterVersion'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    depsResolved: json['depsResolved'] as bool,
    hasContent: json['hasContent'] as bool,
    archiveSize: json['archiveSize'] as int,
    totalSize: json['totalSize'] as int,
  );
}

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
      'depsResolved': instance.depsResolved,
      'hasContent': instance.hasContent,
      'archiveSize': instance.archiveSize,
      'totalSize': instance.totalSize,
    };

FileInfo _$FileInfoFromJson(Map<String, dynamic> json) {
  return FileInfo(
    lastModified: json['lastModified'] == null
        ? null
        : DateTime.parse(json['lastModified'] as String),
    etag: json['etag'] as String,
  );
}

Map<String, dynamic> _$FileInfoToJson(FileInfo instance) => <String, dynamic>{
      'lastModified': instance.lastModified?.toIso8601String(),
      'etag': instance.etag,
    };
