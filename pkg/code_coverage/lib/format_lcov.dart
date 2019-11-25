// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:lcov/lcov.dart';

Map<String, Map<int, int>> _lineExecCounts = <String, Map<int, int>>{};

Future main() async {
  final files = await Directory('build/lcov')
      .list()
      .where((f) => f is File)
      .cast<File>()
      .toList();
  for (File file in files) {
    final coverage = await file.readAsString();
    final report = Report.fromCoverage(coverage);

    for (final record in report.records) {
      final path = record.sourceFile;
      final partOfPubDev = path.startsWith('app/') || path.startsWith('pkg/');
      if (partOfPubDev) {
        final counts = _lineExecCounts.putIfAbsent(path, () => <int, int>{});
        for (final lineData in record.lines.data) {
          counts[lineData.lineNumber] =
              (counts[lineData.lineNumber] ?? 0) + lineData.executionCount;
        }
      }
    }
  }

  for (String path in _lineExecCounts.keys) {
    final counts = _lineExecCounts[path];
    final total = counts.length;
    final covered = counts.values.where((i) => i > 0).length;
    _add(path, total, covered);
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
    // mark some lines with markers
    if (pct < 50.0 || entry.total - entry.covered > 100) {
      sb.write(' [low]');
    }
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
