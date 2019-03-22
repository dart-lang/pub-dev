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

import '../account/backend.dart';
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
// The maximum stored length of `README.md` and other user-provided file content
// that is stored separately in the database.
final _maxStoredLength = 128 * 1024;

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
    @required String fromUserId,
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
        ..fromUserId = fromUserId
        ..fromEmail = fromEmail
        ..created = now
        ..expires = now.add(Duration(days: 1))
        ..notificationCount = 1
        ..lastNotified = now;

      final inserts = <Model>[invite];
      if (historyBackend.isEnabled) {
        final history = new History.entry(new UploaderInvited(
          packageName: packageName,
          currentUserId: fromUserId,
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

  /// Get the invite or return null if it does not exist or is not valid anymore.
  Future<models.PackageInvite> getPackageInvite({
    @required String packageName,
    @required String type,
    @required String recipientEmail,
    @required String urlNonce,
  }) async {
    final inviteId = models.PackageInvite.createId(type, recipientEmail);
    final pkgKey = db.emptyKey.append(models.Package, id: packageName);
    final inviteKey = pkgKey.append(models.PackageInvite, id: inviteId);
    final invite = (await db.lookup<models.PackageInvite>([inviteKey])).single;

    if (invite == null) {
      return null;
    }

    if (invite.isValid(recipientEmail: recipientEmail, urlNonce: urlNonce)) {
      return invite;
    }
    return null;
  }

  /// Delete the invite and clear package cache.
  Future confirmPackageInvite(models.PackageInvite invite) async {
    await db.commit(deletes: [invite.key]);
    await uiPackageCache.invalidateUIPackagePage(invite.packageName);
  }

  /// Removes obsolete/expired invites from Datastore.
  Future deleteObsoleteInvites() async {
    final query = db.query<models.PackageInvite>()
      ..filter('expires <', DateTime.now().toUtc());
    await for (var invite in query.run()) {
      try {
        await db.commit(deletes: [invite.key]);
      } catch (e) {
        _logger.info(
            'PackageInvite delete failed: '
            '${invite.packageName} ${invite.type} ${invite.recipientEmail}',
            e);
      }
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
    final packageKey = db.emptyKey.append(models.Package, id: package);
    final query = db.query<models.PackageVersion>(ancestorKey: packageKey);
    return query.run().map((model) =>
        PackageVersion(package, model.version, model.pubspec.jsonString));
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
    return withAuthenticatedUser((AuthenticatedUser user) {
      _logger.info('User: ${user.userId} / ${user.email}.');

      return withTempDirectory((Directory dir) async {
        final filename = '${dir.absolute.path}/tarball.tar.gz';
        await _saveTarballToFS(data, filename);
        return _performTarballUpload(user, filename, (package, version) {
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
    return withAuthenticatedUser((AuthenticatedUser user) {
      _logger.info('User: ${user.email}.');

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
    return withAuthenticatedUser((AuthenticatedUser user) async {
      final guid = uri.queryParameters['upload_id'];
      _logger.info('Finishing async upload (uuid: $guid)');
      _logger.info('Reading tarball from cloud storage.');

      return withTempDirectory((Directory dir) async {
        final filename = '${dir.absolute.path}/tarball.tar.gz';
        // TODO: check why this is flaky https://github.com/dart-lang/pub-dartlang-dart/issues/1680
        await retryAsync(
            () => _saveTarballToFS(storage.readTempObject(guid), filename));
        return _performTarballUpload(user, filename, (package, version) {
          return storage.uploadViaTempObject(guid, package, version);
        }).whenComplete(() async {
          _logger.info('Removing temporary object $guid.');
          await storage.removeTempObject(guid);
        });
      });
    });
  }

  Future<PackageVersion> _performTarballUpload(
      AuthenticatedUser user,
      String filename,
      Future tarballUpload(String name, String version)) async {
    _logger.info('Examining tarball content.');

    // Parse metadata from the tarball.
    final validatedUpload = await _parseAndValidateUpload(db, filename, user);
    final newVersion = validatedUpload.packageVersion;

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
          !user.email.endsWith('@google.com')) {
        await T.rollback();
        throw new GenericProcessingException(
            'Package name ${newVersion.package} is reserved.');
      }

      // If the package does not exist, then we create a new package.
      if (package == null) package = _newPackageFromVersion(db, newVersion);

      // Check if the uploader of the new version is allowed to upload to
      // the package.
      if (!package.hasUploader(user.userId)) {
        _logger.info('User ${user.userId} (${user.email}) is not an uploader '
            'for package ${package.name}, rolling transaction back.');
        await T.rollback();
        throw new UnauthorizedAccessException(
            'Unauthorized user: ${user.email} is not allowed to '
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

        final inserts = <Model>[
          package,
          newVersion,
          validatedUpload.packageVersionPubspec,
          validatedUpload.packageVersionInfo,
        ];
        if (historyBackend.isEnabled) {
          final history = new History.entry(new PackageUploaded(
            packageName: newVersion.package,
            packageVersion: newVersion.version,
            uploaderId: user.userId,
            uploaderEmail: user.email,
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

    final uploaderEmails =
        await accountBackend.getEmailsOfUserIds(package.uploaders);

    // Notify uploaders via e-mail that a new version has been published.
    await emailSender.sendMessage(
      createPackageUploadedEmail(
        packageName: newVersion.package,
        packageVersion: newVersion.version,
        uploaderEmail: user.email,
        authorizedUploaders: uploaderEmails
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
    uploaderEmail = uploaderEmail.toLowerCase();
    await withAuthenticatedUser((AuthenticatedUser user) async {
      final packageKey = db.emptyKey.append(models.Package, id: packageName);
      final package = (await db.lookup([packageKey])).first as models.Package;

      _validatePackageUploader(package, user.userId, user.email);

      if (!isValidEmail(uploaderEmail)) {
        throw new GenericProcessingException(
            'Not a valid e-mail: `$uploaderEmail`.');
      }

      // TODO: do not create a new User for unverified uploader email
      final uploader =
          await accountBackend.lookupOrCreateUserByEmail(uploaderEmail);
      if (package.hasUploader(uploader.userId)) {
        // The requested uploaderEmail is already part of the uploaders.
        return;
      }

      final status = await backend.updatePackageInvite(
        packageName: packageName,
        type: models.PackageInviteType.newUploader,
        recipientEmail: uploaderEmail,
        fromUserId: user.userId,
        fromEmail: user.email,
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
        activeAccountEmail: user.email,
        addedUploaderEmail: uploaderEmail,
        confirmationUrl: confirmationUrl,
      );
      await emailSender.sendMessage(message);

      throw new GenericProcessingException(
          'We have sent an invitation to $uploaderEmail, '
          'they will be added as uploader after they confirm it.');
    });
  }

  Future confirmUploader(String fromUserId, String fromUserEmail,
      String packageName, AuthenticatedUser uploader) async {
    if (fromUserId == null) {
      final user =
          await accountBackend.lookupOrCreateUserByEmail(fromUserEmail);
      fromUserId = user.userId;
    }
    assert(fromUserId != null);
    return db.withTransaction((Transaction tx) async {
      final packageKey = db.emptyKey.append(models.Package, id: packageName);
      final package = (await tx.lookup([packageKey])).first as models.Package;

      try {
        _validatePackageUploader(package, fromUserId, fromUserEmail);
      } catch (_) {
        await tx.rollback();
        rethrow;
      }

      if (package.hasUploader(uploader.userId)) {
        // The requested uploaderEmail is already part of the uploaders.
        await tx.rollback();
        return;
      }

      // Add [uploaderEmail] to uploaders and commit.
      package.addUploader(uploader.userId, uploader.email);

      final inserts = <Model>[package];
      if (historyBackend.isEnabled) {
        final history = new History.entry(new UploaderChanged(
          packageName: packageName,
          currentUserId: fromUserId,
          currentUserEmail: fromUserEmail,
          addedUploaderIds: [uploader.userId],
          addedUploaderEmails: [uploader.email],
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

  void _validatePackageUploader(
      models.Package package, String userId, String userEmail) {
    // Fail if package doesn't exist.
    if (package == null) {
      throw new GenericProcessingException('Package "$package" does not exist');
    }

    // Fail if calling user doesn't have permission to change uploaders.
    if (!package.hasUploader(userId)) {
      throw new UnauthorizedAccessException(
          'Calling user does not have permission to change uploaders.');
    }
  }

  @override
  Future removeUploader(String packageName, String uploaderEmail) async {
    uploaderEmail = uploaderEmail.toLowerCase();
    return withAuthenticatedUser((AuthenticatedUser user) {
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
        if (!package.hasUploader(user.userId)) {
          await T.rollback();
          throw new UnauthorizedAccessException(
              'Calling user does not have permission to change uploaders.');
        }

        final uploader =
            await accountBackend.lookupOrCreateUserByEmail(uploaderEmail);
        // Fail if the uploader we want to remove does not exist.
        if (!package.hasUploader(uploader.userId)) {
          await T.rollback();
          throw new GenericProcessingException(
              'The uploader to remove does not exist.');
        }

        // We cannot have 0 uploaders, if we would remove the last one, we
        // fail with an error.
        if (package.uploaderCount <= 1) {
          await T.rollback();
          throw new LastUploaderRemoveException();
        }

        // At the moment we don't validate whether the other e-mail addresses
        // are able to authenticate. To prevent accidentally losing the control
        // of a package, we don't allow self-removal.
        if (user.email == uploader.email || user.userId == uploader.userId) {
          await T.rollback();
          throw new GenericProcessingException('Self-removal is not allowed. '
              'Use another account to remove this e-mail address.');
        }

        // Remove the uploader from the list.
        package.removeUploader(uploader.userId, uploader.email);

        final inserts = <Model>[package];
        if (historyBackend.isEnabled) {
          final history = new History.entry(new UploaderChanged(
            packageName: packageName,
            currentUserId: user.userId,
            currentUserEmail: user.email,
            removedUploaderIds: [uploader.userId],
            removedUploaderEmails: [uploader.email],
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

/// Reads a tarball from a byte stream.
///
/// Completes with an error if the incoming stream has an error or if the size
/// exceeds [UploadSignerService.maxUploadSize].
Future _saveTarballToFS(Stream<List<int>> data, String filename) async {
  try {
    int receivedBytes = 0;
    final stream = data.transform<List<int>>(
      StreamTransformer<List<int>, List<int>>.fromHandlers(
        handleData: (chunk, sink) {
          receivedBytes += chunk.length;
          if (receivedBytes <= UploadSignerService.maxUploadSize) {
            sink.add(chunk);
          } else {
            final error = 'Invalid upload: Exceeded '
                '${UploadSignerService.maxUploadSize} upload size.';
            sink.addError(error);
          }
        },
      ),
    );
    await stream.pipe(File(filename).openWrite());
  } catch (e, st) {
    _logger.warning('An error occured while streaming tarball to FS.', e, st);
    rethrow;
  }
  _logger.info('Finished streaming tarball to FS.');
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
    ..uploaders = [authenticatedUser.userId]
    ..uploaderEmails = [authenticatedUser.email];
}

class _ValidatedUpload {
  final models.PackageVersion packageVersion;
  final models.PackageVersionPubspec packageVersionPubspec;
  final models.PackageVersionInfo packageVersionInfo;

  _ValidatedUpload(
    this.packageVersion,
    this.packageVersionPubspec,
    this.packageVersionInfo,
  );
}

/// Parses metadata from a tarball and & validates it.
///
/// This function ensures that `tarball`
///   * is a valid `tar.gz` file
///   * contains a valid `pubspec.yaml` file
///   * reads readme, changelog and pubspec files
///   * creates a [models.PackageVersion] and populates it with all metadata
Future<_ValidatedUpload> _parseAndValidateUpload(
    DatastoreDB db, String filename, AuthenticatedUser user) async {
  assert(user != null);

  final files = await listTarball(filename);

  // Check whether the files can be extracted on case-preserving file systems
  // (e.g. on Windows). We can't allow two files with the same case-insensitive
  // name.
  final lowerCaseFiles = <String>{};
  for (String file in files) {
    final lower = file.toLowerCase();
    if (lowerCaseFiles.contains(lower)) {
      throw GenericProcessingException(
          'Filename collision on case-preserving file systems: $file.');
    }
    lowerCaseFiles.add(lower);
  }

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
  // Large pubspec content should be rejected, as either a storage limit will be
  // limiting it, or it will slow down queries and processing for very little
  // reason.
  if (pubspecContent.length > 128 * 1024) {
    throw GenericProcessingException('pubspec.yaml is too large.');
  }

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
      ? await readTarballFile(filename, readmeFilename,
          maxLength: _maxStoredLength)
      : null;
  final changelogContent = changelogFilename != null
      ? await readTarballFile(filename, changelogFilename,
          maxLength: _maxStoredLength)
      : null;
  String exampleContent = exampleFilename != null
      ? await readTarballFile(filename, exampleFilename,
          maxLength: _maxStoredLength)
      : null;

  if (exampleContent != null && exampleContent.trim().isEmpty) {
    exampleFilename = null;
    exampleContent = null;
  }

  final packageKey = db.emptyKey.append(models.Package, id: pubspec.name);

  final versionString = canonicalizeVersion(pubspec.version);

  final key = models.QualifiedVersionKey(
      namespace: null, package: pubspec.name, version: versionString);

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
    ..uploader = user.userId
    ..uploaderEmail = user.email;

  final versionPubspec = models.PackageVersionPubspec()
    ..initFromKey(key)
    ..updated = version.created
    ..pubspec = pubspec;

  final versionInfo = models.PackageVersionInfo()
    ..initFromKey(key)
    ..updated = version.created
    ..readmeFilename = readmeFilename
    ..readmeContent = readmeContent
    ..changelogFilename = changelogFilename
    ..changelogContent = changelogContent
    ..exampleFilename = exampleFilename
    ..exampleContent = exampleContent
    ..libraries = libraries
    ..libraryCount = libraries.length;

  return _ValidatedUpload(version, versionPubspec, versionInfo);
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
