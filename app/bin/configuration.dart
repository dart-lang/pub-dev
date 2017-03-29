// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:googleapis_auth/auth.dart' as auth;

final activeConfiguration = new Configuration.prod();
//final activeConfiguration = new Configuration.dev();

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

  auth.ServiceAccountCredentials _credentials;

  /// Credentials to use for API calls if not reading the credentials from
  /// the Datastore.
  auth.ServiceAccountCredentials get credentials {
    if (_credentials == null) {
      _credentials = new auth.ServiceAccountCredentials.fromJson(
          new File(Platform.environment['GCLOUD_KEY']).readAsStringSync());
    }
    return _credentials;
  }

  bool get hasCredentials => Platform.environment['GCLOUD_KEY'] != null;

  /// Create a configuration for production deployment.
  ///
  /// This will use the Datastore from the cloud project and the Cloud Storage
  /// bucket 'pub-packages'. The credentials for accessing the Cloud
  /// Storage is retrieved from the Datastore.
  Configuration.prod()
      : projectId = 'dartlang-pub',
        packageBucketName = 'pub-packages' {}

  /// Create a configuration for development/staging deployment.
  Configuration.dev()
      : projectId = 'dartlang-pub-dev',
        packageBucketName = 'dartlang-pub-dev--pub-packages';
}
