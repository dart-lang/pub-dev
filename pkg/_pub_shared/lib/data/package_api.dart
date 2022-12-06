// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'package_api.g.dart';

/// Information for uploading a package.
@JsonSerializable()
class UploadInfo {
  /// The endpoint where the uploaded data should be posted.
  ///
  /// The upload is a POST to [url] with the headers [fields] in the HTTP
  /// request. The body of the POST request must be a valid tar.gz file.
  final String url;

  /// The fields the uploader should add to the multipart upload.
  final Map<String, String>? fields;

  UploadInfo({
    required this.url,
    required this.fields,
  });

  factory UploadInfo.fromJson(Map<String, dynamic> json) =>
      _$UploadInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UploadInfoToJson(this);
}

/// Options and flags to get/set on a package.
@JsonSerializable()
class PkgOptions {
  final bool? isDiscontinued;
  final String? replacedBy;
  final bool? isUnlisted;

  PkgOptions({
    this.isDiscontinued,
    this.replacedBy,
    this.isUnlisted,
  });

  factory PkgOptions.fromJson(Map<String, dynamic> json) =>
      _$PkgOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$PkgOptionsToJson(this);
}

/// The configuration for a package's credential-less publishing.
@JsonSerializable(includeIfNull: false, explicitToJson: true)
class AutomatedPublishingConfig {
  final GithubPublishing? github;
  final GcpPublishing? gcp;

  AutomatedPublishingConfig({
    this.github,
    this.gcp,
  });

