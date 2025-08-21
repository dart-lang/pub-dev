// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'page_data.g.dart';

/// Codec to serialize the [PageData] JSON content on the HTML page.
final pageDataJsonCodec = json.fuse(utf8).fuse(base64);

/// The server-provided config/data for the current page.
///
/// This is embedded in the page's `<meta name="pub-page-data" />` head element
/// using [pageDataJsonCodec].
@JsonSerializable(includeIfNull: false)
class PageData {
  final String? consentId;
  final PkgData? pkgData;
  final PublisherData? publisher;

  /// Flag to monitor when the session is close to expiry.
  /// In such cases a notification will be shown, so that the user
  /// has a chance to save their work on the page before it may be lost.
  final bool? sessionAware;

  PageData({
    this.consentId,
    this.pkgData,
    this.publisher,
    this.sessionAware,
  });

  factory PageData.fromJson(Map<String, dynamic> json) =>
      _$PageDataFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataToJson(this);

  bool get isConsentPage => consentId != null;
  bool get isPackagePage => pkgData != null;
  bool get isPublisherPage => publisher != null;
  bool get isSessionAware => sessionAware == true;
}

/// The server-provided data about the current package.
@JsonSerializable(includeIfNull: false)
class PkgData {
  final String package;
  final String version;

  /// PublisherId of publisher that owns this package, `null` if the package
  /// isn't owned by a publisher.
  final String? publisherId;
  final bool isDiscontinued;
  final bool isLatest;

  PkgData({
    required this.package,
    required this.version,
    required this.publisherId,
    required this.isDiscontinued,
    required this.isLatest,
  });

  factory PkgData.fromJson(Map<String, dynamic> json) =>
      _$PkgDataFromJson(json);

  Map<String, dynamic> toJson() => _$PkgDataToJson(this);
}

/// The server-provided data about the current publisher.
@JsonSerializable()
class PublisherData {
  final String publisherId;

  PublisherData({
    required this.publisherId,
  });

  factory PublisherData.fromJson(Map<String, dynamic> json) =>
      _$PublisherDataFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherDataToJson(this);
}
