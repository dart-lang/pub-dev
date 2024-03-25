// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/utils/dart_sdk_version.dart';
import 'package:_pub_shared/utils/flutter_archive.dart';
import 'package:clock/clock.dart';
import 'package:pub_semver/pub_semver.dart';

/// The default cache timeout after the request is made to the storage server.
const _defaultMaxAge = Duration(hours: 1);

/// The cache timeout used in case the fetch encountered a failure.
const _failedFetchCacheDuration = Duration(minutes: 5);

/// The locally cached last fetch.
CachedSdkVersion? _dart;
CachedSdkVersion? _flutter;

/// Describes the latest stable version of the Dart or Flutter SDK.
class CachedSdkVersion {
  final String version;
  final Version semanticVersion;
  final DateTime published;
  final DateTime expires;

  CachedSdkVersion(this.version, this.published, {DateTime? expires})
      : semanticVersion = Version.parse(version),
        expires = expires ?? clock.now().add(_defaultMaxAge);

  bool get isExpired => clock.now().isAfter(expires);
}

/// Gets the latest stable Dart SDK version information (value may be cached).
Future<CachedSdkVersion> getCachedDartSdkVersion({
  required String lastKnownStable,
}) async {
  if (_dart != null && !_dart!.isExpired) {
    return _dart!;
  }

  final current = await fetchLatestDartSdkVersion(channel: 'stable');
  if (current != null) {
    return _dart = current;
  }

  // If there exists a cached value, extend it.
  // If there is no cached value, use the runtime analysis SDK as the latest.
  return _dart = CachedSdkVersion(
    _dart?.version ?? lastKnownStable,
    _dart?.published ?? clock.now(),
    expires: clock.now().add(_failedFetchCacheDuration),
  );
}

/// Gets the latest stable Flutter SDK version information (value may be cached).
Future<CachedSdkVersion> getCachedFlutterSdkVersion({
  required String lastKnownStable,
}) async {
  if (_flutter != null && !_flutter!.isExpired) {
    return _flutter!;
  }

  final archive = await fetchFlutterArchive();
  final stable = archive?.latestStable;
  if (stable != null && stable.version != null) {
    return _flutter = CachedSdkVersion(
        stable.cleanVersion, stable.releaseDate ?? clock.now());
  }

  // If there exists a cached value, extend it.
  // If there is no cached value, use the runtime analysis SDK as the latest.
  return _flutter = CachedSdkVersion(
    _flutter?.version ?? lastKnownStable,
    _flutter?.published ?? clock.now(),
    expires: clock.now().add(_failedFetchCacheDuration),
  );
}
