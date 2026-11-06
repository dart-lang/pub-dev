// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/data/task_payload.dart';

final _ciEnv = Platform.environment['CI']?.toLowerCase();
final _isRunningOnCI = _ciEnv == 'true' || _ciEnv == '1';

Future<void> buildAppDockerImage() async {
  await _buildDockerImage(path: 'Dockerfile.app', image: 'pub_app');
}

Future<void> buildWorkerDockerImage() async {
  await _buildDockerImage(path: 'Dockerfile.worker', image: 'pub_worker');
}

/// Runs the `pub_app` image built by [buildAppDockerImage] with [args] passed
/// to its entrypoint (the server), and returns the output of the process.
///
/// Throws if the process exits with a non-zero exit code.
Future<String> runAppDockerImage(List<String> args) async {
  final pr = await Process.run('docker', ['run', '--rm', 'pub_app', ...args]);
  if (pr.exitCode != 0) {
    throw Exception(
      'docker run exited with code ${pr.exitCode}\n'
      'stdout:\n${pr.stdout}\nstderr:\n${pr.stderr}',
    );
  }
  return pr.stdout.toString();
}

Future<void> _buildDockerImage({
  required String path,
  required String image,
}) async {
  final gitRootDir = (await Process.run('git', [
    'rev-parse',
    '--show-toplevel',
  ])).stdout.toString().trim();
  final pr = await Process.start(
    'docker',
    ['build', '.', '--tag=$image', '--file=$path'],
    workingDirectory: gitRootDir,
    mode: ProcessStartMode.inheritStdio,
  );
  final exitCode = await pr.exitCode;
  if (exitCode != 0) {
    throw Exception('process returned with exit code $exitCode');
  }
}

Future<Process> startDockerAnalysis(Payload payload) async {
  return await Process.start('docker', <String>[
    'run',
    if (!_isRunningOnCI) '-it',
    '--network=host',
    '--entrypoint=dart',
    '--rm',
    '--privileged',
    'pub_worker',
    'bin/pub_worker.dart',
    json.encode(payload),
  ], mode: ProcessStartMode.inheritStdio);
}
