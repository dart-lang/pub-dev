// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payload _$PayloadFromJson(Map<String, dynamic> json) => Payload(
      package: json['package'] as String,
      callback: json['callback'] as String,
      versions: (json['versions'] as List<dynamic>)
          .map((e) => VersionTokenPair.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
      'package': instance.package,
      'callback': instance.callback,
      'versions': instance.versions,
    };

VersionTokenPair _$VersionTokenPairFromJson(Map<String, dynamic> json) =>
    VersionTokenPair(
      version: json['version'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$VersionTokenPairToJson(VersionTokenPair instance) =>
    <String, dynamic>{
      'version': instance.version,
      'token': instance.token,
    };
