// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientSessionRequest _$ClientSessionRequestFromJson(
        Map<String, dynamic> json) =>
    ClientSessionRequest(
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$ClientSessionRequestToJson(
        ClientSessionRequest instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
    };

ClientSessionStatus _$ClientSessionStatusFromJson(Map<String, dynamic> json) =>
    ClientSessionStatus(
      expires: json['expires'] == null
          ? null
          : DateTime.parse(json['expires'] as String),
      authenticatedAt: json['authenticatedAt'] == null
          ? null
          : DateTime.parse(json['authenticatedAt'] as String),
    );

Map<String, dynamic> _$ClientSessionStatusToJson(
        ClientSessionStatus instance) =>
    <String, dynamic>{
      'expires': instance.expires?.toIso8601String(),
      'authenticatedAt': instance.authenticatedAt?.toIso8601String(),
    };

LikedPackagesRepsonse _$LikedPackagesRepsonseFromJson(
        Map<String, dynamic> json) =>
    LikedPackagesRepsonse(
      likedPackages: (json['likedPackages'] as List<dynamic>?)
          ?.map((e) => PackageLikeResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LikedPackagesRepsonseToJson(
        LikedPackagesRepsonse instance) =>
    <String, dynamic>{
      'likedPackages': instance.likedPackages,
    };

PackageLikeResponse _$PackageLikeResponseFromJson(Map<String, dynamic> json) =>
    PackageLikeResponse(
      package: json['package'] as String?,
      liked: json['liked'] as bool?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$PackageLikeResponseToJson(
        PackageLikeResponse instance) =>
    <String, dynamic>{
      'package': instance.package,
      'liked': instance.liked,
      'created': instance.created?.toIso8601String(),
    };

PackageLikesCount _$PackageLikesCountFromJson(Map<String, dynamic> json) =>
    PackageLikesCount(
      package: json['package'] as String?,
      likes: json['likes'] as int?,
    );

Map<String, dynamic> _$PackageLikesCountToJson(PackageLikesCount instance) =>
    <String, dynamic>{
      'package': instance.package,
      'likes': instance.likes,
    };

AccountPkgOptions _$AccountPkgOptionsFromJson(Map<String, dynamic> json) =>
    AccountPkgOptions(
      isAdmin: json['isAdmin'] as bool?,
    );

Map<String, dynamic> _$AccountPkgOptionsToJson(AccountPkgOptions instance) =>
    <String, dynamic>{
      'isAdmin': instance.isAdmin,
    };

AccountPublisherOptions _$AccountPublisherOptionsFromJson(
        Map<String, dynamic> json) =>
    AccountPublisherOptions(
      isAdmin: json['isAdmin'] as bool?,
    );

Map<String, dynamic> _$AccountPublisherOptionsToJson(
        AccountPublisherOptions instance) =>
    <String, dynamic>{
      'isAdmin': instance.isAdmin,
    };

Consent _$ConsentFromJson(Map<String, dynamic> json) => Consent(
      titleText: json['titleText'] as String,
      descriptionHtml: json['descriptionHtml'] as String,
    );

Map<String, dynamic> _$ConsentToJson(Consent instance) => <String, dynamic>{
      'titleText': instance.titleText,
      'descriptionHtml': instance.descriptionHtml,
    };

ConsentResult _$ConsentResultFromJson(Map<String, dynamic> json) =>
    ConsentResult(
      granted: json['granted'] as bool,
    );

Map<String, dynamic> _$ConsentResultToJson(ConsentResult instance) =>
    <String, dynamic>{
      'granted': instance.granted,
    };

InviteStatus _$InviteStatusFromJson(Map<String, dynamic> json) => InviteStatus(
      emailSent: json['emailSent'] as bool,
      nextNotification: DateTime.parse(json['nextNotification'] as String),
    );

Map<String, dynamic> _$InviteStatusToJson(InviteStatus instance) =>
    <String, dynamic>{
      'emailSent': instance.emailSent,
      'nextNotification': instance.nextNotification.toIso8601String(),
    };
