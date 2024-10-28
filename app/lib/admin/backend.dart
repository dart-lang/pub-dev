// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/data/admin_api.dart' as api;
import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:_pub_shared/utils/sdk_version_cache.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pool/pool.dart';

import '../account/backend.dart';
import '../account/consent_backend.dart';
import '../account/like_backend.dart';
import '../account/models.dart';
import '../admin/models.dart';
import '../audit/models.dart';
import '../package/backend.dart'
    show checkPackageVersionParams, packageBackend, purgePackageCache;
import '../package/models.dart';
import '../publisher/models.dart';
import '../scorecard/backend.dart';
import '../service/email/email_templates.dart';
import '../shared/configuration.dart';
import '../shared/datastore.dart';
import '../shared/exceptions.dart';
import '../shared/versions.dart';
import '../task/backend.dart';
import 'actions/actions.dart' show AdminAction;
import 'tools/delete_all_staging.dart';
import 'tools/list_package_blocked.dart';
import 'tools/list_tools.dart';
import 'tools/notify_service.dart';
import 'tools/package_publisher.dart';
import 'tools/publisher_member.dart';
import 'tools/recent_uploaders.dart';
import 'tools/set_package_blocked.dart';
import 'tools/set_user_blocked.dart';
import 'tools/user_merger.dart';

final _logger = Logger('pub.admin.backend');
final _continuationCodec = utf8.fuse(hex);

