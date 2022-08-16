// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

final _client = HttpClient();

/// Runs `dart pub get --offline --no-precompile` with pre-populated
/// packages directly downloaded from the storage bucket.
///
/// This allows us to not depend on a running `pub.dev` while deploying
/// a new version.
Future<void> main(List<String> args) async {
  final pkgDir = args.single;
  final pubCachePath =
      Platform.environment['PUB_CACHE'] ?? '$pkgDir/.dart_tool/pub-cache';
  final pubCacheDir = Directory(pubCachePath).absolute;
  print('PUB_CACHE: ${pubCacheDir.path}');
  if (pubCacheDir.existsSync()) {
    pubCacheDir.deleteSync(recursive: true);
  }
  pubCacheDir.createSync(recursive: true);

  final pvs = _parsePubspecLockSync(File('$pkgDir/pubspec.lock'));
  final packages = pvs.keys.toList()..sort();
  for (final package in packages) {
    final version = pvs[package]!;
    for (var retry = 0;; retry++) {
      print('Downloading $package: $version (attempt: ${retry + 1})');
      try {
        await _downloadInto(package, version, pubCacheDir);
        break;
      } catch (e) {
        if (retry >= 8) {
          rethrow;
        }
        await Future.delayed(Duration(seconds: 1));
      }
    }
  }
  _client.close();

  print('Running `dart pub get --offline --no-precompile`');
  final pr = Process.runSync(
    'dart',
    ['pub', 'get', '--offline', '--no-precompile'],
    environment: {'PUB_CACHE': pubCacheDir.path},
    workingDirectory: pkgDir,
  );
  if (pr.exitCode != 0) {
    throw AssertionError(
        'pub get failed with exit code ${pr.exitCode}\n${pr.stdout}\n${pr.stderr}');
  }
  print(pr.stdout);
  print(pr.stderr);
}

/// Returns the map of <package>:<version> pairs from the pubspec.lock file.
/// Only hosted dependencies are included in the result map.
Map<String, String> _parsePubspecLockSync(File file) {
  final versions = <String, String>{};
  final lines = file.readAsLinesSync();
  String? package;
  String? source;
  for (final line in lines) {
    bool startsWithSpaces(int count) =>
        line.startsWith(' ' * count) && !line.startsWith(' ' * (count + 1));
    if (startsWithSpaces(2) && line.endsWith(':')) {
      package = line.trim().split(':').first;
      source = null;
    } else if (startsWithSpaces(4) && package != null) {
      final parts = line.trim().split(':');
      if (parts.first == 'source' && parts.length > 1) {
        source = parts[1].trim();
        continue;
      }
      if (parts.first == 'version' && parts.length > 1) {
        if (source != 'hosted') continue;
        final quoted = parts[1].trim().split('"');
        if (quoted.length == 3 && quoted.first.isEmpty && quoted.last.isEmpty) {
          final version = quoted[1];
          if (version.isNotEmpty) {
            versions[package] = version;
          }
        }
      }
    }
  }
  return versions;
}

/// Downloads the archive and extracts it into
/// [pubCacheDir]/hosted/pub.dartlang.org/[package]-[version]/
Future<void> _downloadInto(
    String package, String version, Directory pubCacheDir) async {
  final targetDir = Directory(
      '${pubCacheDir.path}/hosted/pub.dartlang.org/$package-$version');
  if (targetDir.existsSync()) {
    targetDir.deleteSync(recursive: true);
  }
  targetDir.createSync(recursive: true);
  final rq = await _client.getUrl(Uri.parse(
      'https://storage.googleapis.com/dartlang-pub-public-packages/packages/${Uri.encodeComponent(package)}-${Uri.encodeComponent(version)}.tar.gz'));
  final rs = await rq.close();
  if (rs.statusCode != 200) {
    throw Exception('Unable to access archive of $package-$version.');
  }
  final process =
      await Process.start('tar', ['-zxf', '-', '-C', targetDir.path]);
  await rs.pipe(process.stdin);
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    throw Exception('Unable to extract archive of $package-$version.');
  }
}
