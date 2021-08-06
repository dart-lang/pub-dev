// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pool/pool.dart';

import '../account/models.dart';
import '../package/models.dart';
import '../publisher/models.dart';
import '../shared/datastore.dart';
import '../shared/tags.dart' show allowedTagPrefixes;
import '../shared/utils.dart' show LoggerExt;

import 'email.dart' show looksLikeEmail;

final _logger = Logger('integrity.check');

/// Checks the integrity of the datastore.
class IntegrityChecker {
  final DatastoreDB _db;
  final int _concurrency;

  final _userToOauth = <String, String?>{};
  final _oauthToUser = <String, String>{};
  final _deletedUsers = <String>{};
  final _invalidUsers = <String>{};
  final _packages = <String>{};
  final _packageReplacedBys = <String, String>{};
  final _packagesWithVersion = <String>{};
  final _publishers = <String>{};
  final _publishersAbandoned = <String>{};
  int _packageChecked = 0;
  int _versionChecked = 0;

  IntegrityChecker(this._db, {int? concurrency})
      : _concurrency = concurrency ?? 1;

  /// Runs integrity checks, and reports the problems via a [Logger].
  Future<void> verifyAndLogIssues() async {
    var count = 0;
    await for (final problem in findProblems()) {
      count++;
      _logger.reportError(problem);
    }
    _logger.info('Integrity check completed with $count issue(s).');
  }

  /// Runs integrity checks, and returns the list of problems.
  Stream<String> findProblems() async* {
    yield* _checkUsers();
    yield* _checkOAuthUserIDs();
    yield* _checkPublishers();
    yield* _checkPublisherMembers();
    yield* _checkPackages();
    yield* _checkVersions();
    yield* _checkLikes();
    yield* _checkModeratedPackages();
  }

