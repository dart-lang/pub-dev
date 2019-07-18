// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountPkgOptions _$AccountPkgOptionsFromJson(Map<String, dynamic> json) {
  return AccountPkgOptions(isUploader: json['isUploader'] as bool);
}

Map<String, dynamic> _$AccountPkgOptionsToJson(AccountPkgOptions instance) =>
    <String, dynamic>{'isUploader': instance.isUploader};

ConsentResult _$ConsentResultFromJson(Map<String, dynamic> json) {
  return ConsentResult(granted: json['granted'] as bool);
}

Map<String, dynamic> _$ConsentResultToJson(ConsentResult instance) =>
    <String, dynamic>{'granted': instance.granted};
