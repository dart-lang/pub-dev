// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pubserver.repository;

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
    _cached = new Version.parse(versionString);
    return _cached;
  }

  PackageVersion(this.packageName, this.versionString, this.pubspecYaml);

  int get hashCode =>
      packageName.hashCode ^ versionString.hashCode ^ pubspecYaml.hashCode;

  bool operator==(other) {
    return other is PackageVersion &&
           other.packageName == packageName &&
           other.versionString == versionString &&
           other.pubspecYaml == pubspecYaml;
  }

  String toString() => 'PackageVersion: $packageName/$versionString';
}


/// Information obtained when starting an asynchronous upload.
class AsyncUploadInfo {
  /// The endpoint where the uploaded data should be posted.
  ///
  /// The upload is a POST to [uri] with the headers [headers] in the HTTP
  /// request. The body of the POST request must be a valid tar.gz file.
  final Uri uri;

  /// The headers the uploader should add to the upload.
  final Map<String, String> headers;

  AsyncUploadInfo(this.uri, this.headers);
}

/// Exception for unauthorized access attempts.
///
/// Uploading a new package from an unauthorized user will result in an
/// [UnauthorizedAccess] exception.
class UnauthorizedAccess implements Exception {
  final String message;

  UnauthorizedAccess(this.message);

  String toString() => 'UnauthorizedAccess: $message';
}

/// Represents a pub repository.
abstract class PackageRepository {
  /// Returns the known versions of [package].
  Stream<PackageVersion> versions(String package);

  /// Whether the [version] of [package] exists.
  Future<PackageVersion> lookupVersion(String package, String version);


  /// Whether this package repository supports uploading packages.
  bool get supportsUpload => false;

  /// Uploads a new pub package.
  ///
  /// [data] must be a stream of a valid .tar.gz file.
  Future upload(Stream<List<int>> data)
      => new Future.error(new UnsupportedError('No upload support.'));

  /// Whether this package repository supports asynchronous uploads.
  bool get supportsAsyncUpload => false;

  /// Starts a new upload.
  ///
  /// The given [baseRedirectUrl] instructs the uploading client to make a GET
  /// request to this location once the upload is complete. It might contain
  /// additional query parameters and must be supplied to `finishAsyncUpload`.
  ///
  /// The returned [AsyncUploadInfo] specifies where the tar.gz file should be
  /// posted to and what headers should be supplied.
  Future<AsyncUploadInfo> startAsyncUpload(Uri redirectUrl)
      => new Future.error(new UnsupportedError('No async upload support.'));

  /// Finishes the upload of a package.
  Future finishAsyncUpload(Uri uri)
      => new Future.error(new UnsupportedError('No async upload support.'));


  /// Downloads a pub package.
  Future<Stream> download(String package, String version);

  /// Whether this package repository supports download URLs.
  bool get supportsDownloadUrl => false;

  /// A permanent download URL to a package (if supported).
  Future<Uri> downloadUrl(String package, String version)
      => new Future.error(new UnsupportedError('No download link support.'));
}
