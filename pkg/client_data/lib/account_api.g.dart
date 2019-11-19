// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientSessionRequest _$ClientSessionRequestFromJson(Map<String, dynamic> json) {
  return ClientSessionRequest(
    accessToken: json['accessToken'] as String,
  );
}

Map<String, dynamic> _$ClientSessionRequestToJson(
        ClientSessionRequest instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
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

LikedPackagesRepsonse _$LikedPackagesRepsonseFromJson(
    Map<String, dynamic> json) {
  return LikedPackagesRepsonse(
    likedPackages: (json['likedPackages'] as List)
        ?.map((e) => e == null
            ? null
            : PackageLikeResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LikedPackagesRepsonseToJson(
        LikedPackagesRepsonse instance) =>
    <String, dynamic>{
      'likedPackages': instance.likedPackages,
    };

PackageLikeResponse _$PackageLikeResponseFromJson(Map<String, dynamic> json) {
  return PackageLikeResponse(
    package: json['package'] as String,
    liked: json['liked'] as bool,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
  );
}

Map<String, dynamic> _$PackageLikeResponseToJson(
        PackageLikeResponse instance) =>
    <String, dynamic>{
      'package': instance.package,
      'liked': instance.liked,
      'created': instance.created?.toIso8601String(),
    };

PackageLikesCount _$PackageLikesCountFromJson(Map<String, dynamic> json) {
  return PackageLikesCount(
    package: json['package'] as String,
    likes: json['likes'] as int,
  );
}

Map<String, dynamic> _$PackageLikesCountToJson(PackageLikesCount instance) =>
    <String, dynamic>{
      'package': instance.package,
      'likes': instance.likes,
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
