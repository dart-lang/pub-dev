// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payload _$PayloadFromJson(Map<String, dynamic> json) => Payload(
  package: json['package'] as String,
  pubHostedUrl: json['pubHostedUrl'] as String,
  versions: (json['versions'] as List<dynamic>).map(
    (e) => VersionTokenPair.fromJson(e as Map<String, dynamic>),
  ),
);

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
  'package': instance.package,
  'pubHostedUrl': instance.pubHostedUrl,
  'versions': instance.versions,
};

VersionTokenPair _$VersionTokenPairFromJson(Map<String, dynamic> json) =>
    VersionTokenPair(
      version: json['version'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$VersionTokenPairToJson(VersionTokenPair instance) =>
    <String, dynamic>{'version': instance.version, 'token': instance.token};
