// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

final _parser = ArgParser()
  ..addOption('dir', defaultsTo: 'test', help: 'The test directory.')
  ..addOption('name',
      defaultsTo: '_all_tests.dart',
      help: 'The file name to use for all tests.');

/// Generates test/_all_tests.dart that includes reference to all tests.
Future main(List<String> args) async {
  final argv = _parser.parse(args);
  final name = argv['name'] as String;
  final dir = Directory(argv['dir'] as String);

  final files = await dir
      .list(recursive: true)
      .where((fse) => fse is File && fse.path.endsWith('_test.dart'))
      .map((fse) => p.relative(fse.path, from: dir.path))
      .toList();
  files.sort();

  final content = _generateTestContent(files);
  final output = File(p.join(dir.path, name));
  await output.writeAsString(content);
}

String _generateTestContent(List<String> files) {
  final imports = <String>[];
  final calls = <String>[];

  for (String file in files) {
    final alias = file.substring(0, file.length - 10).replaceAll('/', '_');
    imports.add("import '$file' as $alias;");
    calls.add("  group('$file', $alias.main);");
  }

  return '''import 'package:test/test.dart';

${imports.join('\n')}

void main() {
${calls.join('\n')}
}
''';
}
