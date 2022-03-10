// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

/// Configuration from the environment variables.
final EnvConfig envConfig = EnvConfig._detect();

/// Configuration from the environment variables.
class EnvConfig {
  /// Service in AppEngine that this process is running in, `null` if running
  /// locally.
  final String? gaeService;

  /// Version of this service in AppEngine, `null` if running locally.
  ///
  /// Can be used to construct URLs for the given service.
  final String? gaeVersion;

  /// Instance of this service in AppEngine, `null` if running locally.
  ///
  /// NOTE: use only for narrow debug flows.
  final String? gaeInstance;
  final String? gcloudKey;
  final String? gcloudProject;
  final String? stableDartSdkDir;
  final String? stableFlutterSdkDir;
  final String? previewDartSdkDir;
  final String? previewFlutterSdkDir;
  final int frontendCount;
  final int workerCount;

  // Config Path points to configuration file
  final String? configPath;

  EnvConfig._(
    this.gaeService,
    this.gaeVersion,
    this.gaeInstance,
    this.gcloudProject,
    this.gcloudKey,
    this.stableDartSdkDir,
    this.stableFlutterSdkDir,
    this.previewDartSdkDir,
    this.previewFlutterSdkDir,
    this.frontendCount,
    this.workerCount,
    this.configPath,
  );

  factory EnvConfig._detect() {
    final frontendCount =
        int.tryParse(Platform.environment['FRONTEND_COUNT'] ?? '1') ?? 1;
    final workerCount =
        int.tryParse(Platform.environment['WORKER_COUNT'] ?? '1') ?? 1;
    return EnvConfig._(
      Platform.environment['GAE_SERVICE'],
      Platform.environment['GAE_VERSION'],
      Platform.environment['GAE_INSTANCE'],
      Platform.environment['GOOGLE_CLOUD_PROJECT'],
      Platform.environment['GCLOUD_KEY'],
      Platform.environment['TOOL_STABLE_DART_SDK'],
      Platform.environment['TOOL_STABLE_FLUTTER_SDK'],
      Platform.environment['TOOL_PREVIEW_DART_SDK'],
      Platform.environment['TOOL_PREVIEW_FLUTTER_SDK'],
      frontendCount,
      workerCount,
      Platform.environment['PUB_SERVER_CONFIG'],
    );
  }

  /// True, if running locally and not inside AppEngine.
  bool get isRunningLocally => gaeService == null || gaeVersion == null;
}
