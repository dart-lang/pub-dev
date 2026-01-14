// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

/// Runs the provided [args] list and runs it in a sandbox.
Future<void> main(List<String> args) async {
  final needsNetwork =
      Platform.environment['SANDBOX_NETWORK_ENABLED'] == 'true';

  final passThroughKeys = {
    'CI',
    'NO_COLOR',
    'PATH',
    'XDG_CONFIG_HOME',
    'FLUTTER_ROOT',
    'PUB_ENVIRONMENT',
    'PUB_HOSTED_URL',
  };
  final environment = Map.fromEntries(
    Platform.environment.entries.where((e) => passThroughKeys.contains(e.key)),
  );

  /// The current working directory / package directory.
  final currentWorkingDir = await Directory.current.absolute
      .resolveSymbolicLinks();

  /// The directory identified by `PUB_CACHE`.
  final pubCacheDir = _resolveDirectoryByEnvVar('PUB_CACHE');

  /// The directories identified by `SANDBOX_OUTPUT_FOLDER` (if present, is writable).
  final outputFolderDirs = (Platform.environment['SANDBOX_OUTPUT_FOLDER'] ?? '')
      .split(':')
      .toSet()
      .where((e) => e.isNotEmpty)
      .map(_resolveDirectory)
      .nonNulls
      .toList();

  /// The directory identified by `XDG_CONFIG_HOME` (may be writable, depends on `SANDBOX_PROCESS_KIND`).
  final configHomeDir = _resolveDirectoryByEnvVar('XDG_CONFIG_HOME');

  final allMounts = <String>{
    currentWorkingDir,
    ?pubCacheDir,
    ?configHomeDir,

    /// The Dart and Flutter SDKs that pana is using (may contain more than one after download).
    ?_resolveDirectory('/home/worker/dart'),
    ?_resolveDirectory('/home/worker/flutter'),

    /// The `webp` binaries.
    ?_resolveDirectory('/home/worker/bin'),

    // output directories
    ...outputFolderDirs,
  };

  final readOnlyMounts = allMounts
      .where((e) => !outputFolderDirs.contains(e))
      .toList();

  // TODO: use gvisor
  if (Platform.environment['DEBUG_SANDBOX_RUNNER'] == 'true') {
    print('Read mounts:');
    for (final m in readOnlyMounts) {
      print('- $m');
    }

    print('Write mounts:');
    for (final m in outputFolderDirs) {
      print('- $m');
    }

    print('Needs network: $needsNetwork');
  }

  final p = await Process.start(
    args.first,
    args.skip(1).toList(),
    mode: ProcessStartMode.inheritStdio,
    environment: environment,
    includeParentEnvironment: false,
    runInShell: false,
    workingDirectory: currentWorkingDir,
  );
  exit(await p.exitCode);
}

String? _resolveDirectoryByEnvVar(String key) {
  final value = Platform.environment[key];
  if (value == null) {
    return null;
  }
  return _resolveDirectory(value);
}

String? _resolveDirectory(String path) {
  if (FileSystemEntity.isDirectorySync(path)) {
    return Directory(path).absolute.resolveSymbolicLinksSync();
  }
  return null;
}
