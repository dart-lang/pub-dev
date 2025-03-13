// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:tar/tar.dart';

import '../../account/auth_provider.dart';
import '../../fake/backend/fake_auth_provider.dart';
import '../../frontend/handlers/pubapi.client.dart';
import '../../service/async_queue/async_queue.dart';
import '../../shared/configuration.dart';
import '../../shared/utils.dart';
import '../utils/pub_api_client.dart';
import 'import_source.dart';
import 'models.dart';
import 'normalizer.dart';

/// Imports [profile] data into the Datastore.
@visibleForTesting
Future<void> importProfile({
  required TestProfile profile,
  ImportSource? source,
  String? pubHostedUrl,
  String? adminUserEmail,
}) async {
  source ??= ImportSource();
  final resolvedVersions = await source.resolveVersions(profile);
  resolvedVersions.sort();

  // expand profile with resolved version information
  profile = normalize(profile, resolvedVersions: resolvedVersions);

  if (profile.importedPackages
      .any((p) => p.uploaders != null && p.uploaders!.length > 1)) {
    throw UnimplementedError('More than one uploader is not implemented.');
  }
  if (profile.generatedPackages
      .any((p) => p.uploaders != null && p.uploaders!.length > 1)) {
    throw UnimplementedError('More than one uploader is not implemented.');
  }

  // create publishers
  for (final p in profile.publishers) {
    final firstMemberEmail = p.members.first.email;
    await withFakeAuthRetryPubApiClient(
      email: firstMemberEmail,
      scopes: [webmasterScope],
      pubHostedUrl: pubHostedUrl,
      (client) async {
        try {
          await client.createPublisher(p.name);
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

  // create versions in multiple rounds, as they may depend on each other
  var published = true;
  var pending = <ResolvedVersion>[...resolvedVersions];
  final pendingBytes = <String, List<int>>{};
  Object? lastException;
  StackTrace? lastStackTrace;
  // TODO: Fix this slow hack, sort the package versions topographically and
  //       publish in that order! This can do unnecessary rounds and loop!
  while (published && pending.isNotEmpty) {
    published = false;
    final nextPending = <ResolvedVersion>[];

    for (final rv in pending) {
      // figure out the active user
      final uploaderEmails = _potentialActiveEmails(profile, rv.package);
      final uploaderEmail =
          uploaderEmails[rv.version.hashCode.abs() % uploaderEmails.length];
      lastActiveUploaderEmails[rv.package] = uploaderEmail;

      var bytes = pendingBytes['${rv.package}/${rv.version}'] ??
          (profile.isGenerated(rv.package, rv.version)
              ? await source.getGeneratedArchiveBytes(rv.package, rv.version)
              : await source.getPubDevArchiveBytes(rv.package, rv.version));
      bytes = await _mayCleanupTarModeBits(bytes);
      try {
        await withRetryPubApiClient(
          authToken: createFakeAuthTokenForEmail(uploaderEmail,
              audience: activeConfiguration.pubClientAudience),
          pubHostedUrl: pubHostedUrl,
          (client) => client.uploadPackageBytes(bytes),
        );
        published = true;
      } catch (e, st) {
        lastException = e;
        lastStackTrace = st;
        nextPending.add(rv);
        pendingBytes['${rv.package}/${rv.version}'] = bytes;
      }
    }
    pending = nextPending;
  }
  if (pending.isNotEmpty) {
    throw Exception(
        'Unable to publish ${pending.length} packages (first: ${pending.first.toJson()}).'
        '\n$lastException\n$lastStackTrace');
  }

  Future<void> updatePackage(TestPackage testPackage) async {
    final packageName = testPackage.name;
    final activeEmail = lastActiveUploaderEmails[packageName];

    await withFakeAuthRetryPubApiClient(
      email: activeEmail!,
      pubHostedUrl: pubHostedUrl,
      (client) async {
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
      await withRetryPubApiClient(
        authToken:
            createFakeServiceAccountToken(email: adminUserEmail ?? activeEmail),
        pubHostedUrl: pubHostedUrl,
        (client) async {
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

  for (final p in profile.importedPackages) {
    await updatePackage(p);
  }
  for (final p in profile.generatedPackages) {
    await updatePackage(p);
  }

  final createLikeCounts = <String, int>{};
  // create users
  for (final u in profile.users) {
    await withFakeAuthRetryPubApiClient(
      email: u.email,
      pubHostedUrl: pubHostedUrl,
      (client) async {
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
  Future<void> createMissingLike(TestPackage p) async {
    if (p.likeCount != null) {
      final likesMissing = p.likeCount! - (createLikeCounts[p.name] ?? 0);
      if (likesMissing <= 0) return;

      for (var i = 0; i < likesMissing; i++) {
        final userEmail = 'like-$i@pub.dev';
        await withFakeAuthRetryPubApiClient(
          email: userEmail,
          pubHostedUrl: pubHostedUrl,
          (client) async {
            await client.likePackage(p.name);
          },
        );
      }
    }
  }

  for (final p in profile.importedPackages) {
    await createMissingLike(p);
  }
  for (final p in profile.generatedPackages) {
    await createMissingLike(p);
  }

  await source.close();
  await asyncQueue.ongoingProcessing;
}

List<String> _potentialActiveEmails(TestProfile profile, String packageName) {
  final testPackage =
      profile.importedPackages.firstWhereOrNull((p) => p.name == packageName) ??
          profile.generatedPackages.firstWhere((p) => p.name == packageName);

  // uploaders
  if (testPackage.publisher == null) {
    return testPackage.uploaders ?? [profile.resolvedDefaultUser];
  }

  // publisher
  final members = profile.publishers
      .firstWhere((p) => p.name == testPackage.publisher)
      .members;
  return members.map((m) => m.email).toList();
}

/// Old archives may contain mode bits that are not supported with the current
/// upload checks. This method reads the archive and checks for the mode bits.
/// When the archive bits are not supported, it returns a new archive with the
/// bits corrected.
Future<List<int>> _mayCleanupTarModeBits(List<int> bytes) async {
  final archiveBuilder = ArchiveBuilder();
  final tarReader =
      TarReader(Stream.fromIterable([bytes]).transform(gzip.decoder));
  var needsUpdate = false;
  while (await tarReader.moveNext()) {
    final current = tarReader.current;
    if (current.header.mode != 420) {
      // 644₈
      needsUpdate = true;
    }
    archiveBuilder.addFileBytes(
        current.name, await current.contents.foldBytes());
  }
  return needsUpdate ? archiveBuilder.toTarGzBytes() : bytes;
}
