// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/data/publisher_api.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/account/auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';

import '../utils/pub_api_client.dart';
import 'import_source.dart';
import 'models.dart';
import 'normalizer.dart';

/// Imports [profile] data into the Datastore.
@visibleForTesting
Future<void> importProfile({
  required TestProfile profile,
  required ImportSource source,
  String? pubHostedUrl,
  String? adminUserEmail,
}) async {
  final resolvedVersions = await source.resolveVersions(profile);
  resolvedVersions.sort();

  // expand profile with resolved version information
  profile = normalize(profile, resolvedVersions: resolvedVersions);

  if (profile.packages
      .any((p) => p.uploaders != null && p.uploaders!.length > 1)) {
    throw UnimplementedError('More than one uploader is not implemented.');
  }

  // create publishers
  for (final p in profile.publishers) {
    final firstMemberEmail = p.members.first.email;
    final token = createFakeAuthTokenForEmail(firstMemberEmail);
    await withHttpPubApiClient(
      bearerToken: token,
      pubHostedUrl: pubHostedUrl,
      fn: (client) async {
        try {
          await client.createPublisher(
              p.name, CreatePublisherRequest(accessToken: token));
        } on RequestException catch (e) {
          // Ignore 409s, that's probably just because it's been created before.
          if (e.status != 409) {
            rethrow;
          }
        }

        for (final _ in p.members.skip(1)) {
          // TODO: explore implementation options how to add this
          throw UnimplementedError(
              'More than one publisher members is not implemented (${p.name}).');
        }
      },
    );
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

    final bytes = await source.getArchiveBytes(rv.package, rv.version);
    await withHttpPubApiClient(
      bearerToken:
          createFakeAuthTokenForEmail(uploaderEmail, source: AuthSource.client),
      pubHostedUrl: pubHostedUrl,
      // ignore: invalid_use_of_visible_for_testing_member
      fn: (client) => client.uploadPackageBytes(bytes),
    );
  }
  for (final testPackage in profile.packages) {
    final packageName = testPackage.name;
    final activeEmail = lastActiveUploaderEmails[packageName];

    await withHttpPubApiClient(
      bearerToken: createFakeAuthTokenForEmail(activeEmail!),
      pubHostedUrl: pubHostedUrl,
      fn: (client) async {
        // update publisher
        if (testPackage.publisher != null) {
          await client.setPackagePublisher(
            packageName,
            PackagePublisherInfo(publisherId: testPackage.publisher),
          );
        }

        // update options - sending null is a no-op
        await client.setPackageOptions(
            packageName,
            PkgOptions(
              isDiscontinued: testPackage.isDiscontinued,
              replacedBy: testPackage.replacedBy,
              isUnlisted: testPackage.isUnlisted,
            ));

        if (testPackage.retractedVersions != null) {
          for (final version in testPackage.retractedVersions!) {
            await client.setVersionOptions(
                packageName, version, VersionOptions(isRetracted: true));
          }
        }
      },
    );

    if (testPackage.isFlutterFavorite ?? false) {
      await withHttpPubApiClient(
        bearerToken: createFakeAuthTokenForEmail(adminUserEmail ?? activeEmail,
            source: AuthSource.admin),
        pubHostedUrl: pubHostedUrl,
        fn: (client) async {
          await client.adminPostAssignedTags(
            packageName,
            PatchAssignedTags(
              assignedTagsAdded: [PackageTags.isFlutterFavorite],
            ),
          );
        },
      );
    }
  }

  final createLikeCounts = <String, int>{};
  // create users
  for (final u in profile.users) {
    await withHttpPubApiClient(
      bearerToken: createFakeAuthTokenForEmail(u.email),
      pubHostedUrl: pubHostedUrl,
      fn: (client) async {
        // creates user (regardless of likes being specified)
        await client.listPackageLikes();

        if (u.likes.isNotEmpty) {
          for (final p in u.likes) {
            await client.likePackage(p);
            createLikeCounts[p] = (createLikeCounts[p] ?? 0) + 1;
          }
        }
      },
    );
  }
  // fill in missing likes
  for (final p in profile.packages) {
    if (p.likeCount != null) {
      final likesMissing = p.likeCount! - (createLikeCounts[p.name] ?? 0);
      if (likesMissing <= 0) continue;

      for (var i = 0; i < likesMissing; i++) {
        final userEmail = 'like-$i@pub.dev';
        await withHttpPubApiClient(
          bearerToken: createFakeAuthTokenForEmail(userEmail),
          pubHostedUrl: pubHostedUrl,
          fn: (client) async {
            await client.likePackage(p.name);
          },
        );
      }
    }
  }

  await source.close();
}

List<String> _potentialActiveEmails(TestProfile profile, String packageName) {
  final testPackage = profile.packages.firstWhere((p) => p.name == packageName);

  // uploaders
  if (testPackage.publisher == null) return testPackage.uploaders!;

  // publisher
  final members = profile.publishers
      .firstWhere((p) => p.name == testPackage.publisher)
      .members;
  return members.map((m) => m.email).toList();
}
