// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/admin_api.dart';
import 'package:client_data/package_api.dart';
import 'package:client_data/publisher_api.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../shared/tags.dart';
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
    final token = _fakeToken(firstMemberEmail);
    await withPubApiClient(
      bearerToken: token,
      pubHostedUrl: pubHostedUrl,
      fn: (client) async {
        await client.createPublisher(
            p.name, CreatePublisherRequest(accessToken: token));

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
    await withPubApiClient(
      bearerToken: _fakeToken(uploaderEmail),
      pubHostedUrl: pubHostedUrl,
      fn: (client) async {
        final uploadInfo = await client.getPackageUploadUrl();

        final request = http.MultipartRequest('POST', Uri.parse(uploadInfo.url))
          ..fields.addAll(uploadInfo.fields!)
          ..files.add(http.MultipartFile.fromBytes('file', bytes))
          ..followRedirects = false;
        final uploadRs = await request.send();
        if (uploadRs.statusCode != 303) {
          throw AssertionError(
              'Expected HTTP redirect, got ${uploadRs.statusCode}.');
        }

        final callbackUri =
            Uri.parse(uploadInfo.fields!['success_action_redirect']!);
        await client
            .finishPackageUpload(callbackUri.queryParameters['upload_id']!);
      },
    );
  }
  for (final testPackage in profile.packages) {
    final packageName = testPackage.name;
    final activeEmail = lastActiveUploaderEmails[packageName];

    await withPubApiClient(
      bearerToken: _fakeToken(activeEmail!),
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
      },
    );

    if (testPackage.isFlutterFavorite ?? false) {
      await withPubApiClient(
        bearerToken: _fakeToken(adminUserEmail ?? activeEmail),
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

  // create likes
  for (final u in profile.users) {
    await withPubApiClient(
      bearerToken: _fakeToken(u.email),
      pubHostedUrl: pubHostedUrl,
      fn: (client) async {
        // creates user
        await client.listPackageLikes();

        if (u.likes.isNotEmpty) {
          for (final p in u.likes) {
            await client.likePackage(p);
          }
        }
      },
    );
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

String _fakeToken(String email) =>
    email.replaceAll('@', '-at-').replaceAll('.', '-dot-');
