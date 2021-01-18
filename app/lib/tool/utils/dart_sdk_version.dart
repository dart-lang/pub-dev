// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_semver/pub_semver.dart';

/// The locally cached last fetch.
DartSdkVersion _cached;

/// Describes the latest stable version of the Dart SDK.
class DartSdkVersion {
  final String version;
  final Version semanticVersion;
  final DateTime published;
  final DateTime fetched;

  DartSdkVersion(this.version, this.published)
      : semanticVersion = Version.parse(version),
        fetched = DateTime.now();

  Duration get age => DateTime.now().difference(fetched);
}

/// Gets the latest Dart SDK version information (may be cached, but not older
/// than [maxAge]).
Future<DartSdkVersion> getDartSdkVersion(
    {Duration maxAge = const Duration(hours: 1)}) async {
  if (_cached != null && _cached.age < maxAge) return _cached;
  return _fetchDartSdkVersion();
}

/// Fetches the latest Dart SDK version information.
Future<DartSdkVersion> _fetchDartSdkVersion() async {
  final rs = await http.get(
      'https://storage.googleapis.com/dart-archive/channels/stable/release/latest/VERSION');
  if (rs.statusCode != 200) {
    throw AssertionError('Expected OK status code, got: ${rs.statusCode}.');
  }
  final map = json.decode(rs.body) as Map<String, dynamic>;
  final version = map['version'] as String;
  final date = DateTime.parse(map['date'] as String);
  return _cached = DartSdkVersion(version, date);
}
