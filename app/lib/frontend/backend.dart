// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.backend;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_server/repository.dart';
import 'package:uuid/uuid.dart';

import '../history/backend.dart';
import '../history/models.dart';
import '../shared/email.dart';
import '../shared/package_memcache.dart';
import '../shared/urls.dart' as urls;
import '../shared/utils.dart';
import 'email_sender.dart';
import 'model_properties.dart';
import 'models.dart' as models;
import 'name_tracker.dart';
import 'upload_signer_service.dart';

final Logger _logger = new Logger('pub.cloud_repository');
final _random = new Random.secure();

/// Sets the active logged-in user.
void registerLoggedInUser(String user) => ss.register(#_logged_in_user, user);

/// The active logged-in user. This is used for doing authentication checks.
String get _loggedInUser => ss.lookup(#_logged_in_user) as String;

/// Sets the active tarball storage
void registerTarballStorage(TarballStorage ts) =>
    ss.register(#_tarball_storage, ts);

/// The active tarball storage.
TarballStorage get tarballStorage =>
    ss.lookup(#_tarball_storage) as TarballStorage;

/// Sets the backend service.
void registerBackend(Backend backend) => ss.register(#_backend, backend);

/// The active backend service.
Backend get backend => ss.lookup(#_backend) as Backend;

/// A callback to be invoked after an upload of a new [PackageVersion].
typedef Future FinishedUploadCallback(models.PackageVersion pv);

/// Represents the backend for the pub.dartlang.org site.
class Backend {
  final DatastoreDB db;
  final GCloudPackageRepository repository;
  final UIPackageCache uiPackageCache;

  Backend(DatastoreDB db, TarballStorage storage,
      {UIPackageCache cache, FinishedUploadCallback finishCallback})
      : db = db,
        repository = new GCloudPackageRepository(db, storage,
            cache: cache, finishCallback: finishCallback),
        uiPackageCache = cache;

  /// Retrieves packages ordered by their created date.
  Future<List<models.Package>> newestPackages({int offset, int limit}) {
    final query = db.query<models.Package>()
      ..order('-created')
      ..offset(offset)
      ..limit(limit);
    return query.run().toList();
  }

  /// Retrieves packages ordered by their latest version date.
  Future<List<models.Package>> latestPackages({int offset, int limit}) {
    final query = db.query<models.Package>()
      ..order('-updated')
      ..offset(offset)
      ..limit(limit);
    return query.run().toList();
  }

  /// Retrieves the names of all packages, ordered by name.
  Stream<String> allPackageNames(
      {DateTime updatedSince, bool excludeDiscontinued = false}) {
    final query = db.query<models.Package>();

    if (updatedSince != null) {
      query.filter('updated >', updatedSince);
    }

    bool isExcluded(models.Package p) =>
        // isDiscontinued may be null
        excludeDiscontinued && p.isDiscontinued == true;

    return query.run().where((p) => !isExcluded(p)).map((p) => p.name);
  }

  /// Retrieves package versions ordered by their latest version date.
  Future<List<models.PackageVersion>> latestPackageVersions(
      {int offset, int limit, bool devVersions = false}) async {
    final packages = await latestPackages(offset: offset, limit: limit);
    return lookupLatestVersions(packages, devVersions: devVersions);
  }

  /// Looks up a package by name.
  Future<models.Package> lookupPackage(String packageName) async {
    final packageKey = db.emptyKey.append(models.Package, id: packageName);
    return (await db.lookup([packageKey])).first as models.Package;
  }

  /// Looks up a package by name.
  Future<List<models.Package>> lookupPackages(
      Iterable<String> packageNames) async {
    return (await db.lookup(packageNames
            .map((p) => db.emptyKey.append(models.Package, id: p))
            .toList()))
        .cast();
  }

  /// Looks up a specific package version.
  Future<models.PackageVersion> lookupPackageVersion(
      String package, String version) async {
    version = canonicalizeVersion(version);
    final packageVersionKey = db.emptyKey
        .append(models.Package, id: package)
        .append(models.PackageVersion, id: version);
    return (await db.lookup([packageVersionKey])).first
        as models.PackageVersion;
  }

  /// Looks up the latest versions of a list of packages.
  Future<List<models.PackageVersion>> lookupLatestVersions(
      List<models.Package> packages,
      {bool devVersions = false}) async {
    final keys = packages.map((models.Package p) {
      if (devVersions) {
        return p.latestDevVersionKey ?? p.latestVersionKey;
      }
      return p.latestVersionKey;
    }).toList();
    return (await db.lookup(keys)).cast();
  }

  /// Looks up all versions of a package.
  Future<List<models.PackageVersion>> versionsOfPackage(
      String packageName) async {
    final packageKey = db.emptyKey.append(models.Package, id: packageName);
    final query = db.query<models.PackageVersion>(ancestorKey: packageKey);
    return await query.run().toList();
  }

  /// Get a [Uri] which can be used to download a tarball of the pub package.
  Future<Uri> downloadUrl(String package, String version) async {
    version = canonicalizeVersion(version);
    assert(repository.supportsDownloadUrl);
    return repository.downloadUrl(package, version);
  }

  /// Stores a [models.PackageInvite] entry in the Datastore and returns its
  /// current status. When set, the status.urlNonce can be used in
  /// client-communication, e.g. sending via e-mail.
  Future<InviteStatus> updatePackageInvite({
    @required String packageName,
    @required String type,
    @required String recipientEmail,
    @required String fromEmail,
  }) async {
    final now = new DateTime.now().toUtc();
    final inviteId = models.PackageInvite.createId(type, recipientEmail);
    final pkgKey = db.emptyKey.append(models.Package, id: packageName);
    final inviteKey = pkgKey.append(models.PackageInvite, id: inviteId);
    return await db.withTransaction((tx) async {
      final list = await tx.lookup([inviteKey]);
      models.PackageInvite invite = list.single as models.PackageInvite;

      // Existing and active invite with throttled notification.
      if (invite != null && !invite.isExpired() && !invite.shouldNotify()) {
        await tx.rollback();
        return new InviteStatus(nextNotification: invite.nextNotification);
      }

      // Existing and active invite with notification enabled.
      if (invite != null && !invite.isExpired()) {
        invite.lastNotified = now;
        invite.notificationCount++;
        tx.queueMutations(inserts: [invite]);
        await tx.commit();
        return new InviteStatus(urlNonce: invite.urlNonce);
      }

      // Reset old or create new invite.
      invite ??= models.PackageInvite()
        ..parentKey = pkgKey
        ..id = inviteId
        ..type = type
        ..recipientEmail = recipientEmail;
      final urlNonce =
          new List.generate(25, (i) => _random.nextInt(36).toRadixString(36))
              .join();
      invite
        ..urlNonce = urlNonce
        ..fromEmail = fromEmail
        ..created = now
        ..expires = now.add(Duration(days: 1))
        ..notificationCount = 1
        ..lastNotified = now;

      final inserts = <Model>[invite];
      if (historyBackend.isEnabled) {
        final history = new History.entry(new UploaderInvited(
          packageName: packageName,
          currentUserEmail: fromEmail,
          uploaderUserEmail: recipientEmail,
        ));
        inserts.add(history);
      }

      tx.queueMutations(inserts: inserts);
      await tx.commit();
      return new InviteStatus(urlNonce: invite.urlNonce);
    }) as InviteStatus;
  }

  /// Confirm the invite and return the Datastore entry object if successful,
  /// otherwise returns null.
  Future<models.PackageInvite> confirmPackageInvite({
    @required String packageName,
    @required String type,
    @required String recipientEmail,
    @required String urlNonce,
  }) async {
    final inviteId = models.PackageInvite.createId(type, recipientEmail);
    final pkgKey = db.emptyKey.append(models.Package, id: packageName);
    final inviteKey = pkgKey.append(models.PackageInvite, id: inviteId);
    return await db.withTransaction((tx) async {
      final list = await tx.lookup<models.PackageInvite>([inviteKey]);
      final invite = list.single;

      // Invite entry does not exists.
      if (invite == null) {
        await tx.rollback();
        return null;
      }

      // Consistency check
      if (invite.recipientEmail != recipientEmail) {
        await tx.rollback();
        return null;
      }

      // Invite entry has expired.
      if (invite.isExpired()) {
        tx.queueMutations(deletes: [inviteKey]);
        await tx.commit();
        return null;
      }

      // urlNonce check: whether the invite has been updated.
      if (invite.urlNonce != urlNonce) {
        await tx.rollback();
        return null;
      }

      // Invite already confirmed.
      if (invite.confirmed != null) {
        await tx.rollback();
        return invite;
      }

      // Confirming invite.
      invite.confirmed = new DateTime.now().toUtc();
      tx.queueMutations(inserts: [invite]);
      await tx.commit();
      return invite;
    }) as models.PackageInvite;
  }

  /// Removes obsolete (== expired more than a day ago) invites from Datastore.
  Future deleteObsoleteInvites() async {
    final query = db.query<models.PackageInvite>()
      ..filter('expires <', DateTime.now().subtract(Duration(days: 1)));
    await for (var invite in query.run()) {
      db.commit(deletes: [invite.key]);
    }
  }
}

/// The status of an invite after being created or updated.
class InviteStatus {
  final String urlNonce;
  final DateTime nextNotification;

  InviteStatus({this.urlNonce, this.nextNotification});

  bool get isActive => urlNonce != null;

  bool get isDelayed => nextNotification != null;
}

/// A read-only implementation of [PackageRepository] using the Cloud Datastore
/// for metadata and Cloud Storage for tarball storage.
class GCloudPackageRepository extends PackageRepository {
  final Uuid uuid = new Uuid();
  final DatastoreDB db;
  final TarballStorage storage;
  final UIPackageCache cache;
  final FinishedUploadCallback finishCallback;

  GCloudPackageRepository(this.db, this.storage,
      {this.cache, this.finishCallback});

  // Metadata support.

  @override
  Stream<PackageVersion> versions(String package) {
    StreamController<PackageVersion> controller;
    StreamSubscription subscription;

    controller = new StreamController<PackageVersion>(
        onListen: () {
          final packageKey = db.emptyKey.append(models.Package, id: package);
          final query =
              db.query<models.PackageVersion>(ancestorKey: packageKey);
          subscription = query.run().listen((model) {
            final packageVersion = new PackageVersion(
                package, model.version, model.pubspec.jsonString);
            controller.add(packageVersion);
          }, onError: controller.addError, onDone: controller.close);
        },
        onPause: () => subscription.pause(),
        onResume: () => subscription.resume(),
        onCancel: () => subscription.cancel());
    return controller.stream;
  }

  @override
  Future<PackageVersion> lookupVersion(String package, String version) async {
    version = canonicalizeVersion(version);

    final packageVersionKey = db.emptyKey
        .append(models.Package, id: package)
        .append(models.PackageVersion, id: version);

    final pv =
        (await db.lookup([packageVersionKey])).first as models.PackageVersion;
    if (pv == null) return null;
    return new PackageVersion(package, version, pv.pubspec.jsonString);
  }

  // Download support.

  @override
  Future<Stream<List<int>>> download(String package, String version) async {
    // TODO: Should we first test for existence?
    // Maybe with a cache?
    version = canonicalizeVersion(version);
    return storage.download(package, version);
  }

  @override
  bool get supportsDownloadUrl => true;

  @override
  Future<Uri> downloadUrl(String package, String version) async {
    version = canonicalizeVersion(version);
    return storage.downloadUrl(package, version);
  }

  // Upload support.

  @override
  bool get supportsUpload => true;

  @override
  Future<PackageVersion> upload(Stream<List<int>> data) {
    _logger.info('Starting upload.');
    return _withAuthenticatedUser((String userEmail) {
      _logger.info('User: $userEmail.');

      return withTempDirectory((Directory dir) async {
        final filename = '${dir.absolute.path}/tarball.tar.gz';
        await _saveTarballToFS(data, filename);
        return _performTarballUpload(userEmail, filename, (package, version) {
          return storage.upload(
              package, version, new File(filename).openRead());
        });
      });
    });
  }

  @override
  bool get supportsAsyncUpload => true;

  @override
  Future<AsyncUploadInfo> startAsyncUpload(Uri redirectUrl) async {
    _logger.info('Starting async upload.');
    // NOTE: We use a authenticated user scope here to ensure the uploading
    // user is authenticated. But we're not validating anything at this point
    // because we don't even know which package or version is going to be
    // uploaded.
    return _withAuthenticatedUser((String userEmail) {
      _logger.info('User: $userEmail.');

      final guid = uuid.v4().toString();
      final String object = storage.tempObjectName(guid);
      final String bucket = storage.bucket.bucketName;
      final Duration lifetime = const Duration(minutes: 10);

      final url = redirectUrl.resolve('?upload_id=$guid');

      _logger
          .info('Redirecting pub client to google cloud storage (uuid: $guid)');
      return uploadSigner.buildUpload(bucket, object, lifetime, '$url');
    });
  }

  /// Finishes the upload of a package.
  @override
  Future<PackageVersion> finishAsyncUpload(Uri uri) {
    return _withAuthenticatedUser((String userEmail) async {
      final guid = uri.queryParameters['upload_id'];
      _logger.info('Finishing async upload (uuid: $guid)');
      _logger.info('Reading tarball from cloud storage.');

      return withTempDirectory((Directory dir) async {
        final filename = '${dir.absolute.path}/tarball.tar.gz';
        // TODO: check why this is flaky https://github.com/dart-lang/pub-dartlang-dart/issues/1680
        await retryAsync(
            () => _saveTarballToFS(storage.readTempObject(guid), filename));
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
      String userEmail,
      String filename,
      Future tarballUpload(String name, String version)) async {
    _logger.info('Examining tarball content.');

    // Parse metadata from the tarball.
    final models.PackageVersion newVersion =
        await _parseAndValidateUpload(db, filename, userEmail);

    models.Package package;

    // Add the new package to the repository by storing the tarball and
    // inserting metadata to datastore (which happens atomically).
    final pv = await db.withTransaction((Transaction T) async {
      _logger.info('Starting datastore transaction.') as PackageVersion;

      final tuple = (await T.lookup([newVersion.key, newVersion.packageKey]));
      final version = tuple[0] as models.PackageVersion;
      package = tuple[1] as models.Package;

      // If the version already exists, we fail.
      if (version != null) {
        await T.rollback();
        _logger.info('Version ${version.version} of package '
            '${version.package} already exists, rolling transaction back.');
        throw new GenericProcessingException(
            'Version ${version.version} of package '
            '${version.package} already exists.');
      }

      // reserved package names for the Dart team
      if (package == null &&
          matchesReservedPackageName(newVersion.package) &&
          !newVersion.uploaderEmail.endsWith('@google.com')) {
        await T.rollback();
        throw new GenericProcessingException(
            'Package name ${newVersion.package} is reserved.');
      }

      // If the package does not exist, then we create a new package.
      if (package == null) package = _newPackageFromVersion(db, newVersion);

      // Check if the uploader of the new version is allowed to upload to
      // the package.
      if (!package.hasUploader(newVersion.uploaderEmail)) {
        _logger.info('User ${newVersion.uploaderEmail} is not an uploader '
            'for package ${package.name}, rolling transaction back.');
        await T.rollback();
        throw new UnauthorizedAccessException(
            'Unauthorized user: ${newVersion.uploaderEmail} is not allowed to '
            'upload versions to package ${package.name}.');
      }

      // Update the date when the package was last updated.
      package.updated = newVersion.created;

      // Keep the latest version in the package object up-to-date.
      package.updateVersion(newVersion);

      try {
        _logger.info('Trying to upload tarball to cloud storage.');
        // Apply update: Push to cloud storage
        await tarballUpload(package.name, newVersion.version);

        final inserts = <Model>[package, newVersion];
        if (historyBackend.isEnabled) {
          final history = new History.entry(new PackageUploaded(
            packageName: newVersion.package,
            packageVersion: newVersion.version,
            uploaderEmail: newVersion.uploaderEmail,
            timestamp: newVersion.created,
          ));
          inserts.add(history);
        }

        // Apply update: Update datastore.
        _logger.info('Trying to commit datastore changes.');
        T.queueMutations(inserts: inserts);
        await T.commit();

        _logger.info('Upload successful.');

        // Try to load all package versions, sort them by `sort_order` and
        // store them again.
        await _updatePackageSortIndex(package.key);

        return new PackageVersion(newVersion.package, newVersion.version,
            newVersion.pubspec.jsonString);
      } catch (error, stack) {
        _logger.warning('Error while committing: $error, $stack');

        // This call might fail if the transaction has already been
        // committed/rolled back or the transaction failed.
        //
        // In which case we simply ignore the rollback error and rethrow the
        // original error.
        try {
          await T.rollback();
        } catch (_) {}
        rethrow;
      }
    });

    // Notify uploaders via e-mail that a new version has been published.
    await emailSender.sendMessage(
      createPackageUploadedEmail(
        packageName: newVersion.package,
        packageVersion: newVersion.version,
        uploaderEmail: newVersion.uploaderEmail,
        authorizedUploaders: package.uploaderEmails
            .map((email) => new EmailAddress(null, email))
            .toList(),
      ),
    );

    if (finishCallback != null) {
      await finishCallback(newVersion);
    }
    return pv as PackageVersion;
  }

  Future _updatePackageSortIndex(Key packageKey) async {
    try {
      _logger.info('Trying to update the `sort_order` field.');
      await db.withTransaction((Transaction T) async {
        final versions =
            await T.query<models.PackageVersion>(packageKey).run().toList();
        versions.sort((versionA, versionB) {
          return versionA.semanticVersion.compareTo(versionB.semanticVersion);
        });

        final List<models.PackageVersion> modifiedVersions = [];

        for (int i = 0; i < versions.length; i++) {
          final version = versions[i];
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
          error,
          stack);
    }
  }

  // Uploaders support.

  @override
  bool get supportsUploaders => true;

  @override
  Future addUploader(String packageName, String uploaderEmail) async {
    await _withAuthenticatedUser((String userEmail) async {
      final packageKey = db.emptyKey.append(models.Package, id: packageName);
      final package = (await db.lookup([packageKey])).first as models.Package;

      _validateActiveUser(userEmail, package);

      if (!isValidEmail(uploaderEmail)) {
        throw new GenericProcessingException(
            'Not a valid e-mail: `$uploaderEmail`.');
      }

      if (package.hasUploader(uploaderEmail)) {
        // The requested uploaderEmail is already part of the uploaders.
        return;
      }

      final status = await backend.updatePackageInvite(
        packageName: packageName,
        type: models.PackageInviteType.newUploader,
        recipientEmail: uploaderEmail,
        fromEmail: userEmail,
      );

      if (status.isDelayed) {
        throw new GenericProcessingException(
            'Previous invite is still active, next notification can be sent '
            'on ${status.nextNotification.toIso8601String()}.');
      }

      final confirmationUrl = urls.pkgInviteUrl(
        type: models.PackageInviteType.newUploader,
        package: packageName,
        email: uploaderEmail,
        urlNonce: status.urlNonce,
      );
      final message = createUploaderConfirmationEmail(
        packageName: packageName,
        activeAccountEmail: userEmail,
        addedUploaderEmail: uploaderEmail,
        confirmationUrl: confirmationUrl,
      );
      await emailSender.sendMessage(message);

      throw new GenericProcessingException(
          'We have sent an invitation to $uploaderEmail, '
          'they will be added as uploader after they confirm it.');
    });
  }

  Future confirmUploader(
      String userEmail, String packageName, String uploaderEmail) async {
    return db.withTransaction((Transaction tx) async {
      final packageKey = db.emptyKey.append(models.Package, id: packageName);
      final package = (await tx.lookup([packageKey])).first as models.Package;

      try {
        _validateActiveUser(userEmail, package);
      } catch (_) {
        await tx.rollback();
        rethrow;
      }

      if (package.hasUploader(uploaderEmail)) {
        // The requested uploaderEmail is already part of the uploaders.
        await tx.rollback();
        return;
      }

      // Add [uploaderEmail] to uploaders and commit.
      package.uploaderEmails.add(uploaderEmail);

      final inserts = <Model>[package];
      if (historyBackend.isEnabled) {
        final history = new History.entry(new UploaderChanged(
          packageName: packageName,
          currentUserEmail: userEmail,
          addedUploaderEmails: [uploaderEmail],
        ));
        inserts.add(history);
      }

      tx.queueMutations(inserts: inserts);
      await tx.commit();
      if (cache != null) {
        await cache.invalidateUIPackagePage(package.name);
      }
    });
  }

  void _validateActiveUser(String userEmail, models.Package package) {
    // Fail if package doesn't exist.
    if (package == null) {
      throw new GenericProcessingException('Package "$package" does not exist');
    }

    // Fail if calling user doesn't have permission to change uploaders.
    if (!package.hasUploader(userEmail)) {
      throw new UnauthorizedAccessException(
          'Calling user does not have permission to change uploaders.');
    }
  }

  @override
  Future removeUploader(String packageName, String uploaderEmail) async {
    return _withAuthenticatedUser((String userEmail) {
      return db.withTransaction((Transaction T) async {
        final packageKey = db.emptyKey.append(models.Package, id: packageName);
        final package = (await T.lookup([packageKey])).first as models.Package;

        // Fail if package doesn't exist.
        if (package == null) {
          await T.rollback();
          throw new GenericProcessingException(
              'Package "$package" does not exist');
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
          throw new GenericProcessingException(
              'The uploader to remove does not exist.');
        }

        // Remove the uploader from the list.
        package.removeUploader(uploaderEmail);

        // We cannot have 0 uploaders, if we would remove the last one, we
        // fail with an error.
        if (package.uploaderEmails.isEmpty) {
          await T.rollback();
          throw new LastUploaderRemoveException();
        }

        // At the moment we don't validate whether the other e-mail addresses
        // are able to authenticate. To prevent accidentally losing the control
        // of a package, we don't allow self-removal.
        if (userEmail == uploaderEmail) {
          await T.rollback();
          throw new GenericProcessingException('Self-removal is not allowed. '
              'Use another account to remove this e-mail address.');
        }

        final inserts = <Model>[package];
        if (historyBackend.isEnabled) {
          final history = new History.entry(new UploaderChanged(
            packageName: packageName,
            currentUserEmail: userEmail,
            removedUploaderEmails: [uploaderEmail],
          ));
          inserts.add(history);
        }

        T.queueMutations(inserts: inserts);
        await T.commit();
        if (cache != null) {
          await cache.invalidateUIPackagePage(package.name);
        }
      });
    });
  }
}

/// Calls [func] with the currently logged in user as an argument.
///
/// If no user is currently logged in, this will throw an `UnauthorizedAccess`
/// exception.
Future<T> _withAuthenticatedUser<T>(FutureOr<T> func(String user)) async {
  if (_loggedInUser == null) {
    throw new UnauthorizedAccessException('No active user.');
  }
  return await func(_loggedInUser);
}

/// Reads a tarball from a byte stream.
///
/// Compeltes with an error if the incoming stream has an error or if the size
/// exceeds `GcloudPackageRepo.MAX_TARBALL_SIZE`.
Future _saveTarballToFS(Stream<List<int>> data, String filename) async {
  final Completer completer = new Completer();

  StreamSink<List<int>> sink;
  StreamSubscription dataSubscription;
  StreamController<List<int>> intermediary;
  Future addStreamFuture;

  void abort(Object error, StackTrace stack) {
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

  void finish() {
    _logger.info('Finished streaming tarball to FS.');
    completer.complete();
  }

  void startReading() {
    int receivedBytes = 0;

    dataSubscription = data.listen(
        (List<int> chunk) {
          receivedBytes += chunk.length;
          if (receivedBytes <= UploadSignerService.maxUploadSize) {
            intermediary.add(chunk);
          } else {
            final error = 'Invalid upload: Exceeded '
                '${UploadSignerService.maxUploadSize} upload size.';
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
          }).catchError((Object error, StackTrace stack) {
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
models.Package _newPackageFromVersion(
    DatastoreDB db, models.PackageVersion version) {
  final now = new DateTime.now().toUtc();
  return new models.Package()
    ..parentKey = db.emptyKey
    ..id = version.pubspec.name
    ..name = version.pubspec.name
    ..created = now
    ..updated = now
    ..downloads = 0
    ..latestVersionKey = version.key
    ..latestDevVersionKey = version.key
    ..uploaderEmails = [_loggedInUser];
}

/// Parses metadata from a tarball and & validates it.
///
/// This function ensures that `tarball`
///   * is a valid `tar.gz` file
///   * contains a valid `pubspec.yaml` file
///   * reads readme, changelog and pubspec files
///   * creates a [models.PackageVersion] and populates it with all metadata
Future<models.PackageVersion> _parseAndValidateUpload(
    DatastoreDB db, String filename, String user) async {
  assert(user != null);

  final files = await listTarball(filename);

  // Searches in [files] for a file name [name] and compare in a
  // case-insensitive manner.
  //
  // Returns `null` if not found otherwise the correct filename.
  String searchForFile(String name) {
    final String nameLowercase = name.toLowerCase();
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

  final libraries = files
      .where((file) => file.startsWith('lib/'))
      .where((file) => !file.startsWith('lib/src'))
      .where((file) => file.endsWith('.dart'))
      .map((file) => file.substring('lib/'.length))
      .toList();

  if (!files.contains('pubspec.yaml')) {
    throw new GenericProcessingException(
        'Invalid upload: no pubspec.yaml file');
  }

  final pubspecContent = await readTarballFile(filename, 'pubspec.yaml');

  final pubspec = new Pubspec.fromYaml(pubspecContent);
  if (pubspec.name == null ||
      pubspec.version == null ||
      pubspec.name.trim().isEmpty ||
      pubspec.version.trim().isEmpty) {
    throw new GenericProcessingException('Invalid `pubspec.yaml` file');
  }

  validatePackageName(pubspec.name);
  if (!nameTracker.accept(pubspec.name)) {
    throw new GenericProcessingException(
        'Package name is too similar to another package.');
  }
  urls.syntaxCheckHomepageUrl(pubspec.homepage);

  if (pubspec.hasBothAuthorAndAuthors) {
    throw new GenericProcessingException(
        'Do not specify both `author` and `authors` in `pubspec.yaml`.');
  }

  String exampleFilename;
  for (String candidate in exampleFileCandidates(pubspec.name)) {
    exampleFilename = searchForFile(candidate);
    if (exampleFilename != null) break;
  }

  final readmeContent = readmeFilename != null
      ? await readTarballFile(filename, readmeFilename)
      : null;
  final changelogContent = changelogFilename != null
      ? await readTarballFile(filename, changelogFilename)
      : null;
  String exampleContent = exampleFilename != null
      ? await readTarballFile(filename, exampleFilename)
      : null;

  if (exampleContent != null && exampleContent.trim().isEmpty) {
    exampleFilename = null;
    exampleContent = null;
  }

  final packageKey = db.emptyKey.append(models.Package, id: pubspec.name);

  final versionString = canonicalizeVersion(pubspec.version);

  final version = new models.PackageVersion()
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
    ..exampleFilename = exampleFilename
    ..exampleContent = exampleContent
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

  TarballStorage(this.storage, Bucket bucket, String namespace)
      : bucket = bucket,
        namer = new TarballStorageNamer(bucket.bucketName, namespace);

  /// Generates a path to a temporary object on cloud storage.
  String tempObjectName(String guid) => namer.tmpObjectName(guid);

  /// Reads the temporary object identified by [guid]
  Stream<List<int>> readTempObject(String guid) =>
      bucket.read(namer.tmpObjectName(guid));

  /// Makes a temporary object a new tarball.
  Future uploadViaTempObject(
      String guid, String package, String version) async {
    final object = namer.tarballObjectName(package, version);

    // Copy the temporary object to it's destination place.
    await storage.copyObject(
        bucket.absoluteObjectName(namer.tmpObjectName(guid)),
        bucket.absoluteObjectName(object));

    // Change the ACL to include a `public-read` entry.
    final ObjectInfo info = await bucket.info(object);
    final publicRead = new AclEntry(new AllUsersScope(), AclPermission.READ);
    final acl =
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
    final object = namer.tarballObjectName(package, version);
    return bucket.read(object);
  }

  /// Deletes the tarball of a [package] in the given [version] permanently.
  Future remove(String package, String version) {
    final object = namer.tarballObjectName(package, version);
    return bucket.delete(object);
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
    final object = namer.tarballObjectName(package, version);
    return tarball
        .pipe(bucket.write(object, predefinedAcl: PredefinedAcl.publicRead));
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

  TarballStorageNamer(this.bucket, String namespace)
      : namespace = namespace == null ? '' : namespace,
        prefix =
            (namespace == null || namespace.isEmpty) ? '' : 'ns/$namespace/';

  /// The GCS object name of a tarball object - excluding leading '/'.
  String tarballObjectName(String package, String version)
      // TODO: Do we need some kind of escaping here?
      =>
      '${prefix}packages/$package-$version.tar.gz';

  /// The GCS object name of an temporary object [guid] - excluding leading '/'.
  String tmpObjectName(String guid) => 'tmp/$guid';

  /// The http URL of a publicly accessable GCS object.
  String tarballObjectUrl(String package, String version) {
    final object = tarballObjectName(package, version);
    return 'https://storage.googleapis.com/$bucket/$object';
  }
}
