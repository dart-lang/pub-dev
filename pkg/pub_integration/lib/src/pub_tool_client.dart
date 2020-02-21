// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

/// Command line pub interface.
class PubToolClient {
  final String _dartSdkDir;
  final String _pubHostedUrl;
  final Directory _tempDir;
  final Directory _pubCacheDir;

  PubToolClient._(
    this._dartSdkDir,
    this._pubHostedUrl,
    this._tempDir,
    this._pubCacheDir,
  );

  /// Creates a new PubToolClient context with a temporary directory.
  static Future<PubToolClient> create({
    @required String pubHostedUrl,
    @required String credentialsFileContent,
    String dartSdkDir,
  }) async {
    final dir = await Directory.systemTemp.createTemp();
    final pubCacheDir = Directory(p.join(dir.path, 'pub-cache'));
    await pubCacheDir.create(recursive: true);
    await File(p.join(pubCacheDir.path, 'credentials.json'))
        .writeAsString(credentialsFileContent);
    return PubToolClient._(dartSdkDir, pubHostedUrl, dir, pubCacheDir);
  }

  /// Delete temp resources.
  Future<void> close() async {
    await _tempDir?.delete(recursive: true);
  }

  /// Runs a process.
  Future<ProcessResult> runProc(
    String executable,
    List<String> arguments, {
    String workingDirectory,
    Map<String, String> environment,
    String expectedError,
  }) async {
    final fullPathExecutable = _dartSdkDir == null
        ? executable
        : p.join(_dartSdkDir, 'bin', executable);
    final cmd = '$fullPathExecutable ${arguments.join(' ')}';
    print('Running $cmd in $workingDirectory...');
    environment ??= <String, String>{};
    environment['PUB_CACHE'] = _pubCacheDir.path;
    environment['PUB_HOSTED_URL'] = _pubHostedUrl;

    final pr = await Process.run(
      fullPathExecutable,
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

  Future<ProcessResult> getDependencies(String pkgDir) async {
    return await runProc('pub', ['get'], workingDirectory: pkgDir);
  }

  Future<ProcessResult> publish(String pkgDir, {String expectedError}) async {
    return await runProc(
      'pub',
      ['publish', '--force'],
      workingDirectory: pkgDir,
      expectedError: expectedError,
    );
  }

  Future<ProcessResult> addUploader(String pkgDir, String email) async {
    return await runProc(
      'pub',
      ['uploader', 'add', email],
      workingDirectory: pkgDir,
      expectedError:
          'We have sent an invitation to $email, they will be added as uploader after they confirm it.',
    );
  }

  Future<ProcessResult> removeUploader(String pkgDir, String email) async {
    return await runProc(
      'pub',
      ['uploader', 'remove', email],
      workingDirectory: pkgDir,
    );
  }
}