  Stream<String> _checkUsers() async* {
    _logger.info('Scanning Users...');
    final gmailComEmails = <String>{};
    await for (User user in _db.query<User>().run()) {
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

      if (user.isDeleted is! bool) {
        yield 'User "${user.userId}" has an `isDeleted` property which is not a bool.';
      }
      if (user.isBlocked is! bool) {
        yield 'User "${user.userId}" has an `isBlocked` property which is not a bool.';
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
    }
  }

  Stream<String> _checkOAuthUserIDs() async* {
    _logger.info('Scanning OAuthUserIDs...');
    await for (OAuthUserID mapping in _db.query<OAuthUserID>().run()) {
      if (mapping.userIdKey == null) {
        yield 'OAuthUserID "${mapping.oauthUserId}" has invalid `userId`.';
      } else {
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
      }
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
      if (p.isAbandoned!) {
        _publishersAbandoned.add(p.publisherId);
        if (members.isNotEmpty) {
          yield 'Publisher "${p.publisherId}" is marked as abandoned, '
              'but has members (first: "${members.first.userId}").';
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
      if (_deletedUsers.contains(pm.userId)) {
        yield 'PublisherMember "${pm.publisherId}" / "${pm.userId}" references a deleted User.';
      }
      if (!_userToOauth.containsKey(pm.userId)) {
        yield 'PublisherMember "${pm.publisherId}" / "${pm.userId}" references a non-existing User.';
      }
    }
  }

  Stream<String> _checkPackages() async* {
    _logger.info('Scanning Packages...');
    final pool = Pool(_concurrency);
    final futures = <Future<List<String>>>[];
    await for (Package p in _db.query<Package>().run()) {
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
      if (p.publisherId == null && !p.isDiscontinued) {
        yield 'Package "${p.name}" has no uploaders, must be marked discontinued.';
      }

      if (p.publisherId != null &&
          _publishersAbandoned.contains(p.publisherId) &&
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
    if (p.likes is! int || p.likes < 0) {
      yield 'Package "${p.name}" has a `likes` property which is not a non-negative integer.';
    }
    if (p.isDiscontinued is! bool) {
      yield 'Package "${p.name}" has an `isDiscontinued` property which is not a bool.';
    }
    if (p.isUnlisted is! bool) {
      yield 'Package "${p.name}" has an `isUnlisted` property which is not a bool.';
    }
    if (p.isWithheld is! bool) {
      yield 'Package "${p.name}" has an `isWithheld` property which is not a bool.';
    }
    for (String? userId in p.uploaders!) {
      if (!_userToOauth.containsKey(userId)) {
        yield 'Package "${p.name}" has uploader without User: "$userId".';
      }
      if (_invalidUsers.contains(userId)) {
        yield 'Package "${p.name}" has invalid uploader: "$userId".';
      }
    }
    final versionKeys = <Key>{};
    final qualifiedVersionKeys = <QualifiedVersionKey>{};
    await for (final pv
        in _db.query<PackageVersion>(ancestorKey: p.key).run()) {
      versionKeys.add(pv.key);
      qualifiedVersionKeys.add(pv.qualifiedVersionKey);
      if (pv.uploader == null) {
        yield 'PackageVersion "${pv.qualifiedVersionKey}" has no uploader.';
      }
      if (!_userToOauth.containsKey(pv.uploader)) {
        yield 'PackageVersion "${pv.qualifiedVersionKey}" has uploader without User: "${pv.uploader}".';
      }
      if (_invalidUsers.contains(pv.uploader)) {
        yield 'PackageVersion "${pv.qualifiedVersionKey}" has invalid uploader: User "${pv.uploader}".';
      }
    }
    if (p.lastVersionPublished == null) {
      yield 'Package "${p.name}" has an `lastVersionPublished` property which is null.';
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

    // Checking if PackageVersionInfo is referenced by a PackageVersion entity.
    final pviQuery = _db.query<PackageVersionInfo>()
      ..filter('package =', p.name);
    final pviKeys = <QualifiedVersionKey>{};
    final referencedAssetIds = <String>[];
    await for (PackageVersionInfo pvi in pviQuery.run()) {
      final key = pvi.qualifiedVersionKey;
      pviKeys.add(key);
      if (!qualifiedVersionKeys.contains(key)) {
        yield 'PackageVersionInfo "$key" has no PackageVersion.';
      }
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
      if (!qualifiedVersionKeys.contains(key)) {
        yield 'PackageVersionAsset "${pva.id}" has no PackageVersion.';
      }
      foundAssetIds.add(pva.assetId);
      // check if PackageVersionAsset is referenced in PackageVersionInfo
      if (!referencedAssetIds.contains(pva.assetId)) {
        yield 'PackageVersionAsset "${pva.id}" is not referenced from PackageVersionInfo.';
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
    _packagesWithVersion.add(pv.package);

    if (pv.uploader == null) {
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has no uploader.';
    }

    // Sanity checks for the `created` property
    if (pv.created == null) {
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has no `created` property.';
    } else if (pv.created!.isAfter(DateTime.now().add(Duration(minutes: 15)))) {
      // Can't be published in the future (+15 min to allow for clock drift).
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has `created` > now().';
    } else if (pv.created!.isBefore(DateTime(2011))) {
      // Can't be published before Dart, which was first published in 2011.
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has `created` < 2011.';
    }

    _versionChecked++;
    if (_versionChecked % 5000 == 0) {
      _logger.info('  .. $_versionChecked done (${pv.qualifiedVersionKey})');
    }
  }

  Stream<String> _checkLikes() async* {
    _logger.info('Scanning Likes...');

    await for (final like in _db.query<Like>().run()) {
      if (like.packageName == null) {
        yield 'Like entity for user "${like.userId}" and package "${like.package}" has a '
            '`packageName` property which is not a string.';
      } else if (like.packageName != like.package) {
        yield 'Like entity for user "${like.userId}" and package "${like.package}"'
            ' has a `packageName` property which is not the same as `package`/`id`.';
      }

      final userId = like.userId;
      if (!_userToOauth.keys.contains(userId)) {
        yield 'Like entity with nonexisting user "$userId".';
      }
      if (_deletedUsers.contains(userId)) {
        yield 'Like entity with deleted user "$userId".';
      }

      if (await _packageMissing(like.package)) {
        yield 'User "$userId" likes missing package "${like.package}".';
      }
    }
  }

  Stream<String> _checkModeratedPackages() async* {
    _logger.info('Scanning ModeratedPackages...');

    await for (final pkg in _db.query<ModeratedPackage>().run()) {
      final packageName = pkg.name!;
      if (await _packageExists(packageName)) {
        yield 'Moderated package "$packageName" also present in active packages.';
      }
    }
  }

  Future<bool> _packageExists(String packageName) async {
    return _packages.contains(packageName);
  }

  Future<bool> _packageMissing(String packageName) async =>
      !(await _packageExists(packageName));
}
