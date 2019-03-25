// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:googleapis_auth/auth.dart' as auth;

final activeConfiguration = new Configuration.fromEnv(envConfig);

/// Class describing the configuration of running pub.dartlang.org.
///
/// The configuration define the location of the Datastore with the
/// package metadata and the Cloud Storage bucket for the actual package
/// tar files.
class Configuration {
  /// The name of the Cloud Storage bucket to use for uploaded package content.
  final String packageBucketName;

  /// The Cloud project Id. This is only required when using Apiary to access
  /// Datastore and/or Cloud Storage
  final String projectId;

  /// The scheme://host:port prefix for the search service.
  final String searchServicePrefix;

  /// The name of the Cloud Storage bucket to use for dartdoc generated output.
  final String dartdocStorageBucketName;

  /// The name of the Cloud Storage bucket to use for popularity data dumps.
  final String popularityDumpBucketName;

  /// The name of the Cloud Storage bucket to use for search snapshots.
  final String searchSnapshotBucketName;

  /// The name of the Cloud Storage bucket to use for datastore backup snapshots.
  final String backupSnapshotBucketName;

  /// The OAuth redirect endpoint to use.
  final String oauthRedirectUrl;

  /// The OAuth audience (`client_id`) that the `pub` client uses.
  final String pubClientAudience;

  /// The OAuth audience (`client_id`) that the pub site uses.
  final String pubSiteAudience;

  /// Credentials to use for API calls if not reading the credentials from
  /// the Datastore.
  final auth.ServiceAccountCredentials credentials;

  /// Create a configuration for production deployment.
  ///
  /// This will use the Datastore from the cloud project and the Cloud Storage
  /// bucket 'pub-packages'. The credentials for accessing the Cloud
  /// Storage is retrieved from the Datastore.
  Configuration._prod() : this._local('dartlang-pub');

  /// Create a configuration for development/staging deployment.
  Configuration._dev() : this._local('dartlang-pub-dev');

  /// Base configuration for local development
  Configuration._local(String projectId)
      : projectId = projectId,
        packageBucketName = projectId == 'dartlang-pub'
            ? 'pub-packages'
            : '$projectId--pub-packages',
        searchServicePrefix = 'https://search-dot-$projectId.appspot.com',
        dartdocStorageBucketName = '$projectId--dartdoc-storage',
        popularityDumpBucketName = '$projectId--popularity',
        searchSnapshotBucketName = '$projectId--search-snapshot',
        backupSnapshotBucketName = '$projectId--backup-snapshots',
        oauthRedirectUrl = projectId == 'dartlang-pub'
            ? 'https://pub.dartlang.org/oauth/callback'
            : 'https://dartlang-pub-dev.appspot.com/oauth/callback',
        pubClientAudience =
            '818368855108-8grd2eg9tj9f38os6f1urbcvsq399u8n.apps.googleusercontent.com',
        pubSiteAudience = projectId == 'dartlang-pub'
            ? '818368855108-e8skaopm5ih5nbb82vhh66k7ft5o7dn3.apps.googleusercontent.com'
            : '621485135717-idb8t8nnguphtu2drfn2u4ig7r56rm6n.apps.googleusercontent.com',
        credentials = _loadCredentials();

  /// Create a configuration based on the environment variables.
  factory Configuration.fromEnv(EnvConfig env) {
    if (env.gcloudProject == 'dartlang-pub-dev') {
      return new Configuration._dev();
    } else {
      return new Configuration._prod();
    }
  }
}

/// Configuration from the environment variables.
class EnvConfig {
  final String gaeService;
  final String gcloudKey;
  final String gcloudProject;
  final String toolEnvDartSdkDir;
  final String flutterSdkDir;
  final int frontendCount;
  final int workerCount;

  EnvConfig._(
    this.gaeService,
    this.gcloudProject,
    this.gcloudKey,
    this.toolEnvDartSdkDir,
    this.flutterSdkDir,
    this.frontendCount,
    this.workerCount,
  ) {
    if (this.gcloudProject == null) {
      throw new Exception('GCLOUD_PROJECT needs to be set!');
    }
  }

  factory EnvConfig._detect() {
    final frontendCount =
        int.tryParse(Platform.environment['FRONTEND_COUNT'] ?? '1') ?? 1;
    final workerCount =
        int.tryParse(Platform.environment['WORKER_COUNT'] ?? '1') ?? 1;
    return new EnvConfig._(
      Platform.environment['GAE_SERVICE'],
      Platform.environment['GCLOUD_PROJECT'],
      Platform.environment['GCLOUD_KEY'],
      Platform.environment['TOOL_ENV_DART_SDK'],
      Platform.environment['FLUTTER_SDK'],
      frontendCount,
      workerCount,
    );
  }

  bool get hasCredentials => gcloudProject != null && gcloudKey != null;
}

/// Configuration from the environment variables.
final EnvConfig envConfig = new EnvConfig._detect();

auth.ServiceAccountCredentials _loadCredentials([String path]) {
  path ??= envConfig.gcloudKey;
  final content = File(path).readAsStringSync();
  return auth.ServiceAccountCredentials.fromJson(content);
}
