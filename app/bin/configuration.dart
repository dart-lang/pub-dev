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
  static const String _prodProjectId = 'dartlang-pub';
  static const String _prodPackageBucket = 'pub.dartlang.org';

  /// The service account email address used for accessing Cloud Storage.
  final String _productionServiceAccountEmail =
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

  /// Using 'gcloud preview app run app.yaml' locally with apiary datastore can
  /// be enabled by settings this to `true`.
  final bool useApiaryDatastore;

  /// The name of the Cloud Storage bucket to use.
  final String packageBucketName;

  /// The Cloud project Id. This is only required when using Apiary to access
  /// Datastore and/or Cloud Storage
  final String projectId;

  final String _credentialsFile;

  auth.ServiceAccountCredentials _credentials;

  /// Credentials to use for API calls if not reading the credentials from
  /// the Datastore.
  auth.ServiceAccountCredentials get credentials {
    if (_credentials == null) {
      _credentials = new auth.ServiceAccountCredentials.fromJson(
          new File(_credentialsFile).readAsStringSync());
    }
    return _credentials;
  }

  bool get hasCredentials => _credentialsFile != null;

  /// Create a configuration for production deployment.
  ///
  /// This will use the Datastore from the cloud project and the Cloud Storage
  /// bucket 'pub.dartlang.org'. The credentials for accessing the Cloud
  /// Storage is retrieved from the Datastore.
  Configuration.prod()
      : useDbKeys = true,
        useApiaryDatastore = false,
        packageBucketName = _prodPackageBucket,
        projectId = null,
        _credentialsFile = null {}

  /// Create a configuration for development deployment. Running local using
  /// 'gcloud preview app run'.
  ///
  /// This will use the locally emulated Datastore and the Cloud Storage bucket
  /// passed as arguments. The credentials for the Cloud Storage bucket must
  /// reside in the `key.json` in the root of the project where the
  /// `Dockerfile` expects it to be.
  Configuration.dev(String this.projectId,
                    String this.packageBucketName)
      : useDbKeys = false,
        useApiaryDatastore = false,
        _credentialsFile = '/project/key.json' {}

  /// Create a configuration for running locally using dart:io while accessing
  /// the production data.
  ///
  /// The credentials used must be for a service account for the production
  /// cloud project.
  Configuration.prod_io({String credentialsFile})
      : useDbKeys = true,
        useApiaryDatastore = true,
        packageBucketName = _prodPackageBucket,
        projectId = _prodProjectId,
        _credentialsFile = credentialsFile != null
            ? credentialsFile
            : Platform.script.resolve('../../key.json').toFilePath() {}

  /// Create a configuration for development running directly on dart:io.
  ///
  /// The [projectId] is the cloud project holding the Datastore and the
  /// Cloud Storage bucket. The [packageBucketName] is the actual Cloud
  /// Storage bucket to use.
  ///
  /// The credentials used must be for a service account for the provided
  /// cloud project.
  Configuration.dev_io(String this.projectId,
                       String this.packageBucketName,
                       {String credentialsFile})
      : useDbKeys = false,
        useApiaryDatastore = true,
        _credentialsFile = credentialsFile != null
            ? credentialsFile
            : Platform.script.resolve('../../key.json').toFilePath() {}

  /// Create a new configuration replacing some of the properties of the
  /// source.
  Configuration replace({bool useDbKeys,
                         bool useApiaryDatastore,
                         String packageBucketName,
                         String projectId,
                         String credentialsFile}) {
    return new Configuration._(
        useDbKeys != null ? useDbKeys : this.useDbKeys,
        useApiaryDatastore != null ? useApiaryDatastore
                                   : this.useApiaryDatastore,
        packageBucketName != null ? packageBucketName : this.packageBucketName,
        projectId != null ? projectId : this.projectId,
        credentialsFile != null ? credentialsFile : this._credentialsFile);
  }

  Configuration._(this.useDbKeys,
                  this.useApiaryDatastore,
                  this.packageBucketName,
                  this.projectId,
                  this._credentialsFile);

}

