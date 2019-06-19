// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) {
  return AccountInfo(
      email: json['email'] as String,
      pkgScopeData: json['pkgScopeData'] == null
          ? null
          : PkgScopeData.fromJson(
              json['pkgScopeData'] as Map<String, dynamic>));
}

Map<String, dynamic> _$AccountInfoToJson(AccountInfo instance) =>
    <String, dynamic>{
      'email': instance.email,
      'pkgScopeData': instance.pkgScopeData
    };

PkgScopeData _$PkgScopeDataFromJson(Map<String, dynamic> json) {
  return PkgScopeData(
      package: json['package'] as String,
      isUploader: json['isUploader'] as bool);
}

Map<String, dynamic> _$PkgScopeDataToJson(PkgScopeData instance) =>
    <String, dynamic>{
      'package': instance.package,
      'isUploader': instance.isUploader
    };
