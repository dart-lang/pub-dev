// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.backend_test_utils;

import 'dart:async';
import 'dart:io';

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

Future<List<int>> packageArchiveBytes({String pubspecContent}) async {
  return await withTempDirectory((String tmp) async {
    final readme = File('$tmp/README.md');
    final changelog = File('$tmp/CHANGELOG.md');
    final pubspec = File('$tmp/pubspec.yaml');

    await readme.writeAsString(foobarReadmeContent);
    await changelog.writeAsString(foobarChangelogContent);
    await pubspec.writeAsString(pubspecContent ?? foobarStablePubspec);

    await Directory('$tmp/lib').create();
    File('$tmp/lib/test_library.dart')
        .writeAsString('hello() => print("hello");');

    final files = [
      'README.md',
      'CHANGELOG.md',
      'pubspec.yaml',
      'lib/test_library.dart'
    ];
    final args = ['cz', ...files];
    final Process p =
        await Process.start('tar', args, workingDirectory: '$tmp');
    p.stderr.drain();
    final bytes = await p.stdout.fold<List<int>>([], (b, d) => b..addAll(d));
    final exitCode = await p.exitCode;
    if (exitCode != 0) {
      throw Exception('Failed to make tarball of test package.');
    }
    return bytes;
  });
}
