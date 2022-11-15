// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:_pub_shared/search/tags.dart';
import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/storage.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pool/pool.dart';

import '../account/agent.dart';
import '../account/backend.dart';
import '../account/models.dart';
import '../audit/models.dart';
import '../package/backend.dart';
import '../package/model_properties.dart';
import '../package/models.dart';
import '../publisher/models.dart';
import '../tool/utils/http.dart';

import 'configuration.dart';
import 'datastore.dart';
import 'email.dart' show looksLikeEmail;
import 'env_config.dart';
import 'storage.dart';
import 'urls.dart' as urls;
import 'utils.dart' show canonicalizeVersion, ByteArrayEqualsExt;

final _logger = Logger('integrity.check');
final _random = math.Random.secure();

/// Checks the integrity of the datastore.
class IntegrityChecker {
  final DatastoreDB _db;
  final int _concurrency;

  final _userToOauth = <String, String?>{};
  final _oauthToUser = <String, String>{};
  final _deletedUsers = <String>{};
  final _invalidUsers = <String>{};
  final _packages = <String>{};
  final _packageLikes = <String, int>{};
  final _moderatedPackages = <String>{};
  final _packageReplacedBys = <String, String>{};
  final _packagesWithVersion = <String>{};
  final _publishers = <String>{};
  final _publishersAbandoned = <String>{};
  // package name -> versions
  final _badVersionInPubspec = <String, Set<String>>{};
  int _packageChecked = 0;
  int _versionChecked = 0;
  late http.Client _httpClient;

  IntegrityChecker(this._db, {int? concurrency})
      : _concurrency = concurrency ?? 1;

  /// Runs integrity checks, and reports the problems via a [Logger].
  Future<void> verifyAndLogIssues() async {
    var count = 0;
    await for (final problem in findProblems()) {
      count++;
      _logger.warning('[pub-integrity-problem] $problem');
    }
    _logger.info('Integrity check completed with $count issue(s).');
  }

  /// Runs integrity checks, and returns the list of problems.
  Stream<String> findProblems() async* {
    _httpClient = httpRetryClient(lenient: true);
    try {
      yield* _checkUsers();
      yield* _checkOAuthUserIDs();
      yield* _checkPublishers();
      yield* _checkPublisherMembers();
      yield* _checkPackages();
      yield* _checkVersions();
      yield* _checkLikes();
      yield* _checkModeratedPackages();
      yield* _checkAuditLogs();
      yield* _reportPubspecVersionIssues();
    } finally {
      _httpClient.close();
    }
  }

  Stream<String> _checkUsers() async* {
    _logger.info('Scanning Users...');
    final gmailComEmails = <String>{};
    await for (User user in _db.query<User>().run()) {
      if (!isValidUserId(user.userId)) {
        yield 'User has invalid userId: "${user.userId}".';
      }

      _userToOauth[user.userId] = user.oauthUserId;
      final email = user.email;
      if (email == null || email.isEmpty || !looksLikeEmail(email)) {
        yield 'User "${user.userId}" has invalid email: "${user.email}".';
        _invalidUsers.add(user.userId);
      }

      // We can have email addresses that have multiple account (also User and
      // OAuthUserId entities), because at one point they have closed their account,
      // and somebody (maybe the same person) later re-created one with the given email.
      //
      // This is considered normal for non-gmail.com accounts, but should be impossible
      // for gmail.com accounts, as they cannot be recreated.
      if (email != null &&
          email.endsWith('@gmail.com') &&
          !gmailComEmails.add(email)) {
        yield 'Email address "$email" is present at "${user.userId}" and another Users.';
      }

      if (user.isDeleted) {
        _deletedUsers.add(user.userId);
        if (user.oauthUserId != null) {
          yield 'User "${user.userId}" is deleted, but `oauthUserId` is still set.';
        }
        if (user.created != null) {
          yield 'User "${user.userId}" is deleted, but `created` time is still set.';
        }
      }

      if (user.oauthUserId == null &&
          user.created != null &&
          user.created!.isAfter(DateTime(2022, 1, 1))) {
        yield 'User "${user.userId}" is recently created, but has no `oauthUserId`.';
      }
    }
  }

