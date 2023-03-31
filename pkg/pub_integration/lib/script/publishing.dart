// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as path;
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
  final String credentialsFileContent;
  final String mainAccessToken;
  final String invitedEmail;
  final InviteCompleterFn inviteCompleterFn;
  final bool expectLiveSite;
  final PubHttpClient _pubHttpClient;

  String? _newDummyVersion;
  late bool _hasRetry;

  late Directory _temp;
  late Directory _dummyDir;
  late Directory _dummyExampleDir;
  late Directory _retryDir;

  PublishingScript(
    this.pubHostedUrl,
    this.credentialsFileContent,
    this.mainAccessToken,
    this.invitedEmail,
    this.inviteCompleterFn,
    this.expectLiveSite,
  ) : _pubHttpClient = PubHttpClient(pubHostedUrl);

  /// Verify all integration steps.
  Future<void> verify() async {
    await _queryVersions();
    _temp = await Directory.systemTemp.createTemp('pub-integration');
    final dart = await DartToolClient.withServer(
      pubHostedUrl: pubHostedUrl,
      credentialsFileContent: credentialsFileContent,
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
          expectedError:
              '`CHANGELOG.md` exceeds the maximum content length (131072 bytes).');
      await _dummyDir.delete(recursive: true);

      // upload package
      await _createDummyPkg(oversized: false);
      await dart.getDependencies(_dummyDir.path);
      await dart.publish(_dummyDir.path,
          expectedOutputContains:
              'Successfully uploaded https://pub.dev/packages/_dummy_pkg version $_newDummyVersion.');
      await Future.delayed(Duration(seconds: 1));
      await _verifyDummyPkg();

      // upload the same version again
      await dart.publish(_dummyDir.path,
          expectedError:
              'Version $_newDummyVersion of package _dummy_pkg already exists.');

      // run example
      await dart.getDependencies(_dummyExampleDir.path);
      await dart.run(_dummyExampleDir.path, 'bin/main.dart');

      // TODO: re-add uploader invites with better token/session/csrf handling
      // // add/remove uploader
      // await _pubHttpClient.inviteUploader(
      //   packageName: '_dummy_pkg',
      //   accessToken: mainAccessToken,
      //   invitedEmail: invitedEmail,
      // );
      // await inviteCompleterFn();
      // await _verifyDummyPkg();
      // await _pubHttpClient.removeUploader(
      //   packageName: '_dummy_pkg',
      //   accessToken: mainAccessToken,
      //   uploaderEmail: invitedEmail,
      // );
      // await _verifyDummyPkg();

      if (expectLiveSite) {
        await _verifyDummyDocumentation();
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
        changelogContentSizeInKB: oversized ? 129 : 4);
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

  Future<void> _verifyDummyDocumentation() async {
    final pageHtml = await _pubHttpClient.getDocumentationPage('_dummy_pkg');
    if (!pageHtml.contains('made with love by dartdoc')) {
      throw Exception('Documentation page is not the output of dartdoc.');
    }
    if (!pageHtml.contains('<a href="_dummy_pkg/_dummy_pkg-library.html">')) {
      throw Exception('Documentation page does not contain main library.');
    }
  }
}
