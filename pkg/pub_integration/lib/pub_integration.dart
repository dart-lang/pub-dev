// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:math';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:pub_semver/pub_semver.dart';

import 'src/pub_client.dart';
import 'src/test_data.dart';

final _random = Random.secure();

typedef InviteCompleterFn = Future Function();

/// Runs the integration tests on the [pubHostedUrl].
Future verifyPubIntegration({
  @required String pubHostedUrl,
  @required String credentialsFile,
  @required String invitedEmail,
  @required InviteCompleterFn inviteCompleterFn,
}) async {
  final integration = _PubIntegration._(
    pubHostedUrl,
    credentialsFile,
    invitedEmail,
    inviteCompleterFn,
  );
  await integration.verify();
}

/// A single object to execute integration tests on the pub site (or a test site).
class _PubIntegration {
  final String pubHostedUrl;
  final String credentialsFile;
  final String invitedEmail;
  final InviteCompleterFn inviteCompleterFn;
  final PubClient _pubClient;

  String _newDummyVersion;
  bool _hasRetry;

  Directory _temp;
  Directory _pubCacheDir;
  Directory _dummyDir;
  Directory _dummyExampleDir;
  Directory _retryDir;

  _PubIntegration._(
    this.pubHostedUrl,
    this.credentialsFile,
    this.invitedEmail,
    this.inviteCompleterFn,
  ) : this._pubClient = PubClient(pubHostedUrl);

  /// Verify all integration steps.
  Future verify() async {
    await _queryVersions();
    _temp = await Directory.systemTemp.createTemp('pub-integration');
    try {
      _pubCacheDir = Directory(path.join(_temp.path, 'pub-cache'));
      await _pubCacheDir.create(recursive: true);
      await File(credentialsFile)
          .copy(path.join(_pubCacheDir.path, 'credentials.json'));

      if (!_hasRetry) {
        await _createFakeRetryPkg();
        await _pubGet(_retryDir);
        await _upload(_retryDir);
      }
      // upload package
      await _createDummyPkg();
      await _pubGet(_dummyDir);
      await _upload(_dummyDir);
      await Future.delayed(Duration(seconds: 1));
      await _verifyDummyPkg();

      // run example
      await _pubGet(_dummyExampleDir);
      await _run(_dummyExampleDir, 'bin/main.dart');

      // add/remove uploader
      await _addUploader();
      await _verifyDummyPkg(matchInvited: true);
      await _removeUploader();
      await _verifyDummyPkg(matchInvited: false);
    } finally {
      await _temp.delete(recursive: true);
    }
  }

  Future _queryVersions() async {
    final retryVersion = await _pubClient.getLatestVersionName('retry');
    _hasRetry = retryVersion != null;

    final dv = await _pubClient.getLatestVersionName('_dummy_pkg');
    final v = Version.parse(dv ?? '0.0.1');
    final build =
        List.generate(5, (i) => _random.nextInt(36).toRadixString(36)).join();
    _newDummyVersion =
        Version(v.major, v.minor, v.patch + 1, build: build).toString();
  }

  Future _createDummyPkg() async {
    _dummyDir = Directory(path.join(_temp.path, 'pkg', '_dummy_pkg'));
    _dummyExampleDir = Directory(path.join(_dummyDir.path, 'example'));
    await _dummyDir.create(recursive: true);
    await createDummyPkg(_dummyDir.path, _newDummyVersion);
  }

  Future _createFakeRetryPkg() async {
    _retryDir = Directory(path.join(_temp.path, 'pkg', 'retry'));
    await _retryDir.create(recursive: true);
    await createFakeRetryPkg(_retryDir.path);
  }

  Future _pubGet(Directory dir) async {
    await _runProc('pub', ['get'], workingDirectory: dir.path);
  }

  Future _upload(Directory dir) async {
    await _runProc('pub', ['publish', '--force'], workingDirectory: dir.path);
  }

  Future _run(Directory dir, String file) async {
    await _runProc('dart', [file], workingDirectory: dir.path);
  }

  Future _verifyDummyPkg({bool matchInvited}) async {
    final dv = await _pubClient.getLatestVersionName('_dummy_pkg');
    if (dv != _newDummyVersion) {
      throw Exception(
          'Expected version does not match: $dv != $_newDummyVersion');
    }

    final pageHtml = await _pubClient.getLatestVersionPage('_dummy_pkg');
    if (!pageHtml.contains(_newDummyVersion)) {
      throw Exception('New version is not to be found on package page.');
    }
    if (!pageHtml.contains('developer@example.com')) {
      throw Exception(
          'pubspec author field is not to be found on package page.');
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

  Future _addUploader() async {
    await _runProc(
      'pub',
      ['uploader', 'add', invitedEmail],
      workingDirectory: _dummyDir.path,
      expectedError:
          'We have sent an invitation to $invitedEmail, they will be added as uploader after they confirm it.',
    );
    await inviteCompleterFn();
  }

  Future _removeUploader() async {
    await _runProc(
      'pub',
      ['uploader', 'remove', invitedEmail],
      workingDirectory: _dummyDir.path,
    );
  }

  Future<ProcessResult> _runProc(
    String executable,
    List<String> arguments, {
    String workingDirectory,
    Map<String, String> environment,
    String expectedError,
  }) async {
    final cmd = '$executable ${arguments.join(' ')}';
    print('Running $cmd in $workingDirectory...');
    environment ??= <String, String>{};
    environment['PUB_CACHE'] = _pubCacheDir.path;
    environment['PUB_HOSTED_URL'] = pubHostedUrl;

    final pr = await Process.run(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      environment: environment,
    );
    if (pr.exitCode == 0) return pr;
    if (expectedError == pr.stderr.toString().trim()) return pr;
    throw Exception('$cmd failed with exit code ${pr.exitCode}.\n'
        'STDOUT: ${pr.stdout}\n'
        'STDERR: ${pr.stderr}');
  }
}
