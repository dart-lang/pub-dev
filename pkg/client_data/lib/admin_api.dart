// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

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
  final String continuationToken;

  // json_serializable boiler-plate
  AdminListUsersResponse({@required this.users, this.continuationToken});
  factory AdminListUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminListUsersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdminListUsersResponseToJson(this);
}

/// Entry in the [AdminListUsersResponse] structure.
@JsonSerializable()
class AdminUserEntry {
  /// The `pub.dev` specific user identifier.
  ///
  /// This is a random UUID generated when the user was created.
  final String userId;

  /// OAuth2 `user_id`, if one was ever set (otherwise this is `null`).
  ///
  /// Legacy users may not have an [oauthUserId], if they have not signed in
  /// since we started recording this attribute.
  final String oauthUserId;

  /// Email of the user.
  final String email;

  // json_serializable boiler-plate
  AdminUserEntry({
    @required this.userId,
    @required this.email,
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
  AssignedTags({@required this.assignedTags});
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
