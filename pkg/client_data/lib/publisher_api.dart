// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'publisher_api.g.dart';

/// Request payload when creating a publisher.
@JsonSerializable()
class CreatePublisherRequest {
  /// The OAuth2 `access_token` to be used with webmasters API to prove
  /// ownership of the domain.
  ///
  /// This must:
  ///  * be valid at the time of the request,
  ///  * obtained from the OAuth2 flow used on the pub.dev website,
  ///  * have the scope: `'https://www.googleapis.com/auth/webmasters.readonly'`.
  final String accessToken;

  // json_serializable boiler-plate
  CreatePublisherRequest({@required this.accessToken});
  factory CreatePublisherRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePublisherRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePublisherRequestToJson(this);
}

/// Request payload when updating a publisher.
@JsonSerializable()
class UpdatePublisherRequest {
  /// A human readable description in markdown.
  ///
  /// If left as `null` this field will be ignored, and the description of the
  /// publisher will not be changed.
  final String description;

  /// A valid URL that points to the publisher's website.
  ///
  /// If left as `null` this field will be ignored, and the website URL of the
  /// publisher will not be changed.
  final String websiteUrl;

  /// Email to be set as contact email for the publisher.
  ///
  /// If left as `null` this field will be ignored.
  /// If changed, the change will not take effect until the confirmation email
  /// have been confirmed by the user.
  final String contactEmail;

  // json_serializable boiler-plate
  UpdatePublisherRequest({
    this.description,
    this.websiteUrl,
    this.contactEmail,
  });

  factory UpdatePublisherRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePublisherRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePublisherRequestToJson(this);
}

/// Response payload for fetching a publisher.
@JsonSerializable()
class PublisherInfo {
  /// A human readable description in markdown.
  final String description;

  /// The website URL of the publisher.
  final String websiteUrl;

  /// The currently verified contact email for the publisher.
  final String contactEmail;

  // json_serializable boiler-plate
  PublisherInfo({
    @required this.description,
    @required this.websiteUrl,
    @required this.contactEmail,
  });

  factory PublisherInfo.fromJson(Map<String, dynamic> json) =>
      _$PublisherInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PublisherInfoToJson(this);
}

/// Response payload for fetching list of members for a given publisher.
@JsonSerializable()
class PublisherMembers {
  /// List of members of the publisher
  final List<PublisherMember> members;

  // json_serializable boiler-plate
  PublisherMembers({@required this.members});
  factory PublisherMembers.fromJson(Map<String, dynamic> json) =>
      _$PublisherMembersFromJson(json);
  Map<String, dynamic> toJson() => _$PublisherMembersToJson(this);
}

/// Response payload for fetching a specific member of a given publisher.
@JsonSerializable()
class PublisherMember {
  /// Unqiue user identifier, specific to `pub.dev`.
  final String userId;

  /// The role or access-level of for this user in the given publisher.
  ///
  /// Allowed values are:
  ///  * `'admin'`, can perform any operation.
  final String role;

  /// Verified email address of the user.
  ///
  /// This is how users are displayed in the user-interface.
  final String email;

  // json_serializable boiler-plate
  PublisherMember({
    @required this.userId,
    @required this.role,
    @required this.email,
  });

  factory PublisherMember.fromJson(Map<String, dynamic> json) =>
      _$PublisherMemberFromJson(json);
  Map<String, dynamic> toJson() => _$PublisherMemberToJson(this);
}

/// Request payload for updating a users membership of a publisher.'
@JsonSerializable()
class UpdatePublisherMemberRequest {
  /// The role or access-level of for this user in the given publisher.
  ///
  /// Allowed values are:
  ///  * `'admin'`, can perform any operation.
  ///
  /// If left `null` the server will ignore this field and leave it unchanged.
  final String role;

  // json_serializable boiler-plate
  UpdatePublisherMemberRequest({this.role});
  factory UpdatePublisherMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePublisherMemberRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePublisherMemberRequestToJson(this);
}

/// Request payload for inviting a new user to become member of a publisher.
@JsonSerializable()
class InviteMemberRequest {
  /// Email to which the invitation will be sent.
  ///
  /// This must be the primary email associated with the invited users Google
  /// Account. The invited user will later be required to sign-in with a
  /// Google Account that has this email in-order to accept the invitation.
  final String email;

  // json_serializable boiler-plate
  InviteMemberRequest({@required this.email});
  factory InviteMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$InviteMemberRequestFromJson(json);
  Map<String, dynamic> toJson() => _$InviteMemberRequestToJson(this);
}