  Stream<String> _checkOAuthUserIDs() async* {
    _logger.info('Scanning OAuthUserIDs...');
    await for (OAuthUserID mapping in _db.query<OAuthUserID>().run()) {
      if (mapping.userIdKey == null) {
        yield 'OAuthUserID "${mapping.oauthUserId}" has no `userId`.';
      } else {
        if (!isValidUserId(mapping.userId)) {
          yield 'OAuthUserID "${mapping.oauthUserId}" has invalid `userId`: "${mapping.userId}".';
        }
        _oauthToUser[mapping.oauthUserId] = mapping.userId;
      }
    }

    for (final userId in _userToOauth.keys) {
      final oauthUserId = _userToOauth[userId];
      // Migrated users without login are OK.
      if (oauthUserId == null) {
        continue;
      }
      final pointer = _oauthToUser[oauthUserId];
      if (pointer == null) {
        yield 'User "$userId" points to OAuthUserID "$oauthUserId" but has no mapping.';
      } else if (pointer != userId) {
        yield 'User "$userId" points to OAuthUserID "$oauthUserId" but it points to a different one ("$pointer").';
      }
    }

    for (final oauthUserId in _oauthToUser.keys) {
      final userId = _oauthToUser[oauthUserId];
      if (userId == null) {
        yield 'OAuthUserID "$oauthUserId" has no User.';
        continue;
      }
      // make sure we have the latest userId -> oauthUserId mapping
      await _userExists(userId);
      // check mapping
      final pointer = _userToOauth[userId];
      if (pointer == null) {
        yield 'User "$userId" is mapped from OAuthUserID "$oauthUserId", but does not have it set.';
      } else if (pointer != oauthUserId) {
        yield 'User "$userId" is mapped from OAuthUserID "$oauthUserId", but points to a different one ("$pointer").';
      }
    }
  }

  Stream<String> _checkPublishers() async* {
    _logger.info('Scanning Publishers...');
    await for (final p in _db.query<Publisher>().run()) {
      _publishers.add(p.publisherId);
      final members =
          await _db.query<PublisherMember>(ancestorKey: p.key).run().toList();
      if (p.isAbandoned) {
        _publishersAbandoned.add(p.publisherId);
        // all members must be blocked
        for (final member in members) {
          final user = await accountBackend.lookupUserById(member.userId!);
          if (user != null && !user.isBlocked) {
            yield 'Publisher "${p.publisherId}" is marked as abandoned, '
                'but has non-blocked member ("${member.userId}" - "${user.email}").';
          }
        }
        if (members.isEmpty && p.contactEmail != null) {
          yield 'Publisher "${p.publisherId}" is marked as abandoned, has no members, '
              'but still has contact email ("${p.contactEmail}").';
        }
      } else {
        if (members.isEmpty) {
          yield 'Publisher "${p.publisherId}" has no members, but it is not marked as abandoned.';
        }
      }
    }
  }

  Stream<String> _checkPublisherMembers() async* {
    _logger.info('Scanning PublisherMembers...');
    await for (final pm in _db.query<PublisherMember>().run()) {
      if (pm.id != pm.userId) {
        yield 'PublisherMember "${pm.id}" has bad `userId` value: "${pm.userId}".';
      }
      if (!_publishers.contains(pm.publisherId)) {
        yield 'PublisherMember "${pm.userId}" references a non-existing `publisherId`: "${pm.publisherId}".';
      }
      if (pm.userId == null) {
        yield 'PublisherMember of "${pm.publisherId}" has no `userId`.';
      } else {
        yield* _checkUserValid(
          pm.userId!,
          entityType: 'PublisherMember',
          entityId: '${pm.publisherId} / ${pm.userId}',
        );
      }
    }
  }

  Stream<String> _checkPackages() async* {
    _logger.info('Scanning Packages...');
    final pool = Pool(_concurrency);
    final futures = <Future<List<String>>>[];
    await for (final p in _db.query<Package>().run()) {
      final f = pool.withResource(() => _checkPackage(p).toList());
      futures.add(f);
    }
    for (final f in futures) {
      for (final item in await f) {
        yield item;
      }
    }
    await pool.close();

    for (final r in _packageReplacedBys.entries) {
      if (await _packageMissing(r.value)) {
        yield 'Package "${r.key}" has a `replacedBy` property with missing package "${r.value}".';
      }
    }
  }

