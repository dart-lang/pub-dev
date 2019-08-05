// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'account_api.g.dart';

/// Account-specific information about a package.
@JsonSerializable()
class AccountPkgOptions {
  final bool isUploader;

  AccountPkgOptions({
    @required this.isUploader,
  });

  factory AccountPkgOptions.fromJson(Map<String, dynamic> json) =>
      _$AccountPkgOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$AccountPkgOptionsToJson(this);
}

@JsonSerializable(nullable: false)
class Consent {
  /// The description of the consent request, in HTML format.
  final String descriptionHtml;

  Consent({@required this.descriptionHtml});

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
