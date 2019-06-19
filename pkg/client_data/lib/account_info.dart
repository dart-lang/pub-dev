// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'account_info.g.dart';

/// The server-provided config/data of the current page.
@JsonSerializable()
class AccountInfo {
  final String email;
  final PkgScopeData pkgScopeData;

  AccountInfo({
    @required this.email,
    this.pkgScopeData,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoToJson(this);
}

/// Account-specific information about a package.
@JsonSerializable()
class PkgScopeData {
  final String package;
  final bool isUploader;

  PkgScopeData({
    @required this.package,
    @required this.isUploader,
  });

  factory PkgScopeData.fromJson(Map<String, dynamic> json) =>
      _$PkgScopeDataFromJson(json);

  Map<String, dynamic> toJson() => _$PkgScopeDataToJson(this);
}
