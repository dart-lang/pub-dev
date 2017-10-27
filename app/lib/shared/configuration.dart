// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:math' show max;

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

  /// The scheme://host:port prefix for the analyzer service.
  final String analyzerServicePrefix;

  /// The scheme://host:port prefix for the dartdoc service.
  final String dartdocServicePrefix;

  /// The scheme://host:port prefix for the search service.
  final String searchServicePrefix;

  /// The name of the Cloud Storage bucket to use for popularity data dumps.
  final String popularityDumpBucketName;

  /// The name of the Cloud Storage bucket to use for search snapshots.
  final String searchSnapshotBucketName;

  auth.ServiceAccountCredentials _credentials;

  /// Credentials to use for API calls if not reading the credentials from
  /// the Datastore.
  auth.ServiceAccountCredentials get credentials {
    if (_credentials == null) {
      _credentials = new auth.ServiceAccountCredentials.fromJson(
          new File(envConfig.gcloudKey).readAsStringSync());
    }
    return _credentials;
  }

  bool get hasCredentials => envConfig.hasGcloudKey;

  /// Create a configuration for production deployment.
  ///
  /// This will use the Datastore from the cloud project and the Cloud Storage
  /// bucket 'pub-packages'. The credentials for accessing the Cloud
  /// Storage is retrieved from the Datastore.
  Configuration._prod()
      : projectId = 'dartlang-pub',
        packageBucketName = 'pub-packages',
        analyzerServicePrefix = 'https://analyzer-dot-dartlang-pub.appspot.com',
        dartdocServicePrefix = 'https://dartdoc-dot-dartlang-pub.appspot.com',
        searchServicePrefix = 'https://search-dot-dartlang-pub.appspot.com',
        popularityDumpBucketName = 'dartlang-pub--popularity',
        searchSnapshotBucketName = 'dartlang-pub--search-snapshot';

  /// Create a configuration for development/staging deployment.
  Configuration._dev()
      : projectId = 'dartlang-pub-dev',
        packageBucketName = 'dartlang-pub-dev--pub-packages',
        analyzerServicePrefix =
            'https://analyzer-dot-dartlang-pub-dev.appspot.com',
        dartdocServicePrefix =
            'https://dartdoc-dot-dartlang-pub-dev.appspot.com',
        searchServicePrefix = 'https://search-dot-dartlang-pub-dev.appspot.com',
        popularityDumpBucketName = 'dartlang-pub-dev-popularity',
        searchSnapshotBucketName = 'dartlang-pub-dev--search-snapshot';

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
  final String flutterSdkDir;
  final int isolateCount;

  EnvConfig._(
    this.gaeService,
    this.gcloudProject,
    this.gcloudKey,
    this.flutterSdkDir,
    this.isolateCount,
  ) {
    if (this.gcloudProject == null) {
      throw new Exception('GCLOUD_PROJECT needs to be set!');
    }
  }

  factory EnvConfig._detect() {
    final String isolateCountStr = Platform.environment['ISOLATE_COUNT'] ?? '1';
    int isolateCount = int.parse(isolateCountStr, onError: (_) => 1);
    isolateCount = max(1, isolateCount);
    return new EnvConfig._(
      Platform.environment['GAE_SERVICE'],
      Platform.environment['GCLOUD_PROJECT'],
      Platform.environment['GCLOUD_KEY'],
      Platform.environment['FLUTTER_SDK'],
      isolateCount,
    );
  }

  bool get hasGcloudKey => gcloudKey != null;
}

/// Configuration from the environment variables.
final EnvConfig envConfig = new EnvConfig._detect();
