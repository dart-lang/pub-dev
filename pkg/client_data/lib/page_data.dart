// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'page_data.g.dart';

/// Codec to serialize the [PageData] JSON content on the HTML page.
final pageDataJsonCodec = json.fuse(utf8).fuse(base64);

/// The server-provided config/data for the current page.
///
/// This is embedded in the page's `<meta name="pub-page-data" />` head element
/// using [pageDataJsonCodec].
@JsonSerializable(includeIfNull: false)
class PageData {
  final String consentId;
  final PkgData pkgData;
  final PublisherData publisher;

  PageData({
    this.consentId,
    this.pkgData,
    this.publisher,
  });

  factory PageData.fromJson(Map<String, dynamic> json) =>
      _$PageDataFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataToJson(this);

  bool get isConsentPage => consentId != null;
  bool get isPackagePage => pkgData != null;
  bool get isPublisherPage => publisher != null;
}

/// The server-provided data about the current package.
@JsonSerializable(includeIfNull: false)
class PkgData {
  final String package;
  final String version;
  final int likes;

  /// PublisherId of publisher that owns this package, `null` if the package
  /// isn't owned by a publisher.
  final String publisherId;
  final bool isDiscontinued;

  PkgData({
    @required this.package,
    @required this.version,
    @required this.publisherId,
    @required this.isDiscontinued,
    @required this.likes,
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
    @required this.publisherId,
  });

  factory PublisherData.fromJson(Map<String, dynamic> json) =>
      _$PublisherDataFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherDataToJson(this);
}
