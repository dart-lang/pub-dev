// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;

Future<String> _testDataFolder() async {
  final u = await Isolate.resolvePackageUri(Uri.parse(
    'package:pub_integration/pub_integration.dart',
  ));
  return p.join(p.dirname(u!.toFilePath()), '..', 'test_data');
}

Future createFakeRetryPkg(String dir) async {
  await _copy(p.join(await _testDataFolder(), 'retry'), dir);
}

Future createDummyPkg(String dir, String? version,
    {int changelogContentSizeInKB = 0}) async {
  await _copy(p.join(await _testDataFolder(), '_dummy_pkg'), dir);
  final pubspecFile = File(p.join(dir, 'pubspec.yaml'));
  final pubspecContent = await pubspecFile.readAsString();
  await pubspecFile.writeAsString('version: $version\n$pubspecContent');

  final changelogFile = File(p.join(dir, 'CHANGELOG.md'));
  final changelogContent = StringBuffer('## $version\n\n - changes\n');
  for (var i = 0; i < changelogContentSizeInKB; i++) {
    changelogContent.write('\n0123456789abcde');
    changelogContent.write('0123456789abcde\n' * 63);
  }
  await changelogFile.writeAsString(changelogContent.toString());
}

Future _copy(String fromDir, String toDir) async {
  final dir = Directory(fromDir);
  final files = await dir
      .list(recursive: true)
      .where((fse) => fse is File)
      .cast<File>()
      .toList();
  for (final file in files) {
    final relativePath = p.relative(file.path, from: fromDir);
    final newPath = p.join(toDir, relativePath);
    final newFile = File(newPath);
    await newFile.parent.create(recursive: true);
    await file.copy(newFile.path);
  }
}
