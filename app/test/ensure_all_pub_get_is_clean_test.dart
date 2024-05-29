// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:retry/retry.dart';
import 'package:test/test.dart';

void main() {
  final directories = [
    'app',
    ..._listPkgDirs(),
  ];

  test('known packages', () {
    expect(directories, contains('pkg/_pub_shared'));
    expect(directories, contains('pkg/pub_worker'));
    expect(directories, contains('pkg/web_app'));
  });

  test(
    'ensure pub get',
    () async {
      final workingDirectory = p.join(Directory.current.path, '..');
      await runConstrained(
        ['dart', 'pub', 'get', '--enforce-lockfile'],
        workingDirectory: workingDirectory,
        throwOnError: true,
        retryOptions: RetryOptions(maxAttempts: 2),
        retryIf: (_) => true,
      );
    },
    timeout: Timeout(Duration(minutes: 2)),
  );
}

Iterable<String> _listPkgDirs() sync* {
  for (final d in Directory(p.join('..', 'pkg')).listSync()) {
    if (d is! Directory) continue;
    final pubspecFile = File(p.join(d.path, 'pubspec.yaml'));
    if (pubspecFile.existsSync()) {
      yield p.join('pkg', p.basename(d.path));
    }
  }
}
