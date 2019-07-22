// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageData _$PageDataFromJson(Map<String, dynamic> json) {
  return PageData(
    pkgData: json['pkgData'] == null
        ? null
        : PkgData.fromJson(json['pkgData'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PageDataToJson(PageData instance) => <String, dynamic>{
      'pkgData': instance.pkgData,
    };

PkgData _$PkgDataFromJson(Map<String, dynamic> json) {
  return PkgData(
    package: json['package'] as String,
    version: json['version'] as String,
    isDiscontinued: json['isDiscontinued'] as bool,
  );
}

Map<String, dynamic> _$PkgDataToJson(PkgData instance) => <String, dynamic>{
      'package': instance.package,
      'version': instance.version,
      'isDiscontinued': instance.isDiscontinued,
    };
