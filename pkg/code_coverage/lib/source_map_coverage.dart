// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart';
import 'package:source_maps/parser.dart';

final _pathHashRegexp = RegExp('/static/(hash-[a-z0-9]+/)');

/// Converts the browser-provided JS and CSS coverage information (using the
/// compiled source maps) into LCOV format.
Future<void> main() async {
  final scriptFiles = Directory('../../static/js')
      .listSync()
      .map((e) => e.path)
      .where((e) => e.endsWith('.js.map'))
      .map((e) => e.substring(5, e.length - 4))
      .toList();
  final coverageFiles =
      Directory('build/puppeteer').listSync(recursive: true).whereType<File>();
  for (final coverageFile in coverageFiles) {
    if (coverageFile.path.endsWith('.js.json')) {
      final name = basename(coverageFile.path);
      await _process(
        staticPaths: scriptFiles,
        coveragePath: coverageFile.path,
        outputPath: 'build/lcov/puppeteer-$name.info',
      );
    }

    if (coverageFile.path.endsWith('.css.json')) {
      final name = basename(coverageFile.path);
      await _process(
        staticPaths: ['/static/css/style.css'],
        coveragePath: coverageFile.path,
        outputPath: 'build/lcov/puppeteer-$name.info',
      );
    }
  }
}

Future<void> _process({
  required String coveragePath,
  required String outputPath,
  required List<String> staticPaths,
}) async {
  // load coverages
  final origCoverageRoot = json.decode(File(coveragePath).readAsStringSync())
      as Map<String, dynamic>;
  final coverageRoot = origCoverageRoot
      .map((k, v) => MapEntry(k.replaceAll(_pathHashRegexp, '/static/'), v));

  // source line coverage counter
  final sourceCoverage = <String, Map<int, int>>{};

  for (final staticPath in staticPaths) {
    final compiledPath = '../..$staticPath';
    final mapPath = '$compiledPath.map';

    final sm = parse(File(mapPath).readAsStringSync()) as SingleMapping;

    // Initialize line counts with 0 for all the known lines.
    for (final e in sm.lines.expand((l) => l.entries)) {
      if (e.sourceUrlId == null) continue;
      final sourceUrl = sm.urls[e.sourceUrlId!];
      if (sourceUrl.startsWith('org-dartlang-sdk:')) continue;
      final counts = sourceCoverage.putIfAbsent(sourceUrl, () => <int, int>{});
      counts[e.sourceLine!] ??= 0;
    }

    // Returns the source map location for [line] and [column] in the compiled file.
    // [line] and [column] is starting from 1

    // Returns `null` if the position is invalid or if there is no mapping.
    TargetEntry? _sourceLines(int line, int column) {
      try {
        final entries = sm.lines[line - 1].entries;
        // TargetEntry.column is 0-indexed
        return entries.lastWhereOrNull((e) => e.column < column);
      } catch (_) {
        return null;
      }
    }

    final compiled = File(compiledPath).readAsStringSync();
    final compiledLines = compiled.split('\n');

    // Returns the compiled code source position for [offset].
    _Position _compiledPosition(int offset) {
      int line = 0;
      while (
          line < compiledLines.length && offset > compiledLines[line].length) {
        offset -= compiledLines[line].length + 1;
        line++;
      }
      return _Position(line + 1, offset + 1);
    }

    final coverageKeys = coverageRoot.keys
        .where((key) => staticPath.allMatches(key).isNotEmpty)
        .toList();
    for (final coverageKey in coverageKeys) {
      final coverage = coverageRoot[coverageKey] as Map<String, dynamic>;
      final rangesList =
          (coverage['ranges'] as List).cast<Map<String, dynamic>>();

      // process coverages
      rangesList
          .map((r) => _Range(r['start'] as int, r['end'] as int))
          .expand(
              (r) => List<int>.generate(r.end - r.start, (i) => i + r.start))
          .map(_compiledPosition)
          .map((s) => _sourceLines(s.line, s.column))
          .where((e) => e != null && e.sourceUrlId != null)
          .forEach(
        (e) {
          final sourceUrl = sm.urls[e!.sourceUrlId!];
          if (sourceUrl.startsWith('org-dartlang-sdk:')) return;
          final counts =
              sourceCoverage.putIfAbsent(sourceUrl, () => <int, int>{});
          counts[e.sourceLine!] = 1;
        },
      );
    }
  }

  // format results in the LCOV block format
  final sources = sourceCoverage.keys.toList()..sort();
  String _lcovSource(String source) {
    final relativeFileName = relative(source, from: '../..');
    final counts = sourceCoverage[source];
    final lines = counts!.keys.toList()..sort();
    return [
      'SF:$relativeFileName',
      ...lines.map((line) => 'DA:$line,${counts[line]}'),
      'end_of_record\n',
    ].join('\n');
  }

  File(outputPath).writeAsStringSync(sources.map(_lcovSource).join());
}

class _Range {
  final int start;
  final int end;

  _Range(this.start, this.end);
}

class _Position {
  final int line;
  final int column;

  _Position(this.line, this.column);
}
