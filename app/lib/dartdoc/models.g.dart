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
    ResolvedDocUrlVersion instance) {
  final val = <String, dynamic>{
    'version': instance.version,
    'urlSegment': instance.urlSegment,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  return val;
}

DocPageStatus _$DocPageStatusFromJson(Map<String, dynamic> json) =>
    DocPageStatus(
      code: $enumDecode(_$DocPageStatusCodeEnumMap, json['code']),
      redirectPath: json['redirectPath'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$DocPageStatusToJson(DocPageStatus instance) {
  final val = <String, dynamic>{
    'code': _$DocPageStatusCodeEnumMap[instance.code]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('redirectPath', instance.redirectPath);
  writeNotNull('errorMessage', instance.errorMessage);
  return val;
}

const _$DocPageStatusCodeEnumMap = {
  DocPageStatusCode.ok: 'ok',
  DocPageStatusCode.redirect: 'redirect',
  DocPageStatusCode.missing: 'missing',
};
