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
