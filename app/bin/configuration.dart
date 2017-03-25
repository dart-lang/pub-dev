// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:googleapis_auth/auth.dart' as auth;

/// Class describing the configuration of running pub.dartlang.org.
///
/// The configuration define the location of the Datastore with the
/// package metadata and the Cloud Storage bucket for the actual package
/// tar files.
class Configuration {
  /// The service account email address used for accessing Cloud Storage.
  static const String _productionServiceAccountEmail =
      "818368855108@developer.gserviceaccount.com";

  /// If `useDbKeys` is `true` the credentials for accessing Cloud Storage is
  /// read from the Datastore. If `useDbKeys` is false the credentials for
  /// accessing Cloud Storage is read from a file. The location of that file
  /// depends on the environment.
  final bool useDbKeys;

  /// The service account email for the service account when `useDbKeys`
  /// is true.
  String get serviceAccountEmail {
    if (useDbKeys) {
      return _productionServiceAccountEmail;
    } else {
      return credentials.email;
    }
  }

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
  /// bucket 'pub.dartlang.org'. The credentials for accessing the Cloud
  /// Storage is retrieved from the Datastore.
  Configuration.prod()
      : projectId = 'dartlang-pub',
        packageBucketName = 'pub.dartlang.org',
        useDbKeys = true {}

  /// Create a configuration for development running directly on dart:io.
  ///
  /// The [projectId] is the cloud project holding the Datastore and the
  /// Cloud Storage bucket. The [packageBucketName] is the actual Cloud
  /// Storage bucket to use.
  ///
  /// The credentials used must be for a service account for the provided
  /// cloud project.
  Configuration.dev(this.projectId, this.packageBucketName)
      : useDbKeys = false;
}
