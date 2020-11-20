// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:gcloud/service_scope.dart';
import 'package:meta/meta.dart';

import 'package:client_data/package_api.dart';

import '../../account/backend.dart';
import '../../account/models.dart';
import '../../package/backend.dart';
import '../../publisher/models.dart';
import '../../shared/datastore.dart';

import 'import_source.dart';
import 'models.dart';
import 'normalizer.dart';

/// Imports [profile] data into the Datastore.
@visibleForTesting
Future<void> importProfile({
  @required TestProfile profile,
  @required ImportSource source,
}) async {
  final resolvedVersions = await source.resolveVersions(profile);

  // expand profile with resolved version information
  profile = normalize(profile, resolvedVersions: resolvedVersions);

  // create users
  for (final u in profile.users) {
    // The default oauthUserId is following the same pattern as we have in
    // `fake_auth_provider.dart`.
    final oauthUserId =
        u.oauthUserId ?? u.email.replaceAll('.', '-').replaceAll('@', '-');
    final userId = _userIdFromEmail(u.email);
    await dbService.commit(inserts: [
      User()
        ..id = userId
        ..oauthUserId = oauthUserId
        ..email = u.email
        ..created = u.created ?? DateTime.now().toUtc()
        ..isDeleted = u.isDeleted ?? false
        ..isBlocked = u.isBlocked ?? false,
      OAuthUserID()
        ..id = oauthUserId
        ..userIdKey = dbService.emptyKey.append(User, id: userId),
    ]);
  }

  // create publishers
  for (final p in profile.publishers) {
    await dbService.commit(inserts: [
      Publisher()
        ..id = p.name
        ..contactEmail = p.members.isEmpty ? null : p.members.first.email
        ..websiteUrl = 'https://${p.name}/'
        ..created = p.created ?? DateTime.now().toUtc()
        ..updated = p.updated ?? DateTime.now().toUtc()
        ..isAbandoned = false,
      ...p.members.map(
        (m) => PublisherMember()
          ..parentKey = dbService.emptyKey.append(Publisher, id: p.name)
          ..id = _userIdFromEmail(m.email)
          ..userId = _userIdFromEmail(m.email)
          ..created = m.created ?? DateTime.now().toUtc()
          ..updated = m.updated ?? DateTime.now().toUtc()
          ..role = PublisherMemberRole.admin,
      )
    ]);
  }

  // create versions
  for (final testPackage in profile.packages) {
    final packageName = testPackage.name;
    User lastActiveUser;
    for (final versionName in testPackage.versions) {
      // figure out the active user
      final uploaderEmails = _potentialActiveEmails(profile, packageName);
      final uploaderEmail =
          uploaderEmails[versionName.hashCode.abs() % uploaderEmails.length];
      final activeUser =
          await accountBackend.lookupUserById(_userIdFromEmail(uploaderEmail));
      lastActiveUser = activeUser;

      // upload package in the name of the active user
      await fork(() async {
        registerAuthenticatedUser(activeUser);
        // ignore: invalid_use_of_visible_for_testing_member
        await packageBackend.upload(Stream<List<int>>.fromFuture(
            source.getArchiveBytes(packageName, versionName)));
      });
    }

    // update package info
    await fork(() async {
      registerAuthenticatedUser(lastActiveUser);
      // update publisher
      if (testPackage.publisher != null) {
        await packageBackend.setPublisher(
          packageName,
          PackagePublisherInfo(publisherId: testPackage.publisher),
        );
      }

      // update options - sending null is a no-op
      await packageBackend.updateOptions(
          packageName,
          PkgOptions(
            isDiscontinued: testPackage.isDiscontinued,
            replacedBy: testPackage.replacedBy,
            isUnlisted: testPackage.isUnlisted,
          ));
    });
  }

  // create likes
  for (final u in profile.users) {
    if (u.likes == null || u.likes.isEmpty) continue;
    final userId = _userIdFromEmail(u.email);
    await dbService.commit(inserts: [
      ...u.likes.map(
        (p) => Like()
          ..parentKey = dbService.emptyKey.append(User, id: userId)
          ..id = p
          // TODO: support via [TestProfile]
          ..created = DateTime.now().toUtc()
          ..packageName = p,
      )
    ]);
  }

  await source.close();
}

List<String> _potentialActiveEmails(TestProfile profile, String packageName) {
  final testPackage = profile.packages.firstWhere((p) => p.name == packageName);

  // uploaders
  if (testPackage.publisher == null) return testPackage.uploaders;

  // publisher
  final members = profile.publishers
      .firstWhere((p) => p.name == testPackage.publisher)
      .members;
  return members.map((m) => m.email).toList();
}

String _userIdFromEmail(String email) {
  final hash = sha1.convert(utf8.encode('email-$email')).toString();
  return hash.substring(0, 8) +
      '-' +
      hash.substring(8, 12) +
      '-' +
      hash.substring(12, 16) +
      '-' +
      hash.substring(16, 20) +
      '-' +
      hash.substring(20, 32);
}
