// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.backend;

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:pub_server/repository.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

import 'models.dart' as models;
import 'model_properties.dart';
import 'upload_signer_service.dart';
import 'package_memcache.dart';
import 'utils.dart';

final Logger _logger = new Logger('pub.cloud_repository');


/// Sets the active logged-in user.
void registerLoggedInUser(String user) => ss.register(#_logged_in_user, user);

/// The active logged-in user. This is used for doing authentication checks.
String get loggedInUser => ss.lookup(#_logged_in_user);


/// Sets the active tarball storage
void registerTarballStorage(TarballStorage ts)
    => ss.register(#_tarball_storage, ts);

/// The active tarball storage.
TarballStorage get tarballStorage => ss.lookup(#_tarball_storage);


/// Sets the backend service.
void registerBackend(Backend backend) => ss.register(#_backend, backend);

/// The active backend service.
Backend get backend => ss.lookup(#_backend);


/// Represents the backend for the pub.dartlang.org site.
class Backend {
  final DatastoreDB db;
  final GCloudPackageRepository repository;
  final UIPackageCache uiPackageCache;

  Backend(DatastoreDB db, TarballStorage storage, {UIPackageCache cache})
      : db = db,
        repository = new GCloudPackageRepository(db, storage),
        uiPackageCache = cache;

  /// Retrieves packages ordered by their latest version date.
  Future<List<models.Package>> latestPackages(
      {int offset: null, int limit: null}) {
    var query = db.query(models.Package)
        ..order('-updated')
        ..offset(offset)
        ..limit(limit);
    return query.run().toList();
  }

  /// Retrieves package versions ordered by their latest version date.
  Future<List<models.PackageVersion>> latestPackageVersions(
      {int offset: null, int limit: null}) async {
    var packages = await latestPackages(offset: offset, limit: limit);
    return lookupLatestVersions(packages);
  }

  /// Looks up a package by name.
  Future<models.Package> lookupPackage(String packageName) async {
    var packageKey = db.emptyKey.append(models.Package, id: packageName);
    return (await db.lookup([packageKey])).first;
  }

  /// Looks up a specific package version.
  Future<models.Package> lookupPackageVersion(String package,
                                              String version) async {
    version = canonicalizeVersion(version);
    var packageVersionKey = db.emptyKey
        .append(models.Package, id: package)
        .append(models.PackageVersion, id: version);
    return (await db.lookup([packageVersionKey])).first;
  }

  /// Looks up the latest versions of a list of packages.
  Future<List<models.PackageVersion>> lookupLatestVersions(
      List<models.Package> packages) {
    var keys = packages.map((models.Package p) => p.latestVersionKey).toList();
    return db.lookup(keys);
  }

  /// Looks up all versions of a package.
  Future<List<models.PackageVersion>> versionsOfPackage(String packageName) {
    var packageKey = db.emptyKey.append(models.Package, id: packageName);
    var query = db.query(models.PackageVersion, ancestorKey: packageKey);
    return query.run().toList();
  }

  /// Get a [Uri] which can be used to download a tarball of the pub package.
  Future<Uri> downloadUrl(String package, String version) async {
    version = canonicalizeVersion(version);
    assert (repository.supportsDownloadUrl);
    return repository.downloadUrl(package, version);
  }
}


/// A read-only implementation of [PackageRepository] using the Cloud Datastore
/// for metadata and Cloud Storage for tarball storage.
class GCloudPackageRepository extends PackageRepository {
  final Uuid uuid = new Uuid();
  final DatastoreDB db;
  final TarballStorage storage;

  GCloudPackageRepository(this.db, this.storage);

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
          },
          onError: controller.addError,
          onDone: controller.close);
        },
        onPause: () => subscription.pause(),
        onResume: () => subscription.resume(),
        onCancel: () => subscription.cancel());
    return controller.stream;
  }

  Future<PackageVersion> lookupVersion(String package, String version) async {
    version = canonicalizeVersion(version);

    var packageVersionKey = db
        .emptyKey
        .append(models.Package, id: package)
        .append(models.PackageVersion, id: version);

    models.PackageVersion pv = (await db.lookup([packageVersionKey])).first;
    if (pv == null) return null;
    return new PackageVersion(package, version, pv.pubspec.jsonString);
  }

  // Download support.

  Future<Stream<List<int>>> download(String package, String version) async {
    // TODO: Should we first test for existence?
    // Maybe with a cache?
    version = canonicalizeVersion(version);
    return storage.download(package, version);
  }

  bool get supportsDownloadUrl => true;

  Future<Uri> downloadUrl(String package, String version) async {
    version = canonicalizeVersion(version);
    return storage.downloadUrl(package, version);
  }

  // Upload support.

  bool get supportsUpload => true;

  Future<PackageVersion> upload(Stream<List<int>> data)  {
    _logger.info('Starting upload.');
    return withAuthenticatedUser((String userEmail) {
      _logger.info('User: $userEmail.');

      return withTempDirectory((Directory dir) async {
        var filename = '${dir.absolute.path}/tarball.tar.gz';
        await saveTarballToFS(data, filename);
        return _performTarballUpload(userEmail, filename, (package, version) {
          return storage.upload(
              package, version, new File(filename).openRead());
        });
      });
    });
  }

  bool get supportsAsyncUpload => true;

  Future<AsyncUploadInfo> startAsyncUpload(Uri redirectUrl) async {
    _logger.info('Starting async upload.');
    // NOTE: We use a authenticated user scope here to ensure the uploading
    // user is authenticated. But we're not validating anything at this point
    // because we don't even know which package or version is going to be
    // uploaded.
    return withAuthenticatedUser((String userEmail) {
      _logger.info('User: $userEmail.');

      String guid =  uuid.v4();
      String object = storage.tempObjectName(guid);
      String bucket = storage.bucket.bucketName;
      Duration lifetime = const Duration(minutes: 10);

      var url = redirectUrl.resolve('?upload_id=$guid');

      _logger.info(
          'Redirecting pub client to google cloud storage (uuid: $guid)');
      return uploadSigner.buildUpload(bucket, object, lifetime, '$url');
    });
  }

  /// Finishes the upload of a package.
  Future<PackageVersion> finishAsyncUpload(Uri uri) {
    return withAuthenticatedUser((String userEmail) async {
      var guid = uri.queryParameters['upload_id'];
      _logger.info('Finishing async upload (uuid: $guid)');
      _logger.info('Reading tarball from cloud storage.');

      return withTempDirectory((Directory dir) async {
        var filename = '${dir.absolute.path}/tarball.tar.gz';
        await saveTarballToFS(storage.readTempObject(guid), filename);
        return _performTarballUpload(userEmail, filename, (package, version) {
          return storage.uploadViaTempObject(guid, package, version);
        }).whenComplete(() async {
          _logger.info('Removing temporary object $guid.');
          await storage.removeTempObject(guid);
        });
      });
    });
  }

  Future<PackageVersion> _performTarballUpload(
      String userEmail, String filename,
      Future tarballUpload(name, version)) async {
      _logger.info('Examining tarball content.');

    // Parse metadata from the tarball.
    models.PackageVersion newVersion =
        await parseAndValidateUpload(db, filename, userEmail);

    // Add the new package to the repository by storing the tarball and
    // inserting metadata to datastore (which happens atomically).
    return await db.withTransaction((Transaction T) async {
      _logger.info('Starting datastore transaction.');

      var tuple = (await T.lookup([newVersion.key, newVersion.packageKey]));
      models.PackageVersion version = tuple[0];
      models.Package package = tuple[1];

      // If the version already exists, we fail.
      if (version != null) {
        await T.rollback();
        _logger.warning(
            'Version ${version.version} of package '
            '${version.package} already exists, rolling transaction back.');
        throw new Exception(
            'Version ${version.version} of package '
            '${version.package} already exists.');
      }

      // If the package does not exist, then we create a new package.
      if (package == null) package = newPackageFromVersion(db, newVersion);

      // Check if the uploader of the new version is allowed to upload to
      // the package.
      if (!package.hasUploader(newVersion.uploaderEmail)) {
        _logger.warning(
            'User ${newVersion.uploaderEmail} is not an uploader '
            'for package ${package.name}, rolling transaction back.');
        await T.rollback();
        throw new UnauthorizedAccessException(
            'Unauthorized user: ${newVersion.uploaderEmail} is not allowed to '
            'upload versions to package ${package.name}.');
      }

      // Update the date when the package was last updated.
      package.updated = newVersion.created;

      // Keep the latest version in the package object up-to-date.
      if (package.latestSemanticVersion < newVersion.semanticVersion &&
          (package.latestSemanticVersion.isPreRelease ||
           !newVersion.semanticVersion.isPreRelease)) {
        package.latestVersionKey = newVersion.key;
      }

      try {
        _logger.info('Trying to upload tarball to cloud storage.');
        // Apply update: Push to cloud storage
        await tarballUpload(package.name, newVersion.version);

        // Apply update: Update datastore.
        _logger.info('Trying to commit datastore changes.');
        T.queueMutations(inserts: [package, newVersion]);
        await T.commit();

        _logger.info('Upload successful.');

        // Try to load all package versions, sort them by `sort_order` and
        // store them again.
        await _updatePackageSortIndex(package.key);

        return new PackageVersion(
            newVersion.package, newVersion.version,
            newVersion.pubspec.jsonString);
      } catch (error, stack) {
        _logger.warning('Error while committing: $error, $stack');
        await T.rollback();
        rethrow;
      }
    });
  }

  Future _updatePackageSortIndex(Key packageKey) async {
    try {
      _logger.info('Trying to update the `sort_order` field.');
      await db.withTransaction((Transaction T) async {
        List<models.PackageVersion> versions = await
            T.query(models.PackageVersion, packageKey).run().toList();
        versions.sort((versionA, versionB) {
          return versionA.semanticVersion.compareTo(
              versionB.semanticVersion);
        });

        List<models.PackageVersion> modifiedVersions = [];

        for (int i = 0; i < versions.length; i++) {
          var version = versions[i];
          if (version.sortOrder != i) {
            version.sortOrder = i;
            modifiedVersions.add(version);
          }
        }

        T.queueMutations(inserts: modifiedVersions);
        await T.commit();
        _logger.info('Successfully updated `sort_order` field of '
                     '${modifiedVersions.length} versions'
                     '(out of ${versions.length} versions).');
      });
    } catch (error, stack) {
      // We ignore errors, since the sorting is not that critical and
      // the upload itself was successfull.
      _logger.warning(
          'Sorting by `sort_order` failed, but upload was successful.',
          error, stack);
    }
  }

  // Uploaders support.

  bool get supportsUploaders => true;

  Future addUploader(String packageName, String uploaderEmail) async {
    return withAuthenticatedUser((String userEmail) {
      return db.withTransaction((Transaction T) async {
        var packageKey = db.emptyKey.append(models.Package, id: packageName);
        models.Package package = (await T.lookup([packageKey])).first;

        // Fail if package doesn't exist.
        if (package == null) {
          await T.rollback();
          throw new Exception('Package "$package" does not exist');
        }

        // Fail if calling user doesn't have permission to change uploaders.
        if (!package.hasUploader(userEmail)) {
          await T.rollback();
          throw new UnauthorizedAccessException(
              'Calling user does not have permission to change uploaders.');
        }

        // Fail if the uploader we want to add already exists.
        if (package.hasUploader(uploaderEmail)) {
          await T.rollback();
          throw new UploaderAlreadyExistsException();
        }

        // Add [uploaderEmail] to uploaders and commit.
        package.uploaderEmails.add(uploaderEmail);
        T.queueMutations(inserts: [package]);
        return T.commit();
      });
    });
  }

  Future removeUploader(String packageName, String uploaderEmail) async {
    return withAuthenticatedUser((String userEmail) {
      return db.withTransaction((Transaction T) async {
        var packageKey = db.emptyKey.append(models.Package, id: packageName);
        models.Package package = (await T.lookup([packageKey])).first;

        // Fail if package doesn't exist.
        if (package == null) {
          await T.rollback();
          throw new Exception('Package "$package" does not exist');
        }

        // Fail if calling user doesn't have permission to change uploaders.
        if (!package.hasUploader(userEmail)) {
          await T.rollback();
          throw new UnauthorizedAccessException(
              'Calling user does not have permission to change uploaders.');
        }

        // Fail if the uploader we want to remove does not exist.
        if (!package.hasUploader(uploaderEmail)) {
          await T.rollback();
          throw new Exception('The uploader to remove does not exist.');
        }

        // Remove the uploader from the list.
        package.removeUploader(uploaderEmail);

        // We cannot have 0 uploaders, if we would remove the last one, we
        // fail with an error.
        if (package.uploaderEmails.isEmpty) {
          await T.rollback();
          throw new LastUploaderRemoveException();
        }

        T.queueMutations(inserts: [package]);
        return T.commit();
      });
    });
  }
}

/// Calls [func] with the currently logged in user as an argument.
///
/// If no user is currently logged in, this will throw an `UnauthorizedAccess`
/// exception.
withAuthenticatedUser(func(String user)) async {
  if (loggedInUser == null) {
    throw new UnauthorizedAccessException('No active user.');
  }
  return func(loggedInUser);
}

/// Reads a tarball from a byte stream.
///
/// Compeltes with an error if the incoming stream has an error or if the size
/// exceeds `GcloudPackageRepo.MAX_TARBALL_SIZE`.
Future saveTarballToFS(Stream<List<int>> data, String filename) async {
  Completer completer = new Completer();

  StreamSink<List<int>> sink;
  StreamSubscription dataSubscription;
  StreamController intermediary;
  Future addStreamFuture;

  abort(error, stack) {
    _logger.warning(
        'An error occured while streaming tarball to FS.', error, stack);

    if (dataSubscription != null) {
      dataSubscription.cancel();
      dataSubscription = null;
    }
    if (!completer.isCompleted) {
      completer.completeError(error, stack);
    }
  }

  finish() {
    _logger.info('Finished streaming tarball to FS.');
    completer.complete();
  }

  startReading() {
    int receivedBytes = 0;

    dataSubscription = data.listen((List<int> chunk) {
      receivedBytes += chunk.length;
      if (receivedBytes <= UploadSignerService.MAX_UPLOAD_SIZE) {
        intermediary.add(chunk);
      } else {
        var error = 'Invalid upload: Exceeded '
            '${UploadSignerService.MAX_UPLOAD_SIZE} upload size.';
        intermediary.addError(error);
        intermediary.close();

        abort(error, null);
      }
    },
    onError: abort,
    onDone: () {
      intermediary.close();
      addStreamFuture.then((_) async {
        await sink.close();
        finish();
      }).catchError((error, stack) {
        // NOTE: There is also an error handler further down for `addStream()`,
        // since an error might occur before we get this `onDone` callback.
        // In this case `abort` will not do anything.
        abort(error, stack);
      });
    });
  }

  intermediary = new StreamController(
      onListen: startReading,
      onPause: () => dataSubscription.pause(),
      onResume: () => dataSubscription.resume(),
      onCancel: () {
        // NOTE: We do nothing here. The `.pipe()` further down will
        //  - listen on the stream
        //  - will get data
        //  - will get the done event
        //  - will cancel the subscription
        // => Since this is normal behavior we're not aborting here.
      });


  sink = new File(filename).openWrite();
  addStreamFuture = sink.addStream(intermediary.stream);
  addStreamFuture.catchError(abort);

  return completer.future;
}

/// Creates a new `Package` and populates all of it's fields.
models.Package newPackageFromVersion(DatastoreDB db,
                                     models.PackageVersion version) {
  var now = new DateTime.now().toUtc();
  return new models.Package()
      ..parentKey = db.emptyKey
      ..id = version.pubspec.name
      ..name = version.pubspec.name
      ..created = now
      ..updated = now
      ..downloads = 0
      ..latestVersionKey = version.key
      ..uploaderEmails = [loggedInUser];
}

/// Parses metadata from a tarball and & validates it.
///
/// This function ensures that `tarball`
///   * is a valid `tar.gz` file
///   * contains a valid `pubspec.yaml` file
///   * reads readme, changelog and pubspec files
///   * creates a [models.PackageVersion] and populates it with all metadata
Future<models.PackageVersion> parseAndValidateUpload(DatastoreDB db,
                                                     String filename,
                                                     String user) async {
  assert (user != null);

  var files = await listTarball(filename);

  // Searches in [files] for a file name [name] and compare in a
  // case-insensitive manner.
  //
  // Returns `null` if not found otherwise the correct filename.
  String searchForFile(String name) {
    String nameLowercase = name.toLowerCase();
    for (String filename in files) {
      if (filename.toLowerCase() == nameLowercase) {
        return filename;
      }
    }
    return null;
  }

  var readmeFilename = searchForFile('README.md');
  if (readmeFilename == null) {
    readmeFilename = searchForFile('README');
  }

  var changelogFilename = searchForFile('CHANGELOG.md');
  if (changelogFilename == null) {
    changelogFilename = searchForFile('CHANGELOG');
  }

  var libraries = files
      .where((file) => file.startsWith('lib/'))
      .where((file) => !file.startsWith('lib/src'))
      .where((file) => file.endsWith('.dart'))
      .map((file) => file.substring('lib/'.length))
      .toList();

  if (!files.contains('pubspec.yaml')) {
    throw 'Invalid upload: no pubspec.yaml file';
  }

  var pubspecContent = await readTarballFile(filename, 'pubspec.yaml');

  var pubspec = new Pubspec.fromYaml(pubspecContent);
  if (pubspec.name == null || pubspec.version == null) {
    throw 'Invalid `pubspec.yaml` file';
  }

  var readmeContent = readmeFilename != null
      ? await readTarballFile(filename, readmeFilename) : null;
  var changelogContent = changelogFilename != null
      ? await readTarballFile(filename, changelogFilename) : null;

  var packageKey = db.emptyKey.append(models.Package, id: pubspec.name);

  var versionString = canonicalizeVersion(pubspec.version);

  var version = new models.PackageVersion()
      ..id = versionString
      ..parentKey = packageKey
      ..version = versionString
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
}

/// Helper utility class for interfacing with Cloud Storage for storing
/// tarballs.
class TarballStorage {
  final TarballStorageNamer namer;
  final Storage storage;
  final Bucket bucket;

  TarballStorage(this.storage, Bucket bucket, String namespace) :
      bucket = bucket,
      namer = new TarballStorageNamer(bucket.bucketName, namespace);

  /// Generates a path to a temporary object on cloud storage.
  String tempObjectName(String guid) => namer.tmpObjectName(guid);

  /// Reads the temporary object identified by [guid]
  Stream<List<int>> readTempObject(String guid)
      => bucket.read(namer.tmpObjectName(guid));

  /// Makes a temporary object a new tarball.
  Future uploadViaTempObject(String guid,
                             String package,
                             String version) async {
    var object = namer.tarballObjectName(package, version);

    // Copy the temporary object to it's destination place.
    await storage.copyObject(
        bucket.absoluteObjectName(namer.tmpObjectName(guid)),
        bucket.absoluteObjectName(object));

    // Change the ACL to include a `public-read` entry.
    ObjectInfo info = await bucket.info(object);
    var publicRead = new AclEntry(new AllUsersScope(), AclPermission.READ);
    var acl =
        new Acl(new List.from(info.metadata.acl.entries)..add(publicRead));
    await bucket.updateMetadata(object, info.metadata.replace(acl: acl));
  }

  /// Remove a previously generated temporary object.
  Future removeTempObject(String guid) async {
    if (guid == null) throw new ArgumentError('No guid given.');
    return bucket.delete(namer.tmpObjectName(guid));
  }

  /// Download the tarball of a [package] in the given [version].
  Stream<List<int>> download(String package, String version) {
    var object = namer.tarballObjectName(package, version);
    return bucket.read(object);
  }

  /// Get the URL to the tarball of a [package] in the given [version].
  Future<Uri> downloadUrl(String package, String version) {
    // NOTE: We should maybe check for existence first?
    // return storage.bucket(bucket).info(object)
    //     .then((info) => info.downloadLink);
    return new Future.value(
        Uri.parse(namer.tarballObjectUrl(package, version)));
  }

  /// Upload [tarball] of a [package] in the given [version].
  Future upload(String package, String version, Stream<List<int>> tarball) {
    var object = namer.tarballObjectName(package, version);
    return tarball.pipe(
        bucket.write(object, predefinedAcl: PredefinedAcl.publicRead));
  }
}

/// Class used for getting GCS object/bucket names and object URLs.
///
///
/// The GCS bucket contains package tarballs in a temporary place and stored
/// package tarballs which are used by clients. The latter can be stored either
/// via an empty or non-empty namespace.
///
/// The layout of the GCS bucket is as follows:
///   gs://<bucket-name>/tmp/<uuid>
///   gs://<bucket-name>/packages/<package-name>-<version>.tar.gz
///   gs://<bucket-name>/ns/<namespace>/packages/<package-name>-<version>.tar.gz
class TarballStorageNamer {
  /// The GCS bucket used.
  final String bucket;

  /// The namespace used.
  final String namespace;

  /// The prefix of where packages are stored (i.e. '' or 'ns/<namespace>').
  final String prefix;

  TarballStorageNamer(this.bucket, String namespace) :
      namespace = namespace == null ? '' : namespace,
      prefix = (namespace == null || namespace.isEmpty) ? '' : 'ns/$namespace/';

  /// The GCS object name of a tarball object - excluding leading '/'.
  String tarballObjectName(String package, String version)
      // TODO: Do we need some kind of escaping here?
      => '${prefix}packages/$package-$version.tar.gz';

  /// The GCS object name of an temporary object [guid] - excluding leading '/'.
  String tmpObjectName(String guid) => 'tmp/$guid';

  /// The http URL of a publicly accessable GCS object.
  String tarballObjectUrl(String package, String version) {
    var object = tarballObjectName(package, version);
    return 'https://storage.googleapis.com/${bucket}/${object}';
  }
}
