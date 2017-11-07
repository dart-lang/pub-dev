// Copyright 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:io/io.dart';

/// Runs `dartfmt` commands and `pub publish`.
Future<Null> main() async {
  final manager = new ProcessManager();

  // Runs dartfmt --version and outputs the result via stdout.
  print('Running dartfmt --version');
  var spawn = await manager.spawn('dartfmt', ['--version']);
  await spawn.exitCode;

  // Runs dartfmt -n . and outputs the result via stdout.
  print('Running dartfmt -n .');
  spawn = await manager.spawn('dartfmt', ['-n', '.']);
  await spawn.exitCode;

  // Runs pub publish. Upon hitting a blocking stdin state, you may directly
  // output to the processes's stdin via your own, similar to how a bash or
  // shell script would spawn a process.
  print('Running pub publish');
  spawn = await manager.spawn('pub', ['publish']);
  await spawn.exitCode;

  // Closes stdin for the entire program.
  await sharedStdIn.terminate();
}
