// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageData _$PageDataFromJson(Map<String, dynamic> json) => PageData(
      consentId: json['consentId'] as String?,
      pkgData: json['pkgData'] == null
          ? null
          : PkgData.fromJson(json['pkgData'] as Map<String, dynamic>),
      publisher: json['publisher'] == null
          ? null
          : PublisherData.fromJson(json['publisher'] as Map<String, dynamic>),
      sessionAware: json['sessionAware'] as bool?,
    );

Map<String, dynamic> _$PageDataToJson(PageData instance) => <String, dynamic>{
      if (instance.consentId case final value?) 'consentId': value,
      if (instance.pkgData case final value?) 'pkgData': value,
      if (instance.publisher case final value?) 'publisher': value,
      if (instance.sessionAware case final value?) 'sessionAware': value,
    };

PkgData _$PkgDataFromJson(Map<String, dynamic> json) => PkgData(
      package: json['package'] as String,
      version: json['version'] as String,
      publisherId: json['publisherId'] as String?,
      isDiscontinued: json['isDiscontinued'] as bool,
      likes: (json['likes'] as num).toInt(),
      isLatest: json['isLatest'] as bool,
    );

Map<String, dynamic> _$PkgDataToJson(PkgData instance) => <String, dynamic>{
      'package': instance.package,
      'version': instance.version,
      'likes': instance.likes,
      if (instance.publisherId case final value?) 'publisherId': value,
      'isDiscontinued': instance.isDiscontinued,
      'isLatest': instance.isLatest,
    };

PublisherData _$PublisherDataFromJson(Map<String, dynamic> json) =>
    PublisherData(
      publisherId: json['publisherId'] as String,
    );

Map<String, dynamic> _$PublisherDataToJson(PublisherData instance) =>
    <String, dynamic>{
      'publisherId': instance.publisherId,
    };
