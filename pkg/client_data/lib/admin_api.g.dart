// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminListUsersResponse _$AdminListUsersResponseFromJson(
    Map<String, dynamic> json) {
  return AdminListUsersResponse(
    users: (json['users'] as List)
        ?.map((e) => e == null
            ? null
            : AdminUserEntry.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    continuationToken: json['continuationToken'] as String,
  );
}

Map<String, dynamic> _$AdminListUsersResponseToJson(
        AdminListUsersResponse instance) =>
    <String, dynamic>{
      'users': instance.users,
      'continuationToken': instance.continuationToken,
    };

AdminUserEntry _$AdminUserEntryFromJson(Map<String, dynamic> json) {
  return AdminUserEntry(
    userId: json['userId'] as String,
    email: json['email'] as String,
    oauthUserId: json['oauthUserId'] as String,
  );
}

Map<String, dynamic> _$AdminUserEntryToJson(AdminUserEntry instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'oauthUserId': instance.oauthUserId,
      'email': instance.email,
    };
