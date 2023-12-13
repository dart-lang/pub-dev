// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:pub_worker/payload.dart';

final _ciEnv = Platform.environment['CI']?.toLowerCase();
final _isRunningOnCI = _ciEnv == 'true' || _ciEnv == '1';

Future<void> buildDockerImage() async {
  final gitRootDir =
      (await Process.run('git', ['rev-parse', '--show-toplevel']))
          .stdout
          .toString()
          .trim();
  final pr = await Process.start(
    'docker',
    [
      'build',
      '.',
      '--tag=pub_worker',
      '--file=Dockerfile.worker',
    ],
    workingDirectory: gitRootDir,
    mode: ProcessStartMode.inheritStdio,
  );
  final exitCode = await pr.exitCode;
  if (exitCode != 0) {
    throw Exception('process returned with exit code $exitCode');
  }
}

Future<Process> startDockerAnalysis(Payload payload) async {
  return await Process.start(
    'docker',
    <String>[
      'run',
      if (!_isRunningOnCI) '-it',
      '--network=host',
      '--entrypoint=dart',
      '--rm',
      'pub_worker',
      'bin/pub_worker.dart',
      json.encode(payload),
    ],
    mode: ProcessStartMode.inheritStdio,
  );
}
