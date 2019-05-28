// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;

Future createFakeRetryPkg(String dir) async {
  await _copy('test_data/retry', dir);
}

Future createDummyPkg(String dir, String version) async {
  await _copy('test_data/_dummy_pkg', dir);
  final pubspecFile = File(p.join(dir, 'pubspec.yaml'));
  final pubspecContent = await pubspecFile.readAsString();
  await pubspecFile.writeAsString('version: $version\n$pubspecContent');
}

Future _copy(String fromDir, String toDir) async {
  final dir = Directory(fromDir);
  final files = await dir
      .list(recursive: true)
      .where((fse) => fse is File)
      .cast<File>()
      .toList();
  for (File file in files) {
    final relativePath = p.relative(file.path, from: fromDir);
    final newPath = p.join(toDir, relativePath);
    final newFile = File(newPath);
    await newFile.parent.create(recursive: true);
    await file.copy(newFile.path);
  }
}