  factory AutomatedPublishingConfig.fromJson(Map<String, dynamic> json) =>
      _$AutomatedPublishingConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AutomatedPublishingConfigToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class GithubPublishing {
  bool? isEnabled;

  /// The `owner/repository` path of the project on github.com.
  String? repository;

  /// The tag pattern that is required for the publishing.
  ///
  /// This pattern must have a single `{{version}}` field somewhere
  /// in it, otherwise it is a character-to-character match, with no
  /// regular expressions or other templating substitutes.
  ///
  /// Some of the expected values:
  /// - `{{version}}`
  /// - `v{{version}}`
  /// - `subproject-v{{version}}`
  String? tagPattern;

  /// Whether to require the action from a specific environment.
  bool? requireEnvironment;

  /// The GitHub environment where the publishing is required from.
  String? environment;

  GithubPublishing({
    this.isEnabled,
    this.repository,
    this.tagPattern,
    this.requireEnvironment,
    this.environment,
  });

  factory GithubPublishing.fromJson(Map<String, dynamic> json) =>
      _$GithubPublishingFromJson(json);

  Map<String, dynamic> toJson() => _$GithubPublishingToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class GcpPublishing {
  bool? isEnabled;
  String? serviceAccountEmail;

  GcpPublishing({
    this.isEnabled,
    this.serviceAccountEmail,
  });

  factory GcpPublishing.fromJson(Map<String, dynamic> json) =>
      _$GcpPublishingFromJson(json);

  Map<String, dynamic> toJson() => _$GcpPublishingToJson(this);
}

@JsonSerializable()
class VersionOptions {
  final bool? isRetracted;

  VersionOptions({
    this.isRetracted,
  });

  factory VersionOptions.fromJson(Map<String, dynamic> json) =>
      _$VersionOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$VersionOptionsToJson(this);
}

/// Publisher ownership to get/set on a package.
@JsonSerializable()
class PackagePublisherInfo {
  /// Domain name of the publisher that owns this package, `null` if package
  /// is not owned by a publisher.
  final String? publisherId;

  PackagePublisherInfo({
    this.publisherId,
  });

  factory PackagePublisherInfo.fromJson(Map<String, dynamic> json) =>
      _$PackagePublisherInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PackagePublisherInfoToJson(this);
}

/// A simple response communicating the operation was successful.
@JsonSerializable()
class SuccessMessage {
  final Message success;

  SuccessMessage({required this.success});

  factory SuccessMessage.fromJson(Map<String, dynamic> json) =>
      _$SuccessMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessMessageToJson(this);
}

/// A message wrapper for pub client API compatibility.
@JsonSerializable()
class Message {
  final String message;

  Message({required this.message});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

/// Used in `pub` client for finding which versions exist.
/// (`listVersions` method in pubapi)
@JsonSerializable(includeIfNull: false)
class PackageData {
  /// Package name.
  final String name;

  /// `true` if package is discontinued.
  /// If it is omitted, `null` or `false` the package is *not discontinued*.
  final bool? isDiscontinued;

  /// If [isDiscontinued] is set, this _may_ point to a package that can be used
  /// instead (set by the package admin).
  final String? replacedBy;

  /// This is merely a convenience property, because the [VersionInfo] for the
  /// latest version also exists in the [versions] list.
  ///
  /// This is the latest that is NOT a pre-release, unless there only is
  /// pre-releases in the [versions] list.
  final VersionInfo latest;

  /// The available versions, sorted by their semantic version number (ascending).
  final List<VersionInfo> versions;

  PackageData({
    required this.name,
    this.isDiscontinued,
    this.replacedBy,
    required this.latest,
    required this.versions,
  });

  factory PackageData.fromJson(Map<String, dynamic> json) =>
      _$PackageDataFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDataToJson(this);

  // The cached version list contains the versions in semantically ascending order.
  // By reversing that list, we will have them in semantically descending order,
  // which is the preferred order for displaying on the versions page.
  late final List<VersionInfo> descendingVersions = versions.reversed.toList();
}

@JsonSerializable(includeIfNull: false)
class VersionInfo {
  final String version;

  /// `true` if version is retracted.
  /// If it is omitted, `null` or `false` the package is *not retracted*.
  final bool? retracted;

  final Map<String, dynamic> pubspec;

  /// As of Dart 2.8 `pub` client uses [archiveUrl] to find the archive.
  @JsonKey(name: 'archive_url')
  final String? archiveUrl;

  /// The SHA-256 hash of the canonical archive.
  @JsonKey(name: 'archive_sha256')
  final String? archiveSha256;

  /// This is an optional field of the API response, it may be `null` or omitted.
  final DateTime? published;

  VersionInfo({
    required this.version,
    required this.retracted,
    required this.pubspec,
    required this.archiveUrl,
    required this.archiveSha256,
    required this.published,
  });

  factory VersionInfo.fromJson(Map<String, dynamic> json) =>
      _$VersionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VersionInfoToJson(this);
}

@JsonSerializable(includeIfNull: false)
class VersionScore {
  final int? grantedPoints;
  final int? maxPoints;
  final int? likeCount;
  final double? popularityScore;
  final List<String>? tags;
  final DateTime? lastUpdated;

  VersionScore({
    required this.grantedPoints,
    required this.maxPoints,
    required this.likeCount,
    required this.popularityScore,
    required this.tags,
    required this.lastUpdated,
  });

  factory VersionScore.fromJson(Map<String, dynamic> json) =>
      _$VersionScoreFromJson(json);

  Map<String, dynamic> toJson() => _$VersionScoreToJson(this);
}

/// Request payload for removing an uploader from a package.
@JsonSerializable()
class RemoveUploaderRequest {
  /// Email of the uploader to be removed.
  ///
  /// This must be the primary email associated with the users Google Account.
  final String email;

  RemoveUploaderRequest({required this.email});

  factory RemoveUploaderRequest.fromJson(Map<String, dynamic> json) =>
      _$RemoveUploaderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RemoveUploaderRequestToJson(this);
}

/// Request payload for inviting a new user to become uploader of a package.
@JsonSerializable()
class InviteUploaderRequest {
  /// Email to which the invitation will be sent.
  ///
  /// This must be the primary email associated with the invited users Google
  /// Account. The invited user will later be required to sign-in with a
  /// Google Account that has this email in-order to accept the invitation.
  final String email;

  // json_serializable boiler-plate
  InviteUploaderRequest({required this.email});

  factory InviteUploaderRequest.fromJson(Map<String, dynamic> json) =>
      _$InviteUploaderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$InviteUploaderRequestToJson(this);
}
