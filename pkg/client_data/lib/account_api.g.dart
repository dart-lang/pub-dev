// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountPkgOptions _$AccountPkgOptionsFromJson(Map<String, dynamic> json) {
  return AccountPkgOptions(
    isUploader: json['isUploader'] as bool,
  );
}

Map<String, dynamic> _$AccountPkgOptionsToJson(AccountPkgOptions instance) =>
    <String, dynamic>{
      'isUploader': instance.isUploader,
    };

Consent _$ConsentFromJson(Map<String, dynamic> json) {
  return Consent(
    html: json['html'] as String,
  );
}

Map<String, dynamic> _$ConsentToJson(Consent instance) => <String, dynamic>{
      'html': instance.html,
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
