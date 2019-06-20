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
