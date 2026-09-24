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
  /// Service in AppEngine or Cloud Run that this process is running in, `null`
  /// if running locally.
  late final service =
      Platform.environment['GAE_SERVICE'] ??
      Platform.environment['K_SERVICE'] ??
      Platform.environment['CLOUD_RUN_JOB'];

  /// Version or revision of this service in AppEngine or Cloud Run, `null` if
  /// running locally.
  ///
  /// Can be used to construct URLs for the given service.
  late final _version =
      Platform.environment['GAE_VERSION'] ??
      Platform.environment['K_REVISION'] ??
      Platform.environment['CLOUD_RUN_EXECUTION'];

  /// Instance or task identifier of this service in AppEngine or Cloud Run,
  /// `null` if running locally.
  ///
  /// NOTE: use only for narrow debug flows.
  late final _instance =
      Platform.environment['GAE_INSTANCE'] ??
      Platform.environment['K_REVISION'] ??
      Platform.environment['CLOUD_RUN_TASK_INDEX'];

  /// HTTP port for the server to listen on (defaults to 8080).
  late final port = int.tryParse(Platform.environment['PORT'] ?? '') ?? 8080;

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

  /// When specified, the server will output emails (as separate files, encoded in JSON)
  /// in the specified directory.
  late final fakeEmailSenderOutputDir =
      Platform.environment['FAKE_EMAIL_SENDER_OUTPUT_DIR'];

  /// When specified, the server will connect to this URL for postgres database connections.
  late final pubPostgresUrl = Platform.environment['PUB_POSTGRES_URL'];

  /// True, if running specifically inside AppEngine.
  bool get isRunningInAppengine =>
      Platform.environment.containsKey('GAE_SERVICE') &&
      Platform.environment.containsKey('GAE_VERSION');

  /// True, if running inside AppEngine or Cloud Run.
  bool get isRunningInCloud => service != null && _version != null;

  /// True, if the process is using precompiled binaries. This can be used to decide
  /// if the isolate's source code can be loaded from the file system (as a dill file).
  bool get hasPrecompiledBinaries => isRunningInCloud;

  /// True, if running locally and not inside AppEngine or Cloud Run.
  bool get isRunningLocally => !isRunningInCloud;

  /// Ensure that we're running in the right environment, or is running locally.
  void checkServiceEnvironment(String name) {
    if (service != null && service != name) {
      throw StateError('Cannot start "$name" in "$service" environment.');
    }
  }

  /// Environment variables that are exposed in the `/debug` endpoint.
  Map<String, dynamic> debugMap({bool includeInstanceHash = false}) {
    return {
      'GAE_VERSION': _version ?? '-',
      'GAE_MEMORY_MB': Platform.environment['GAE_MEMORY_MB'],
      if (includeInstanceHash)
        'instanceHash': sha256
            .convert(utf8.encode(_instance ?? '-'))
            .toString(),
    };
  }
}
