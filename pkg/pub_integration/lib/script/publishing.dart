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
  final String clientSdkDir;
  final String pubHostedUrl;
  final String credentialsFileContent;
  final String invitedEmail;
  final InviteCompleterFn inviteCompleterFn;
  PubHttpClient _pubHttpClient;
  PubToolClient _pubToolClient;

  String _newDummyVersion;
  bool _hasRetry;

  Directory _temp;
  Directory _dummyDir;
  Directory _dummyExampleDir;
  Directory _retryDir;

  PublishingScript(
    this.clientSdkDir,
    this.pubHostedUrl,
    this.credentialsFileContent,
    this.invitedEmail,
    this.inviteCompleterFn,
  );

  /// Verify all integration steps.
  Future<void> verify() async {
    assert(_pubHttpClient == null);
    assert(_pubToolClient == null);
    _pubHttpClient = PubHttpClient(pubHostedUrl);
    await _queryVersions();
    _temp = await Directory.systemTemp.createTemp('pub-integration');
    try {
      _pubToolClient = await PubToolClient.create(
          pubHostedUrl: pubHostedUrl,
          credentialsFileContent: credentialsFileContent);

      if (!_hasRetry) {
        await _createFakeRetryPkg();
        await _pubToolClient.getDependencies(_retryDir.path);
        await _pubToolClient.publish(_retryDir.path);
      }
      // upload package
      await _createDummyPkg();
      await _pubToolClient.getDependencies(_dummyDir.path);
      await _pubToolClient.publish(_dummyDir.path);
      await Future.delayed(Duration(seconds: 1));
      await _verifyDummyPkg();

      // upload the same version again
      await _pubToolClient.publish(_dummyDir.path,
          expectedError:
              'Version $_newDummyVersion of package _dummy_pkg already exists.');

      // run example
      await _pubToolClient.getDependencies(_dummyExampleDir.path);
      await _run(_dummyExampleDir, 'bin/main.dart');

      // add/remove uploader
      await _pubToolClient.addUploader(_dummyDir.path, invitedEmail);
      await inviteCompleterFn();
      await _verifyDummyPkg(matchInvited: true);
      await _pubToolClient.removeUploader(_dummyDir.path, invitedEmail);
      await _verifyDummyPkg(matchInvited: false);
    } finally {
      await _temp.delete(recursive: true);
      _pubHttpClient.close();
      await _pubToolClient?.close();
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

  Future<void> _createDummyPkg() async {
    _dummyDir = Directory(path.join(_temp.path, 'pkg', '_dummy_pkg'));
    _dummyExampleDir = Directory(path.join(_dummyDir.path, 'example'));
    await _dummyDir.create(recursive: true);
    await createDummyPkg(_dummyDir.path, _newDummyVersion);
  }

  Future<void> _createFakeRetryPkg() async {
    _retryDir = Directory(path.join(_temp.path, 'pkg', 'retry'));
    await _retryDir.create(recursive: true);
    await createFakeRetryPkg(_retryDir.path);
  }

  Future<void> _run(Directory dir, String file) async {
    await _pubToolClient.runProc('dart', [file], workingDirectory: dir.path);
  }

  Future<void> _verifyDummyPkg({bool matchInvited}) async {
    final dv = await _pubHttpClient.getLatestVersionName('_dummy_pkg');
    if (dv != _newDummyVersion) {
      throw Exception(
          'Expected version does not match: $dv != $_newDummyVersion');
    }

    final pageHtml = await _pubHttpClient.getLatestVersionPage('_dummy_pkg');
    if (!pageHtml.contains(_newDummyVersion)) {
      throw Exception('New version is not to be found on package page.');
    }
    if (pageHtml.contains('developer@example.com')) {
      throw Exception(
          'pubspec author field most not be found on package page.');
    }
    if (matchInvited != null) {
      final found = pageHtml.contains(invitedEmail);
      if (matchInvited && !found) {
        throw Exception('Invited email is not to be found on package page.');
      }
      if (!matchInvited && found) {
        throw Exception('Invited email is still to be found on package page.');
      }
    }
  }
}
