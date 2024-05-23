// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as path;
import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:pub_integration/src/test_scenario.dart';
import 'package:pub_semver/pub_semver.dart';

import '../src/pub_http_client.dart';
import '../src/pub_tool_client.dart';
import '../src/test_data.dart';

final _random = Random.secure();

typedef InviteCompleterFn = Future<void> Function();

/// A single object to execute integration script and verification tests with the
/// `pub` tool on the pub.dev site (or on a test site).
class PublishingScript {
  final String pubHostedUrl;
  final bool expectLiveSite;
  final PubHttpClient _pubHttpClient;
  final TestUser adminUser;
  final TestUser invitedUser;

  String? _newDummyVersion;
  late bool _hasRetry;

  late Directory _temp;
  late Directory _dummyDir;
  late Directory _dummyExampleDir;
  late Directory _retryDir;

  PublishingScript(
    this.pubHostedUrl,
    this.expectLiveSite, {
    required this.adminUser,
    required this.invitedUser,
  }) : _pubHttpClient = PubHttpClient(pubHostedUrl);

  /// Verify all integration steps.
  Future<void> verify() async {
    await _queryVersions();
    _temp = await Directory.systemTemp.createTemp('pub-integration');
    final dart = await DartToolClient.withServer(
      pubHostedUrl: pubHostedUrl,
      credentialsFileContent: json.encode(await adminUser.createCredentials()),
    );
    try {
      if (!_hasRetry) {
        await _createFakeRetryPkg();
        await dart.getDependencies(_retryDir.path);
        await dart.publish(_retryDir.path);
      }

      // too large asset files are rejected
      await _createDummyPkg(oversized: true);

      await dart.publish(_dummyDir.path,
          expectedErrorContains:
              '`CHANGELOG.md` exceeds the maximum content length');
      await _dummyDir.delete(recursive: true);

      // upload package
      await _createDummyPkg(oversized: false);
      await dart.getDependencies(_dummyDir.path);
      await dart.publish(_dummyDir.path,
          expectedOutputContains:
              'Successfully uploaded https://pub.dev/packages/_dummy_pkg version $_newDummyVersion');
      // On appengine we may experience a longer cache period for the public API.
      // Waiting for up to 150 seconds for the version to be updated.
      for (var i = 1; i <= 50; i++) {
        await Future.delayed(Duration(seconds: 3));
        final latest = await _pubHttpClient.getLatestVersionName('_dummy_pkg');
        if (latest == _newDummyVersion) {
          break;
        }
      }
      await _verifyDummyPkg();

      // upload the same version again
      await dart.publish(_dummyDir.path,
          expectedErrorContains:
              'Version $_newDummyVersion of package _dummy_pkg already exists.');

      // run example
      await dart.getDependencies(_dummyExampleDir.path);
      await dart.run(_dummyExampleDir.path, 'bin/main.dart');

      if (pubHostedUrl.startsWith('http://localhost:')) {
        // invite uploader
        // TODO: use page.invitePackageAdmin instead
        await adminUser.withBrowserPage((page) async {
          final emails =
              await page.listPackageUploaderEmails(package: '_dummy_pkg');
          if (emails.contains(invitedUser.email)) {
            throw Exception('"${invitedUser.email}" is already an uploader.');
          }
          await page.invitePackageAdmin(
            package: '_dummy_pkg',
            invitedEmail: invitedUser.email,
          );
        });

        final lastEmail = await invitedUser.readLatestEmail();
        final consentId = extractConsentIdFromEmail(lastEmail);

        // accepting it with the good user
        await invitedUser.withBrowserPage((page) async {
          await page.acceptConsent(consentId: consentId);
          final emails =
              await page.listPackageUploaderEmails(package: '_dummy_pkg');
          if (!emails.contains(invitedUser.email)) {
            throw Exception(
                '"${invitedUser.email}" has not become an uploader.');
          }
        });

        await _verifyDummyPkg();

        // remove uploader with API
        await adminUser.withBrowserPage((page) async {
          await page.deletePackageAdmin(
            package: '_dummy_pkg',
            email: invitedUser.email,
          );
          final emails =
              await page.listPackageUploaderEmails(package: '_dummy_pkg');
          if (emails.contains(invitedUser.email)) {
            throw Exception('"${invitedUser.email}" is still an uploader.');
          }
        });

        await _verifyDummyPkg();
      }

      if (expectLiveSite) {
        await _verifyRetryDocumentation();
      }
    } finally {
      await _temp.delete(recursive: true);
      await _pubHttpClient.close();
      await dart.close();
    }
  }

  Future<void> _queryVersions() async {
    final retryVersion = await _pubHttpClient.getLatestVersionName('retry');
    _hasRetry = retryVersion != null;

    final dv = await _pubHttpClient.getLatestVersionName('_dummy_pkg');
    final v = Version.parse(dv ?? '0.0.1');
    final build =
        List.generate(5, (i) => _random.nextInt(36).toRadixString(36)).join();
    _newDummyVersion =
        Version(v.major, v.minor, v.patch + 1, build: build).toString();
  }

  Future<void> _createDummyPkg({required bool oversized}) async {
    _dummyDir = Directory(path.join(_temp.path, 'pkg', '_dummy_pkg'));
    _dummyExampleDir = Directory(path.join(_dummyDir.path, 'example'));
    await _dummyDir.create(recursive: true);
    await createDummyPkg(_dummyDir.path, _newDummyVersion,
        changelogContentSizeInKB: oversized ? 257 : 4);
  }

  Future<void> _createFakeRetryPkg() async {
    _retryDir = Directory(path.join(_temp.path, 'pkg', 'retry'));
    await _retryDir.create(recursive: true);
    await createFakeRetryPkg(_retryDir.path);
  }

  Future<void> _verifyDummyPkg() async {
    final dv = await _pubHttpClient.getLatestVersionName('_dummy_pkg');
    if (dv != _newDummyVersion) {
      throw Exception(
          'Expected version does not match: $dv != $_newDummyVersion');
    }

    final tabs = [
      null,
      'changelog',
      'example',
      'license',
      'pubspec',
      'score',
      'versions',
    ];
    for (final tab in tabs) {
      final pageHtml =
          (await _pubHttpClient.getLatestVersionPage('_dummy_pkg', tab: tab))!;
      if (!pageHtml.contains(_newDummyVersion!)) {
        throw Exception('New version is not to be found on package page.');
      }
      if (pageHtml.contains('developer@example.com')) {
        throw Exception(
            'pubspec author field must not be found on package page.');
      }
    }
  }

  Future<void> _verifyRetryDocumentation() async {
    final pageHtml = await _pubHttpClient.getDocumentationPage('retry');
    if (!pageHtml.contains('made with love by dartdoc')) {
      throw Exception('Documentation page is not the output of dartdoc.');
    }
    if (!pageHtml.contains('<a href="retry/retry-library.html">')) {
      throw Exception('Documentation page does not contain main library.');
    }
  }
}
