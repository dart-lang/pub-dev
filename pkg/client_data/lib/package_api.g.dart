// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AsyncUploadInfo _$AsyncUploadInfoFromJson(Map<String, dynamic> json) {
  return AsyncUploadInfo(
    url: json['url'] as String,
    fields: (json['fields'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$AsyncUploadInfoToJson(AsyncUploadInfo instance) =>
    <String, dynamic>{
      'url': instance.url,
      'fields': instance.fields,
    };

PkgOptions _$PkgOptionsFromJson(Map<String, dynamic> json) {
  return PkgOptions(
    isDiscontinued: json['isDiscontinued'] as bool,
  );
}

Map<String, dynamic> _$PkgOptionsToJson(PkgOptions instance) =>
    <String, dynamic>{
      'isDiscontinued': instance.isDiscontinued,
    };

PackagePublisherInfo _$PackagePublisherInfoFromJson(Map<String, dynamic> json) {
  return PackagePublisherInfo(
    publisherId: json['publisherId'] as String,
  );
}

Map<String, dynamic> _$PackagePublisherInfoToJson(
        PackagePublisherInfo instance) =>
    <String, dynamic>{
      'publisherId': instance.publisherId,
    };
