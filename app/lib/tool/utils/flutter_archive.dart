// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart';

part 'flutter_archive.g.dart';

/// Returns the latest released versions on all Flutter release channels.
///
/// See:
/// - https://flutter.dev/docs/development/tools/sdk/releases?tab=linux
/// - https://github.com/flutter/flutter/wiki/Flutter-build-release-channels
Future<FlutterArchive> fetchFlutterArchive() async {
  final client = Client();
  final rs = await client.get(
      'https://storage.googleapis.com/flutter_infra/releases/releases_linux.json');
  client.close();
  return FlutterArchive.fromJson(json.decode(rs.body) as Map<String, dynamic>);
}

/// The latest released versions on all Flutter release channels.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FlutterArchive {
  final String baseUrl;
  @JsonKey(name: 'current_release')
  final FlutterCurrentRelease currentRelease;
  final List<FlutterRelease> releases;

  FlutterArchive({this.baseUrl, this.currentRelease, this.releases});

  factory FlutterArchive.fromJson(Map<String, dynamic> json) =>
      _$FlutterArchiveFromJson(json);

  Map<String, dynamic> toJson() => _$FlutterArchiveToJson(this);
}

/// The hashes of the current Flutter releases on the different channels.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FlutterCurrentRelease {
  final String beta;
  final String dev;
  final String stable;

  FlutterCurrentRelease({this.beta, this.dev, this.stable});

  factory FlutterCurrentRelease.fromJson(Map<String, dynamic> json) =>
      _$FlutterCurrentReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$FlutterCurrentReleaseToJson(this);
}

/// A single release for Flutter.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FlutterRelease {
  final String hash;
  final String channel;
  final String version;
  @JsonKey(name: 'release_date')
  final DateTime releaseDate;
  final String archive;
  final String sha256;

  FlutterRelease({
    this.hash,
    this.channel,
    this.version,
    this.releaseDate,
    this.archive,
    this.sha256,
  });

  factory FlutterRelease.fromJson(Map<String, dynamic> json) =>
      _$FlutterReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$FlutterReleaseToJson(this);
}
