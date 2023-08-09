// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'admin_api.g.dart';

/// Admin API response for listing all users.
@JsonSerializable()
class AdminListUsersResponse {
  /// List of users.
  ///
  /// This list may be incomplete, if so a [continuationToken] is included in
  /// this request.
  final List<AdminUserEntry> users;

  /// Token for requesting next batch of users.
  ///
  /// If the list of [users] is incomplete, because there is more users than a
  /// single request body can include, the [continuationToken] can be provided
  /// as query-string parameter `?ct=`, in another request.
  /// If [continuationToken] is `null` no further `users` can be returned.
  final String? continuationToken;

  // json_serializable boiler-plate
  AdminListUsersResponse({required this.users, this.continuationToken});
  factory AdminListUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminListUsersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdminListUsersResponseToJson(this);
}

/// Admin API response for listing all _admin actions_.
@JsonSerializable()
class AdminListActionsResponse {
  /// List of admin actions.
  final List<AdminAction> actions;

  // json_serializable boiler-plate
  AdminListActionsResponse({required this.actions});
  factory AdminListActionsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminListActionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdminListActionsResponseToJson(this);
}

@JsonSerializable()
class AdminAction {
  /// Name of the action is an identifier to be specified when the action is
  /// triggered.
  final String name;

  /// Map from option name to description of the option.
  ///
  /// This are specified as querystring parameters when invoking the action.
  final Map<String, String> options;

  /// A one-liner summary of what this action does.
  final String summary;

  /// A multi-line explanation of what this action does, written in markdown.
  ///
  /// This **must** explain what the action does? What the implications are?
  /// What other actions could be useful to use in conjunction.
  /// What are reasonable expectations around cache-time outs, etc.
  ///
  /// Do write detailed documentation and include examples.
  final String description;

  // json_serializable boiler-plate
  AdminAction({
    required this.name,
    required this.options,
    required this.summary,
    required this.description,
  });
  factory AdminAction.fromJson(Map<String, dynamic> json) =>
      _$AdminActionFromJson(json);
  Map<String, dynamic> toJson() => _$AdminActionToJson(this);
}

@JsonSerializable()
class AdminInvokeActionResponse {
  /// Output from running the action.
  final Map<String, Object?> output;

  AdminInvokeActionResponse({required this.output});
  factory AdminInvokeActionResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminInvokeActionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdminInvokeActionResponseToJson(this);
}

/// Entry in the [AdminListUsersResponse] structure.
@JsonSerializable()
class AdminUserEntry {
  /// The `pub.dev` specific user identifier.
  ///
  /// This is a random UUID generated when the user was created.
  final String? userId;

  /// OAuth2 `user_id`, if one was ever set (otherwise this is `null`).
  ///
  /// Legacy users may not have an [oauthUserId], if they have not signed in
  /// since we started recording this attribute.
  final String? oauthUserId;

  /// Email of the user.
  final String? email;

  // json_serializable boiler-plate
  AdminUserEntry({
    required this.userId,
    required this.email,
    this.oauthUserId,
  });
  factory AdminUserEntry.fromJson(Map<String, dynamic> json) =>
      _$AdminUserEntryFromJson(json);
  Map<String, dynamic> toJson() => _$AdminUserEntryToJson(this);
}

/// Admin API response for listing assigned tags.
@JsonSerializable()
class AssignedTags {
  final List<String> assignedTags;

  // json_serializable boiler-plate
  AssignedTags({required this.assignedTags});
  factory AssignedTags.fromJson(Map<String, dynamic> json) =>
      _$AssignedTagsFromJson(json);
  Map<String, dynamic> toJson() => _$AssignedTagsToJson(this);
}

/// Admin API request to mutate list of assigned tags.
@JsonSerializable()
class PatchAssignedTags {
  final List<String> assignedTagsAdded;
  final List<String> assignedTagsRemoved;

  // json_serializable boiler-plate
  PatchAssignedTags({
    this.assignedTagsAdded = const <String>[],
    this.assignedTagsRemoved = const <String>[],
  });
  factory PatchAssignedTags.fromJson(Map<String, dynamic> json) =>
      _$PatchAssignedTagsFromJson(json);
  Map<String, dynamic> toJson() => _$PatchAssignedTagsToJson(this);
}

@JsonSerializable()
class PackageUploaders {
  final List<AdminUserEntry> uploaders;

  PackageUploaders({required this.uploaders});

  factory PackageUploaders.fromJson(Map<String, dynamic> json) =>
      _$PackageUploadersFromJson(json);

  Map<String, dynamic> toJson() => _$PackageUploadersToJson(this);
}
