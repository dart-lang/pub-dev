// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:lcov_dart/lcov_dart.dart';

Map<String, Map<int, int>> _lineExecCounts = <String, Map<int, int>>{};

Future main() async {
  final files = await Directory('build/lcov')
      .list(recursive: true)
      .where((f) => f is File)
      .cast<File>()
      .toList();
  for (File file in files) {
    final coverage = await file.readAsString();
    if (coverage.isEmpty) {
      print('${file.path} is empty.');
      continue;
    }
    final report = Report.fromCoverage(coverage);

    for (final record in report.records) {
      final path = record!.sourceFile;
      final partOfPubDev = path.startsWith('app/') || path.startsWith('pkg/');
      if (partOfPubDev) {
        final counts = _lineExecCounts.putIfAbsent(path, () => <int, int>{});
        for (final lineData in record.lines!.data) {
          counts[lineData.lineNumber] =
              (counts[lineData.lineNumber] ?? 0) + lineData.executionCount;
        }
      }
    }
  }

  for (String path in _lineExecCounts.keys) {
    final counts = _lineExecCounts[path];
    final total = counts!.length;
    final covered = counts.values.where((i) => i > 0).length;
    _add(path, total, covered);
  }

  final output = StringBuffer();

  final libEntries = [
    _tree['app/lib'],
    ..._tree.values
        .where(
            (e) => e.key.startsWith('pkg/') && e.depth == 2 && e.leaf != 'test')
        .where((e) =>
            !e.key.startsWith('pkg/api_builder/') &&
            !e.key.startsWith('pkg/code_coverage/') &&
            !e.key.startsWith('pkg/fake_gcloud/') &&
            !e.key.startsWith('pkg/pub_integration/'))
  ].nonNulls;
  final pubDevEntry = Entry('pub-dev')
    ..covered = libEntries.map((e) => e.covered).reduce((a, b) => a + b)
    ..total = libEntries.map((e) => e.total).reduce((a, b) => a + b);
  output.writeln([
    pubDevEntry.formatted('pub-dev'),
    _tree['app/lib']?.formatted('app'),
    _tree['pkg/web_app/lib']?.formatted('pkg/web_app'),
    _tree['pkg/web_css/lib']?.formatted('pkg/web_css'),
  ].join(', '));

  final keys = _tree.keys.toList()..sort();
  for (String key in keys) {
    final entry = _tree[key];
    final pctStr = entry!.percentAsString;
    final sb = StringBuffer();
    sb.write('   ' * entry.depth);
    sb.write('${entry.leaf} - $pctStr% - ${entry.covered}/${entry.total}');
    // mark some lines with markers
    if (entry.percent < 50.0 || entry.total - entry.covered > 100) {
      sb.write(' [low]');
    }
    output.writeln(sb);
  }

  await File('build/report.txt').writeAsString(output.toString());

  final uncoveredRanges = _lineExecCounts.keys
      .map((path) => _topUncoveredRange(path, _lineExecCounts[path]!))
      .nonNulls
      .where((u) => u.codeLineCount > 0)
      .toList()
    ..sort((a, b) => -a.codeLineCount.compareTo(b.codeLineCount));
  await File('build/uncovered-ranges.txt').writeAsString(uncoveredRanges
      .map((r) => '${r.path} ${r.startLine}-${r.endLine} (${r.codeLineCount})')
      .join('\n'));
}

final _tree = <String, Entry>{};

void _add(String path, int total, int covered) {
  final segments = path.split('/');
  for (int i = 0; i < segments.length; i++) {
    final key = segments.take(i + 1).join('/');
    final entry = _tree.putIfAbsent(key, () => Entry(key));
    entry.depth = i;
    entry.leaf = segments[i];
    entry.total += total;
    entry.covered += covered;
  }
}

class Entry {
  final String key;
  int depth = 0;
  String? leaf;
  int total = 0;
  int covered = 0;

  Entry(this.key);

  double get percent => total == 0 ? 0.0 : covered * 100.0 / total;
  String get percentAsString => percent.toStringAsFixed(1);

  String formatted(String? path) {
    return '$percentAsString% in ${path ?? key} ($covered/$total)';
  }
}

class _UncoveredRange {
  final String path;
  final int startLine;
  final int endLine;
  final int codeLineCount;

  _UncoveredRange(this.path, this.startLine, this.endLine, this.codeLineCount);
}

_UncoveredRange? _topUncoveredRange(String path, Map<int, int> counts) {
  final lines = counts.keys.toList()..sort();
  var uncovered = 0;
  var maxUncovered = 0;
  var maxEndIndex = -1;
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (counts[line] == 0) {
      uncovered++;
      if (maxUncovered < uncovered) {
        maxUncovered = uncovered;
        maxEndIndex = i;
      } else {
        uncovered = 0;
      }
    }
  }
  if (maxEndIndex == -1) return null;
  final maxStartIndex = maxEndIndex - maxUncovered + 1;
  return _UncoveredRange(
      path, lines[maxStartIndex], lines[maxEndIndex], maxUncovered);
}
