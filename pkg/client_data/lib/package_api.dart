// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

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
  final Map<String, String> fields;

  UploadInfo({
    @required this.url,
    @required this.fields,
  });

  factory UploadInfo.fromJson(Map<String, dynamic> json) =>
      _$UploadInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UploadInfoToJson(this);
}

/// Options and flags to get/set on a package.
@JsonSerializable()
class PkgOptions {
  final bool isDiscontinued;

  PkgOptions({
    this.isDiscontinued,
  });

  factory PkgOptions.fromJson(Map<String, dynamic> json) =>
      _$PkgOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$PkgOptionsToJson(this);
}

/// Publisher ownership to get/set on a package.
@JsonSerializable()
class PackagePublisherInfo {
  /// Domain name of the publisher that owns this package, `null` if package
  /// is not owned by a publisher.
  final String publisherId;

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

  SuccessMessage({@required this.success});

  factory SuccessMessage.fromJson(Map<String, dynamic> json) =>
      _$SuccessMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessMessageToJson(this);
}

/// A message wrapper for pub client API compatibility.
@JsonSerializable()
class Message {
  final String message;

  Message({@required this.message});

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

  /// This is merely a convenience property, because the [VersionInfo] for the
  /// latest version also exists in the [versions] list.
  ///
  /// This is the latest that is NOT a pre-release, unless there only is
  /// pre-releases in the [versions] list.
  final VersionInfo latest;

  /// The available versions, sorted by their semantic version number (ascending).
  final List<VersionInfo> versions;

  /// `true` if package is discontinued.
  /// If it is omitted, `null` or `false` the package is *not discontinued*.
  final bool isDiscontinued;

  PackageData({
    @required this.name,
    @required this.latest,
    @required this.versions,
    this.isDiscontinued,
  });

  factory PackageData.fromJson(Map<String, dynamic> json) =>
      _$PackageDataFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDataToJson(this);
}

@JsonSerializable()
class VersionInfo {
  final String version;

  final Map<String, dynamic> pubspec;

  /// As of Dart 2.8 `pub` client uses [archiveUrl] to find the archive.
  @JsonKey(name: 'archive_url')
  final String archiveUrl;

  VersionInfo({
    @required this.version,
    @required this.pubspec,
    @required this.archiveUrl,
  });

  factory VersionInfo.fromJson(Map<String, dynamic> json) =>
      _$VersionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VersionInfoToJson(this);
}
