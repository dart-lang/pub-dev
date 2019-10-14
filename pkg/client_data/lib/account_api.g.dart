// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientSessionData _$ClientSessionDataFromJson(Map<String, dynamic> json) {
  return ClientSessionData(
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$ClientSessionDataToJson(ClientSessionData instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
    };

ClientSessionStatus _$ClientSessionStatusFromJson(Map<String, dynamic> json) {
  return ClientSessionStatus(
    changed: json['changed'] as bool,
    expires: json['expires'] == null
        ? null
        : DateTime.parse(json['expires'] as String),
  );
}

Map<String, dynamic> _$ClientSessionStatusToJson(
        ClientSessionStatus instance) =>
    <String, dynamic>{
      'changed': instance.changed,
      'expires': instance.expires?.toIso8601String(),
    };

PackageLikes _$PackageLikesFromJson(Map<String, dynamic> json) {
  return PackageLikes(
    (json['likedPackages'] as List)
        ?.map((e) =>
            e == null ? null : PackageLike.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PackageLikesToJson(PackageLikes instance) =>
    <String, dynamic>{
      'likedPackages': instance.likedPackages,
    };

PackageLike _$PackageLikeFromJson(Map<String, dynamic> json) {
  return PackageLike(
    package: json['package'] as String,
    liked: json['liked'] as bool,
  );
}

Map<String, dynamic> _$PackageLikeToJson(PackageLike instance) =>
    <String, dynamic>{
      'package': instance.package,
      'liked': instance.liked,
    };

AccountPkgOptions _$AccountPkgOptionsFromJson(Map<String, dynamic> json) {
  return AccountPkgOptions(
    isAdmin: json['isAdmin'] as bool,
  );
}

Map<String, dynamic> _$AccountPkgOptionsToJson(AccountPkgOptions instance) =>
    <String, dynamic>{
      'isAdmin': instance.isAdmin,
    };

AccountPublisherOptions _$AccountPublisherOptionsFromJson(
    Map<String, dynamic> json) {
  return AccountPublisherOptions(
    isAdmin: json['isAdmin'] as bool,
  );
}

Map<String, dynamic> _$AccountPublisherOptionsToJson(
        AccountPublisherOptions instance) =>
    <String, dynamic>{
      'isAdmin': instance.isAdmin,
    };

Consent _$ConsentFromJson(Map<String, dynamic> json) {
  return Consent(
    titleText: json['titleText'] as String,
    descriptionHtml: json['descriptionHtml'] as String,
  );
}

Map<String, dynamic> _$ConsentToJson(Consent instance) => <String, dynamic>{
      'titleText': instance.titleText,
      'descriptionHtml': instance.descriptionHtml,
    };

ConsentResult _$ConsentResultFromJson(Map<String, dynamic> json) {
  return ConsentResult(
    granted: json['granted'] as bool,
  );
}

Map<String, dynamic> _$ConsentResultToJson(ConsentResult instance) =>
    <String, dynamic>{
      'granted': instance.granted,
    };

InviteStatus _$InviteStatusFromJson(Map<String, dynamic> json) {
  return InviteStatus(
    emailSent: json['emailSent'] as bool,
    nextNotification: json['nextNotification'] == null
        ? null
        : DateTime.parse(json['nextNotification'] as String),
  );
}

Map<String, dynamic> _$InviteStatusToJson(InviteStatus instance) =>
    <String, dynamic>{
      'emailSent': instance.emailSent,
      'nextNotification': instance.nextNotification?.toIso8601String(),
    };
