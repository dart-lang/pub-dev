// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminListUsersResponse _$AdminListUsersResponseFromJson(
    Map<String, dynamic> json) {
  return AdminListUsersResponse(
    users: (json['users'] as List<dynamic>)
        .map((e) => AdminUserEntry.fromJson(e as Map<String, dynamic>))
        .toList(),
    continuationToken: json['continuationToken'] as String?,
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
    userId: json['userId'] as String?,
    email: json['email'] as String?,
    oauthUserId: json['oauthUserId'] as String?,
  );
}

Map<String, dynamic> _$AdminUserEntryToJson(AdminUserEntry instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'oauthUserId': instance.oauthUserId,
      'email': instance.email,
    };

AssignedTags _$AssignedTagsFromJson(Map<String, dynamic> json) {
  return AssignedTags(
    assignedTags: (json['assignedTags'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$AssignedTagsToJson(AssignedTags instance) =>
    <String, dynamic>{
      'assignedTags': instance.assignedTags,
    };

PatchAssignedTags _$PatchAssignedTagsFromJson(Map<String, dynamic> json) {
  return PatchAssignedTags(
    assignedTagsAdded: (json['assignedTagsAdded'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    assignedTagsRemoved: (json['assignedTagsRemoved'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$PatchAssignedTagsToJson(PatchAssignedTags instance) =>
    <String, dynamic>{
      'assignedTagsAdded': instance.assignedTagsAdded,
      'assignedTagsRemoved': instance.assignedTagsRemoved,
    };

PackageUploaders _$PackageUploadersFromJson(Map<String, dynamic> json) {
  return PackageUploaders(
    uploaders: (json['uploaders'] as List<dynamic>)
        .map((e) => AdminUserEntry.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PackageUploadersToJson(PackageUploaders instance) =>
    <String, dynamic>{
      'uploaders': instance.uploaders,
    };
