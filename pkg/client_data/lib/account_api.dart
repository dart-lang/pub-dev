// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'account_api.g.dart';

/// A session request to be processed on the server.
@JsonSerializable()
class ClientSessionRequest {
  /// The OAuth2 `access_token` to be used when accessing profile data like
  /// image URL.
  ///
  /// This must:
  ///  * be valid at the time of the request,
  ///  * obtained from the OAuth2 flow used on the pub.dev website.
  final String accessToken;

  ClientSessionRequest({
    @required this.accessToken,
  });

  factory ClientSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$ClientSessionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ClientSessionRequestToJson(this);
}

/// The server-provided status of the current session.
@JsonSerializable()
class ClientSessionStatus {
  /// True, if the user session has been updated and the current page should be
  /// reloaded.
  final bool changed;
  final DateTime expires;

  ClientSessionStatus({
    @required this.changed,
    @required this.expires,
  });

  factory ClientSessionStatus.fromJson(Map<String, dynamic> json) =>
      _$ClientSessionStatusFromJson(json);

  factory ClientSessionStatus.fromBytes(List<int> bytes) =>
      ClientSessionStatus.fromJson(
          json.decode(utf8.decode(bytes)) as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$ClientSessionStatusToJson(this);

  bool get isValid => expires != null && DateTime.now().isBefore(expires);
}

/// Response from listing of likes.
@JsonSerializable()
class LikedPackagesRepsonse {
  List<PackageLikeResponse> likedPackages;
  LikedPackagesRepsonse({@required this.likedPackages});

  factory LikedPackagesRepsonse.fromJson(Map<String, dynamic> json) =>
      _$LikedPackagesRepsonseFromJson(json);

  Map<String, dynamic> toJson() => _$LikedPackagesRepsonseToJson(this);
}

/// Response from quering or putting a package like.
///
/// [created] might be null when [liked] is `false`.
@JsonSerializable()
class PackageLikeResponse {
  String package;
  bool liked;
  DateTime created;

  PackageLikeResponse(
      {@required this.package, @required this.liked, this.created});

  factory PackageLikeResponse.fromJson(Map<String, dynamic> json) =>
      _$PackageLikeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PackageLikeResponseToJson(this);
}

/// Response from querying a package to see how many likes it has.
@JsonSerializable()
class PackageLikesCount {
  /// Package that was liked.
  String package;

  /// Number of users who have liked [package].
  int likes;

  PackageLikesCount({@required this.package, @required this.likes});

  factory PackageLikesCount.fromJson(Map<String, dynamic> json) =>
      _$PackageLikesCountFromJson(json);

  Map<String, dynamic> toJson() => _$PackageLikesCountToJson(this);
}

/// Account-specific information about a package.
@JsonSerializable()
class AccountPkgOptions {
  final bool isAdmin;

  AccountPkgOptions({
    @required this.isAdmin,
  });

  factory AccountPkgOptions.fromJson(Map<String, dynamic> json) =>
      _$AccountPkgOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$AccountPkgOptionsToJson(this);
}

/// Account-specific information about a publisher.
@JsonSerializable()
class AccountPublisherOptions {
  final bool isAdmin;

  AccountPublisherOptions({
    @required this.isAdmin,
  });

  factory AccountPublisherOptions.fromJson(Map<String, dynamic> json) =>
      _$AccountPublisherOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$AccountPublisherOptionsToJson(this);
}

@JsonSerializable(nullable: false)
class Consent {
  /// Title for this consent request.
  final String titleText;

  /// The description of the consent request, in HTML format.
  final String descriptionHtml;

  Consent({
    @required this.titleText,
    @required this.descriptionHtml,
  });

  factory Consent.fromJson(Map<String, dynamic> json) =>
      _$ConsentFromJson(json);

  Map<String, dynamic> toJson() => _$ConsentToJson(this);
}

@JsonSerializable(nullable: false)
class ConsentResult {
  final bool granted;

  ConsentResult({@required this.granted});

  factory ConsentResult.fromJson(Map<String, dynamic> json) =>
      _$ConsentResultFromJson(json);

  Map<String, dynamic> toJson() => _$ConsentResultToJson(this);
}

/// The status of the current member invitation.
@JsonSerializable()
class InviteStatus {
  /// Whether a new notification e-mail was sent with the current request.
  final bool emailSent;

  /// On a repeated request we throttle the sending of the e-mails, we won't
  /// send a new message before this timestamp.
  final DateTime nextNotification;

  InviteStatus({@required this.emailSent, @required this.nextNotification});
  factory InviteStatus.fromJson(Map<String, dynamic> json) =>
      _$InviteStatusFromJson(json);
  Map<String, dynamic> toJson() => _$InviteStatusToJson(this);
}
