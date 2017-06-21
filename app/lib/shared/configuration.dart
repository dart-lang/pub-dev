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
  /// The name of the Cloud Storage bucket to use.
  final String packageBucketName;

  /// The Cloud project Id. This is only required when using Apiary to access
  /// Datastore and/or Cloud Storage
  final String projectId;

  /// The host name for the search service.
  final String searchServiceHost;

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
        searchServiceHost = 'search-dot-dartlang-pub.appspot.com';

  /// Create a configuration for development/staging deployment.
  Configuration._dev()
      : projectId = 'dartlang-pub-dev',
        packageBucketName = 'dartlang-pub-dev--pub-packages',
        searchServiceHost = 'search-dot-dartlang-pub-dev.appspot.com';

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
  final String duceneDir;
  final String gaeService;
  final String gcloudKey;
  final String gcloudProject;
  final String flutterSdkDir;

  EnvConfig._(this.duceneDir, this.gaeService, this.gcloudProject,
      this.gcloudKey, this.flutterSdkDir) {
    if (this.gcloudProject == null) {
      throw new Exception('GCLOUD_PROJECT needs to be set!');
    }
  }

  factory EnvConfig._detect() {
    return new EnvConfig._(
      Platform.environment['DUCENE_DIR'],
      Platform.environment['GAE_SERVICE'],
      Platform.environment['GCLOUD_PROJECT'],
      Platform.environment['GCLOUD_KEY'],
      Platform.environment['FLUTTER_SDK'],
    );
  }

  bool get hasGcloudKey => gcloudKey != null;
}

/// Configuration from the environment variables.
final EnvConfig envConfig = new EnvConfig._detect();
