// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';

part 'task_payload.g.dart';

/// JSON payload given as single argument to the `pub_worker.dart` command.
@JsonSerializable()
final class Payload {
  /// Package name of the package to be processed.
  final String package;

  /// Base URL for doing callbacks to the default service.
  ///
  /// This property should not end in a slash.
  ///
  /// The [pubHostedUrl] URL should work in the following requests:
  ///  * `GET  <callbackUrl>/api/packages/<packages>`,
  ///  * `POST <callbackUrl>/api/tasks/<package>/<version>/upload`, and,
  ///  * `POST <callbackUrl>/api/tasks/<package>/<version>/finished`.
  ///
  /// The POST requests must be authenticated with:
  ///         `authorization: bearer <token>`
  /// Using the `<token>` matching the `<version>` being reported.
  final String pubHostedUrl;

  /// Lists of (`version`, `token`) for versions to process.
  ///
  /// Given in order of priority, with the assumption that the first entry
  /// is the one it's most important to process.
  final List<VersionTokenPair> versions;

  // json_serializable boiler-plate
  Payload({
    required this.package,
    required this.pubHostedUrl,
    required Iterable<VersionTokenPair> versions,
  }) : versions = UnmodifiableListView(versions.toList(growable: false));

  factory Payload.fromJson(Map<String, dynamic> json) =>
      _$PayloadFromJson(json);
  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}

/// Pair of [version] and [token].
@JsonSerializable()
final class VersionTokenPair {
  /// Version of [Payload.package] to be processed.
  final String version;

  /// Secret token for authenticating `/upload` and `/finished` API callbacks
  /// for [version].
  ///
  /// The [token] is attached to requests using:
  /// `authorization: bearer <token>`.
  final String token;

  // json_serializable boiler-plate
  VersionTokenPair({
    required this.version,
    required this.token,
  });
  factory VersionTokenPair.fromJson(Map<String, dynamic> json) =>
      _$VersionTokenPairFromJson(json);
  Map<String, dynamic> toJson() => _$VersionTokenPairToJson(this);
}
