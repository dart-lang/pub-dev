// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:_pub_shared/search/tags.dart';
import 'package:_pub_shared/utils/http.dart';
import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pool/pool.dart';
import 'package:retry/retry.dart';

import '../account/agent.dart';
import '../account/models.dart';
import '../admin/models.dart';
import '../audit/models.dart';
import '../package/backend.dart';
import '../package/model_properties.dart';
import '../package/models.dart';
import '../publisher/backend.dart';
import '../publisher/models.dart';
import '../service/email/email_templates.dart'
    show isValidEmail, looksLikeEmail;
import '../shared/env_config.dart';
import 'configuration.dart';
import 'datastore.dart';
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
  final _blockedUsers = <String>{};
  final _packages = <String>{};
  final _packageLikes = <String, int>{};
  final _moderatedPackages = <String>{};
  final _packagesWithIsModeratedFlag = <String>{};
  final _packageReplacedBys = <String, String>{};
  final _packagesWithVersion = <String>{};
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
    _logger.info([
      'Integrity check completed with $count issue(s).',
      if (count == 0) '[pub-integrity-no-problems-found]',
    ].join(' '));
  }

  /// Runs integrity checks, and returns the list of problems.
  Stream<String> findProblems() async* {
    _httpClient = httpRetryClient(lenient: true);
    try {
      yield* _checkUsers();
      yield* _checkOAuthUserIDs();

      final publisherAttributes = _PublisherAttributes();
      yield* _checkPublishers(publisherAttributes);
      yield* _checkPublisherMembers(publisherAttributes);
      yield* _checkPublishersAfterMembers(publisherAttributes);
      yield* _checkPackages(publisherAttributes: publisherAttributes);
      publisherAttributes.clear(); // no longer used

      yield* _checkVersions();
      yield* _checkLikes();
      yield* _checkModeratedPackages();
      yield* _checkAuditLogs();
      yield* _checkModerationCases();
      yield* _reportPubspecVersionIssues();
      // TODO: report unmapped properties
    } finally {
      _httpClient.close();
    }
  }

  Stream<String> _checkUsers() async* {
    _logger.info('Scanning Users...');
    final gmailComEmails = <String>{};
    yield* _queryWithPool<User>((user) async* {
      if (!looksLikeUserId(user.userId)) {
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

      if (user.isNotVisible) {
        _blockedUsers.add(user.userId);
      }

      yield* _checkModeratedFlags(
        kind: 'User',
        id: user.userId,
        isModerated: user.isModerated,
        moderatedAt: user.moderatedAt,
      );
    });
  }

  Stream<String> _checkOAuthUserIDs() async* {
    _logger.info('Scanning OAuthUserIDs...');
    yield* _queryWithPool<OAuthUserID>((mapping) async* {
      if (mapping.userIdKey == null) {
        yield 'OAuthUserID "${mapping.oauthUserId}" has no `userId`.';
      } else {
        if (!looksLikeUserId(mapping.userId)) {
          yield 'OAuthUserID "${mapping.oauthUserId}" has invalid `userId`: "${mapping.userId}".';
        }
        _oauthToUser[mapping.oauthUserId] = mapping.userId;
      }
    });

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

  Stream<String> _checkPublishers(
    _PublisherAttributes publisherAttributes,
  ) async* {
    _logger.info('Scanning Publishers...');
    yield* _queryWithPool<Publisher>((p) async* {
      publisherAttributes.addPublisher(p);

      yield* _checkModeratedFlags(
        kind: 'Publisher',
        id: p.publisherId,
        isModerated: p.isModerated,
        moderatedAt: p.moderatedAt,
      );
    });
  }

  Stream<String> _checkPublishersAfterMembers(
    _PublisherAttributes publisherAttributes,
  ) async* {
    for (final publisherId in publisherAttributes.publisherIds) {
      if (publisherAttributes.isAbandoned(publisherId)) {
        if (publisherAttributes.hasContact(publisherId) &&
            publisherAttributes.hasNoMember(publisherId)) {
          yield 'Publisher "$publisherId" is marked as abandoned, has no members, '
              'but still has contact email.';
        }
      } else {
        if (publisherAttributes.hasNoMember(publisherId)) {
          yield 'Publisher "$publisherId" has no members, but it is not marked as abandoned.';
        }
      }
    }
  }

  Stream<String> _checkPublisherMembers(
    _PublisherAttributes publisherAttributes,
  ) async* {
    _logger.info('Scanning PublisherMembers...');
    yield* _queryWithPool<PublisherMember>((pm) async* {
      if (pm.id != pm.userId) {
        yield 'PublisherMember "${pm.id}" has bad `userId` value: "${pm.userId}".';
      }
      publisherAttributes.increaseMemberCount(pm.publisherId);
      if (!publisherAttributes.publisherIds.contains(pm.publisherId)) {
        // double check actual status to prevent misreports on cache race conditions
        final p = await publisherBackend.getPublisher(pm.publisherId);
        if (p == null) {
          yield 'PublisherMember "${pm.userId}" references a non-existing `publisherId`: "${pm.publisherId}".';
        }
      }
      if (pm.userId == null) {
        yield 'PublisherMember of "${pm.publisherId}" has no `userId`.';
      } else {
        yield* _checkUserValid(
          pm.userId!,
          entityType: 'PublisherMember',
          entityId: '${pm.publisherId} / ${pm.userId}',
        );

        if (!_blockedUsers.contains(pm.userId!) &&
            publisherAttributes.isAbandoned(pm.publisherId)) {
          yield 'Publisher "${pm.publisherId}" is marked as abandoned, but has non-blocked member ("${pm.userId}").';
        }
      }
    });
  }

  Stream<String> _checkPackages({
    required _PublisherAttributes publisherAttributes,
  }) async* {
    _logger.info('Scanning Packages...');
    yield* _queryWithPool<Package>(
        (p) => _checkPackage(p, publisherAttributes: publisherAttributes));

    for (final r in _packageReplacedBys.entries) {
      if (await _packageMissing(r.value)) {
        yield 'Package "${r.key}" has a `replacedBy` property with missing package "${r.value}".';
      }
    }
  }

  Stream<String> _checkPackage(
    Package p, {
    required _PublisherAttributes publisherAttributes,
  }) async* {
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
      if (p.publisherId == null && p.isVisible && !p.isDiscontinued) {
        yield 'Package "${p.name}" has no uploaders, must be marked discontinued.';
      }

      if (p.publisherId != null &&
          publisherAttributes.isAbandoned(p.publisherId!) &&
          p.isVisible &&
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
        // Moderated versions are not counted.
        if (!pv.isModerated) {
          versionCountUntilLastPublished++;
        }
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
    yield* _checkModeratedFlags(
      kind: 'Package',
      id: p.name!,
      isModerated: p.isModerated,
      moderatedAt: p.moderatedAt,
    );
    if (p.isModerated || p.isBlocked) {
      _packagesWithIsModeratedFlag.add(p.name!);
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

    await for (final pvi in pviQuery.run()) {
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
    for (final key in qualifiedVersionKeys) {
      if (!pviKeys.contains(key)) {
        yield 'PackageVersion "$key" has no PackageVersionInfo.';
      }
    }

    // Checking if PackageVersionAsset is referenced by a PackageVersion entity.
    final pvaQuery = _db.query<PackageVersionAsset>()
      ..filter('package =', p.name);
    final foundAssetIds = <String?>{};
    await for (final pva in pvaQuery.run()) {
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
        // double check actual status to prevent misreports on cache race conditions
        final info = await packageBackend.lookupPackageVersionInfo(
            pva.package!, pva.version!);
        if (info == null || !info.assets.contains(pva.kind!)) {
          yield 'PackageVersionAsset "${pva.id}" is not referenced from PackageVersionInfo.';
        }
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
    yield* _queryWithPool<PackageVersion>(_checkPackageVersion);

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
    final shouldBeInPublicBucket =
        !_packagesWithIsModeratedFlag.contains(pv.package) && !pv.isModerated;
    final tarballItems = await retry(
      () async {
        return await _checkTarballInBuckets(pv, archiveDownloadUri,
                shouldBeInPublicBucket: shouldBeInPublicBucket)
            .toList();
      },
      maxAttempts: 2,
    );
    yield* Stream.fromIterable(tarballItems);

    yield* _checkModeratedFlags(
      kind: 'PackageVersion',
      id: pv.qualifiedVersionKey.toString(),
      isModerated: pv.isModerated,
      moderatedAt: pv.moderatedAt,
    );

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

  Stream<String> _checkTarballInBuckets(
    PackageVersion pv,
    Uri archiveDownloadUri, {
    required bool shouldBeInPublicBucket,
  }) async* {
    final canonicalInfo = await packageBackend.tarballStorage
        .getCanonicalBucketArchiveInfo(pv.package, pv.version!);
    if (canonicalInfo == null) {
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has no matching canonical archive file.';
      return;
    }

    final info =
        await packageBackend.packageTarballInfo(pv.package, pv.version!);
    if (info == null) {
      if (shouldBeInPublicBucket) {
        yield 'PackageVersion "${pv.qualifiedVersionKey}" has no matching public archive file.';
      }
      return;
    }

    if (!shouldBeInPublicBucket) {
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has matching public archive file but it must not.';
      return;
    }

    if (!canonicalInfo.hasSameSignatureAs(info)) {
      yield 'Canonical archive for PackageVersion "${pv.qualifiedVersionKey}" differs from public bucket.';
    }

    final publicInfo = await packageBackend.tarballStorage
        .getPublicBucketArchiveInfo(pv.package, pv.version!);
    if (!canonicalInfo.hasSameSignatureAs(publicInfo)) {
      yield 'Canonical archive for PackageVersion "${pv.qualifiedVersionKey}" differs in the public bucket.';
    }

    final sha256Hash = pv.sha256;
    if (sha256Hash == null || sha256Hash.length != 32) {
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has invalid sha256.';
    } else if (envConfig.isRunningLocally || _random.nextInt(1000) == 0) {
      // On prod do not check every archive all the time, but select a few of the archives randomly.
      final bytes = (await _httpClient.get(archiveDownloadUri)).bodyBytes;
      final hash = sha256.convert(bytes).bytes;
      if (!hash.byteToByteEquals(sha256Hash)) {
        yield 'PackageVersion "${pv.qualifiedVersionKey}" has sha256 hash mismatch.';
      }
    }

    // Also issue a HTTP request.
    final rs = await _httpClient.head(archiveDownloadUri);
    if (rs.statusCode != 200) {
      yield 'PackageVersion "${pv.qualifiedVersionKey}" has no matching archive file (HTTP status ${rs.statusCode}).';
    }
  }

  Stream<String> _checkLikes() async* {
    _logger.info('Scanning Likes...');

    final counts = <String, int>{};
    yield* _queryWithPool<Like>((like) async* {
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
    });

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

    yield* _queryWithPool<ModeratedPackage>((pkg) async* {
      final packageName = pkg.name!;
      _moderatedPackages.add(packageName);
      if (await _packageExists(packageName)) {
        // double check actual status to prevent misreports on cache race conditions
        final p = await packageBackend.lookupPackage(packageName);
        if (p != null) {
          yield 'Moderated package "$packageName" also present in active packages.';
        }
      }
    });
  }

  Stream<String> _checkAuditLogs() async* {
    _logger.info('Scanning AuditLogRecords...');
    yield* _queryWithPool<AuditLogRecord>(_checkAuditLogRecord);
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
      if (looksLikeServiceAgent(r.agent!)) {
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

    /// Set true for entries where we retain the record indefinitely,
    /// even if the [User] has been deleted or invalidated.
    bool isRetainedRecord = false,
  }) async* {
    final label =
        entityId == null ? '$entityType entity' : '$entityType "$entityId"';
    if (!looksLikeUserIdOrServiceAgent(agent)) {
      yield '$label references an invalid agent: "$agent".';
    }
    if (looksLikeUserId(agent)) {
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

    /// Set true for entries where we retain the record indefinitely,
    /// even if the [User] has been deleted or invalidated.
    bool isRetainedRecord = false,
  }) async* {
    final label =
        entityId == null ? '$entityType entity' : '$entityType "$entityId"';
    if (!looksLikeUserId(userId)) {
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

  Stream<String> _checkModerationCases() async* {
    _logger.info('Scanning ModerationCases...');
    yield* _queryWithPool<ModerationCase>(_checkModerationCase);
  }

  Stream<String> _checkModerationCase(ModerationCase mc) async* {
    if (!isValidEmail(mc.reporterEmail)) {
      yield 'ModerationCase "${mc.caseId}" has invalid `reporterEmail`.';
    }
    if (mc.resolved != null && mc.status == ModerationStatus.pending) {
      yield 'ModerationCase "${mc.caseId}" is resolved but `status` is "pending".';
    }
    if (mc.status != ModerationStatus.pending && mc.resolved == null) {
      yield 'ModerationCase "${mc.caseId}" has non-pending `status` but `resolved` is null.';
    }
    final subject = ModerationSubject.tryParse(mc.subject);
    if (subject == null) {
      yield 'ModerationCase "${mc.caseId}" has invalid `subject`.';
    }
    if (mc.url != null && Uri.tryParse(mc.url!) == null) {
      yield 'ModerationCase "${mc.caseId}" has invalid `url`.';
    }
    for (final entry in mc.getActionLog().entries) {
      if (entry.timestamp.isBefore(mc.opened)) {
        yield 'ModerationCase "${mc.caseId}" has action logged before it was opened.';
      }
      if (mc.resolved != null && entry.timestamp.isAfter(mc.resolved!)) {
        yield 'ModerationCase "${mc.caseId}" has action logged after it was resolved.';
      }
      if (ModerationSubject.tryParse(entry.subject) == null) {
        yield 'ModerationCase "${mc.caseId}" has action logged with invalid `subject`.';
      }
    }
    // TODO: verify fields once the other PR lands

    if (mc.appealedCaseId != null) {
      final appealed = await dbService.lookupOrNull<ModerationCase>(
          dbService.emptyKey.append(ModerationCase, id: mc.appealedCaseId!));
      if (appealed == null) {
        yield 'ModerationCase "${mc.caseId}" references an appealed case that does not exists.';
      }
    }
  }

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

  Stream<String> _queryWithPool<R extends Model>(
      Stream<String> Function(R model) fn) async* {
    final query = _db.query<R>();
    final pool = Pool(_concurrency);
    final futures = <Future<List<String>>>[];
    try {
      await for (final m in query.run()) {
        final f = pool.withResource(() => fn(m).toList());
        futures.add(f);
      }
      for (final f in futures) {
        for (final item in await f) {
          yield item;
        }
      }
    } finally {
      await pool.close();
    }
  }
}

typedef StreamingIssuesFn = Stream<String> Function();
typedef StreamingIssuesFnCallback = void Function(StreamingIssuesFn fn);

class _PublisherAttributes {
  final publisherIds = <String>{};
  final _abandoned = <String>{};
  final _withoutContact = <String>{};
  final _memberCount = <String, int>{};

  void addPublisher(Publisher p) {
    publisherIds.add(p.publisherId);
    if (p.isAbandoned) {
      _abandoned.add(p.publisherId);
    }
    if (!p.hasContactEmail) {
      _withoutContact.add(p.publisherId);
    }
  }

  bool isAbandoned(String publisherId) {
    return _abandoned.contains(publisherId);
  }

  bool hasContact(String publisherId) {
    return !_withoutContact.contains(publisherId);
  }

  bool hasNoMember(String publisherId) {
    return (_memberCount[publisherId] ?? 0) == 0;
  }

  void increaseMemberCount(String publisherId) {
    _memberCount[publisherId] = (_memberCount[publisherId] ?? 0) + 1;
  }

  void clear() {
    _abandoned.clear();
    _withoutContact.clear();
    _memberCount.clear();
  }
}

/// Check that `isModerated` and `moderatedAt` are consistent.
Stream<String> _checkModeratedFlags({
  required String kind,
  required String id,
  required bool isModerated,
  required DateTime? moderatedAt,
}) async* {
  if (isModerated && moderatedAt == null) {
    yield '$kind "$id" has `isModerated = true` but `moderatedAt` is null.';
  }
  if (!isModerated && moderatedAt != null) {
    yield '$kind "$id" has `isModerated = false` but `moderatedAt` is not null.';
  }
}