/// Sets the admin backend service.
void registerAdminBackend(AdminBackend backend) =>
    ss.register(#_adminBackend, backend);

/// The active admin backend service.
AdminBackend get adminBackend => ss.lookup(#_adminBackend) as AdminBackend;

typedef Tool = Future<String> Function(List<String> args);

final Map<String, Tool> availableTools = {
  'delete-all-staging': executeDeleteAllStaging,
  'list-package-blocked': executeListPackageBlocked,
  'notify-service': executeNotifyService,
  'package-publisher': executeSetPackagePublisher,
  'recent-uploaders': executeRecentUploaders,
  'publisher-member': executePublisherMember,
  'publisher-invite-member': executePublisherInviteMember,
  'set-package-blocked': executeSetPackageBlocked,
  'set-user-blocked': executeSetUserBlocked,
  'user-merger': executeUserMergerTool,
  'list-tools': executeListTools,
};

/// Represents the backend for the admin handling and authentication.
class AdminBackend {
  final DatastoreDB _db;
  AdminBackend(this._db);

  /// Executes a [tool] with the [args].
  ///
  /// NOTE: This method allows old command-line tools to be used via the
  /// admin API, but it should only be used as a temporary measure.
  /// Tools should be either removed or migrated to proper top-level API endpoints.
  Future<String> executeTool(String tool, List<String> args) async {
    await requireAuthenticatedAdmin(AdminPermission.executeTool);
    final toolFunction = availableTools[tool] ?? executeListTools;
    return await toolFunction(args);
  }

  /// List users.
  Future<api.AdminListUsersResponse> listUsers({
    String? email,
    String? oauthUserId,
    String? continuationToken,
    int limit = 1000,
  }) async {
    InvalidInputException.checkRange(limit, 'limit', minimum: 1, maximum: 1000);
    await requireAuthenticatedAdmin(AdminPermission.listUsers);

    final query = _db.query<User>()..limit(limit);

    if (email != null) {
      InvalidInputException.checkNull(oauthUserId, '?ouid=');
      InvalidInputException.checkNull(continuationToken, '?ct=');
      query.filter('email =', email);
    } else if (oauthUserId != null) {
      InvalidInputException.checkNull(continuationToken, '?ct=');
      query.filter('oauthUserId =', oauthUserId);
    } else if (continuationToken != null) {
      String lastId;
      try {
        lastId = _continuationCodec.decode(continuationToken);
      } on FormatException catch (_) {
        throw InvalidInputException.continuationParseError();
      }
      InvalidInputException.checkNotNull(lastId, '?ct=');

      // NOTE: we should fix https://github.com/dart-lang/gcloud/issues/23
      //       and remove the toDatastoreKey conversion here.
      final key =
          _db.modelDB.toDatastoreKey(_db.emptyKey.append(User, id: lastId));
      query.filter('__key__ >', key);
      query.order('__key__');
    } else {
      query.order('__key__');
    }

    final users = await query.run().toList();
    // We may return a page with users less than a limit, but we always
    // set the continuation token to the correct value.
    final newContinuationToken = users.length < limit
        ? null
        : _continuationCodec.encode(users.last.userId);

    return api.AdminListUsersResponse(
      users: _convertUsers(users),
      continuationToken: newContinuationToken,
    );
  }

  /// Removes user from the Datastore and updates the packages and other
  /// entities they may have controlled.
  ///
  /// Verifies the current authenticated user for admin permissions.
  Future<void> removeUser(String userId) async {
    final caller = await requireAuthenticatedAdmin(AdminPermission.removeUsers);
    final user = await accountBackend.lookupUserById(userId);
    if (user == null) return;
    if (user.isDeleted) return;
    _logger.info('${caller.displayId}) initiated the delete '
        'of ${user.userId} (${user.email})');
    await _removeUser(user);
  }

  /// Removes user from the Datastore and updates the packages and other
  /// entities they may have controlled.
  Future<void> _removeUser(User user) async {
    // Package.uploaders
    final pool = Pool(10);
    final futures = <Future>[];
    final pkgQuery = _db.query<Package>()..filter('uploaders =', user.userId);
    await for (final p in pkgQuery.run()) {
      final f = pool
          .withResource(() => _removeUploaderFromPackage(p.key, user.userId));
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();

    // PublisherMember
    // Publisher.contactEmail
    final memberQuery = _db.query<PublisherMember>()
      ..filter('userId =', user.userId);
    await for (final m in memberQuery.run()) {
      await _removeMember(user, m);
    }

    // Like
    await _removeAndDecrementLikes(user);

    // User
    // OAuthUserID
    // TODO: consider deleting User if there are no other references to it
    await _markUserDeleted(user);
  }

  // Remove like entities and decrement likes count on all packages liked by [user].
  Future<void> _removeAndDecrementLikes(User user) async {
    final pool = Pool(5);
    final futures = <Future>[];
    for (final like in await likeBackend.listPackageLikes(user)) {
      final f = pool
          .withResource(() => likeBackend.unlikePackage(user, like.package!));
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();
  }

  Future<void> _removeUploaderFromPackage(Key pkgKey, String userId) async {
    await withRetryTransaction(_db, (tx) async {
      final p = await tx.lookupValue<Package>(pkgKey);
      p.removeUploader(userId);
      if (p.uploaders!.isEmpty) {
        p.isDiscontinued = true;
      }
      tx.insert(p);
    });
  }

  Future<void> _removeMember(User user, PublisherMember member) async {
    final seniorMember =
        await _remainingSeniorMember(member.publisherKey, member.userId!);
    await withRetryTransaction(_db, (tx) async {
      final p = await tx.lookupValue<Publisher>(member.publisherKey);
      if (seniorMember == null) {
        p.isAbandoned = true;
        p.contactEmail = null;
        // TODO: consider deleting Publisher if there are no other references to it
      } else if (p.contactEmail == user.email) {
        final seniorUser =
            await accountBackend.lookupUserById(seniorMember.userId!);
        p.contactEmail = seniorUser!.email;
      }
      tx.queueMutations(inserts: [p], deletes: [member.key]);
    });
    if (seniorMember == null) {
      // mark packages under the publisher discontinued
      final query = _db.query<Package>()
        ..filter('publisherId =', member.publisherId);
      final pool = Pool(4);
      final futures = <Future>[];
      await for (final package in query.run()) {
        if (package.isDiscontinued) continue;
        final f = pool.withResource(
          () => withRetryTransaction(_db, (tx) async {
            final p = await tx.lookupValue<Package>(package.key);
            p.isDiscontinued = true;
            tx.insert(p);
          }),
        );
        futures.add(f);
      }
      await Future.wait(futures);
      await pool.close();
    }
  }

  /// Returns the member of the publisher that (a) is not removed,
  /// (b) preferably is an admin, and (c) is member of the publisher for the
  /// longest time.
  ///
  /// If there are no more admins left, the "oldest" non-admin member is returned.
  Future<PublisherMember?> _remainingSeniorMember(
      Key publisherKey, String excludeUserId) async {
    final otherMembers = await _db
        .query<PublisherMember>(ancestorKey: publisherKey)
        .run()
        .where((m) => m.userId != excludeUserId)
        .toList();

    if (otherMembers.isEmpty) return null;

    // sort admins in the front, and on equal level sort by created time
    otherMembers.sort((a, b) {
      if (a.role == b.role) return a.created!.compareTo(b.created!);
      if (a.role == PublisherMemberRole.admin) return -1;
      if (b.role == PublisherMemberRole.admin) return 1;
      return a.created!.compareTo(b.created!);
    });

    return otherMembers.first;
  }

  Future<void> _markUserDeleted(User user) async {
    await withRetryTransaction(_db, (tx) async {
      final u = await tx.lookupValue<User>(user.key);
      final deleteKeys = <Key>[];
      if (user.oauthUserId != null) {
        final mappingKey =
            _db.emptyKey.append(OAuthUserID, id: user.oauthUserId);
        final mapping = await tx.lookupOrNull<OAuthUserID>(mappingKey);
        if (mapping != null) {
          deleteKeys.add(mappingKey);
        }
      }

      u
        ..oauthUserId = null
        ..created = null
        ..isDeleted = true;
      tx.queueMutations(inserts: [u], deletes: deleteKeys);
    });
  }

  /// Removes the package from the Datastore and updates other related
  /// entities. It is safe to call [removePackage] on an already removed
  /// package, as the call is idempotent.
  ///
  /// Creates a [ModeratedPackage] instance (if not already present) in
  /// Datastore representing the removed package. No new package with the same
  /// name can be published.
  ///
  /// Verifies the current authenticated user for admin permissions.
  Future<void> removePackage(String packageName) async {
    final caller =
        await requireAuthenticatedAdmin(AdminPermission.removePackage);
    _logger.info('${caller.displayId}) initiated the delete '
        'of package $packageName');
    await _removePackage(packageName);
  }

  /// Removes the package from the Datastore and updates other related
  /// entities. It is safe to call [removePackage] on an already removed
  /// package, as the call is idempotent.
  ///
  /// Creates a [ModeratedPackage] instance (if not already present) in
  /// Datastore representing the removed package. No new package with the same
  /// name can be published.
  Future<void> _removePackage(
    String packageName, {
    DateTime? moderated,
  }) async {
    final packageKey = _db.emptyKey.append(Package, id: packageName);
    final versions = (await _db
            .query<PackageVersion>(ancestorKey: packageKey)
            .run()
            .map((pv) => pv.version!)
            .toList())
        .toSet();

    final pool = Pool(10);
    final futures = <Future>[];
    for (final v in versions) {
      // Deleting public and canonical archives, 404 errors are ignored.
      futures.add(pool.withResource(
          () => packageBackend.removePackageTarball(packageName, v)));
    }
    await Future.wait(futures);
    await pool.close();

    _logger.info('Removing package from Package.replacedBy...');
    final replacedByQuery = _db.query<Package>()
      ..filter('replacedBy =', packageName);
    await for (final pkg in replacedByQuery.run()) {
      await withRetryTransaction(_db, (tx) async {
        final p = await tx.lookupOrNull<Package>(pkg.key);
        if (p == null) {
          return;
        }
        if (p.replacedBy == packageName) {
          p.replacedBy = null;
          tx.insert(p);
        }
      });
    }

    _logger.info('Removing package from PackageVersionInfo ...');
    await _db.deleteWithQuery(
        _db.query<PackageVersionInfo>()..filter('package =', packageName));

    _logger.info('Removing package from PackageVersionAsset ...');
    await _db.deleteWithQuery(
        _db.query<PackageVersionAsset>()..filter('package =', packageName));

    _logger.info('Removing package from Like ...');
    await _db.deleteWithQuery(
        _db.query<Like>()..filter('packageName =', packageName));

    _logger.info('Removing package from AuditLogRecord...');
    await _db.deleteWithQuery(
        _db.query<AuditLogRecord>()..filter('packages =', packageName));

    _logger.info('Removing Package from Datastore...');
    await withRetryTransaction(_db, (tx) async {
      final package = await tx.lookupOrNull<Package>(packageKey);
      if (package == null) {
        _logger
            .info('Package $packageName not found. Removing related elements.');
        // Returning early makes sure we are not creating ghost `ModeratedPackage`
        // entities because of a typo.
        return;
      }
      tx.delete(packageKey);

      final moderatedPkgKey =
          _db.emptyKey.append(ModeratedPackage, id: packageName);
      final moderatedPkg =
          await _db.lookupOrNull<ModeratedPackage>(moderatedPkgKey);
      if (moderatedPkg == null) {
        // Refresh versions to make sure we are not missing a freshly uploaded one.
        versions.addAll(await tx
            .query<PackageVersion>(packageKey)
            .run()
            .map((pv) => pv.version!)
            .toList());

        versions.addAll(package.deletedVersions ?? const <String>[]);

        tx.insert(ModeratedPackage()
          ..parentKey = _db.emptyKey
          ..id = packageName
          ..name = packageName
          ..moderated = moderated ?? clock.now().toUtc()
          ..versions = versions.toList()
          ..publisherId = package.publisherId
          ..uploaders = package.uploaders);

        _logger.info('Adding package to moderated packages ...');
      }
    });

    _logger.info('Removing package from PackageVersion ...');
    await _db
        .deleteWithQuery(_db.query<PackageVersion>(ancestorKey: packageKey));

    _logger.info('Package "$packageName" got successfully removed.');
    _logger.info(
        'NOTICE: Redis caches referencing the package will expire given time.');
  }

  /// Updates the options (e.g. retraction) of the specific package version and
  /// updates other related entities.
  /// It is safe to call [updateVersionOptions] on an version with the same
  /// options values (e.g. same retracted status), as the call is idempotent.
  Future<void> updateVersionOptions(
      String packageName, String version, VersionOptions options) async {
    checkPackageVersionParams(packageName, version);
    InvalidInputException.check(options.isRetracted != null,
        'Only updating "isRetracted" is implemented.');
    final caller =
        await requireAuthenticatedAdmin(AdminPermission.manageRetraction);

    if (options.isRetracted != null) {
      final isRetracted = options.isRetracted!;
      _logger.info('${caller.displayId}) initiated the isRetracted status '
          'of package $packageName $version to be $isRetracted.');

      await withRetryTransaction(_db, (tx) async {
        final p = await tx.lookupOrNull<Package>(
            _db.emptyKey.append(Package, id: packageName));
        if (p == null) {
          throw NotFoundException.resource(packageName);
        }
        final pv = await tx.lookupOrNull<PackageVersion>(
            p.key.append(PackageVersion, id: version));
        if (pv == null) {
          throw NotFoundException.resource(version);
        }

        if (pv.isRetracted != isRetracted) {
          await packageBackend.doUpdateRetractedStatus(
              caller, tx, p, pv, isRetracted);
        }
      });
      await purgePackageCache(packageName);
    }
  }

  /// Removes the specific package version from the Datastore and updates other
  /// related entities. It is safe to call [removePackageVersion] on an already
  /// removed version, as the call is idempotent.
  Future<void> removePackageVersion(String packageName, String version) async {
    final caller =
        await requireAuthenticatedAdmin(AdminPermission.removePackage);

    _logger.info('${caller.displayId}) initiated the delete '
        'of package $packageName $version');

    final currentDartSdk = await getCachedDartSdkVersion(
        lastKnownStable: toolStableDartSdkVersion);
    final currentFlutterSdk = await getCachedFlutterSdkVersion(
        lastKnownStable: toolStableFlutterSdkVersion);
    await withRetryTransaction(_db, (tx) async {
      final packageKey = _db.emptyKey.append(Package, id: packageName);
      final package = await tx.lookupOrNull<Package>(packageKey);
      if (package == null) {
        throw Exception(
            'Package "$packageName" does not exists. Use full package removal without the version qualifier.');
      }

      final versionsQuery = tx.query<PackageVersion>(packageKey);
      final versions = await versionsQuery.run().toList();
      final versionNames = versions.map((v) => v.version).toList();
      if (versionNames.contains(version)) {
        tx.delete(packageKey.append(PackageVersion, id: version));
        package.updated = clock.now().toUtc();
      } else {
        print('Package $packageName does not have a version $version.');
      }

      if (versionNames.length == 1 && versionNames.single == version) {
        throw Exception(
            'Last version detected. Use full package removal without the version qualifier.');
      }

      package.updateVersions(
        versions.where((v) => v.version != version).toList(),
        dartSdkVersion: currentDartSdk.semanticVersion,
        flutterSdkVersion: currentFlutterSdk.semanticVersion,
      );
      package.deletedVersions ??= <String>[];
      if (!package.deletedVersions!.contains(version)) {
        package.deletedVersions!.add(version);
      }

      tx.insert(package);
    });

    print('Removing GCS objects ...');
    await packageBackend.removePackageTarball(packageName, version);

    await _db.deleteWithQuery(
      _db.query<PackageVersionInfo>()..filter('package =', packageName),
      where: (PackageVersionInfo info) => info.version == version,
    );

    await _db.deleteWithQuery(
      _db.query<PackageVersionAsset>()..filter('package =', packageName),
      where: (PackageVersionAsset asset) => asset.version == version,
    );

    await purgePackageCache(packageName);
    await purgeScorecardData(packageName, version, isLatest: true);
    // trigger (eventual) re-analysis
    await taskBackend.trackPackage(packageName);
  }

  /// Handles GET '/api/admin/packages/<package>/assigned-tags'
  ///
  /// Note, this API end-point is intentionally locked down even if it doesn't
  /// return anything secret. This is because the /admin/ section is only
  /// intended to be exposed to administrators. Users can read the assigned-tags
  /// through API that returns list of package tags.
  Future<api.AssignedTags> handleGetAssignedTags(
    String packageName,
  ) async {
    checkPackageVersionParams(packageName);
    await requireAuthenticatedAdmin(AdminPermission.manageAssignedTags);
    final package = await packageBackend.lookupPackage(packageName);
    if (package == null) {
      throw NotFoundException.resource(packageName);
    }

    return api.AssignedTags(
      assignedTags: package.assignedTags!,
    );
  }

  /// Handles POST '/api/admin/packages/<package>/assigned-tags'
  Future<api.AssignedTags> handlePostAssignedTags(
    String packageName,
    api.PatchAssignedTags body,
  ) async {
    await requireAuthenticatedAdmin(AdminPermission.manageAssignedTags);

    InvalidInputException.check(
      body.assignedTagsAdded
          .every((tag) => allowedTagPrefixes.any(tag.startsWith)),
      'Only following tag-prefixes are allowed "${allowedTagPrefixes.join("\", ")}"',
    );
    InvalidInputException.check(
      body.assignedTagsAdded
          .toSet()
          .intersection(body.assignedTagsRemoved.toSet())
          .isEmpty,
      'assignedTagsAdded cannot contain tags also removed assignedTagsRemoved',
    );

    return await withRetryTransaction(_db, (tx) async {
      final package = await tx.lookupOrNull<Package>(_db.emptyKey.append(
        Package,
        id: packageName,
      ));

      if (package == null) {
        throw NotFoundException.resource(packageName);
      }

      if (package.assignedTags!.any(body.assignedTagsRemoved.contains) ||
          !body.assignedTagsAdded.every(package.assignedTags!.contains)) {
        package.assignedTags!
          ..removeWhere(body.assignedTagsRemoved.contains)
          ..addAll(body.assignedTagsAdded);
        package.updated = clock.now().toUtc();
        tx.insert(package);
      }

      return api.AssignedTags(
        assignedTags: package.assignedTags!,
      );
    });
  }

  /// Handles GET '/api/admin/packages/<package>/uploaders'
  ///
  /// Returns the list of uploaders for a package.
  Future<api.PackageUploaders> handleGetPackageUploaders(
    String packageName,
  ) async {
    checkPackageVersionParams(packageName);
    await requireAuthenticatedAdmin(AdminPermission.managePackageOwnership);
    final package = await packageBackend.lookupPackage(packageName);
    if (package == null) {
      throw NotFoundException.resource(packageName);
    }
    InvalidInputException.check(
        package.publisherId == null, 'Package must not be under a publisher.');

    final users = await accountBackend.lookupUsersById(package.uploaders!);
    return api.PackageUploaders(
      uploaders: _convertUsers(users),
    );
  }

  List<api.AdminUserEntry> _convertUsers(Iterable<User?> users) {
    return users.nonNulls
        .where((u) => !u.isDeleted)
        .map(
          (u) => api.AdminUserEntry(
            userId: u.userId,
            oauthUserId: u.oauthUserId,
            email: u.email,
          ),
        )
        .toList();
  }

  /// Handles PUT '/api/admin/packages/<package>/uploaders/<email>'
  ///
  /// Returns the list of uploaders for a package.
  Future<api.PackageUploaders> handleAddPackageUploader(
      String packageName, String email) async {
    checkPackageVersionParams(packageName);
    final authenticatedAgent =
        await requireAuthenticatedAdmin(AdminPermission.managePackageOwnership);
    final package = await packageBackend.lookupPackage(packageName);
    if (package == null) {
      throw NotFoundException.resource(packageName);
    }

    final uploaderEmail = email.toLowerCase();
    InvalidInputException.check(
        isValidEmail(uploaderEmail), 'Not a valid email: `$uploaderEmail`.');

    await consentBackend.invitePackageUploader(
      agent: authenticatedAgent,
      packageName: packageName,
      uploaderEmail: uploaderEmail,
    );
    return await handleGetPackageUploaders(packageName);
  }

  /// Handles DELETE '/api/admin/packages/<package>/uploaders/<email>'
  ///
  /// Returns the list of uploaders for a package.
  Future<api.PackageUploaders> handleRemovePackageUploader(
      String packageName, String email) async {
    checkPackageVersionParams(packageName);
    final authenticatedAgent =
        await requireAuthenticatedAdmin(AdminPermission.managePackageOwnership);
    final package = await packageBackend.lookupPackage(packageName);
    if (package == null) {
      throw NotFoundException.resource(packageName);
    }

    final uploaderEmail = email.toLowerCase();
    InvalidInputException.check(
        isValidEmail(uploaderEmail), 'Not a valid email: `$uploaderEmail`.');
    final uploaderUsers =
        await accountBackend.lookupUsersByEmail(uploaderEmail);
    InvalidInputException.check(uploaderUsers.isNotEmpty,
        'No users found for email: `$uploaderEmail`.');

    await withRetryTransaction(_db, (tx) async {
      final p = await tx.lookupValue<Package>(package.key);
      InvalidInputException.check(
          p.publisherId == null, 'Package must not be under a publisher.');
      var removed = false;
      for (final uploaderUser in uploaderUsers) {
        final r = p.uploaders!.remove(uploaderUser.userId);
        if (r) {
          removed = true;
          tx.insert(await AuditLogRecord.uploaderRemoved(
            agent: authenticatedAgent,
            package: packageName,
            uploaderUser: uploaderUser,
          ));
        }
      }
      if (removed) {
        if (p.uploaders!.isEmpty) {
          p.isDiscontinued = true;
          tx.insert(await AuditLogRecord.packageOptionsUpdated(
            agent: authenticatedAgent,
            package: packageName,
            publisherId: p.publisherId,
            options: ['discontinued'],
          ));
        }
        p.updated = clock.now().toUtc();
        tx.insert(p);
      }
    });
    return await handleGetPackageUploaders(packageName);
  }

  Future<api.AdminListActionsResponse> listActions() async {
    await requireAuthenticatedAdmin(AdminPermission.invokeAction);

    return api.AdminListActionsResponse(
      actions: AdminAction.actions
          .map(
            (action) => api.AdminAction(
              name: action.name,
              summary: action.summary,
              description: action.description,
              options: action.options,
            ),
          )
          .toList(),
    );
  }

  Future<api.AdminInvokeActionResponse> invokeAction(
    String actionName,
    Map<String, String> args,
  ) async {
    await requireAuthenticatedAdmin(AdminPermission.invokeAction);

    final action = AdminAction.actions.firstWhereOrNull(
      (a) => a.name == actionName,
    );
    if (action == null) {
      throw NotFoundException.resource(actionName);
    }

    // Don't allow unknown arguments
    final unknownArgs =
        args.keys.toSet().difference(action.options.keys.toSet());
    InvalidInputException.check(
      unknownArgs.isEmpty,
      'Unknown options: ${unknownArgs.join(',')}',
    );

    final result = await action.invoke({
      for (final k in action.options.keys) k: args[k],
    });

    return api.AdminInvokeActionResponse(output: result);
  }

  Future<ModerationCase?> lookupModerationCase(String caseId) async {
    return await dbService.lookupOrNull<ModerationCase>(
        dbService.emptyKey.append(ModerationCase, id: caseId));
  }

  /// Returns a valid [ModerationCase] if it exists and [status] is matching.
  /// Returns `null` if [caseId] is `none`.
  ///
  /// Throws exceptions otherwise.
  Future<ModerationCase?> loadAndVerifyModerationCaseForAdminAction(
    String? caseId, {
    required String? status,
  }) async {
    InvalidInputException.check(
      caseId != null && caseId.isNotEmpty,
      'case must be given',
    );
    if (caseId == 'none') {
      return null;
    }

    final refCase = await adminBackend.lookupModerationCase(caseId!);
    if (refCase == null) {
      throw NotFoundException.resource(caseId);
    }
    if (status != null && refCase.status != status) {
      throw InvalidInputException(
          'ModerationCase.status ("${refCase.status}") != "$status".');
    }
    return refCase;
  }

  /// Scans datastore and deletes moderated subjects where the last action
  /// was more than 3 years ago.
  Future<void> deleteModeratedSubjects({
    @visibleForTesting DateTime? before,
  }) async {
    before ??= clock.ago(days: 3 * 366).toUtc(); // extra buffer days
    // delete packages
    final pQuery = _db.query<Package>()
      ..filter('moderatedAt <', before)
      ..order('moderatedAt');
    await for (final package in pQuery.run()) {
      // sanity check
      if (!package.isModerated) {
        continue;
      }

      _logger.info('Deleting moderated package: ${package.name}');
      await _removePackage(
        package.name!,
        moderated: package.moderatedAt,
      );
      _logger.info('Deleted moderated package: ${package.name}');
    }

    // delete package versions
    final pvQuery = _db.query<PackageVersion>()
      ..filter('moderatedAt <', before)
      ..order('moderatedAt');
    await for (final version in pvQuery.run()) {
      // sanity check
      if (!version.isModerated) {
        continue;
      }

      _logger.info(
          'Deleting moderated package version: ${version.qualifiedVersionKey}');

      // deleting from canonical bucket
      await packageBackend.packageStorage
          .deleteArchiveFromCanonicalBucket(version.package, version.version!);

      // deleting from datastore
      await withRetryTransaction(_db, (tx) async {
        final pv = await tx.lookupOrNull<PackageVersion>(version.key);
        if (pv == null) {
          return null;
        }
        final p = await tx.lookupOrNull<Package>(version.packageKey!);
        if (p == null) {
          return;
        }
        final pvi = await tx.lookupOrNull<PackageVersionInfo>(_db.emptyKey
            .append(PackageVersionInfo,
                id: version.qualifiedVersionKey.qualifiedVersion));

        p.deletedVersions ??= [];
        p.deletedVersions!.add(version.version!);
        p.deletedVersions!.sort();
        p.updated = clock.now().toUtc();
        tx.insert(p);

        // delete version + info + assets
        tx.delete(pv.key);
        if (pvi != null) {
          tx.delete(pvi.key);

          for (final assetKind in pvi.assets) {
            tx.delete(
              _db.emptyKey.append(PackageVersionAsset,
                  id: Uri(pathSegments: [
                    version.package,
                    version.version!,
                    assetKind
                  ]).path),
            );
          }
        }
      });
      _logger.info(
          'Deleted moderated package version: ${version.qualifiedVersionKey}');
    }

    // delete publishers
    final publisherQuery = _db.query<Publisher>()
      ..filter('moderatedAt <', before)
      ..order('moderatedAt');
    await for (final publisher in publisherQuery.run()) {
      // sanity check
      if (!publisher.isModerated) {
        continue;
      }

      _logger.info('Deleting moderated publisher: ${publisher.publisherId}');

      // removes packages of this publisher, no uploaders will be set, marks discontinued
      final pkgQuery = _db.query<Package>()
        ..filter('publisherId =', publisher.publisherId);
      await for (final pkg in pkgQuery.run()) {
        await withRetryTransaction(_db, (tx) async {
          final p = await tx.lookupOrNull<Package>(pkg.key);
          if (p == null) return;
          if (p.publisherId != publisher.publisherId) return;

          p.publisherId = null;
          p.updated = clock.now().toUtc();
          p.isDiscontinued = true;
          tx.insert(p);
        });
      }

      // removes publisher members
      await _db.deleteWithQuery(
          _db.query<PublisherMember>(ancestorKey: publisher.key));

      // removes publisher entity
      await _db.commit(deletes: [publisher.key]);

      _logger.info('Deleted moderated publisher: ${publisher.publisherId}');
    }

    // mark user instances deleted
    final userQuery = _db.query<User>()
      ..filter('moderatedAt <', before)
      ..order('moderatedAt');
    await for (final user in userQuery.run()) {
      // sanity check
      if (!user.isModerated || user.isDeleted) {
        continue;
      }

      _logger.info('Deleting moderated user: ${user.userId}');
      await _removeUser(user);
      _logger.info('Deleting moderated user: ${user.userId}');
    }
  }

  /// Whether the [ModerationCase] has been appealed by [email] already.
  Future<bool> isModerationCaseAppealedByEmail({
    required String caseId,
    required String email,
  }) async {
    final query = dbService.query<ModerationCase>()
      ..filter('appealedCaseId =', caseId);
    final list = await query.run().toList();
    final emails = list.map((mc) => mc.reporterEmail).toSet();
    return emails.contains(email);
  }
}
