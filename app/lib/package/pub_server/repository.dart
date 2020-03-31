// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_server.repository;

import 'dart:async';

import 'package:pub_semver/pub_semver.dart';

/// Represents information about a specific version of a pub package.
class PackageVersion {
  /// The name of the package.
  final String packageName;

  /// The version string of the package.
  final String versionString;

  /// The pubspec yaml file of the package
  final String pubspecYaml;

  Version _cached;

  /// The version of the package as a [Version] object.
  Version get version {
    if (_cached != null) return _cached;
    _cached = Version.parse(versionString);
    return _cached;
  }

  PackageVersion(this.packageName, this.versionString, this.pubspecYaml);

  @override
  int get hashCode =>
      packageName.hashCode ^ versionString.hashCode ^ pubspecYaml.hashCode;

  @override
  bool operator ==(other) {
    return other is PackageVersion &&
        other.packageName == packageName &&
        other.versionString == versionString &&
        other.pubspecYaml == pubspecYaml;
  }

  @override
  String toString() => 'PackageVersion: $packageName/$versionString';
}

/// Information obtained when starting an asynchronous upload.
class AsyncUploadInfo {
  /// The endpoint where the uploaded data should be posted.
  ///
  /// The upload is a POST to [uri] with the headers [fields] in the HTTP
  /// request. The body of the POST request must be a valid tar.gz file.
  final Uri uri;

  /// The fields the uploader should add to the multipart upload.
  final Map<String, String> fields;

  AsyncUploadInfo(this.uri, this.fields);
}

/// Represents a pub repository.
abstract class PackageRepository {
  /// Returns the known versions of [package].
  Stream<PackageVersion> versions(String package);

  /// Whether the [version] of [package] exists.
  Future<PackageVersion> lookupVersion(String package, String version);

  /// Starts a  upload.
  ///
  /// The given [redirectUrl] instructs the uploading client to make a GET
  /// request to this location once the upload is complete. It might contain
  /// additional query parameters and must be supplied to `finishAsyncUpload`.
  ///
  /// The returned [AsyncUploadInfo] specifies where the tar.gz file should be
  /// posted to and what headers should be supplied.
  Future<AsyncUploadInfo> startAsyncUpload(Uri redirectUrl) async =>
      throw UnsupportedError('No async upload support.');

  /// Finishes the upload of a package.
  Future<PackageVersion> finishAsyncUpload(Uri uri) async =>
      throw UnsupportedError('No async upload support.');

  /// Downloads a pub package.
  Future<Stream<List<int>>> download(String package, String version);

  /// A permanent download URL to a package (if supported).
  Future<Uri> downloadUrl(String package, String version) async =>
      throw UnsupportedError('No download link support.');

  /// Adds [userEmail] as an uploader to [package].
  Future addUploader(String package, String userEmail) async =>
      throw UnsupportedError('No uploader support.');

  /// Removes [userEmail] as an uploader from [package].
  Future removeUploader(String package, String userEmail) async =>
      throw UnsupportedError('No uploader support.');
}
