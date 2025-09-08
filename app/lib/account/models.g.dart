// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeData _$LikeDataFromJson(Map<String, dynamic> json) => LikeData(
  userId: json['userId'] as String?,
  package: json['package'] as String?,
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
);

Map<String, dynamic> _$LikeDataToJson(LikeData instance) => <String, dynamic>{
  'userId': instance.userId,
  'package': instance.package,
  'created': instance.created?.toIso8601String(),
};

SessionData _$SessionDataFromJson(Map<String, dynamic> json) => SessionData(
  sessionId: json['sessionId'] as String,
  userId: json['userId'] as String?,
  email: json['email'] as String?,
  name: json['name'] as String?,
  imageUrl: json['imageUrl'] as String?,
  created: DateTime.parse(json['created'] as String),
  expires: DateTime.parse(json['expires'] as String),
  authenticatedAt: json['authenticatedAt'] == null
      ? null
      : DateTime.parse(json['authenticatedAt'] as String),
  csrfToken: json['csrfToken'] as String?,
  grantedScopes: (json['grantedScopes'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$SessionDataToJson(SessionData instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'created': instance.created.toIso8601String(),
      'expires': instance.expires.toIso8601String(),
      'authenticatedAt': instance.authenticatedAt?.toIso8601String(),
      'csrfToken': instance.csrfToken,
      'grantedScopes': instance.grantedScopes,
    };
