// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.backend;

import 'dart:async';
import 'dart:io';

import 'package:client_data/account_api.dart';
import 'package:client_data/package_api.dart' as api;
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pana/pana.dart' show runProc;
import 'package:path/path.dart' as p;
import 'package:pub_dev/service/secret/backend.dart';
import 'package:pub_package_reader/pub_package_reader.dart';

import '../account/backend.dart';
import '../account/consent_backend.dart';
import '../account/models.dart' show User;
import '../analyzer/analyzer_client.dart';
import '../dartdoc/dartdoc_client.dart';
import '../frontend/email_sender.dart';
import '../history/backend.dart';
import '../history/models.dart';
import '../publisher/backend.dart';
import '../publisher/models.dart';
import '../service/spam/backend.dart';
import '../shared/configuration.dart';
import '../shared/datastore_helper.dart';
import '../shared/email.dart';
import '../shared/exceptions.dart';
import '../shared/redis_cache.dart' show cache;
import '../shared/storage.dart';
import '../shared/urls.dart' as urls;
import '../shared/utils.dart';
import 'model_properties.dart';
import 'models.dart';
import 'name_tracker.dart';
import 'upload_signer_service.dart';

final Logger _logger = Logger('pub.cloud_repository');

/// Sets the active tarball storage
void registerTarballStorage(TarballStorage ts) =>
    ss.register(#_tarball_storage, ts);

/// The active tarball storage.
TarballStorage get tarballStorage =>
    ss.lookup(#_tarball_storage) as TarballStorage;

/// Sets the package backend service.
void registerPackageBackend(PackageBackend backend) =>
    ss.register(#_packageBackend, backend);

/// The active package backend service.
PackageBackend get packageBackend =>
    ss.lookup(#_packageBackend) as PackageBackend;

/// Represents the backend for the pub site.
class PackageBackend {
  final DatastoreDB db;
  final TarballStorage _storage;

  PackageBackend(DatastoreDB db, TarballStorage storage)
      : db = db,
        _storage = storage;

  /// Whether the package exists and is not withheld or deleted.
  Future<bool> isPackageVisible(String package) {
    return cache.packageVisible(package).get(() async {
      final p = await db.lookupValue<Package>(
          db.emptyKey.append(Package, id: package),
          orElse: () => null);
      return p != null && p.isVisible;
    });
  }

  /// Retrieves packages ordered by their created date.
  Future<List<Package>> newestPackages({int offset, int limit}) {
    final query = db.query<Package>()
      ..order('-created')
      ..offset(offset)
      ..limit(limit);
    return query.run().where((p) => p.isVisible).toList();
  }

  /// Retrieves packages ordered by their latest version date.
  Future<List<Package>> latestPackages({int offset, int limit}) {
    final query = db.query<Package>()
      ..order('-updated')
      ..offset(offset)
      ..limit(limit);
    return query.run().where((p) => p.isVisible).toList();
  }

  /// Retrieves the names of all packages, ordered by name.
  Stream<String> allPackageNames(
      {DateTime updatedSince, bool excludeDiscontinued = false}) {
    final query = db.query<Package>();

    if (updatedSince != null) {
      query.filter('updated >', updatedSince);
    }

    bool isExcluded(Package p) =>
        // isDiscontinued may be null
        excludeDiscontinued && p.isDiscontinued;

    return query
        .run()
        .where((p) => p.isVisible)
        .where((p) => !isExcluded(p))
        .map((p) => p.name);
  }

  /// Retrieves package versions ordered by their latest version date.
  Future<List<PackageVersion>> latestPackageVersions(
      {int offset, int limit}) async {
    final packages = await latestPackages(offset: offset, limit: limit);
    return lookupLatestVersions(packages);
  }

  /// Returns the latest stable version of a package.
  Future<String> getLatestVersion(String package) async {
    return cache.packageLatestVersion(package).get(() async {
      final p = await db.lookupValue<Package>(
        db.emptyKey.append(Package, id: package),
        orElse: () => null,
      );
      return p?.latestVersion;
    });
  }

  /// Looks up a package by name.
  ///
  /// Returns `null` if the package doesn't exist.
  Future<Package> lookupPackage(String packageName) async {
    final packageKey = db.emptyKey.append(Package, id: packageName);
    return await db.lookupValue<Package>(packageKey, orElse: () => null);
  }

  /// Looks up a moderated package by name.
  ///
  /// Returns `null` if the package doesn't exist.
  Future<ModeratedPackage> lookupModeratedPackage(String packageName) async {
    final packageKey = db.emptyKey.append(ModeratedPackage, id: packageName);
    return await db.lookupValue<ModeratedPackage>(packageKey,
        orElse: () => null);
  }

  /// Looks up a package by name.
  Future<List<Package>> lookupPackages(Iterable<String> packageNames) async {
    return (await db.lookup(packageNames
            .map((p) => db.emptyKey.append(Package, id: p))
            .toList()))
        .cast();
  }

  /// Looks up a specific package version.
  ///
  /// Returns null if the version is not a semantic version or if the version
  /// entity does not exists in the datastore.
  Future<PackageVersion> lookupPackageVersion(
      String package, String version) async {
    version = canonicalizeVersion(version);
    if (version == null) return null;
    final packageVersionKey = db.emptyKey
        .append(Package, id: package)
        .append(PackageVersion, id: version);
    return (await db.lookup([packageVersionKey])).first as PackageVersion;
  }

  /// Looks up the latest versions of a list of packages.
  Future<List<PackageVersion>> lookupLatestVersions(
      List<Package> packages) async {
    final keys = packages.map((Package p) => p.latestVersionKey).toList();
    return (await db.lookup(keys)).cast();
  }

  /// Looks up all versions of a package.
  Future<List<PackageVersion>> versionsOfPackage(String packageName) async {
    final packageKey = db.emptyKey.append(Package, id: packageName);
    final query = db.query<PackageVersion>(ancestorKey: packageKey);
    return await query.run().toList();
  }

  /// Get a [Uri] which can be used to download a tarball of the pub package.
  Future<Uri> downloadUrl(String package, String version) async {
    InvalidInputException.checkSemanticVersion(version);
    version = canonicalizeVersion(version);
    return _storage.downloadUrl(package, version);
  }

  /// Updates [options] on [package].
  Future<void> updateOptions(String package, api.PkgOptions options) async {
    final user = await requireAuthenticatedUser();

    final pkgKey = db.emptyKey.append(Package, id: package);
    String latestVersion;
    await withRetryTransaction(db, (tx) async {
      final p = await tx.lookupOrNull<Package>(pkgKey);
      if (p == null) {
        throw NotFoundException.resource(package);
      }
      latestVersion = p.latestVersion;

      // Check that the user is admin for this package.
      await checkPackageAdmin(p, user.userId);

      bool hasOptionsChanged = false;
      if (options.isDiscontinued != null &&
          options.isDiscontinued != p.isDiscontinued) {
        p.isDiscontinued = options.isDiscontinued;
        hasOptionsChanged = true;
      }
      if (options.isUnlisted != null && options.isUnlisted != p.isUnlisted) {
        p.isUnlisted = options.isUnlisted;
        hasOptionsChanged = true;
      }

      if (!hasOptionsChanged) {
        return;
      }

      p.updated = DateTime.now().toUtc();
      _logger.info('Updating $package options: '
          'isDiscontinued: ${p.isDiscontinued} '
          'isUnlisted: ${p.isUnlisted} '
          'doNotAdvertise: ${p.doNotAdvertise}');
      tx.insert(p);
      tx.insert(History.entry(
        PackageOptionsChanged(
          packageName: p.name,
          userId: user.userId,
          userEmail: user.email,
          isDiscontinued: options.isDiscontinued,
          isUnlisted: options.isUnlisted,
        ),
      ));
    });
    await purgePackageCache(package);
    await analyzerClient.triggerAnalysis(package, latestVersion, <String>{});
  }

  /// Whether [userId] is a package admin (through direct uploaders list or
  /// publisher admin).
  ///
  /// Returns false if the user is not an admin.
  Future<bool> isPackageAdmin(Package p, String userId) async {
    if (userId == null) {
      return false;
    }
    if (p.publisherId == null) {
      return p.containsUploader(userId);
    } else {
      final memberKey = db.emptyKey
          .append(Publisher, id: p.publisherId)
          .append(PublisherMember, id: userId);
      final list = await db.lookup<PublisherMember>([memberKey]);
      final member = list.single;
      return member?.role == PublisherMemberRole.admin;
    }
  }

  /// Whether the [userId] is a package admin (through direct uploaders list or
  /// publisher admin).
  ///
  /// Throws AuthenticationException if the user is provided.
  /// Throws AuthorizationException if the user is not an admin for the package.
  Future<void> checkPackageAdmin(Package package, String userId) async {
    if (userId == null) {
      throw AuthenticationException.authenticationRequired();
    }
    if (!await isPackageAdmin(package, userId)) {
      throw AuthorizationException.userIsNotAdminForPackage(package.name);
    }
  }

  /// Returns the publisher info of a given package.
  Future<api.PackagePublisherInfo> getPublisherInfo(String packageName) async {
    final key = db.emptyKey.append(Package, id: packageName);
    final package = (await db.lookup<Package>([key])).single;
    if (package == null) {
      throw NotFoundException.resource('package "$packageName"');
    }
    return _asPackagePublisherInfo(package);
  }

  /// Returns the number of likes of a given package.
  Future<PackageLikesCount> getPackageLikesCount(String packageName) async {
    final key = db.emptyKey.append(Package, id: packageName);
    final package = await db.lookupValue<Package>(key, orElse: () => null);
    if (package == null) {
      throw NotFoundException.resource('package "$packageName"');
    }
    return PackageLikesCount(package: packageName, likes: package.likes);
  }

  /// Sets/updates the publisher of a package.
  Future<api.PackagePublisherInfo> setPublisher(
      String packageName, api.PackagePublisherInfo request) async {
    InvalidInputException.checkNotNull(request.publisherId, 'publisherId');
    final user = await requireAuthenticatedUser();

    final key = db.emptyKey.append(Package, id: packageName);
    await requirePackageAdmin(packageName, user.userId);
    await requirePublisherAdmin(request.publisherId, user.userId);
    final rs = await withRetryTransaction(db, (tx) async {
      final package = (await db.lookup<Package>([key])).single;
      final fromPublisherId = package.publisherId;
      package.publisherId = request.publisherId;
      package.uploaders.clear();
      package.updated = DateTime.now().toUtc();

      tx.insert(package);
      tx.insert(History.entry(
        PackageTransferred(
          packageName: package.name,
          fromPublisherId: fromPublisherId,
          toPublisherId: package.publisherId,
          userId: user.userId,
          userEmail: user.email,
        ),
      ));

      return _asPackagePublisherInfo(package);
    });
    await purgePublisherCache(publisherId: request.publisherId);
    await purgePackageCache(packageName);
    return rs;
  }

  /// Moves the package out of its current publisher.
  Future<api.PackagePublisherInfo> removePublisher(String packageName) async {
    final user = await requireAuthenticatedUser();
    final package = await requirePackageAdmin(packageName, user.userId);
    if (package.publisherId == null) {
      return _asPackagePublisherInfo(package);
    }
    await requirePublisherAdmin(package.publisherId, user.userId);
//  Code commented out while we decide if this feature is something we want to
//  support going forward.
//
//    final key = db.emptyKey.append(Package, id: packageName);
//    final rs = await db.withTransaction((tx) async {
//      final package = (await db.lookup<Package>([key])).single;
//      package.publisherId = null;
//      package.uploaders = [user.userId];
//      package.updated = DateTime.now().toUtc();
//      // TODO: store PackageTransferred History entry.
//      tx.queueMutations(inserts: [package]);
//      await tx.commit();
//      return _asPackagePublisherInfo(package);
//    });
//    await purgePublisherCache(package.publisherId);
//    await invalidatePackageCache(packageName);
//    return rs as api.PackagePublisherInfo;
    throw NotImplementedException();
  }

  /// Returns the known versions of [package].
  ///
  /// Used in `pub` client for finding which versions exist.
  Future<api.PackageData> listVersions(Uri baseUri, String package) async {
    final pkg = await packageBackend.lookupPackage(package);
    if (pkg == null || pkg.isNotVisible) {
      throw NotFoundException.resource('package "$package"');
    }
    final packageVersions = await packageBackend.versionsOfPackage(package);
    if (packageVersions.isEmpty) {
      throw NotFoundException.resource('package "$package"');
    }
    packageVersions
        .sort((a, b) => a.semanticVersion.compareTo(b.semanticVersion));
    final latest = packageVersions.lastWhere(
      (pv) => !pv.semanticVersion.isPreRelease,
      orElse: () => packageVersions.last,
    );
    return api.PackageData(
      name: package,
      isDiscontinued: pkg.isDiscontinued ? true : null,
      latest: _toApiVersionInfo(baseUri, latest),
      versions:
          packageVersions.map((pv) => _toApiVersionInfo(baseUri, pv)).toList(),
    );
  }

  /// Lookup and return the API's version info object.
  ///
  /// Throws [NotFoundException] when the version is missing.
  Future<api.VersionInfo> lookupVersion(
      Uri baseUri, String package, String version) async {
    InvalidInputException.checkSemanticVersion(version);
    final canonicalVersion = canonicalizeVersion(version);
    InvalidInputException.checkSemanticVersion(canonicalVersion);

    final packageKey = db.emptyKey.append(Package, id: package);
    final packageVersionKey =
        packageKey.append(PackageVersion, id: canonicalVersion);

    if (!await isPackageVisible(package)) {
      throw NotFoundException.resource('package "$package"');
    }
    final pv = await db.lookupValue<PackageVersion>(packageVersionKey,
        orElse: () => null);
    if (pv == null) {
      throw NotFoundException.resource('version "$version"');
    }

    return _toApiVersionInfo(baseUri, pv);
  }

  api.VersionInfo _toApiVersionInfo(Uri baseUri, PackageVersion pv) =>
      api.VersionInfo(
        version: pv.version,
        pubspec: pv.pubspec.asJson,
        archiveUrl: urls.pkgArchiveDownloadUrl(pv.package, pv.version,
            baseUri: baseUri),
        published: pv.created,
      );

  @visibleForTesting
  Future<Stream<List<int>>> download(String package, String version) async {
    // TODO: Should we first test for existence?
    // Maybe with a cache?
    version = canonicalizeVersion(version);
    return _storage.download(package, version);
  }

  @visibleForTesting
  Future<PackageVersion> upload(Stream<List<int>> data) async {
    await requireAuthenticatedUser();
    final guid = createUuid();
    _logger.info('Starting semi-async upload (uuid: $guid)');
    final object = _storage.tempObjectName(guid);
    await data.pipe(_storage.bucket.write(object));
    final finishUri = Uri(
      path: '/api/packages/versions/newUploadFinish',
      queryParameters: {'upload_id': guid},
    );
    return await publishUploadedBlob(finishUri);
  }

  Future<api.UploadInfo> startUpload(Uri redirectUrl) async {
    final restriction = await getUploadRestrictionStatus();
    if (restriction == UploadRestrictionStatus.noUploads) {
      throw PackageRejectedException.uploadRestricted();
    }
    _logger.info('Starting async upload.');
    // NOTE: We use a authenticated user scope here to ensure the uploading
    // user is authenticated. But we're not validating anything at this point
    // because we don't even know which package or version is going to be
    // uploaded.
    final user = await requireAuthenticatedUser();
    _logger.info('User: ${user.email}.');

    final guid = createUuid();
    final String object = _storage.tempObjectName(guid);
    final String bucket = _storage.bucket.bucketName;
    final Duration lifetime = const Duration(minutes: 10);

    final url = redirectUrl.resolve('?upload_id=$guid');

    _logger
        .info('Redirecting pub client to google cloud storage (uuid: $guid)');
    return uploadSigner.buildUpload(bucket, object, lifetime, '$url');
  }

  /// Finishes the upload of a package.
  Future<PackageVersion> publishUploadedBlob(Uri uri) async {
    final restriction = await getUploadRestrictionStatus();
    if (restriction == UploadRestrictionStatus.noUploads) {
      throw PackageRejectedException.uploadRestricted();
    }
    final user = await requireAuthenticatedUser();
    final guid = uri.queryParameters['upload_id'];
    _logger.info('Finishing async upload (uuid: $guid)');
    _logger.info('Reading tarball from cloud storage.');

    return await withTempDirectory((Directory dir) async {
      final filename = '${dir.absolute.path}/tarball.tar.gz';
      await _saveTarballToFS(_storage.readTempObject(guid), filename);
      await _verifyTarball(filename);
      final version = await _performTarballUpload(
        user,
        filename,
        (package, version) =>
            _storage.uploadViaTempObject(guid, package, version),
        restriction,
      );
      _logger.info('Removing temporary object $guid.');
      await _storage.removeTempObject(guid);
      return version;
    });
  }

  Future<PackageVersion> _performTarballUpload(
    User user,
    String filename,
    Future<void> Function(String name, String version) tarballUpload,
    UploadRestrictionStatus restriction,
  ) async {
    _logger.info('Examining tarball content.');

    // Parse metadata from the tarball.
    final validatedUpload = await _parseAndValidateUpload(db, filename, user);
    final newVersion = validatedUpload.packageVersion;

    Package package;
    String prevLatestStableVersion;

    // Add the new package to the repository by storing the tarball and
    // inserting metadata to datastore (which happens atomically).
    final pv = await withRetryTransaction(db, (tx) async {
      _logger.info('Starting datastore transaction.');

      final tuple = (await tx.lookup([newVersion.key, newVersion.packageKey]));
      final version = tuple[0] as PackageVersion;
      package = tuple[1] as Package;

      // If the version already exists, we fail.
      if (version != null) {
        _logger.info('Version ${version.version} of package '
            '${version.package} already exists, rolling transaction back.');
        throw PackageRejectedException.versionExists(
            version.package, version.version);
      }

      // reserved package names for the Dart team
      if (package == null &&
          matchesReservedPackageName(newVersion.package) &&
          !user.email.endsWith('@google.com')) {
        throw PackageRejectedException.nameReserved(newVersion.package);
      }

      // If the package does not exist, then we create a new package.
      prevLatestStableVersion = package?.latestVersion;
      if (package == null) {
        _logger.info('New package uploaded. [new-package-uploaded]');
        if (restriction == UploadRestrictionStatus.onlyUpdates) {
          throw PackageRejectedException.uploadRestricted();
        }
        package = _newPackageFromVersion(db, newVersion, user.userId);
      } else if (!await packageBackend.isPackageAdmin(package, user.userId)) {
        _logger.info('User ${user.userId} (${user.email}) is not an uploader '
            'for package ${package.name}, rolling transaction back.');
        throw AuthorizationException.userCannotUploadNewVersion(package.name);
      }

      if (package.isNotVisible) {
        throw PackageRejectedException.isWithheld();
      }

      // Store the publisher of the package at the time of the upload.
      newVersion.publisherId = package.publisherId;

      // Keep the latest version in the package object up-to-date.
      package.updateVersion(newVersion);
      package.updated = DateTime.now().toUtc();

      _logger.info(
        'Trying to upload tarball for ${package.name} version ${newVersion.version} to cloud storage.',
      );
      // Apply update: Push to cloud storage
      await tarballUpload(package.name, newVersion.version);

      final inserts = <Model>[
        package,
        newVersion,
        validatedUpload.packageVersionPubspec,
        validatedUpload.packageVersionInfo,
        ...validatedUpload.assets,
        History.entry(PackageUploaded(
          packageName: newVersion.package,
          packageVersion: newVersion.version,
          uploaderId: user.userId,
          uploaderEmail: user.email,
          timestamp: newVersion.created,
        )),
      ];

      _logger.info('Trying to commit datastore changes.');
      tx.queueMutations(inserts: inserts);
      return newVersion;
    });
    _logger.info('Upload successful. [package-uploaded]');

    _logger.info('Invalidating cache for package ${newVersion.package}.');
    await purgePackageCache(newVersion.package);

    try {
      final uploaderEmails = package.publisherId == null
          ? await accountBackend.getEmailsOfUserIds(package.uploaders)
          : await publisherBackend.getAdminMemberEmails(package.publisherId);

      // Notify uploaders via email that a new version has been published.
      final email = emailSender.sendMessage(
        createPackageUploadedEmail(
          packageName: newVersion.package,
          packageVersion: newVersion.version,
          uploaderEmail: user.email,
          authorizedUploaders:
              uploaderEmails.map((email) => EmailAddress(null, email)).toList(),
        ),
      );

      // Let's not block the upload response on these. In case of a timeout, the
      // underlying operations still go ahead, but the `Future.wait` call below
      // is not blocked on it.
      await Future.wait([
        email,
        // Trigger analysis and dartdoc generation. Dependent packages can be left
        // out here, because the dependency graph's background polling will pick up
        // the new upload, and will trigger analysis for the dependent packages.
        analyzerClient.triggerAnalysis(
            newVersion.package, newVersion.version, <String>{}),
        dartdocClient
            .triggerDartdoc(newVersion.package, newVersion.version, <String>{}),
        // Trigger a new doc generation for the previous latest stable version
        // in order to update the dartdoc entry and the canonical-urls.
        if (prevLatestStableVersion != null)
          dartdocClient.triggerDartdoc(
              newVersion.package, prevLatestStableVersion, <String>{})
      ]).timeout(Duration(seconds: 10));
    } catch (e, st) {
      final v = newVersion.qualifiedVersionKey;
      _logger.severe('Error post-processing package upload $v', e, st);
    }
    return pv;
  }

  // Uploaders support.

  Future<api.SuccessMessage> addUploader(
      String packageName, String uploaderEmail) async {
    uploaderEmail = uploaderEmail.toLowerCase();
    final user = await requireAuthenticatedUser();
    final packageKey = db.emptyKey.append(Package, id: packageName);
    final package = (await db.lookup([packageKey])).first as Package;

    await _validatePackageUploader(packageName, package, user.userId);
    // Don't send invites for publisher-owned packages.
    if (package.publisherId != null) {
      throw OperationForbiddenException.publisherOwnedPackageNoUploader(
          packageName, package.publisherId);
    }

    InvalidInputException.check(
        isValidEmail(uploaderEmail), 'Not a valid email: `$uploaderEmail`.');

    final uploader = await accountBackend.lookupUserByEmail(uploaderEmail);
    if (uploader != null && package.containsUploader(uploader.userId)) {
      // The requested uploaderEmail is already part of the uploaders.
      return api.SuccessMessage(
          success:
              api.Message(message: '`$uploaderEmail` is already an uploader.'));
    }

    await historyBackend.storeEvent(UploaderInvited(
      packageName: packageName,
      currentUserId: user.userId,
      currentUserEmail: user.email,
      uploaderUserEmail: uploaderEmail,
    ));

    final status = await consentBackend.invitePackageUploader(
      packageName: packageName,
      uploaderUserId: uploader?.userId,
      uploaderEmail: uploaderEmail,
    );

    if (!status.emailSent) {
      throw OperationForbiddenException.inviteActive(status.nextNotification);
    }

    throw OperationForbiddenException.uploaderInviteSent(uploaderEmail);
  }

  Future<void> confirmUploader(String fromUserId, String fromUserEmail,
      String packageName, User uploader) async {
    if (fromUserId == null) {
      final user =
          await accountBackend.lookupOrCreateUserByEmail(fromUserEmail);
      fromUserId = user.userId;
    }
    assert(fromUserId != null);
    await withRetryTransaction(db, (tx) async {
      final packageKey = db.emptyKey.append(Package, id: packageName);
      final package = (await tx.lookup([packageKey])).first as Package;

      await _validatePackageUploader(packageName, package, fromUserId);
      if (package.containsUploader(uploader.userId)) {
        // The requested uploaderEmail is already part of the uploaders.
        return;
      }

      // Add [uploaderEmail] to uploaders and commit.
      package.addUploader(uploader.userId);
      package.updated = DateTime.now().toUtc();

      tx.insert(package);
      tx.insert(History.entry(UploaderChanged(
        packageName: packageName,
        currentUserId: fromUserId,
        currentUserEmail: fromUserEmail,
        addedUploaderIds: [uploader.userId],
        addedUploaderEmails: [uploader.email],
      )));
    });
    await purgePackageCache(packageName);
  }

  Future<void> _validatePackageUploader(
      String packageName, Package package, String userId) async {
    // Fail if package doesn't exist.
    if (package == null) {
      throw NotFoundException.resource(packageName);
    }

    // Fail if calling user doesn't have permission to change uploaders.
    if (!await packageBackend.isPackageAdmin(package, userId)) {
      throw AuthorizationException.userCannotChangeUploaders(package.name);
    }
  }

  Future<api.SuccessMessage> removeUploader(
      String packageName, String uploaderEmail) async {
    uploaderEmail = uploaderEmail.toLowerCase();
    final user = await requireAuthenticatedUser();
    await withRetryTransaction(db, (tx) async {
      final packageKey = db.emptyKey.append(Package, id: packageName);
      final package =
          await tx.lookupValue<Package>(packageKey, orElse: () => null);
      if (package == null) {
        throw NotFoundException.resource('package: $packageName');
      }

      await _validatePackageUploader(packageName, package, user.userId);

      // Fail if the uploader we want to remove does not exist.
      final uploader = await accountBackend.lookupUserByEmail(uploaderEmail);
      if (uploader == null || !package.containsUploader(uploader.userId)) {
        throw NotFoundException.resource('uploader: $uploaderEmail');
      }

      // We cannot have 0 uploaders, if we would remove the last one, we
      // fail with an error.
      if (package.uploaderCount <= 1) {
        throw OperationForbiddenException.lastUploaderRemoveError();
      }

      // At the moment we don't validate whether the other email addresses
      // are able to authenticate. To prevent accidentally losing the control
      // of a package, we don't allow self-removal.
      if (user.email == uploader.email || user.userId == uploader.userId) {
        throw OperationForbiddenException.selfRemovalNotAllowed();
      }

      // Remove the uploader from the list.
      package.removeUploader(uploader.userId);
      package.updated = DateTime.now().toUtc();

      tx.insert(package);
      tx.insert(History.entry(UploaderChanged(
        packageName: packageName,
        currentUserId: user.userId,
        currentUserEmail: user.email,
        removedUploaderIds: [uploader.userId],
        removedUploaderEmails: [uploader.email],
      )));
    });
    await purgePackageCache(packageName);
    return api.SuccessMessage(
        success: api.Message(
            message:
                '$uploaderEmail has been removed as an uploader for this package.'));
  }

  Future<UploadRestrictionStatus> getUploadRestrictionStatus() async {
    final value =
        await secretBackend.getCachedValue(SecretKey.uploadRestriction) ?? '';
    switch (value) {
      case 'no-uploads':
        return UploadRestrictionStatus.noUploads;
      case 'only-updates':
        return UploadRestrictionStatus.onlyUpdates;
      case '':
      case '-':
      case 'no-restriction':
        return UploadRestrictionStatus.noRestriction;
    }
    // safe fallback on enabling uploads
    _logger.warning('Unknown upload restriction status: $value');
    return UploadRestrictionStatus.noRestriction;
  }
}

enum UploadRestrictionStatus {
  /// Publication of new packages and new versions of existing packages is allowed.
  noRestriction,

  /// Publication of new packages is **not** allowed, new versions of existing packages is allowed.
  onlyUpdates,

  /// Publication of packages is **not** allowed.
  noUploads,
}

/// Loads [package], returns its [Package] instance, and also checks if
/// [userId] is an admin of the package.
///
/// Throws AuthenticationException if the user is provided.
/// Throws AuthorizationException if the user is not an admin for the package.
Future<Package> requirePackageAdmin(String package, String userId) async {
  if (userId == null) {
    throw AuthenticationException.authenticationRequired();
  }
  final p = await packageBackend.lookupPackage(package);
  if (p == null) {
    throw NotFoundException.resource('package "$package"');
  }
  await packageBackend.checkPackageAdmin(p, userId);
  return p;
}

api.PackagePublisherInfo _asPackagePublisherInfo(Package p) =>
    api.PackagePublisherInfo(publisherId: p.publisherId);

/// Purge [cache] entries for given [package] and also global page caches.
Future<void> purgePackageCache(String package) async {
  await Future.wait([
    cache.packageVisible(package).purge(),
    cache.packageData(package).purge(),
    cache.packageLatestVersion(package).purge(),
    cache.packageView(package).purge(),
    cache.uiPackagePage(package, null).purge(),
    cache.uiPackageChangelog(package, null).purge(),
    cache.uiPackageExample(package, null).purge(),
    cache.uiPackageInstall(package, null).purge(),
    cache.uiPackageScore(package, null).purge(),
    cache.uiPackageVersions(package).purge(),
    cache.uiIndexPage().purge(),
  ]);
}

/// The status of an invite after being created or updated.
class InviteStatus {
  final String urlNonce;
  final DateTime nextNotification;

  InviteStatus({this.urlNonce, this.nextNotification});

  bool get isActive => urlNonce != null;

  bool get isDelayed => nextNotification != null;
}

/// Reads a tarball from a byte stream.
///
/// Completes with an error if the incoming stream has an error or if the size
/// exceeds [UploadSignerService.maxUploadSize].
Future _saveTarballToFS(Stream<List<int>> data, String filename) async {
  final targetFile = File(filename);
  try {
    int receivedBytes = 0;
    final stream = data.transform<List<int>>(
      StreamTransformer<List<int>, List<int>>.fromHandlers(
        handleData: (chunk, sink) {
          receivedBytes += chunk.length;
          if (receivedBytes <= UploadSignerService.maxUploadSize) {
            sink.add(chunk);
          } else {
            sink.addError(PackageRejectedException.archiveTooLarge(
                UploadSignerService.maxUploadSize));
          }
        },
      ),
    );
    await stream.pipe(targetFile.openWrite());
  } catch (e, st) {
    _logger.warning('An error occured while streaming tarball to FS.', e, st);
    rethrow;
  }
  _logger.info('Finished streaming tarball to FS.');
}

Future<void> _verifyTarball(String filename) async {
  final file = File(filename);
  // Some platforms may not be able to create an archive, only an empty file.
  final fileSize = await file.length();
  if (fileSize == 0) {
    throw PackageRejectedException.archiveEmpty();
  }
  await verifyTarGzSymlinks(filename);
}

// Throws [PackageRejectedException] if the archive is not readable or if there
// is any symlink in the archive.
@visibleForTesting
Future<void> verifyTarGzSymlinks(String filename) async {
  Future<List<String>> listFiles(bool verbose) async {
    final pr = await runProc(
      'tar',
      [verbose ? '-tvf' : '-tf', filename],
    );
    if (pr.exitCode != 0) {
      _logger.info('Rejecting package: tar returned with ${pr.exitCode}\n'
          '${pr.stdout}\n${pr.stderr}');
      throw PackageRejectedException.invalidTarGz();
    }
    return pr.stdout.toString().split('\n');
  }

  final fileNames = (await listFiles(false)).toSet();
  final verboseLines = await listFiles(true);
  // Check if the file has any symlink.
  for (final line in verboseLines) {
    if (line.startsWith('l')) {
      // report only the source path
      // if output is non-standard for any reason, this reports the full line
      final parts = line.split(' -> ');
      final source = parts.first.split(' ').last;
      final target = parts.last;
      if (p.isAbsolute(target)) {
        throw PackageRejectedException.brokenSymlink(source, target);
      }
      final resolvedPath = p.normalize(Uri(path: source).resolve(target).path);
      if (!fileNames.contains(resolvedPath)) {
        throw PackageRejectedException.brokenSymlink(source, target);
      }
    }
  }
}

/// Creates a new `Package` and populates all of it's fields.
Package _newPackageFromVersion(
    DatastoreDB db, PackageVersion version, String userId) {
  final now = DateTime.now().toUtc();
  return Package()
    ..parentKey = db.emptyKey
    ..id = version.pubspec.name
    ..name = version.pubspec.name
    ..created = now
    ..updated = now
    ..downloads = 0
    ..latestVersionKey = version.key
    ..latestPrereleaseVersionKey = version.key
    ..uploaders = [userId]
    ..likes = 0
    ..doNotAdvertise = false
    ..isDiscontinued = false
    ..isUnlisted = false
    ..isWithheld = false
    ..assignedTags = [];
}

class _ValidatedUpload {
  final PackageVersion packageVersion;
  final PackageVersionPubspec packageVersionPubspec;
  final PackageVersionInfo packageVersionInfo;
  final List<PackageVersionAsset> assets;

  _ValidatedUpload(
    this.packageVersion,
    this.packageVersionPubspec,
    this.packageVersionInfo,
    this.assets,
  );
}

class DerivedPackageVersionEntities {
  final PackageVersionPubspec packageVersionPubspec;
  final PackageVersionInfo packageVersionInfo;
  final List<PackageVersionAsset> assets;

  DerivedPackageVersionEntities(
    this.packageVersionPubspec,
    this.packageVersionInfo,
    this.assets,
  );
}

/// Parses metadata from a tarball and & validates it.
///
/// This function ensures that `tarball`
///   * is a valid `tar.gz` file
///   * contains a valid `pubspec.yaml` file
///   * reads readme, changelog and pubspec files
///   * creates a [PackageVersion] and populates it with all metadata
Future<_ValidatedUpload> _parseAndValidateUpload(
    DatastoreDB db, String filename, User user) async {
  assert(user != null);

  final archive = await summarizePackageArchive(filename);
  if (archive.hasIssues) {
    throw PackageRejectedException(archive.issues.first.message);
  }

  final pubspec = Pubspec.fromYaml(archive.pubspecContent);
  PackageRejectedException.check(await nameTracker.accept(pubspec.name),
      'Package name is too similar to another active or moderated package.');

  PackageRejectedException.check(!pubspec.hasBothAuthorAndAuthors,
      'Do not specify both `author` and `authors` in `pubspec.yaml`.');

  final packageKey = db.emptyKey.append(Package, id: pubspec.name);

  final versionString = canonicalizeVersion(pubspec.nonCanonicalVersion);
  if (versionString == null) {
    throw InvalidInputException.canonicalizeVersionError(
        pubspec.nonCanonicalVersion);
  }

  final version = PackageVersion()
    ..id = versionString
    ..parentKey = packageKey
    ..version = versionString
    ..packageKey = packageKey
    ..created = DateTime.now().toUtc()
    ..pubspec = pubspec
    ..readmeFilename = archive.readmePath
    ..readmeContent = archive.readmeContent
    ..changelogFilename = archive.changelogPath
    ..changelogContent = archive.changelogContent
    ..exampleFilename = archive.examplePath
    ..exampleContent = archive.exampleContent
    ..libraries = archive.libraries
    ..downloads = 0
    ..uploader = user.userId;

  final derived = derivePackageVersionEntities(
    archive: archive,
    versionCreated: version.created,
  );

  if (derived.assets.any((a) => spamBackend.isSpam(a.textContent))) {
    throw PackageRejectedException.classifiedAsSpam();
  }

  // TODO: verify if assets sizes are within the transaction limit (10 MB)
  return _ValidatedUpload(version, derived.packageVersionPubspec,
      derived.packageVersionInfo, derived.assets);
}

/// Creates new Datastore entities from the actual extraction of package [archive].
DerivedPackageVersionEntities derivePackageVersionEntities({
  @required PackageSummary archive,
  @required DateTime versionCreated,
}) {
  final pubspec = Pubspec.fromYaml(archive.pubspecContent);
  final key = QualifiedVersionKey(
      package: pubspec.name, version: pubspec.canonicalVersion);

  final versionPubspec = PackageVersionPubspec()
    ..initFromKey(key)
    ..versionCreated = versionCreated
    ..updated = DateTime.now().toUtc()
    ..pubspec = pubspec;

  final assets = <PackageVersionAsset>[
    PackageVersionAsset.init(
      package: key.package,
      version: key.version,
      kind: AssetKind.pubspec,
      versionCreated: versionCreated,
      path: 'pubspec.yaml',
      textContent: archive.pubspecContent,
    ),
    if (archive.readmePath != null)
      PackageVersionAsset.init(
        package: key.package,
        version: key.version,
        kind: AssetKind.readme,
        versionCreated: versionCreated,
        path: archive.readmePath,
        textContent: archive.readmeContent,
      ),
    if (archive.changelogPath != null)
      PackageVersionAsset.init(
        package: key.package,
        version: key.version,
        kind: AssetKind.changelog,
        versionCreated: versionCreated,
        path: archive.changelogPath,
        textContent: archive.changelogContent,
      ),
    if (archive.examplePath != null)
      PackageVersionAsset.init(
        package: key.package,
        version: key.version,
        kind: AssetKind.example,
        versionCreated: versionCreated,
        path: archive.examplePath,
        textContent: archive.exampleContent,
      ),
    if (archive.licensePath != null)
      PackageVersionAsset.init(
        package: key.package,
        version: key.version,
        kind: AssetKind.license,
        versionCreated: versionCreated,
        path: archive.licensePath,
        textContent: archive.licenseContent,
      ),
  ];

  final versionInfo = PackageVersionInfo()
    ..initFromKey(key)
    ..versionCreated = versionCreated
    ..updated = DateTime.now().toUtc()
    ..libraries = archive.libraries
    ..libraryCount = archive.libraries.length
    ..assets = assets.map((a) => a.kind).toList()
    ..assetCount = assets.length;

  return DerivedPackageVersionEntities(versionPubspec, versionInfo, assets);
}

/// Helper utility class for interfacing with Cloud Storage for storing
/// tarballs.
class TarballStorage {
  final TarballStorageNamer namer;
  final Storage storage;
  final Bucket bucket;

  TarballStorage(this.storage, Bucket bucket, String namespace)
      : bucket = bucket,
        namer = TarballStorageNamer(
            activeConfiguration.storageBaseUrl, bucket.bucketName, namespace);

  /// Generates a path to a temporary object on cloud storage.
  String tempObjectName(String guid) => namer.tmpObjectName(guid);

  /// Reads the temporary object identified by [guid]
  Stream<List<int>> readTempObject(String guid) =>
      bucket.read(namer.tmpObjectName(guid));

  /// Makes a temporary object a new tarball.
  Future<void> uploadViaTempObject(
      String guid, String package, String version) async {
    final object = namer.tarballObjectName(package, version);

    // Copy the temporary object to it's destination place.
    await storage.copyObject(
        bucket.absoluteObjectName(namer.tmpObjectName(guid)),
        bucket.absoluteObjectName(object));

    // Change the ACL to include a `public-read` entry.
    final ObjectInfo info = await bucket.info(object);
    final publicRead = AclEntry(AllUsersScope(), AclPermission.READ);
    final acl = Acl(List.from(info.metadata.acl.entries)..add(publicRead));
    await bucket.updateMetadata(object, info.metadata.replace(acl: acl));
  }

  /// Remove a previously generated temporary object.
  Future<void> removeTempObject(String guid) async {
    if (guid == null) throw ArgumentError('No guid given.');
    return bucket.delete(namer.tmpObjectName(guid));
  }

  /// Download the tarball of a [package] in the given [version].
  Stream<List<int>> download(String package, String version) {
    final object = namer.tarballObjectName(package, version);
    return bucket.read(object);
  }

  /// Deletes the tarball of a [package] in the given [version] permanently.
  Future<void> remove(String package, String version) async {
    final object = namer.tarballObjectName(package, version);
    await deleteFromBucket(bucket, object);
  }

  /// Get the URL to the tarball of a [package] in the given [version].
  Future<Uri> downloadUrl(String package, String version) {
    // NOTE: We should maybe check for existence first?
    // return storage.bucket(bucket).info(object)
    //     .then((info) => info.downloadLink);
    return Future.value(Uri.parse(namer.tarballObjectUrl(package, version)));
  }

  /// Upload [tarball] of a [package] in the given [version].
  Future<void> upload(
      String package, String version, Stream<List<int>> tarball) {
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
  /// The tarball object storage prefix
  final String storageBaseUrl;

  /// The GCS bucket used.
  final String bucket;

  /// The namespace used.
  final String namespace;

  /// The prefix of where packages are stored (i.e. '' or 'ns/<namespace>').
  final String prefix;

  TarballStorageNamer(String storageBaseUrl, this.bucket, String namespace)
      : storageBaseUrl = storageBaseUrl.endsWith('/')
            ? storageBaseUrl.substring(0, storageBaseUrl.length - 1)
            : storageBaseUrl,
        namespace = namespace ?? '',
        prefix =
            (namespace == null || namespace.isEmpty) ? '' : 'ns/$namespace/';

  /// The GCS object name of a tarball object - excluding leading '/'.
  String tarballObjectName(String package, String version) =>
      '${prefix}packages/$package-$version.tar.gz';

  /// The GCS object name of an temporary object [guid] - excluding leading '/'.
  String tmpObjectName(String guid) => 'tmp/$guid';

  /// The http URL of a publicly accessable GCS object.
  String tarballObjectUrl(String package, String version) {
    final object = tarballObjectName(package, Uri.encodeComponent(version));
    return '$storageBaseUrl/$bucket/$object';
  }
}
