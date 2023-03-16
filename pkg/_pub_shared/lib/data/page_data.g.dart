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

Map<String, dynamic> _$PageDataToJson(PageData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('consentId', instance.consentId);
  writeNotNull('pkgData', instance.pkgData);
  writeNotNull('publisher', instance.publisher);
  writeNotNull('sessionAware', instance.sessionAware);
  return val;
}

PkgData _$PkgDataFromJson(Map<String, dynamic> json) => PkgData(
      package: json['package'] as String,
      version: json['version'] as String,
      publisherId: json['publisherId'] as String?,
      isDiscontinued: json['isDiscontinued'] as bool,
      likes: json['likes'] as int,
    );

Map<String, dynamic> _$PkgDataToJson(PkgData instance) {
  final val = <String, dynamic>{
    'package': instance.package,
    'version': instance.version,
    'likes': instance.likes,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('publisherId', instance.publisherId);
  val['isDiscontinued'] = instance.isDiscontinued;
  return val;
}

PublisherData _$PublisherDataFromJson(Map<String, dynamic> json) =>
    PublisherData(
      publisherId: json['publisherId'] as String,
    );

Map<String, dynamic> _$PublisherDataToJson(PublisherData instance) =>
    <String, dynamic>{
      'publisherId': instance.publisherId,
    };
