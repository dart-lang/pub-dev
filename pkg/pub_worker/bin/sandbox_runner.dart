// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:runsc/runsc.dart';

/// Runs the provided [args] list and runs it in a sandbox.
Future<void> main(List<String> args) async {
  final passThroughKeys = {
    'CI',
    'NO_COLOR',
    'PATH',
    'HOME',
    'XDG_CONFIG_HOME',
    'FLUTTER_ROOT',
    'PUB_CACHE',
    'PUB_ENVIRONMENT',
    'PUB_HOSTED_URL',
  };
  final environment = Map.fromEntries(
    Platform.environment.entries.where((e) => passThroughKeys.contains(e.key)),
  );

  /// The current working directory / package directory.
  final currentWorkingDir = await Directory.current.absolute
      .resolveSymbolicLinks();

  final needsNetwork =
      Platform.environment['SANDBOX_NETWORK_ENABLED'] == 'true';

  /// The directory identified by `PUB_CACHE`.
  final pubCacheDir = _resolveDirectoryByEnvVar('PUB_CACHE');

  /// The directories identified by `SANDBOX_OUTPUT` (if present, is writable).
  final outputFolders = (Platform.environment['SANDBOX_OUTPUT'] ?? '')
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
    ?_resolveDirectory('/home/worker/dartdoc'),
    ?_resolveDirectory('/home/worker/dart'),
    ?_resolveDirectory('/home/worker/flutter'),

    /// The `webp` binaries.
    ?_resolveDirectory('/home/worker/bin'),

    // output directories
    ...outputFolders,
  };

  final readOnlyMounts = allMounts
      .where((e) => !outputFolders.contains(e))
      .toList();

  final p = await runsc(
    runscExecutable: '/home/worker/gvisor/runsc',
    env: {'TERM': 'xterm', ...environment},
    command: args.first,
    args: args.skip(1).toList(),
    cwd: currentWorkingDir,
    hostname: 'sandbox',
    network: needsNetwork ? NetworkMode.host : NetworkMode.sandbox,
    memoryLimit: 4 * 1024 * 1024 * 1024,
    platform: InterceptionPlatform.systrap,
    resourceLimits: ResourceLimit.simpleSandboxLimits,
    rootless: true,
    rootFileSystemPath: '/home/worker/sandbox-rootfs',
    mounts: [
      ...readOnlyMounts.map(
        (v) => Mount.sandboxReadOnly(source: v, destination: v),
      ),
      ...outputFolders.map(
        (v) => Mount.sandboxReadWrite(source: v, destination: v),
      ),
    ],
    processStartMode: ProcessStartMode.inheritStdio,
    debugLogDir: Platform.environment['SANDBOX_DEBUG_LOG_DIR'],
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
