// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/utils/http.dart';
import 'package:logging/logging.dart';

import 'sdk_version_cache.dart';

final _logger = Logger('tool.sdk_version');

/// Fetches the latest Dart SDK version information.
Future<CachedSdkVersion?> fetchLatestDartSdkVersion({
  required String channel,
}) async {
  for (var i = 0; i < 3; i++) {
    final client = httpRetryClient();
    try {
      final rs = await client.get(Uri.parse(
          'https://storage.googleapis.com/dart-archive/channels/$channel/release/latest/VERSION'));
      if (rs.statusCode != 200) {
        _logger.warning(
            'Unable to fetch the Dart SDK version, status code: ${rs.statusCode}');
        continue;
      }
      final map = json.decode(rs.body) as Map<String, dynamic>;
      final version = map['version'] as String;
      final date = DateTime.parse(map['date'] as String);
      return CachedSdkVersion(version, date);
    } catch (e, st) {
      _logger.warning('Unable to fetch the Dart SDK version', e, st);
      continue;
    } finally {
      client.close();
    }
  }
  return null;
}
