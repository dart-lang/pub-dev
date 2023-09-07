// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

/// Describes the resolved version and the URL redirect info.
@JsonSerializable()
class ResolvedDocUrlVersion {
  /// The version to use to display the documentation.
  final String version;

  /// The URL segment that should be used to display the version.
  ///
  /// This is either:
  /// * `"latest"`,
  /// * `"${version}"`, or,
  /// * `""` (indicating empty response)
  final String segment;

  ResolvedDocUrlVersion({
    required this.version,
    required this.segment,
  });

  factory ResolvedDocUrlVersion.fromJson(Map<String, dynamic> json) =>
      _$ResolvedDocUrlVersionFromJson(json);

  Map<String, dynamic> toJson() => _$ResolvedDocUrlVersionToJson(this);

  bool get isEmpty => version.isEmpty || segment.isEmpty;
}
