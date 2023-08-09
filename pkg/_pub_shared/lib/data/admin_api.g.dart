// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminListUsersResponse _$AdminListUsersResponseFromJson(
        Map<String, dynamic> json) =>
    AdminListUsersResponse(
      users: (json['users'] as List<dynamic>)
          .map((e) => AdminUserEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      continuationToken: json['continuationToken'] as String?,
    );

Map<String, dynamic> _$AdminListUsersResponseToJson(
        AdminListUsersResponse instance) =>
    <String, dynamic>{
      'users': instance.users,
      'continuationToken': instance.continuationToken,
    };

AdminListActionsResponse _$AdminListActionsResponseFromJson(
        Map<String, dynamic> json) =>
    AdminListActionsResponse(
      actions: (json['actions'] as List<dynamic>)
          .map((e) => AdminAction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdminListActionsResponseToJson(
        AdminListActionsResponse instance) =>
    <String, dynamic>{
      'actions': instance.actions,
    };

AdminAction _$AdminActionFromJson(Map<String, dynamic> json) => AdminAction(
      name: json['name'] as String,
      options: Map<String, String>.from(json['options'] as Map),
      summary: json['summary'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AdminActionToJson(AdminAction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'options': instance.options,
      'summary': instance.summary,
      'description': instance.description,
    };

AdminInvokeActionResponse _$AdminInvokeActionResponseFromJson(
        Map<String, dynamic> json) =>
    AdminInvokeActionResponse(
      output: json['output'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AdminInvokeActionResponseToJson(
        AdminInvokeActionResponse instance) =>
    <String, dynamic>{
      'output': instance.output,
    };

AdminUserEntry _$AdminUserEntryFromJson(Map<String, dynamic> json) =>
    AdminUserEntry(
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      oauthUserId: json['oauthUserId'] as String?,
    );

Map<String, dynamic> _$AdminUserEntryToJson(AdminUserEntry instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'oauthUserId': instance.oauthUserId,
      'email': instance.email,
    };

AssignedTags _$AssignedTagsFromJson(Map<String, dynamic> json) => AssignedTags(
      assignedTags: (json['assignedTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AssignedTagsToJson(AssignedTags instance) =>
    <String, dynamic>{
      'assignedTags': instance.assignedTags,
    };

PatchAssignedTags _$PatchAssignedTagsFromJson(Map<String, dynamic> json) =>
    PatchAssignedTags(
      assignedTagsAdded: (json['assignedTagsAdded'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      assignedTagsRemoved: (json['assignedTagsRemoved'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$PatchAssignedTagsToJson(PatchAssignedTags instance) =>
    <String, dynamic>{
      'assignedTagsAdded': instance.assignedTagsAdded,
      'assignedTagsRemoved': instance.assignedTagsRemoved,
    };

PackageUploaders _$PackageUploadersFromJson(Map<String, dynamic> json) =>
    PackageUploaders(
      uploaders: (json['uploaders'] as List<dynamic>)
          .map((e) => AdminUserEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageUploadersToJson(PackageUploaders instance) =>
    <String, dynamic>{
      'uploaders': instance.uploaders,
    };
