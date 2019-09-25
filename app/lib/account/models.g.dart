// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSessionData _$UserSessionDataFromJson(Map<String, dynamic> json) {
  return UserSessionData(
    sessionId: json['sessionId'] as String,
    userId: json['userId'] as String,
    email: json['email'] as String,
    imageUrl: json['imageUrl'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    expires: json['expires'] == null
        ? null
        : DateTime.parse(json['expires'] as String),
  );
}

Map<String, dynamic> _$UserSessionDataToJson(UserSessionData instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'userId': instance.userId,
      'email': instance.email,
      'imageUrl': instance.imageUrl,
      'created': instance.created?.toIso8601String(),
      'expires': instance.expires?.toIso8601String(),
    };
