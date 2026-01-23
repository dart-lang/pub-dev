// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Wrap `runsc` to run commands in a gVisor sandbox without networking.
library;

import 'dart:async' show unawaited;
import 'dart:convert' show json;
import 'dart:io' show Directory, File, Process, ProcessStartMode;

final class Mount {
  final String source;
  final String destination;
  final String type;
  final List<String> options;

  Mount({
    required this.source,
    required this.destination,
    required this.type,
    required this.options,
  });

  /// Recursively mount [source] to [destination] in read-only mode.
  ///
  /// This is an `bind` mount with options:
  /// - `ro`: mount read-only
  /// - `rbind`: recursively mount sub-directories and nested mounts
  /// - `nosuid`: do not allow set-user-identifier or set-group-identifier bits to take effect
  /// - `nodev`: do not interpret character or block special devices on the filesystem
  Mount.sandboxReadOnly({required this.source, required this.destination})
    : type = 'bind',
      options = ['ro', 'rbind', 'nosuid', 'nodev'];

  /// Recursively mount [source] to [destination] in read-write mode.
  ///
  /// This is an `bind` mount with options:
  /// - `rw`: mount read-write
  /// - `rbind`: recursively mount sub-directories and nested mounts
  /// - `noexec`: do not allow direct execution of executables on the filesystem
  /// - `nosuid`: do not allow set-user-identifier or set-group-identifier bits to take effect
  /// - `nodev`: do not interpret character or block special devices on the filesystem
  Mount.sandboxReadWrite({required this.source, required this.destination})
    : type = 'bind',
      options = ['rw', 'rbind', 'noexec', 'nosuid', 'nodev'];
}

/// Represents a Linux resource limit (rlimit) configuration for the sandbox.
final class ResourceLimit {
  final String type;
  final int hard;
  final int soft;

  const ResourceLimit({
    required this.type,
    required this.hard,
    required this.soft,
  });

  /// Limits the number of open file descriptors (files, sockets, pipes).
  const ResourceLimit.noFileLimit(this.hard, [int? soft])
    : type = 'RLIMIT_NOFILE',
      soft = soft ?? hard;

  /// Limits the number of processes/threads to prevent fork bombs.
  const ResourceLimit.noProcessLimit(this.hard, [int? soft])
    : type = 'RLIMIT_NPROC',
      soft = soft ?? hard;

  /// Limits the maximum size (in bytes) of a single file the process can create.
  const ResourceLimit.fileSizeLimit(this.hard, [int? soft])
    : type = 'RLIMIT_FSIZE',
      soft = soft ?? hard;

  /// Limits the size of core dump files; set to 0 to disable them entirely.
  const ResourceLimit.coreDumpLimit(this.hard, [int? soft])
    : type = 'RLIMIT_CORE',
      soft = soft ?? hard;

  static const simpleSandboxLimits = [
    ResourceLimit.noFileLimit(8 * 1096),
    ResourceLimit.noProcessLimit(4 * 1024),
    ResourceLimit.fileSizeLimit(4 * 1024 * 1024 * 1024),
    ResourceLimit.coreDumpLimit(0), // disable core dumps
  ];
}

