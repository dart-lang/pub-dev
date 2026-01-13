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

  final processKind = Platform.environment['SANDBOX_PROCESS_KIND'] ?? '-';

  final pubProcessKinds = {
    'pub-get',
    'pub-upgrade',
    'pub-downgrade',
    'pub-unpack',
    'pub-outdated',
  };
  final isPubCommand = pubProcessKinds.contains(processKind);

  /// The current working directory / package directory (may be writable, depends on `SANDBOX_PROCESS_KIND`).
  final currentWorkingDir = await Directory.current.absolute
      .resolveSymbolicLinks();
  final writableCurrentWorkingDir = isPubCommand;

  /// The directory identified by `PUB_CACHE` (may be writable, depends on `SANDBOX_PROCESS_KIND`).
  final pubCacheDir = _resolveDirectoryByEnvVar('PUB_CACHE');
  final writablePubCacheDir = isPubCommand;

  /// The directory identified by `SANDBOX_OUTPUT_FOLDER` (if present, is writable).
  final outputDir = _resolveDirectoryByEnvVar('SANDBOX_OUTPUT_FOLDER');

  /// The directory identified by `XDG_CONFIG_HOME` (may be writable, depends on `SANDBOX_PROCESS_KIND`).
  final configHomeDir = _resolveDirectoryByEnvVar('XDG_CONFIG_HOME');
  final writableConfigHomeDir = isPubCommand;

  final readMounts = <String>{
    if (!writableCurrentWorkingDir) currentWorkingDir,
    if (pubCacheDir != null && !writablePubCacheDir) pubCacheDir,
    if (configHomeDir != null && !writableConfigHomeDir) configHomeDir,

    /// The Dart and Flutter SDKs that pana is using (may contain more than one after download).
    ?_resolveDirectory('/home/worker/dart'),
    ?_resolveDirectory('/home/worker/flutter'),

    /// The `webp` binaries.
    ?_resolveDirectory('/home/worker/bin'),
  };

  final writeMounts = <String>{
    if (writableCurrentWorkingDir) currentWorkingDir,
    if (pubCacheDir != null && writablePubCacheDir) pubCacheDir,
    if (configHomeDir != null && writableConfigHomeDir) configHomeDir,
    ?outputDir,
  };

  // TODO: use gvisor
  if (Platform.environment['DEBUG_SANDBOX_RUNNER'] == 'true') {
    print('Read mounts:');
    for (final m in readMounts) {
      print('- $m');
    }

    print('Write mounts:');
    for (final m in writeMounts) {
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
