// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:pub_dev/tool/test_profile/import_source.dart';

import '../shared/test_models.dart';

Future<T> withTempDirectory<T>(Future<T> Function(String temp) func) async {
  final Directory dir =
      await Directory.systemTemp.createTemp('pub.dartlang.org-backend-test');
  try {
    return await func(dir.absolute.path);
  } finally {
    await dir.delete(recursive: true);
  }
}

Future<List<int>> packageArchiveBytes({required String pubspecContent}) async {
  final builder = ArchiveBuilder();
  builder.addFile('README.md', foobarReadmeContent);
  builder.addFile('CHANGELOG.md', foobarChangelogContent);
  builder.addFile('pubspec.yaml', pubspecContent);
  builder.addFile('LICENSE', 'BSD LICENSE 2.0');
  builder.addFile('lib/test_library.dart', 'hello() => print("hello");');
  return builder.toTarGzBytes();
}
