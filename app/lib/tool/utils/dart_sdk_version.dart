// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/utils/http.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';

import '../../shared/versions.dart';

final _logger = Logger('tool.sdk_version');

/// The default cache timeout after the request is made to the storage server.
const _defaultMaxAge = Duration(hours: 1);

/// The cache timeout used in case the fetch encountered a failure.
const _failedFetchCacheDuration = Duration(minutes: 5);

/// The locally cached last fetch.
DartSdkVersion? _cached;

/// Describes the latest stable version of the Dart SDK.
class DartSdkVersion {
  final String version;
  final Version semanticVersion;
  final DateTime published;
  final DateTime expires;

  DartSdkVersion(this.version, this.published, {DateTime? expires})
      : semanticVersion = Version.parse(version),
        expires = expires ?? clock.now().add(_defaultMaxAge);

  bool get isExpired => clock.now().isAfter(expires);
}

/// Gets the latest Dart SDK version information (value may be cached).
Future<DartSdkVersion> getDartSdkVersion() async {
  if (_cached != null && !_cached!.isExpired) {
    return _cached!;
  }
  return _fetchDartSdkVersion();
}

/// Fetches the latest Dart SDK version information.
Future<DartSdkVersion> _fetchDartSdkVersion() async {
  final client = httpRetryClient();
  try {
    final rs = await client.get(Uri.parse(
        'https://storage.googleapis.com/dart-archive/channels/stable/release/latest/VERSION'));
    if (rs.statusCode != 200) {
      throw AssertionError('Expected OK status code, got: ${rs.statusCode}.');
    }
    final map = json.decode(rs.body) as Map<String, dynamic>;
    final version = map['version'] as String;
    final date = DateTime.parse(map['date'] as String);
    return _cached = DartSdkVersion(version, date);
  } catch (e, st) {
    _logger.warning('Unable to fetch the Dart SDK version', e, st);
    // If there exists a cached value, extend it.
    // If there is no cached value, use the runtime analysis SDK as the latest.
    return _cached = DartSdkVersion(
      _cached?.version ?? toolStableDartSdkVersion,
      _cached?.published ?? clock.now(),
      expires: clock.now().add(_failedFetchCacheDuration),
    );
  } finally {
    client.close();
  }
}
