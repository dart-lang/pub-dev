// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Utilities to return the Dart SDK location.
library cli_util;

import 'dart:io';

import 'package:path/path.dart' as path;

import 'src/utils.dart';

/// Return the path to the current Dart SDK.
///
/// This first checks for an explicit SDK listed on the command-line
/// (`--dart-sdk`). It then looks in any `DART_SDK` environment variable. Next,
/// it looks relative to the Dart VM executable. Last, it uses the
/// [Platform.resolvedExecutable] API.
///
/// Callers should generally prefer using the [getSdkPath] function.
@Deprecated('Clients should generally prefer getSdkPath()')
Directory getSdkDir([List<String> cliArgs]) {
  // Look for --dart-sdk on the command line.
  if (cliArgs != null) {
    int index = cliArgs.indexOf('--dart-sdk');

    if (index != -1 && (index + 1 < cliArgs.length)) {
      return new Directory(cliArgs[index + 1]);
    }

    for (String arg in cliArgs) {
      if (arg.startsWith('--dart-sdk=')) {
        return new Directory(arg.substring('--dart-sdk='.length));
      }
    }
  }

  // Look in env['DART_SDK']
  if (Platform.environment['DART_SDK'] != null) {
    return new Directory(Platform.environment['DART_SDK']);
  }

  // Look relative to the dart executable.
  File platformExecutable = new File(Platform.executable);
  Directory sdkDirectory = platformExecutable.parent.parent;
  if (isSdkDir(sdkDirectory)) return sdkDirectory;

  // Handle the case where Platform.executable is a sibling of the SDK directory
  // (this happens during internal testing).
  sdkDirectory =
      new Directory(path.join(platformExecutable.parent.path, 'dart-sdk'));
  if (isSdkDir(sdkDirectory)) return sdkDirectory;

  // Use `Platform.resolvedExecutable`.
  return new Directory(getSdkPath());
}

/// Return the path to the current Dart SDK.
String getSdkPath() => path.dirname(path.dirname(Platform.resolvedExecutable));
