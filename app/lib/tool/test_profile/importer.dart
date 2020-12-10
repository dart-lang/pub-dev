// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart';
import 'package:meta/meta.dart';

import 'package:client_data/package_api.dart';
import 'package:client_data/publisher_api.dart';

import '../../account/backend.dart';
import '../../package/backend.dart';
import '../../publisher/backend.dart';

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
  resolvedVersions.sort();

  // expand profile with resolved version information
  profile = normalize(profile, resolvedVersions: resolvedVersions);

  if (profile.packages
      .any((p) => p.uploaders != null && p.uploaders.length > 1)) {
    throw UnimplementedError('More than one uploader is not implemented.');
  }

  // create publishers
  for (final p in profile.publishers) {
    final firstMemberEmail = p.members.first.email;
    final token = _fakeToken(firstMemberEmail);
    await _withAuthorizationToken(token, () async {
      await publisherBackend.createPublisher(
          p.name, CreatePublisherRequest(accessToken: token));

      for (final _ in p.members.skip(1)) {
        // TODO: explore implementation options how to add this
        throw UnimplementedError(
            'More than one publisher members is not implemented (${p.name}).');
      }
    });
  }

  // last active uploader
  final lastActiveUploaderEmails = <String, String>{};

  // create versions
  for (final rv in resolvedVersions) {
    // figure out the active user
    final uploaderEmails = _potentialActiveEmails(profile, rv.package);
    final uploaderEmail =
        uploaderEmails[rv.version.hashCode.abs() % uploaderEmails.length];
    lastActiveUploaderEmails[rv.package] = uploaderEmail;

    await _withAuthorizationToken(_fakeToken(uploaderEmail), () async {
      // ignore: invalid_use_of_visible_for_testing_member
      await packageBackend.upload(Stream<List<int>>.fromFuture(
          source.getArchiveBytes(rv.package, rv.version)));
    });
  }
  for (final testPackage in profile.packages) {
    final packageName = testPackage.name;
    final activeEmail = lastActiveUploaderEmails[packageName];

    await _withAuthorizationToken(_fakeToken(activeEmail), () async {
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
    // create user
    await _withAuthorizationToken(_fakeToken(u.email), () async {});

    if (u.likes != null && u.likes.isNotEmpty) {
      await _withAuthorizationToken(_fakeToken(u.email), () async {
        for (final p in u.likes) {
          await accountBackend.likePackage(await requireAuthenticatedUser(), p);
        }
      });
    }
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

String _fakeToken(String email) =>
    email.replaceAll('@', '-at-').replaceAll('.', '-dot-');

Future<R> _withAuthorizationToken<R>(
    String token, Future<R> Function() fn) async {
  return await fork(() async {
    final user = await accountBackend.authenticateWithBearerToken(token);
    if (user != null) {
      registerAuthenticatedUser(user);
    }
    return await fn();
  }) as R;
}
