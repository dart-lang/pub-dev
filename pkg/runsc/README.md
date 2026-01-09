# runsc_dart

A Dart wrapper for **gVisor (`runsc`)** designed to execute untrusted code in
secure ephemeral sandboxes.

This package allows you to spin up lightweight, isolated containers from Dart
 without needing Docker, daemons, or configuration files.

## Features

 * Isolated filesystem:
   * Changes to root filesystem er not persisted after container termination.
   * Read-only and read-write mounts.
 * Sandboxed network with an isolated loopback device, but no internet access.
 * Runs without root, deamons or global state.

## Usage

```dart
import 'dart:io';
import 'package:runsc_dart/runsc_dart.dart';

void main() async {
  // 1. Define where your rootfs is located (e.g., from 'docker export')
  final rootfs = '/path/to/my/rootfs';

  // 2. Start the sandbox
  final proc = await runsc(
    command: '/bin/echo',
    args: ['Hello', 'Secure World'],
    rootFileSystemPath: rootfs,
    // Secure defaults: Network is loopback-only
  );

  // 3. Pipe output to stdout
  await stdout.addStream(proc.stdout);

  // 4. Ensure we wait for cleanup!
  await proc.exitCode;
}
