// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.gcloud_repository;

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:pubserver/repository.dart';
import 'package:logging/logging.dart';

import 'models.dart' as models;
import 'model_properties.dart';
import 'utils.dart';

final Logger _logger = new Logger('pub.cloud_repository');

/// Sets the active logged-in user.
void registerLoggedInUser(String user) => ss.register(#_logged_in_user, user);

/// The active logged-in user. This is used for doing authentication checks.
String get loggedInUser => ss.lookup(#_logged_in_user);


/// A read-only implementation of [PackageRepository] using the Cloud Datastore
/// for metadata and Cloud Storage for tarball storage.
class GCloudPackageRepo extends PackageRepository {
  static const int MAX_TARBALL_SIZE = 10 * 1024  * 1024;

  final DatastoreDB db;
  TarballStorage _tarballStorage;

  GCloudPackageRepo(this.db, Bucket bucket)
      : _tarballStorage = new TarballStorage(bucket, 'test-packages');

  // Metadata support.

  Stream<PackageVersion> versions(String package) {
    var controller;
    var subscription;

    controller = new StreamController(
        onListen: () {
          var packageKey = db.emptyKey.append(models.Package, id: package);
          var query = db.query(models.PackageVersion, ancestorKey: packageKey);
          subscription = query.run().listen((models.PackageVersion model) {
            var packageVersion = new PackageVersion(
                package, model.version, model.pubspec.jsonString);
            controller.add(packageVersion);
          }, onError: (error, stack) => controller.addError(error, stack),
             onDone: () => controller.close());
        },
        onPause: () => subscription.pause(),
        onResume: () => subscription.resume(),
        onCancel: () => subscription.cancel());
    return controller.stream;
  }

  Future<PackageVersion> lookupVersion(String package, String version) async {
    var packageVersionKey = db
        .emptyKey
        .append(models.Package, id: package)
        .append(models.PackageVersion, id: version);

    models.PackageVersion pv = (await db.lookup([packageVersionKey])).first;
    if (pv == null) return null;
    return new PackageVersion(package, version, pv.pubspec.jsonString);
  }

  // Download support.

  Future<Stream<List<int>>> download(String package, String version) {
    // TODO: Should we first test for existence?
    // Maybe with a cache?
    return new Future.value(_tarballStorage.download(package, version));
  }

  bool get supportsDownloadUrl => true;

  Future<Uri> downloadUrl(String package, String version) {
    return _tarballStorage.downloadUrl(package, version);
  }

  // Upload support.

  bool get supportsUpload => true;

  Future upload(Stream<List<int>> data)  {
    _logger.info('Starting upload.');
    return withAuthenticatedUser((String userEmail) {
      _logger.info('User: $userEmail.');

      // Read the entire tarball & keep it in memory (fail if > 10 MB).
      // TODO: Find out why we it times out when we do it in an async scope.
      return readTarball(data).then((tarball) async {
        // Parse metadata from the tarball.
        models.PackageVersion newVersion =
            await parseAndValidateUpload(tarball, userEmail);

        // Add the new package to the repository by storing the tarball and
        // inserting metadata to datastore (which happens atomically).
        await dbService.withTransaction((Transaction T) async {
          var tuple = (await T.lookup([newVersion.key, newVersion.packageKey]));
          models.PackageVersion version = tuple[0];
          models.Package package = tuple[1];

          // If the version already exists, we fail.
          if (version != null) {
            await T.rollback();
            throw 'version already exists';
          }

          // If the package does not exist, then we create a new package.
          if (package == null) package = newPackageFromVersion(newVersion);

          // Check if the uploader of the new version is allowed to upload to
          // the package.
          if (!package.uploaderEmails.contains(newVersion.uploaderEmail)) {
            await T.rollback();
            throw new UnauthorizedAccess('Unauthorized user.');
          }

          // Update the date when the package was last updated.
          package.updated = newVersion.created;

          // Keep the latest version in the package object up-to-date.
          if (package.latestSemanticVersion < newVersion.semanticVersion &&
              (package.latestSemanticVersion.isPreRelease ||
               !newVersion.semanticVersion.isPreRelease)) {
            package.latestVersion = newVersion.key;
          }

          try {
            _logger.info('Trying to upload tarball to cloud storage.');
            // Apply update: Push to cloud storage
            await _tarballStorage.upload(package.name,
                                         newVersion.version, tarball);

            // Apply update: Update datastore.
            _logger.info('Trying to commit datastore changes.');
            T.queueMutations(inserts: [package, newVersion]);
            await T.commit();


            _logger.info('Upload successful.');

            // Defer the creation of sort_order
            // TODO:
          } catch (error, stack) {
            _logger.info('Error while committing: $error, $stack');
            await T.rollback();
            rethrow;
          }
        });
      });
    });
  }

  bool get supportsAsyncUpload => false;

  Future<AsyncUploadInfo> startAsyncUpload(Uri redirectUrl) {
    return new Future.error(new UnsupportedError('No async upload support.'));
  }

  /// Finishes the upload of a package.
  Future finishAsyncUpload(Uri uri) {
    return new Future.error(new UnsupportedError('No async upload support.'));
  }
}

/// Calls [func] with the currently logged in user as an argument.
///
/// If no user is currently logged in, this will throw an `UnauthorizedAccess`
/// exception.
withAuthenticatedUser(func(String user)) {
  if (loggedInUser == null) {
    throw new UnauthorizedAccess('No active user.');
  }
  return func(loggedInUser);
}

/// Reads a tarball from a byte stream.
///
/// Compeltes with an error if the incoming stream has an error or if the size
/// exceeds `GcloudPackageRepo.MAX_TARBALL_SIZE`.
Future<List<int>> readTarball(Stream<List<int>> data) {
  var tarballBytes = new BytesBuilder();
  var subscription;
  var completer = new Completer();

  subscription = data.listen((List<int> chunk) {
    tarballBytes.add(chunk);
    if (tarballBytes.length > GCloudPackageRepo.MAX_TARBALL_SIZE) {
      // TODO: Test that this actually results in a shutdown() of the socket
      // so we don't buffer data.
      subscription.cancel();
      completer.completeError(
          'Invalid upload: Exceeded ${GCloudPackageRepo.MAX_TARBALL_SIZE} '
          'upload size.');
    }
  }, onError: (error, stack) {
    subscription.cancel();
    completer.completeError(error, stack);
  }, onDone: () {
    completer.complete(tarballBytes.takeBytes());
  });

  return completer.future;
}

/// Creates a new `Package` and populates all of it's fields.
models.Package newPackageFromVersion(models.PackageVersion version) {
  var now = new DateTime.now().toUtc();
  return new models.Package()
      ..id = version.pubspec.name
      ..name = version.pubspec.name
      ..created = now
      ..updated = now
      ..downloads = 0
      ..latestVersion = version.key
      ..uploaderEmails = [loggedInUser];
}

/// Parses metadata from a tarball and & validates it.
///
/// This function ensures that `tarball`
///   * is a valid `tar.gz` file
///   * contains a valid `pubspec.yaml` file
///   * reads readme, changelog and pubspec files
///   * creates a [models.PackageVersion] and populates it with all metadata
Future<models.PackageVersion> parseAndValidateUpload(List<int> tarball,
                                                     String user) async {
  assert (user != null);

  return withTempDirectory((Directory dir) async {
    // TODO: We could think about streaming this to a file instead of doing
    // synchronous writing.
    var file = new File('data.bin');
    await file.writeAsBytes(tarball);

    var files = await listTarball(file.path);

    var readmeFilename;
    if (files.contains('README.md')) readmeFilename = 'README.md';
    else if (files.contains('README')) readmeFilename = 'README';

    var changelogFilename;
    if (files.contains('CHANGELOG.md')) changelogFilename = 'CHANGELOG.md';
    else if (files.contains('CHANGELOG')) readmeFilename = 'CHANGELOG';

    var libraries = files
        .where((file) => file.startsWith('lib/'))
        .where((file) => !file.startsWith('lib/src'))
        .where((file) => file.endsWith('.dart'))
        .toList();

    if (!files.contains('pubspec.yaml')) {
      throw 'Invalid upload: no pubspec.yaml file';
    }

    var pubspecContent = await readTarballFile(file.path, 'pubspec.yaml');

    var pubspec = new Pubspec.fromYaml(pubspecContent);
    if (pubspec.name == null || pubspec.version == null) {
      throw 'Invalid `pubspec.yaml` file';
    }

    var readmeContent = readmeFilename != null
        ? await readTarballFile(file.path, readmeFilename) : null;
    var changelogContent = changelogFilename != null
        ? await readTarballFile(file.path, changelogFilename) : null;

    var packageKey =
        dbService.emptyKey.append(models.Package, id: pubspec.name);

    var version = new models.PackageVersion()
        ..id = pubspec.version
        ..parentKey = packageKey
        ..version = pubspec.version
        ..packageKey = packageKey
        ..created = new DateTime.now().toUtc()
        ..pubspec = pubspec
        ..readmeFilename = readmeFilename
        ..readmeContent = readmeContent
        ..changelogFilename = changelogFilename
        ..changelogContent = changelogContent
        ..libraries = libraries
        ..downloads = 0
        ..sortOrder = 1
        ..uploaderEmail = user;
    return version;
  });
}

/// Helper utility class for interfacing with Cloud Storage for storing
/// tarballs.
class TarballStorage {
  final Bucket bucket;
  final String prefix;

  TarballStorage(this.bucket, this.prefix);

  /// Download the tarball of a [package] in the given [version].
  Stream<List<int>> download(String package, String version) {
    var object = _tarballObject(package, version);
    return bucket.read(object);
  }

  /// Get the URL to the tarball of a [package] in the given [version].
  Future<Uri> downloadUrl(String package, String version) {
    // NOTE: We should maybe check for existence first?
    // return storage.bucket(bucket).info(object)
    //     .then((info) => info.downloadLink);

    var object = _tarballObject(package, version);
    var uri = Uri.parse(
        'https://storage.googleapis.com/${bucket.bucketName}/${object}');
    return new Future.value(uri);
  }

  /// Upload [tarball] of a [package] in the given [version].
  Future upload(String package, String version, List<int> tarball) {
    var object = _tarballObject(package, version);
    return bucket.writeBytes(
        object, tarball, predefinedAcl: PredefinedAcl.publicRead);
  }

  // TODO: Do we need some kind of escaping here?
  String _tarballObject(String package, String version)
      => '$prefix/$package-$version.tar.gz';
}