  Stream<String> _checkPackage(Package p) async* {
    if (p.name == null) {
      yield 'Package "${p.id}" has a `name` property which is null.';
    } else if (p.name != p.id) {
      yield 'Package "${p.id}" has a `name` property which is not the same as the id.';
    } else {
      _packages.add(p.name!);
    }
    if (p.replacedBy != null) {
      _packageReplacedBys[p.name!] = p.replacedBy!;

      if (!p.isDiscontinued) {
        yield 'Package "${p.name}" has a `replacedBy` property without being `isDiscontinued`.';
      }
    }
    // empty uploaders
    if (p.uploaders == null || p.uploaders!.isEmpty) {
      // no publisher
      if (p.publisherId == null && !p.isBlocked && !p.isDiscontinued) {
        yield 'Package "${p.name}" has no uploaders, must be marked discontinued.';
      }

      if (p.publisherId != null &&
          _publishersAbandoned.contains(p.publisherId) &&
          !p.isBlocked &&
          !p.isDiscontinued) {
        yield 'Package "${p.name}" has an abandoned publisher, must be marked discontinued.';
      }
    }
    if (p.assignedTags == null || p.assignedTags is! List<String>) {
      yield 'Package "${p.name}" has an `assignedTags` property which is not a list.';
    }
    final assignedTags = p.assignedTags ?? <String>[];
    for (final tag in assignedTags) {
      if (!allowedTagPrefixes.any(tag.startsWith)) {
        yield 'Package "${p.name}" has assigned tag "$tag" in `assignedTags` '
            'property, which is not allowed.';
      }
    }
    if (assignedTags.length != assignedTags.toSet().length) {
      yield 'Package "${p.name}" has an `assignedTags` property which contains duplicates.';
    }
    if (p.likes < 0) {
      yield 'Package "${p.name}" has a `likes` property which is not a non-negative integer.';
    }
    _packageLikes[p.name!] = p.likes;
    final uploaders = p.uploaders;
    if (uploaders != null) {
      for (final userId in uploaders) {
        yield* _checkUserValid(
          userId,
          entityType: 'Package',
          entityId: p.name,
        );
      }
    }
    if (p.deletedVersions != null) {
      // make sure we store valid versions here
      for (final v in p.deletedVersions!) {
        final c = canonicalizeVersion(v);
        if (c == null) {
          yield 'Package "{p.name}" has invalid deleted version "$v".';
        }
      }
    }
    final versionKeys = <Key>{};
    final qualifiedVersionKeys = <QualifiedVersionKey>{};
    int versionCountUntilLastPublished = 0;
    await for (final pv
        in _db.query<PackageVersion>(ancestorKey: p.key).run()) {
      versionKeys.add(pv.key);
      qualifiedVersionKeys.add(pv.qualifiedVersionKey);
      if (p.deletedVersions != null &&
          p.deletedVersions!.contains(pv.version!)) {
        yield 'PackageVersion "${pv.qualifiedVersionKey}" exists, but is marked as deleted in Package "${p.name}".';
      }
      // Count only the versions that were created before the last published timestamp,
      // to prevent false alarms that could happing if a new version is being published
      // while the integrity check is running.
      if (!pv.created!.isAfter(p.lastVersionPublished!)) {
        versionCountUntilLastPublished++;
      }
    }
    if (p.versionCount != versionCountUntilLastPublished) {
      yield 'Package "${p.name}" has `versionCount` (${p.versionCount}) that differs from the '
          'number of versions until the last published date ($versionCountUntilLastPublished). '
          'Total number of versions: ${versionKeys.length}.';
    }
    if (p.lastVersionPublished == null) {
      yield 'Package "${p.name}" has a `lastVersionPublished` property which is null.';
    }
    if (p.latestPublished == null) {
      yield 'Package "${p.name}" has a `latestPublished` property which is null.';
    }
    if (p.latestPrereleasePublished == null) {
      yield 'Package "${p.name}" has a `latestPrereleasePublished` property which is null.';
    }
    if (p.latestPreviewPublished == null) {
      yield 'Package "${p.name}" has a `latestPreviewPublished` property which is null.';
    }
    if (p.lastVersionPublished != null &&
        p.latestPublished != null &&
        p.lastVersionPublished!.isBefore(p.latestPreviewPublished!)) {
      yield 'Package "${p.name}" has a `lastVersionPublished` property which is before its `latestPublished`.';
    }
    if (p.lastVersionPublished != null &&
        p.latestPrereleasePublished != null &&
        p.lastVersionPublished!.isBefore(p.latestPrereleasePublished!)) {
      yield 'Package "${p.name}" has a `lastVersionPublished` property which is before its `latestPrereleasePublished`. (${p.latestVersion} ${p.latestPrereleaseVersion}, ${p.lastVersionPublished} - ${p.latestPrereleasePublished})';
    }
    if (p.lastVersionPublished != null &&
        p.latestPreviewPublished != null &&
        p.lastVersionPublished!.isBefore(p.latestPreviewPublished!)) {
      yield 'Package "${p.name}" has a `lastVersionPublished` property which is before its `latestPreviewPublished`.';
    }

    if (p.latestVersionKey == null) {
      yield 'Package "${p.name}" has a `latestVersionKey` property which is null.';
    } else if (!versionKeys.contains(p.latestVersionKey)) {
      'Package "${p.name}" has missing `latestVersionKey`: "${p.latestVersionKey!.id}".';
    }
    if (p.latestPrereleaseVersionKey == null) {
      yield 'Package "${p.name}" has a `latestPrereleaseVersionKey` property which is null.';
    } else if (!versionKeys.contains(p.latestPrereleaseVersionKey)) {
      yield 'Package "${p.name}" has missing `latestPrereleaseVersionKey`: "${p.latestPrereleaseVersionKey!.id}".';
    }
    if (p.latestPreviewVersionKey == null) {
      yield 'Package "${p.name}" has a `latestPreviewVersionKey` property which is null.';
    } else if (!versionKeys.contains(p.latestPreviewVersionKey)) {
      yield 'Package "${p.name}" has missing `latestPreviewVersionKey`: "${p.latestPreviewVersionKey!.id}".';
    }

    // Checking if PackageVersionInfo is referenced by a PackageVersion entity.
    final pviQuery = _db.query<PackageVersionInfo>()
      ..filter('package =', p.name);
    final pviKeys = <QualifiedVersionKey>{};
    final referencedAssetIds = <String>[];

    Stream<String> checkPackageVersionKey(
        String entityType, QualifiedVersionKey key) async* {
      if (!qualifiedVersionKeys.contains(key)) {
        final pv = await packageBackend.lookupPackageVersion(
            key.package!, key.version!);
        if (pv == null) {
          yield '$entityType "$key" has no PackageVersion.';
        } else {
          qualifiedVersionKeys.add(key);
        }
      }
    }

    await for (PackageVersionInfo pvi in pviQuery.run()) {
      final key = pvi.qualifiedVersionKey;
      pviKeys.add(key);
      yield* checkPackageVersionKey('PackageVersionInfo', key);
      if (pvi.versionCreated == null) {
        yield 'PackageVersionInfo "$key" has a `versionCreated` property which is null.';
      }
      if (pvi.updated == null) {
        yield 'PackageVersionInfo "$key" has an `updated` property which is null.';
      }
      if (pvi.libraryCount == null) {
        yield 'PackageVersionInfo "$key" has a `libraryCount` property which is null.';
      }
      for (final kind in pvi.assets) {
        referencedAssetIds.add(key.assetId(kind));
      }
    }
    for (QualifiedVersionKey key in qualifiedVersionKeys) {
      if (!pviKeys.contains(key)) {
        yield 'PackageVersion "$key" has no PackageVersionInfo.';
      }
    }

    // Checking if PackageVersionAsset is referenced by a PackageVersion entity.
    final pvaQuery = _db.query<PackageVersionAsset>()
      ..filter('package =', p.name);
    final foundAssetIds = <String?>{};
    await for (PackageVersionAsset pva in pvaQuery.run()) {
      final key = pva.qualifiedVersionKey;
      if (pva.id !=
          Uri(pathSegments: [pva.package!, pva.version!, pva.kind!]).path) {
        yield 'PackageVersionAsset "${pva.id}" uses old id format.';
        continue;
      }
      yield* checkPackageVersionKey('PackageVersionAsset', key);
      foundAssetIds.add(pva.assetId);
      // check if PackageVersionAsset is referenced in PackageVersionInfo
      if (!referencedAssetIds.contains(pva.assetId)) {
        yield 'PackageVersionAsset "${pva.id}" is not referenced from PackageVersionInfo.';
      }
      // check pubspec content
      if (pva.kind == AssetKind.pubspec) {
        try {
          final pubspec = Pubspec.fromYaml(pva.textContent!);
          if (pubspec.hasBadVersionFormat) {
            _badVersionInPubspec
                .putIfAbsent(p.name!, () => <String>{})
                .add(pva.version!);
          }
        } catch (e) {
          yield 'PackageVersionAsset "${pva.id}" "pubspec" has parse error: $e.';
        }
      }
    }

    // check if all of PackageVersionInfo.assets exist
    for (final id in referencedAssetIds) {
      if (!foundAssetIds.contains(id)) {
        yield 'PackageVersionAsset "$id" is referenced from PackageVersionInfo but does not exist.';
      }
    }

    _packageChecked++;
    if (_packageChecked % 200 == 0) {
      _logger.info('  .. $_packageChecked done (${p.name})');
    }
  }

