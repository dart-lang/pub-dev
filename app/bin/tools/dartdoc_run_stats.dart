// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Creates a report about [DartdocRun] entries.
/// Example use:
///   dart bin/tools/dartdoc_run_stats.dart --output report.json

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:meta/meta.dart';

import 'package:pub_dev/dartdoc/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/versions.dart';

Future<void> main(List<String> args) async {
  final ArgParser parser = ArgParser()
    ..addOption('output', help: 'The report output file (or stdout otherwise)');
  final ArgResults argv = parser.parse(args);

  final packageTops = <String, DartdocEntry>{};

  await withToolRuntime(() async {
    final query = dbService.query<DartdocRun>()
      ..filter('runtimeVersion =', runtimeVersion);
    var scanned = 0;
    await for (final dr in query.run()) {
      final prev = packageTops[dr.package];
      final entry = dr.entry;
      if (prev == null || prev.runDuration < entry.runDuration) {
        packageTops[dr.package] = entry;
      }
      scanned++;
      if (scanned % 5000 == 0) {
        print('Scanned $scanned DartdocRun entities.');
      }
    }
  });

  final entries = packageTops.values.toList()
    ..sort((a, b) => -a.runDuration.compareTo(b.runDuration));

  final topSeconds = <String, int>{};
  for (final e in entries.take(100)) {
    topSeconds[e.packageName] = e.runDuration.inSeconds;
  }

  Map<String, int> sumBy({
    @required int top,
    String Function(DartdocEntry e) keyFn,
  }) {
    final map = <String, int>{};
    for (final e in entries.take(100)) {
      final key = keyFn(e) ?? '';
      map[key] = (map[key] ?? 0) + 1;
    }
    return map;
  }

  final report = <String, dynamic>{
    'slowest-100': {
      'seconds': topSeconds,
      'usesFlutter': entries.take(100).where((e) => e.usesFlutter).length,
      'dart-version': sumBy(top: 100, keyFn: (e) => e.sdkVersion),
      'flutter-version': sumBy(top: 100, keyFn: (e) => e.flutterVersion),
    },
    'slowest-1k': {
      'usesFlutter': entries.take(1000).where((e) => e.usesFlutter).length,
      'dart-version': sumBy(top: 1000, keyFn: (e) => e.sdkVersion),
      'flutter-version': sumBy(top: 1000, keyFn: (e) => e.flutterVersion),
    },
  };

  final json = JsonEncoder.withIndent('  ').convert(report);
  if (argv['output'] != null) {
    final outputFile = File(argv['output'] as String);
    print('Writing report to ${outputFile.path}');
    await outputFile.parent.create(recursive: true);
    await outputFile.writeAsString(json + '\n');
  } else {
    print(json);
  }
}
