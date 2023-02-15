// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';

/// Configuration from the environment variables.
final envConfig = _EnvConfig();

/// Configuration from the environment variables.
///
/// TODO: consider migrating the values to be non-nullable
class _EnvConfig {
  /// Service in AppEngine that this process is running in, `null` if running
  /// locally.
  late final _gaeService = Platform.environment['GAE_SERVICE'];

  /// Version of this service in AppEngine, `null` if running locally.
  ///
  /// Can be used to construct URLs for the given service.
  late final _gaeVersion = Platform.environment['GAE_VERSION'];

  /// Instance of this service in AppEngine, `null` if running locally.
  ///
  /// NOTE: use only for narrow debug flows.
  late final _gaeInstance = Platform.environment['GAE_INSTANCE'];

  late final googleCloudProject = Platform.environment['GOOGLE_CLOUD_PROJECT'];

  /// Points to configuration file
  late final configPath = Platform.environment['PUB_SERVER_CONFIG'];

  /// Youtube API key to use (skips Datastore secret).
  late final youtubeApiKey = Platform.environment['YOUTUBE_API_KEY'];

  /// Drives the logging environment in certain tests.
  /// **Examples**:
  ///  * `DEBUG='*'`, will show output from all loggers.
  ///  * `DEBUG='pub.*'`, will show output from loggers with name prefixed 'pub.'.
  ///  * `DEBUG='* -neat_cache'`, will show output from all loggers, except 'neat_cache'.
  @visibleForTesting
  late final debug = Platform.environment['DEBUG'];

  /// Local override for OAuth services when developing for external servers.
  late final fakeOauthSiteAudience =
      Platform.environment['PUB_DEV_FAKE_OAUTH_SITE_AUDIENCE'];

  /// Local override for OAuth services when developing for external servers.
  late final fakeOauthSiteAudienceSecret =
      Platform.environment['PUB_DEV_FAKE_OAUTH_SITE_AUDIENCE_SECRET'];

  /// True, if running inside AppEngine.
  bool get isRunningInAppengine => _gaeService != null && _gaeVersion != null;

  /// True, if running locally and not inside AppEngine.
  bool get isRunningLocally => !isRunningInAppengine;

  /// Ensure that we're running in the right environment, or is running locally.
  void checkServiceEnvironment(String name) {
    if (_gaeService != null && _gaeService != name) {
      throw StateError(
        'Cannot start "$name" in "$_gaeService" environment.',
      );
    }
  }

  /// Environment variables that are exposed in the `/debug` endpoint.
  Map<String, dynamic> debugMap({bool includeInstanceHash = false}) {
    return {
      'GAE_VERSION': _gaeVersion ?? '-',
      'GAE_MEMORY_MB': Platform.environment['GAE_MEMORY_MB'],
      if (includeInstanceHash)
        'instanceHash':
            sha256.convert(utf8.encode(_gaeInstance ?? '-')).toString(),
    };
  }
}