  Stream<String> _checkVersions() async* {
    _logger.info('Scanning PackageVersions...');
    await for (PackageVersion pv in _db.query<PackageVersion>().run()) {
      yield* _checkPackageVersion(pv);
    }

    for (final package in _packages
        .where((package) => !_packagesWithVersion.contains(package))) {
      yield 'Package "$package" has no version.';
    }
    for (final package in _packagesWithVersion) {
      if (await _packageMissing(package)) {
        yield 'Package "$package" is missing.';
      }
    }
  }

  Stream<String> _checkPackageVersion(PackageVersion pv) async* {
    final archiveDownloadUri = Uri.parse(urls.pkgArchiveDownloadUrl(
        pv.package, pv.version!,
        baseUri: activeConfiguration.primaryApiUri));
    _packagesWithVersion.add(pv.package);

    if (pv.uploader == null) {
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has no uploader.';
    } else {
      yield* _checkAgentValid(
        pv.uploader!,
        entityType: 'PackageVersion',
        entityId: pv.qualifiedVersionKey.toString(),
        isRetainedRecord: true,
      );
    }
    if (pv.isRetracted && pv.retracted == null) {
      yield 'PackageVersion "${pv.qualifiedVersionKey}" is retracted, but `retracted` property is null.';
    }
    if (!envConfig.isRunningLocally) {
      final info =
          await packageBackend.packageTarballinfo(pv.package, pv.version!);
      if (info == null) {
        yield 'PackageVersion "${pv.qualifiedVersionKey}" has no matching archive file.';
      }
      final canonicalInfo = await storageService
          .bucket(activeConfiguration.canonicalPackagesBucketName!)
          // ignore: invalid_use_of_visible_for_testing_member
          .tryInfo(tarballObjectName(pv.package, pv.version!));

      if (canonicalInfo != null) {
        if (!canonicalInfo.hasSameSignatureAs(info)) {
          yield 'Canonical archive for PackageVersion "${pv.qualifiedVersionKey}" differs in old bucket.';
        }

        final publicInfo = await storageService
            .bucket(activeConfiguration.publicPackagesBucketName!)
            // ignore: invalid_use_of_visible_for_testing_member
            .tryInfo(tarballObjectName(pv.package, pv.version!));
        if (!canonicalInfo.hasSameSignatureAs(publicInfo)) {
          yield 'Canonical archive for PackageVersion "${pv.qualifiedVersionKey}" differs in the public bucket.';
        }
      }

      // Also issue a HTTP request.
      final rs = await _httpClient.head(archiveDownloadUri);
      if (rs.statusCode != 200) {
        yield 'PackageVersion "${pv.qualifiedVersionKey}" has no matching archive file (HTTP status ${rs.statusCode}).';
      }
    }

    // TODO: remove null check after the backfill should have filled the property.
    final sha256Hash = pv.sha256;
    if (sha256Hash == null || sha256Hash.length != 32) {
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has invalid sha256.';
    } else if (_random.nextInt(1000) == 0) {
      // Do not check every archive all the time, but select a few of the archives randomly.
      final bytes = (await _httpClient.get(archiveDownloadUri)).bodyBytes;
      final hash = sha256.convert(bytes).bytes;
      if (!hash.byteToByteEquals(sha256Hash)) {
        yield 'PackageVersion "${pv.qualifiedVersionKey}" has sha256 hash mismatch.';
      }
    }

    // Sanity checks for the `created` property
    if (pv.created == null) {
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has no `created` property.';
    } else if (pv.created!.isAfter(clock.now().add(Duration(minutes: 15)))) {
      // Can't be published in the future (+15 min to allow for clock drift).
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has `created` > now().';
    } else if (pv.created!.isBefore(DateTime(2011))) {
      // Can't be published before Dart, which was first published in 2011.
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has `created` < 2011.';
    }

    if (pv.pubspec == null) {
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has no `pubspec` property.';
    } else if (pv.pubspec!.hasBadVersionFormat) {
      _badVersionInPubspec
          .putIfAbsent(pv.package, () => <String>{})
          .add(pv.version!);
    }

    _versionChecked++;
    if (_versionChecked % 5000 == 0) {
      _logger.info('  .. $_versionChecked done (${pv.qualifiedVersionKey})');
    }
  }

