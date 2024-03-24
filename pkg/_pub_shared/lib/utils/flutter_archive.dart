// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/utils/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';

part 'flutter_archive.g.dart';

final _logger = Logger('flutter_archive');

/// Returns the latest released versions on all Flutter release channels.
///
/// See:
/// - https://flutter.dev/docs/development/tools/sdk/releases?tab=linux
/// - https://github.com/flutter/flutter/wiki/Flutter-build-release-channels
///
/// Returns `null` if the archive cannot be fetched.
Future<FlutterArchive?> fetchFlutterArchive() async {
  for (var i = 0; i < 3; i++) {
    final client = httpRetryClient();
    try {
      final rs = await client.get(Uri.parse(
          'https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json'));
      return FlutterArchive.fromJson(
          json.decode(rs.body) as Map<String, dynamic>);
    } catch (e, st) {
      _logger.warning('Unable to fetch the Flutter SDK archive', e, st);
      continue;
    } finally {
      client.close();
    }
  }
  return null;
}

/// The latest released versions on all Flutter release channels.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FlutterArchive {
  final String? baseUrl;
  @JsonKey(name: 'current_release')
  final FlutterCurrentRelease? currentRelease;
  final List<FlutterRelease>? releases;

  FlutterArchive({this.baseUrl, this.currentRelease, this.releases});

  factory FlutterArchive.fromJson(Map<String, dynamic> json) =>
      _$FlutterArchiveFromJson(json);

  Map<String, dynamic> toJson() => _$FlutterArchiveToJson(this);

  late final _stableVersions = releases
      ?.where((e) => e.channel == 'stable' && e.version != null)
      .toList();

  late final latestStable = (_stableVersions?.isNotEmpty ?? false)
      ? _stableVersions!.reduce(
          (a, b) => a.semanticVersion.compareTo(b.semanticVersion) <= 0 ? b : a)
      : null;

  late final _betaVersions =
      releases?.where((e) => e.channel == 'beta' && e.version != null).toList();

  late final latestBeta = (_betaVersions?.isNotEmpty ?? false)
      ? _betaVersions!.reduce(
          (a, b) => a.semanticVersion.compareTo(b.semanticVersion) <= 0 ? b : a)
      : null;
}

/// The hashes of the current Flutter releases on the different channels.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FlutterCurrentRelease {
  final String? beta;
  final String? dev;
  final String? stable;

  FlutterCurrentRelease({this.beta, this.dev, this.stable});

  factory FlutterCurrentRelease.fromJson(Map<String, dynamic> json) =>
      _$FlutterCurrentReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$FlutterCurrentReleaseToJson(this);
}

/// A single release for Flutter.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FlutterRelease {
  final String? hash;
  final String? channel;
  final String? version;
  @JsonKey(name: 'release_date')
  final DateTime? releaseDate;
  final String? archive;
  final String? sha256;

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

  late final cleanVersion =
      version!.startsWith('v') ? version!.substring(1) : version!;

  late final semanticVersion = Version.parse(cleanVersion);
}