/// Executes the [command] inside a secure gVisor sandbox using the `runsc` runtime.
///
/// This function creates a temporary OCI runtime bundle (`config.json`) and
/// launches the container. It is designed for executing untrusted code where
/// inputs and outputs are handled via file system mounts and/or standard I/O.
///
/// **Prerequisites:**
/// * A prepared root filesystem (rootfs) at [rootFileSystemPath].
///   This generally comes from `docker export`.
/// * The `runsc` binary installed on the host.
/// * The `unshare` utility (if [rootless] is true).
///
/// **Security & Isolation:**
/// * **Network:** Defaults to [NetworkMode.sandbox] which provides a loopback
///   interface (127.0.0.1) but no external network access.
/// * **Filesystem:** The rootfs is mounted with an overlay, such that changes
///   are not persisted to the host disk. Use [mounts] to explicitly grant
///   read-only or read-write access to specific host directories.
/// * **Resources:** Default limits prevent fork bombs (PID exhaustion) and
///   excessive file descriptor usage. Provide [memoryLimit] to cap RAM usage.
///
/// **Example:**
/// ```dart
/// final proc = await runsc(
///   command: '/usr/bin/dart',
///   args: ['analyze', '/input/project'],
///   rootFileSystemPath: '/path/to/extracted/rootfs',
///   mounts: [
///     Mount.sandboxReadOnly(source: '/host/src', destination: '/input/project'),
///   ],
/// );
/// await proc.exitCode;
/// ```
///
/// ## Caveats
///
/// * **File Synchronization:** gVisor caches file attributes. Modifications to
///   mounted files on the host during execution may not propagate immediately
///   to the sandbox. Treat inputs as immutable while running.
/// * **Rootless Limitations:** When [rootless] is true, [memoryLimit] and
///   CPU limits are ignored because unprivileged users cannot modify cgroups.
/// * **Cleanup:** Always await [Process.exitCode] or explicitly kill the
///   process to ensure the sandbox is terminated and temporary state
///   directories are deleted.
Future<Process> runsc({
  String runscExecutable = 'runsc',
  String cwd = '/',
  required String command,
  List<String> args = const [],
  String hostname = 'runsc',
  Map<String, String> env = const {
    'PATH': '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    'TERM': 'xterm',
  },
  String username = 'root',
  int uid = 0,
  int gid = 0,
  required String rootFileSystemPath,
  bool rootFileSystemReadOnly = false,
  List<Mount> mounts = const [],
  List<ResourceLimit> resourceLimits = ResourceLimit.simpleSandboxLimits,
  NetworkMode network = NetworkMode.sandbox,
  InterceptionPlatform platform = InterceptionPlatform.systrap,
  bool rootless = false,
  int? memoryLimit,
  ProcessStartMode? processStartMode,
  String? debugLogDir,
}) async {
  if (env.keys.any((k) => k.contains('='))) {
    throw ArgumentError.value(
      env,
      'env',
      'Environment variable keys cannot contain "="',
    );
  }

  if (runscExecutable.contains('/')) {
    runscExecutable = File(runscExecutable).absolute.path;
  }

  final absoluteRootFs = File(rootFileSystemPath).absolute.path;

  final config = json.encode({
    'ociVersion': '1.0.0',
    'process': {
      'user': {'uid': uid, 'gid': gid, 'username': username},
      'args': [command, ...args],
      'env': [for (final entry in env.entries) '${entry.key}=${entry.value}'],
      'cwd': cwd,
      'capabilities': {
        'bounding': [],
        'effective': [],
        'inheritable': [],
        'permitted': [],
        'ambient': [],
      },
      'rlimits': [
        for (final r in resourceLimits)
          {'type': r.type, 'hard': r.hard, 'soft': r.soft},
      ],
    },
    'root': {'path': absoluteRootFs, 'readonly': rootFileSystemReadOnly},
    'hostname': hostname,
    'mounts': [
      {'destination': '/proc', 'type': 'proc', 'source': 'proc'},
      {'destination': '/dev', 'type': 'tmpfs', 'source': 'tmpfs'},
      {
        'destination': '/sys',
        'type': 'sysfs',
        'source': 'sysfs',
        'options': ['nosuid', 'noexec', 'nodev', 'ro'],
      },
      for (final m in mounts)
        {
          'destination': m.destination,
          'source': File(m.source).absolute.path,
          'type': m.type,
          'options': m.options,
        },
    ],
    'linux': {
      'namespaces': [
        {'type': 'pid'},
        if (network != NetworkMode.host) {'type': 'network'},
        {'type': 'ipc'},
        {'type': 'uts'},
        {'type': 'mount'},
      ],
      'maskedPaths': [
        '/proc/kcore',
        '/proc/latency_stats',
        '/proc/timer_list',
        '/proc/sched_debug',
        '/sys/firmware',
      ],
      'readonlyPaths': [
        '/proc/bus',
        '/proc/fs',
        '/proc/irq',
        if (network == NetworkMode.host) '/proc/net',
        '/proc/sys',
        '/proc/sysrq-trigger',
      ],
      'resources': {
        if (memoryLimit != null)
          'memory': {
            'limit': memoryLimit,
            'swap': memoryLimit, // disable swap by setting same as limit
          },
      },
    },
  });

  final tmp = await Directory.systemTemp.createTemp('runsc-');
  try {
    await File.fromUri(tmp.uri.resolve('config.json')).writeAsString(config);
    final stateDir = await Directory.fromUri(tmp.uri.resolve('state')).create();

    var executable = runscExecutable;
    var processArgs = [
      if (rootless) '--rootless',
      if (debugLogDir != null) ...[
        '--debug',
        '--debug-log=/tmp/runsc/',
        '--strace',
      ],
      '--network=${network.name}',
      '--platform=${platform.name}',
      '--root=${stateDir.path}',
      '--overlay2=root:self',
    ];

    if (rootless) {
      // If rootless, 'unshare' is the executable, runsc becomes an argument
      processArgs = [
        '-r',
        if (network != NetworkMode.host) '-n',
        executable,
        ...processArgs,
        '--ignore-cgroups',
      ];
      executable = 'unshare';
    }

    // Add the command verb and a container ID (using "sandbox" or random string)
    processArgs.addAll(['run', 'sandbox']);

    final proc = await Process.start(
      executable,
      processArgs,
      workingDirectory: tmp.path,
      includeParentEnvironment: false,
      runInShell: false,
      mode: processStartMode ?? ProcessStartMode.normal,
    );
    unawaited(
      proc.exitCode.whenComplete(() async {
        try {
          await tmp.delete(recursive: true);
        } catch (e) {
          // ignore cleanup errors
        }
      }),
    );
    return proc;
  } catch (_) {
    try {
      await tmp.delete(recursive: true);
    } catch (e) {
      // ignore cleanup errors
    }
    rethrow;
  }
}

/// The interception platform used by gVisor to capture system calls.
enum InterceptionPlatform {
  /// Default. Uses a seccomp-bpf filter to trap system calls. Works everywhere.
  systrap,

  /// Uses hardware virtualization. Requires `/dev/kvm` access. Faster for CPU heavy tasks.
  kvm,

  /// Legacy mechanism. Slow. Generally avoid.
  ptrace,
}

/// Defines how the sandbox interacts with the host network.
enum NetworkMode {
  /// Isolated network namespace with a loopback device (127.0.0.1).
  /// No external internet access. Best for untrusted code.
  sandbox,

  /// No network stack at all. Even loopback is disabled.
  none,

  /// Shares the host network. DANGEROUS for untrusted code.
  host,
}