  Stream<String> _checkLikes() async* {
    _logger.info('Scanning Likes...');

    final counts = <String, int>{};
    await for (final like in _db.query<Like>().run()) {
      if (like.packageName == null) {
        yield 'Like entity for user "${like.userId}" and package "${like.package}" has a '
            '`packageName` property which is not a string.';
      } else if (like.packageName != like.package) {
        yield 'Like entity for user "${like.userId}" and package "${like.package}"'
            ' has a `packageName` property which is not the same as `package`/`id`.';
      }

      yield* _checkUserValid(like.userId, entityType: 'Like');

      if (await _packageMissing(like.package)) {
        yield 'User "${like.userId}" likes missing package "${like.package}".';
      }

      counts[like.package] = (counts[like.package] ?? 0) + 1;
    }

    final allPackages = <String>{
      ..._packageLikes.keys,
      ...counts.keys,
    };
    for (final package in allPackages) {
      final counted = counts[package] ?? 0;
      final originalStored = _packageLikes[package] ?? 0;
      if (counted == originalStored) {
        continue;
      }

      final p = await packageBackend.lookupPackage(package);
      final updatedStored = p!.likes;
      if (counted == updatedStored) {
        continue;
      }

      final diff = counted - updatedStored;

      // Allowing some difference to attribute for the likes created or removed
      // between the package reads and the current counts.
      if (diff.abs() <= math.max(3, counted * 0.10)) {
        continue;
      }

      yield 'Package "$package" has like count difference: observed: $counted != stored: $updatedStored.';
    }
  }

