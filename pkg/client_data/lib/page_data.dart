// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'page_data.g.dart';

/// The server-provided config/data for the current page.
///
/// This is the `application/ld+json` data embedded in the page with
/// `"@context":"https://pub.dev"`.
@JsonSerializable()
class PageData {
  final PkgData pkgData;

  PageData({this.pkgData});

  factory PageData.fromJson(Map<String, dynamic> json) =>
      _$PageDataFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataToJson(this);

  bool get isPackagePage => pkgData != null;
}

/// The server-providerd data about the current package.
@JsonSerializable()
class PkgData {
  final String package;
  final String version;
  final bool isDiscontinued;

  PkgData({
    @required this.package,
    @required this.version,
    @required this.isDiscontinued,
  });

  factory PkgData.fromJson(Map<String, dynamic> json) =>
      _$PkgDataFromJson(json);

  Map<String, dynamic> toJson() => _$PkgDataToJson(this);
}
