// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

final _client = HttpClient();

/// Fetches and populates a local .pub-cache directory without using `pub`
/// client and `pub.dev` services.
Future<void> main(List<String> args) async {
  final baseDir = File(Platform.script.toFilePath()).parent.parent;
  print('Base directory: $baseDir');

  final pubCacheDir = Directory('${baseDir.path}/build/pub-cache');
  print('PUB_CACHE_DIR: ${pubCacheDir.path}');
  pubCacheDir.createSync(recursive: true);

  final multiVersions = <String, Set<String>>{};
  final lockFiles = baseDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => !f.path.contains('/pkg/code_coverage/'))
      .where((f) => !f.path.contains('/pkg/pub_integration/'))
      .where((f) => f.path.endsWith('pubspec.lock'));
  for (final f in lockFiles) {
    print('Parsing ${f.path} ...');
    final pvs = _parsePubspecLockSync(f);
    for (final package in pvs.keys) {
      multiVersions.putIfAbsent(package, () => <String>{}).add(pvs[package]!);
    }
  }

  final packages = multiVersions.keys.toList()..sort();
  for (final package in packages) {
    final versions = multiVersions[package]!.toList()..sort();
    print('Found $package: $versions ...');
    for (final version in versions) {
      await _downloadInto(package, version, pubCacheDir);
    }
  }
  _client.close();
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
  if (targetDir.existsSync() &&
      File('${targetDir.path}/pubspec.yaml').existsSync()) {
    print('- $package-$version already exists');
    return;
  }
  targetDir.createSync(recursive: true);
  final rq = await _client.getUrl(Uri.parse(
      'https://storage.googleapis.com/pub-packages/packages/${Uri.encodeComponent(package)}-${Uri.encodeComponent(version)}.tar.gz'));
  final rs = await rq.close();
  if (rs.statusCode != 200) {
    throw AssertionError('Unable to access archive of $package-$version.');
  }
  final bodyChunks = await rs.toList();

  final process =
      await Process.start('tar', ['-zxf', '-', '-C', targetDir.path]);
  for (final chunk in bodyChunks) {
    process.stdin.add(chunk);
  }
  await process.stdin.close();
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    throw AssertionError('Unable to extract archive of $package-$version.');
  }
  print('- $package-$version downloaded');
}