  Stream<String> _checkModeratedPackages() async* {
    _logger.info('Scanning ModeratedPackages...');

    await for (final pkg in _db.query<ModeratedPackage>().run()) {
      final packageName = pkg.name!;
      _moderatedPackages.add(packageName);
      if (await _packageExists(packageName)) {
        yield 'Moderated package "$packageName" also present in active packages.';
      }
    }
  }

  Stream<String> _checkAuditLogs() async* {
    _logger.info('Scanning AuditLogRecords...');

    await for (final record in _db.query<AuditLogRecord>().run()) {
      yield* _checkAuditLogRecord(record);
    }
  }

  Stream<String> _checkAuditLogRecord(AuditLogRecord r) async* {
    yield* _checkAgentValid(
      r.agent!,
      entityType: 'AuditLogRecord',
      entityId: r.id,
      isRetainedRecord: r.isNotExpired,
    );

    final users = r.users;
    if (users == null || users.isEmpty) {
      if (isKnownServiceAgent(r.agent!)) {
        // agent-initiated log records may not have users
      } else {
        yield 'AuditLogRecord "${r.id}" has no users.';
      }
    } else {
      for (final u in users) {
        yield* _checkUserValid(
          u,
          entityType: 'AuditLogRecord',
          entityId: r.id,
          isRetainedRecord: r.isNotExpired,
        );
      }
    }

    for (final p in r.packages ?? const <String>[]) {
      if (!_moderatedPackages.contains(p) && await _packageMissing(p)) {
        yield 'AuditLogRecord "${r.id}" has missing package "$p".';
      }
    }

    for (final pv in r.packageVersions ?? const <String>[]) {
      final parts = pv.split('/');
      if (parts.length != 2) {
        yield 'AuditLogRecord "${r.id}" has invalid package version "$pv".';
        continue;
      }
      final p = parts[0];
      if (!_moderatedPackages.contains(p) && await _packageMissing(p)) {
        yield 'AuditLogRecord "${r.id}" has missing package "$p" in package version "$pv".';
      }
    }
  }

