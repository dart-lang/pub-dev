// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
