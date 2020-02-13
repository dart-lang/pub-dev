// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Creates a report about analysis and dartdoc task failures.
/// Example use:
///   dart bin/tools/task_stats.dart --output report.json

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/dartdoc/dartdoc_client.dart';

Future main(List<String> args) async {
  final ArgParser parser = ArgParser()
    ..addOption('max-age',
        defaultsTo: '365', help: 'The maximum age of the package in days.')
    ..addOption('output', help: 'The report output file (or stdout otherwise)');
  final ArgResults argv = parser.parse(args);
  final int maxAgeDays = int.parse(argv['max-age'] as String);

  final pool = Pool(20);

  final Map report = {};

  await withProdServices(() async {
    final statFutures = <Future<_Stat>>[];
    final updatedAfter = DateTime.now().subtract(Duration(days: maxAgeDays));
    final query = dbService.query<Package>()
      ..filter('updated >=', updatedAfter);
    await for (Package p in query.run()) {
      statFutures
          .add(pool.withResource(() => _getStat(p.name, p.latestVersion)));
    }

    final stats = await Future.wait(statFutures);
    report['analyzer'] = _summarize(stats, (s) => s.analyzer);
    report['dartdoc'] = _summarize(stats, (s) => s.dartdoc);
  });

  final String json = JsonEncoder.withIndent('  ').convert(report);
  if (argv['output'] != null) {
    final File outputFile = File(argv['output'] as String);
    print('Writing report to ${outputFile.path}');
    await outputFile.parent.create(recursive: true);
    await outputFile.writeAsString(json + '\n');
  } else {
    print(json);
  }

  exit(0);
}

Future<String> _analyzerStatus(String package, String version) async {
  final reports = await scoreCardBackend
      .loadReports(package, version, reportTypes: [ReportType.pana]);
  final panaReport = reports[ReportType.pana];
  return panaReport?.reportStatus ?? 'awaiting';
}

Future<String> _dartdocStatus(String package, String version) async {
  final list = await dartdocClient.getEntries(package, [version]);
  final entry = list.single;
  if (entry == null) return 'awaiting';
  return entry.hasContent ? 'success' : 'failure';
}

Future<_Stat> _getStat(String package, String version) async {
  final List<String> statusList = await Future.wait([
    _analyzerStatus(package, version),
    _dartdocStatus(package, version),
  ]);
  return _Stat(
    package: package,
    version: version,
    analyzer: statusList[0],
    dartdoc: statusList[1],
  );
}

class _Stat {
  final String package;
  final String version;
  final String analyzer;
  final String dartdoc;

  _Stat({this.package, this.version, this.analyzer, this.dartdoc});
}

Map<String, List<String>> _groupBy(
    List<_Stat> stats, String Function(_Stat stat) keyFn) {
  final result = <String, List<String>>{};
  for (_Stat stat in stats) {
    final String key = keyFn(stat);
    result.putIfAbsent(key, () => []).add(stat.package);
  }
  result.values.forEach((list) => list.sort());
  return result;
}

Map _summarize(List<_Stat> stats, String Function(_Stat stat) keyFn) {
  final values = _groupBy(stats, keyFn);
  final counts = <String, int>{};
  for (String key in values.keys) {
    counts[key] = values[key].length;
  }
  values.remove('success');
  return {
    'counts': counts,
    'values': values,
  };
}