  Stream<String> _checkAgentValid(
    String agent, {
    required String entityType,
    String? entityId,

    /// Set true for entries where we retain the record indefintely,
    /// even if the [User] has been deleted or invalidated.
    bool isRetainedRecord = false,
  }) async* {
    final label =
        entityId == null ? '$entityType entity' : '$entityType "$entityId"';
    if (!isValidUserIdOrServiceAgent(agent)) {
      yield '$label references an invalid agent: "$agent".';
    }
    if (isValidUserId(agent)) {
      yield* _checkUserValid(
        agent,
        entityType: entityType,
        entityId: entityId,
        isRetainedRecord: isRetainedRecord,
      );
    }
  }

  Stream<String> _checkUserValid(
    String userId, {
    required String entityType,
    String? entityId,

    /// Set true for entries where we retain the record indefintely,
    /// even if the [User] has been deleted or invalidated.
    bool isRetainedRecord = false,
  }) async* {
    final label =
        entityId == null ? '$entityType entity' : '$entityType "$entityId"';
    if (!isValidUserId(userId)) {
      yield '$label references an invalid userId: "$userId".';
    }
    if (!(await _userExists(userId))) {
      yield '$label references a nonexisting User: "$userId".';
    }
    if (!isRetainedRecord && _deletedUsers.contains(userId)) {
      yield '$label references a deleted User "$userId".';
    }
    if (_invalidUsers.contains(userId)) {
      yield '$label references an invalid User: "$userId".';
    }
  }

  Future<bool> _userExists(String userId) async {
    if (_userToOauth.containsKey(userId)) {
      return true;
    }
    final user =
        await _db.lookupOrNull<User>(_db.emptyKey.append(User, id: userId));
    if (user == null) {
      return false;
    }
    _userToOauth[user.userId] = user.oauthUserId;
    return true;
  }

  Future<bool> _packageExists(String packageName) async {
    if (_packages.contains(packageName)) {
      return true;
    }
    // There is a chance that the package was first published
    // after the integrity check started, and it would be missing
    // from the pre-populated set. Doing a second lookup to make
    // sure of the existence of the package.
    final p = await packageBackend.lookupPackage(packageName);
    if (p != null) {
      _packages.add(packageName);
      return true;
    }
    return false;
  }

  Future<bool> _packageMissing(String packageName) async =>
      !(await _packageExists(packageName));

  Stream<String> _reportPubspecVersionIssues() async* {
    for (final String package in _badVersionInPubspec.keys) {
      final values = _badVersionInPubspec[package]!.toList()..sort();
      // report the number of versions affected, plus the first 10 versions
      yield [
        'Bad version format in pubspec for package "$package" ${values.length} versions: ',
        '${values.take(10).map((s) => '"$s"').join(', ')}',
        if (values.length > 10) ' and more.'
      ].join();
    }
  }
}
