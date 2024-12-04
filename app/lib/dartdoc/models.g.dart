// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResolvedDocUrlVersion _$ResolvedDocUrlVersionFromJson(
        Map<String, dynamic> json) =>
    ResolvedDocUrlVersion(
      version: json['version'] as String,
      urlSegment: json['urlSegment'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResolvedDocUrlVersionToJson(
        ResolvedDocUrlVersion instance) =>
    <String, dynamic>{
      'version': instance.version,
      'urlSegment': instance.urlSegment,
      if (instance.message case final value?) 'message': value,
    };

DocPageStatus _$DocPageStatusFromJson(Map<String, dynamic> json) =>
    DocPageStatus(
      code: $enumDecode(_$DocPageStatusCodeEnumMap, json['code']),
      redirectPath: json['redirectPath'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$DocPageStatusToJson(DocPageStatus instance) =>
    <String, dynamic>{
      'code': _$DocPageStatusCodeEnumMap[instance.code]!,
      if (instance.redirectPath case final value?) 'redirectPath': value,
      if (instance.errorMessage case final value?) 'errorMessage': value,
    };

const _$DocPageStatusCodeEnumMap = {
  DocPageStatusCode.ok: 'ok',
  DocPageStatusCode.redirect: 'redirect',
  DocPageStatusCode.missing: 'missing',
};
