// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;

Future<void> main() async {
  final cwd = Directory.current.absolute;
  if (!cwd.path.endsWith('code_coverage')) {
    print('Must run from pkg/code_coverage directory.');
    exit(1);
  }
  final buildOutputDir = Directory(p.join(cwd.path, 'build'));

  final projectDir = cwd.parent.parent;
  final listPkgs = Directory(p.join(projectDir.path, 'pkg'))
      .listSync()
      .whereType<Directory>()
      .map((e) => p.basename(e.path))
      .toList()
    ..sort();
  final skipPkgDirs = [
    'api_builder',
    'code_coverage',
    'pub_dartdoc', // TODO: investigate why this is stalled and does not complete
    'pub_integration',
    'web_app',
    'web_css',
  ];
  for (final pkg in listPkgs) {
    if (skipPkgDirs.contains(pkg)) continue;

    final pkgDir = p.join(projectDir.path, 'pkg', pkg);
    final rawOutputDir = p.join(buildOutputDir.path, 'raw', 'pkg', pkg);
    await Directory(rawOutputDir).create(recursive: true);
    print('Running test in pkg/$pkg...');
    await Process.run(
      'dart',
      [
        'test',
        '--run-skipped',
        '--coverage',
        rawOutputDir,
      ],
      workingDirectory: pkgDir,
    );
    print('Formatting coverage in pkg/$pkg...');
    await Process.run(
      'dart',
      [
        'run',
        'coverage:format_coverage',
        '--packages',
        p.join(projectDir.path, '.dart_tool', 'package_config.json'),
        '-i',
        rawOutputDir,
        '--base-directory',
        projectDir.path,
        '--lcov',
        '--out',
        p.join(buildOutputDir.path, 'lcov', 'pkg', '$pkg.json.info'),
      ],
      workingDirectory: pkgDir,
    );
  }
}
