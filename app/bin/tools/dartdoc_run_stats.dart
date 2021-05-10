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

import 'package:pub_dev/dartdoc/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/versions.dart';

final _mb = 1024 * 1024;

Future<void> main(List<String> args) async {
  final ArgParser parser = ArgParser()
    ..addOption('output', help: 'The report output file (or stdout otherwise)')
    ..addOption('runtime-version',
        help: 'Specify runtimeVersion of use `all`.',
        defaultsTo: runtimeVersion);
  final argv = parser.parse(args);
  final rv = argv['runtime-version'];

  final durations = <String, DartdocEntry>{};
  final archives = <String, DartdocEntry>{};
  final totals = <String, DartdocEntry>{};

  await withToolRuntime(() async {
    final query = dbService.query<DartdocRun>();
    if (rv != 'all') {
      query.filter('runtimeVersion =', rv);
    }
    var scanned = 0;
    await for (final dr in query.run()) {
      final entry = dr.entry;

      if (entry.runDuration != null) {
        final prevDuration = durations[dr.package];
        if (prevDuration == null ||
            prevDuration.runDuration < entry.runDuration) {
          durations[dr.package] = entry;
        }
      }

      if (entry.archiveSize != null && entry.totalSize != null) {
        final prevArchive = archives[dr.package];
        if (prevArchive == null ||
            prevArchive.archiveSize < entry.archiveSize) {
          archives[dr.package] = entry;
        }

        final prevTotal = totals[dr.package];
        if (prevTotal == null || prevTotal.totalSize < entry.totalSize) {
          totals[dr.package] = entry;
        }
      }

      scanned++;
      if (scanned % 5000 == 0) {
        print('Scanned $scanned DartdocRun entities.');
      }
    }
  });

  final topDurations = durations.values.toList()
    ..sort((a, b) => -a.runDuration.compareTo(b.runDuration));
  final topArchives = archives.values.toList()
    ..sort((a, b) => -a.archiveSize.compareTo(b.archiveSize));
  final topTotals = totals.values.toList()
    ..sort((a, b) => -a.totalSize.compareTo(b.totalSize));

  final topSeconds = <String, int>{};
  for (final e in topDurations.take(100)) {
    topSeconds[e.packageName] = e.runDuration.inSeconds;
  }

  Map<String, int> sum(
    Iterable<DartdocEntry> entries,
    String Function(DartdocEntry e) keyFn,
  ) {
    final counts = <String, int>{};
    for (final e in topDurations) {
      final key = keyFn(e) ?? '';
      counts[key] = (counts[key] ?? 0) + 1;
    }
    return counts;
  }

  Map<String, int> buckets(
    Iterable<DartdocEntry> entries,
    int Function(DartdocEntry) valueFn, [
    int resolution = 1,
  ]) {
    final counts = <String, int>{};
    for (final e in entries) {
      final value = valueFn(e);
      final k = (value ~/ resolution) * resolution;
      final key = '$k';
      counts[key] = (counts[key] ?? 0) + 1;
    }
    return counts;
  }

  final report = <String, dynamic>{
    'slowest-100': {
      'seconds': topSeconds,
      'usesFlutter': topDurations.take(100).where((e) => e.usesFlutter).length,
      'dart-version': sum(topDurations.take(100), (e) => e.sdkVersion),
      'flutter-version': sum(topDurations.take(100), (e) => e.flutterVersion),
    },
    'slowest-1k': {
      'usesFlutter': topDurations.take(1000).where((e) => e.usesFlutter).length,
      'dart-version': sum(topDurations.take(1000), (e) => e.sdkVersion),
      'flutter-version': sum(topDurations.take(1000), (e) => e.flutterVersion),
    },
    'archive-1MB': buckets(topArchives, (e) => e.archiveSize ~/ _mb),
    'archive-10MB': buckets(topArchives, (e) => e.archiveSize ~/ _mb, 10),
    'total-1MB': buckets(topTotals, (e) => e.totalSize ~/ _mb),
    'total-10MB': buckets(topTotals, (e) => e.totalSize ~/ _mb, 10),
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
