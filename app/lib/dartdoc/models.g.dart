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
