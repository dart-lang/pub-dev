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
          json.decode(rs.body) as Map<String, Object?>);
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

  factory FlutterArchive.fromJson(Map<String, Object?> json) =>
      _$FlutterArchiveFromJson(json);

  Map<String, Object?> toJson() => _$FlutterArchiveToJson(this);

  late final FlutterRelease? latestStable = _findLatestOfChannel('stable');

  late final FlutterRelease? latestBeta = _findLatestOfChannel('beta');

  FlutterRelease? _findLatestOfChannel(String channelName) {
    final releasesInChannel = releases
        ?.where((e) => e.channel == channelName && e.version != null)
        .toList(growable: false);
    if (releasesInChannel == null || releasesInChannel.isEmpty) return null;

    return releasesInChannel.reduce(
        (a, b) => a.semanticVersion.compareTo(b.semanticVersion) <= 0 ? b : a);
  }
}

/// The hashes of the current Flutter releases on the different channels.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FlutterCurrentRelease {
  final String? beta;
  final String? dev;
  final String? stable;

  FlutterCurrentRelease({this.beta, this.dev, this.stable});

  factory FlutterCurrentRelease.fromJson(Map<String, Object?> json) =>
      _$FlutterCurrentReleaseFromJson(json);

  Map<String, Object?> toJson() => _$FlutterCurrentReleaseToJson(this);
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
  @JsonKey(name: 'dart_sdk_version')
  final String? dartSdkVersion;

  FlutterRelease({
    this.hash,
    this.channel,
    this.version,
    this.releaseDate,
    this.archive,
    this.sha256,
    this.dartSdkVersion,
  });

  factory FlutterRelease.fromJson(Map<String, Object?> json) =>
      _$FlutterReleaseFromJson(json);

  Map<String, Object?> toJson() => _$FlutterReleaseToJson(this);

  String get cleanVersion {
    final version = this.version!;
    return version.startsWith('v') ? version.substring(1) : version;
  }

  late final Version semanticVersion = Version.parse(cleanVersion);

  /// The parsed Dart SDK version or `null` if we were not able to
  /// parse the value.
  late final Version? semanticDartSdkVersion = () {
    // The Dart SDK version string may be `3.4.3` for stable versions or
    // `3.5.0 (build 3.5.0-180.3.beta)` for prerelease versions.
    // For simplicity we only parse the first part of the version string.
    final extractedDartSdkVersion = dartSdkVersion?.split(' ').first;
    if (extractedDartSdkVersion == null) {
      return null;
    }
    try {
      return Version.parse(extractedDartSdkVersion);
    } catch (_) {
      return null;
    }
  }();
}
