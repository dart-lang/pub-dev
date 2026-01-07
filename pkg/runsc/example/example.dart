// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:runsc/runsc.dart';

Future<void> main() async {
  final proc = await runsc(
    runscExecutable: './runsc',
    env: {
      'PATH': '/dart-sdk/bin',
      'TERM': 'xterm',
      'PUB_CACHE': '/input/pub-cache',
    },
    command: 'dart',
    args: ['analyze'],
    cwd: '/input/package/',
    hostname: 'sandbox',
    network: NetworkMode.sandbox,
    memoryLimit: 4 * 1024 * 1024 * 1024,
    platform: InterceptionPlatform.systrap,
    resourceLimits: ResourceLimit.simpleSandboxLimits,
    rootless: true,
    rootFileSystemPath: 'rootfs',
    mounts: [
      Mount.sandboxReadWrite(source: 'input', destination: '/input'),
      Mount.sandboxReadOnly(source: 'dart-sdk', destination: '/dart-sdk'),
    ],
  );

  unawaited(stdout.addStream(proc.stdout));
  unawaited(stderr.addStream(proc.stderr));

  print('Exit code: ${await proc.exitCode}');
}
