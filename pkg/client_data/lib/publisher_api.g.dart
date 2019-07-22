// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePublisherRequest _$CreatePublisherRequestFromJson(
    Map<String, dynamic> json) {
  return CreatePublisherRequest(
    accessToken: json['accessToken'] as String,
  );
}

Map<String, dynamic> _$CreatePublisherRequestToJson(
        CreatePublisherRequest instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
    };

UpdatePublisherRequest _$UpdatePublisherRequestFromJson(
    Map<String, dynamic> json) {
  return UpdatePublisherRequest(
    description: json['description'] as String,
    contact: json['contact'] as String,
  );
}

Map<String, dynamic> _$UpdatePublisherRequestToJson(
        UpdatePublisherRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'contact': instance.contact,
    };

PublisherInfo _$PublisherInfoFromJson(Map<String, dynamic> json) {
  return PublisherInfo(
    description: json['description'] as String,
    contact: json['contact'] as String,
  );
}

Map<String, dynamic> _$PublisherInfoToJson(PublisherInfo instance) =>
    <String, dynamic>{
      'description': instance.description,
      'contact': instance.contact,
    };

PublisherMembers _$PublisherMembersFromJson(Map<String, dynamic> json) {
  return PublisherMembers(
    members: (json['members'] as List)
        ?.map((e) => e == null
            ? null
            : PublisherMember.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PublisherMembersToJson(PublisherMembers instance) =>
    <String, dynamic>{
      'members': instance.members,
    };

PublisherMember _$PublisherMemberFromJson(Map<String, dynamic> json) {
  return PublisherMember(
    userId: json['userId'] as String,
    role: json['role'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$PublisherMemberToJson(PublisherMember instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'role': instance.role,
      'email': instance.email,
    };

UpdatePublisherMemberRequest _$UpdatePublisherMemberRequestFromJson(
    Map<String, dynamic> json) {
  return UpdatePublisherMemberRequest(
    role: json['role'] as String,
  );
}

Map<String, dynamic> _$UpdatePublisherMemberRequestToJson(
        UpdatePublisherMemberRequest instance) =>
    <String, dynamic>{
      'role': instance.role,
    };

InviteMemberRequest _$InviteMemberRequestFromJson(Map<String, dynamic> json) {
  return InviteMemberRequest(
    reason: json['reason'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$InviteMemberRequestToJson(
        InviteMemberRequest instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'email': instance.email,
    };
