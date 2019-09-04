// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
    descriptionHtml: json['descriptionHtml'] as String,
  );
}

Map<String, dynamic> _$ConsentToJson(Consent instance) => <String, dynamic>{
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
