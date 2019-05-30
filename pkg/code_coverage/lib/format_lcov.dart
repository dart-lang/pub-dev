// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:lcov/lcov.dart';

Future main() async {
  final coverage = await File('build/lcov.info').readAsString();
  final report = Report.fromCoverage(coverage);

  for (final record in report.records) {
    if (record.sourceFile.startsWith('app/') ||
        record.sourceFile.startsWith('pkg/')) {
      _add(record.sourceFile, record.lines.found, record.lines.hit);
    }
  }

  final output = StringBuffer();

  final keys = _tree.keys.toList()..sort();
  for (String key in keys) {
    final entry = _tree[key];
    final pct = entry.total == 0 ? 0.0 : entry.covered * 100.0 / entry.total;
    final pctStr = pct.toStringAsFixed(1);
    final sb = StringBuffer();
    sb.write('   ' * entry.depth);
    sb.write('${entry.leaf} - $pctStr% - ${entry.covered}/${entry.total}');
    output.writeln(sb);
  }

  await File('build/report.txt').writeAsString(output.toString());
}

final _tree = <String, Entry>{};

void _add(String path, int total, int covered) {
  final segments = path.split('/');
  for (int i = 0; i < segments.length; i++) {
    final key = segments.take(i + 1).join('/');
    final entry = _tree.putIfAbsent(key, () => Entry());
    entry.depth = i;
    entry.leaf = segments[i];
    entry.total += total;
    entry.covered += covered;
  }
}

class Entry {
  int depth = 0;
  String leaf;
  int total = 0;
  int covered = 0;
}
