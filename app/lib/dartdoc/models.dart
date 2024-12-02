// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

/// Describes the resolved version and the URL redirect info.
@JsonSerializable(includeIfNull: false)
class ResolvedDocUrlVersion {
  /// The version to use to display the documentation.
  final String version;

  /// The URL segment that should be used to display the version.
  ///
  /// This is either:
  /// * `"latest"`,
  /// * `"${version}"`, or,
  /// * `""` (indicating empty response)
  final String urlSegment;

  /// When the resolution is empty, the 404 response will have this message.
  final String? message;

  ResolvedDocUrlVersion({
    required this.version,
    required this.urlSegment,
    this.message,
  });

  ResolvedDocUrlVersion.empty({
    required this.message,
  })  : version = '',
        urlSegment = '';

  factory ResolvedDocUrlVersion.fromJson(Map<String, dynamic> json) =>
      _$ResolvedDocUrlVersionFromJson(json);

  Map<String, dynamic> toJson() => _$ResolvedDocUrlVersionToJson(this);

  bool get isEmpty => version.isEmpty || urlSegment.isEmpty;
  bool get isLatestStable => urlSegment == 'latest';
}

/// Describes the status of a dartdoc page.
@JsonSerializable(includeIfNull: false)
class DocPageStatus {
  final DocPageStatusCode code;
  final String? redirectPath;
  final String? errorMessage;

  DocPageStatus({
    required this.code,
    this.redirectPath,
    this.errorMessage,
  });

  factory DocPageStatus.ok() {
    return DocPageStatus(code: DocPageStatusCode.ok);
  }

  factory DocPageStatus.redirect(String redirectPath) {
    return DocPageStatus(
      code: DocPageStatusCode.redirect,
      redirectPath: redirectPath,
    );
  }

  factory DocPageStatus.missing(String errorMessage) {
    return DocPageStatus(
      code: DocPageStatusCode.missing,
      errorMessage: errorMessage,
    );
  }

  factory DocPageStatus.fromJson(Map<String, dynamic> json) =>
      _$DocPageStatusFromJson(json);

  Map<String, dynamic> toJson() => _$DocPageStatusToJson(this);
}

/// Explicit status of [DocPageStatus].
enum DocPageStatusCode {
  /// page generated and ready to be served
  ok,

  /// page generated and redirects to a new URL
  redirect,

  /// page does not exists
  missing,
}
