// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:markdown/markdown.dart';
import 'package:path/path.dart' as p;

/// Compares the screenshots from the previous and current test runs.
/// Uses imagemagick for image processing.
///
/// `dart <script.dart> <before-dir> <after-dir> <report-dir>`
Future<void> main(List<String> args) async {
  final beforeFiles = await _list(args[0]);
  final afterFiles = await _list(args[1]);

  final reportDir = Directory(args[2]);
  await reportDir.create(recursive: true);
  await _CompareTool(
    args[0],
    beforeFiles,
    args[1],
    afterFiles,
    reportDir,
  )._compare();
}

class _CompareTool {
  final String _beforeDir;
  final String _afterDir;
  final Directory _reportDir;
  final Map<String, File> _beforeFiles;
  final Map<String, File> _afterFiles;
  final _report = StringBuffer();

  _CompareTool(
    this._beforeDir,
    this._beforeFiles,
    this._afterDir,
    this._afterFiles,
    this._reportDir,
  );

  Future<void> _compare() async {
    _report.writeln(
        'Screenshot comparison report generated at ${DateTime.now().toIso8601String()}.');

    final newFiles = _afterFiles.keys
        .where((key) => !_beforeFiles.containsKey(key))
        .toList();
    if (newFiles.isNotEmpty) {
      _report.writeln([
        '',
        '# New files',
        newFiles.map((e) => '- `$e`').join('\n'),
      ].join('\n\n'));
    }

    final missingFiles = _beforeFiles.keys
        .where((key) => !_afterFiles.containsKey(key))
        .toList();
    if (missingFiles.isNotEmpty) {
      _report.writeln([
        '',
        '# Missing files',
        missingFiles.map((e) => '- `$e`').join('\n'),
      ].join('\n\n'));
    }

    for (final path in _afterFiles.keys) {
      final after = _afterFiles[path]!;
      if (!_beforeFiles.containsKey(path)) continue;
      final before = _beforeFiles[path]!;

      // quick byte-content check
      final afterBytes = await after.readAsBytes();
      final beforeBytes = await before.readAsBytes();
      if (afterBytes.length == beforeBytes.length &&
          afterBytes.indexed.every((e) => beforeBytes[e.$1] == e.$2)) {
        continue;
      }

      final relativeDir = p.dirname(path);
      final basename = p.basenameWithoutExtension(path);
      final diffPath =
          p.join(_reportDir.path, relativeDir, '$basename-diff.png');
      await File(diffPath).parent.create(recursive: true);

      final pr = await Process.run('docker', [
        'run',
        '--rm',
        '-v',
        '$_beforeDir:/root/before',
        '-v',
        '$_afterDir:/root/after',
        '-v',
        '${_reportDir.path}:/root/diff',
        'odiff',
        p.join('/root/before', relativeDir, '$basename.png'),
        p.join('/root/after', relativeDir, '$basename.png'),
        p.join('/root/diff', relativeDir, '$basename-diff.png'),
      ]);
      if (pr.exitCode == 0) continue;

      final beforeFile =
          File(p.join(_reportDir.path, relativeDir, '$basename-before.png'));
      await beforeFile.writeAsBytes(beforeBytes);
      final afterFile =
          File(p.join(_reportDir.path, relativeDir, '$basename-after.png'));
      await afterFile.writeAsBytes(afterBytes);

      _report.writeln('\n<div class="image">');
      _report.writeln('\n### `$path`\n\n');
      _report.writeln(
          '- ![before](${p.join(relativeDir, '$basename-before.png')})\n');
      _report.writeln(
          '- ![after](${p.join(relativeDir, '$basename-after.png')})\n');
      _report
          .writeln('- ![diff](${p.join(relativeDir, '$basename-diff.png')})\n');
      _report.writeln('\n</div>');
      _report.writeln();
    }

    await _writeIndexHtml();
  }

  Future<void> _writeIndexHtml() async {
    final script = await File('tool/comparison_web.js').readAsString();
    final styles = await File('tool/comparison_web.css').readAsString();
    await File(p.join(_reportDir.path, 'index.html')).writeAsString([
      '<html>',
      '<head>',
      '<style>\n$styles\n</style>',
      '</head>',
      '<body>',
      markdownToHtml(_report.toString()),
      '<script>\n$script\n</script>\n',
      '</body></html>',
    ].join('\n'));
  }
}

Future<Map<String, File>> _list(String path) async {
  final map = <String, File>{};
  await for (final file in Directory(path).list(recursive: true)) {
    if (file is! File) continue;
    final rp = p.relative(file.path, from: path);
    map[rp] = file;
  }
  return Map.fromEntries(
      map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
}
