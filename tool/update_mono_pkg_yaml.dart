// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

/// Updates mono_pkg.yaml files with the current Dart SDK runtime.
/// When an extra command line argument is provided, it will be used
/// instead of the current Dart SDK runtime.
void main(List<String> args) {
  final sdkVersion =
      args.isEmpty ? Platform.version.split(' ').first : args.first;

  final baseDir = _inferPubDevBaseDir();
  final packagePaths = _detectPackagePaths(baseDir);

  for (final path in packagePaths) {
    _updatePackage('$baseDir/$path', sdkVersion);
  }
}

String _inferPubDevBaseDir() {
  return Platform.script
      .toFilePath()
      .split('/')
      .reversed
      .skip(2)
      .toList()
      .reversed
      .join('/');
}

List<String> _detectPackagePaths(String baseDir) {
  return <String>[
    'app',
    ...Directory('$baseDir/pkg')
        .listSync()
        .whereType<Directory>()
        .map((d) => d.path.split('/').last)
        .map((e) => 'pkg/$e')
        .toList(),
  ];
}

void _updatePackage(String path, String sdkVersion) {
  final monoPkg = File('$path/mono_pkg.yaml');
  if (monoPkg.existsSync()) {
    print('updating: ${monoPkg.path}');
    final lines = monoPkg.readAsLinesSync();
    final index = lines.indexOf('sdk:');
    if (index >= 0 &&
        index + 2 < lines.length &&
        lines[index + 1].startsWith('  - ') &&
        lines[index + 2].isEmpty) {
      lines[index + 1] = '  - $sdkVersion';
      monoPkg.writeAsStringSync(lines.join('\n') + '\n');
    }
  }
}
