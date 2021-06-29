// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9

/// Reads the latest stable version of packages and creates a JSON report.
/// Example use:
///   dart bin/tools/package_stats.dart --output report.json

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:pool/pool.dart';

import 'package:pub_dev/analyzer/analyzer_client.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/datastore.dart';

Future main(List<String> args) async {
  final ArgParser parser = ArgParser()
    ..addOption('output', help: 'The report output file (or stdout otherwise)');
  final ArgResults argv = parser.parse(args);

  int totalCount = 0;
  int flutterCount = 0;

  final List<String> flutterPlugins = [];
  final List<String> flutterSdks = [];

  final homepageScheme = _Counter();
  final licenseNames = _Counter();
  final grantedPoints = _Counter();
  final tags = _Counter();

  await withToolRuntime(() async {
    Future<void> process(Package p) async {
      totalCount++;
      if (totalCount % 25 == 0) {
        print('Reading package #$totalCount: ${p.name}');
      }

      final latest =
          await dbService.lookupValue<PackageVersion>(p.latestVersionKey);
      final pubspec = latest.pubspec;

      if (pubspec.hasFlutterPlugin) {
        flutterPlugins.add(p.name);
      }
      if (pubspec.dependsOnFlutterSdk) {
        flutterSdks.add(p.name);
      }
      if (pubspec.hasFlutterPlugin || pubspec.dependsOnFlutterSdk) {
        flutterCount++;
      }

      final homepage = pubspec.homepage ?? pubspec.repository;
      if (homepage == null) {
        homepageScheme.increment('empty');
      } else {
        try {
          final uri = Uri.parse(homepage);
          if (uri.scheme != 'http' && uri.scheme != 'https') {
            homepageScheme.increment('not_http');
          } else {
            homepageScheme.increment(uri.scheme);
          }
        } catch (_) {
          homepageScheme.increment('parse_error');
        }
      }

      final analysis =
          await analyzerClient.getAnalysisView(p.name, p.latestVersion);
      licenseNames.increment(analysis.licenseFile ?? 'none');
      grantedPoints.increment(analysis.report?.grantedPoints ?? 0);
    }

    final pool = Pool(16);
    final futures = <Future>[];
    await for (Package p in dbService.query<Package>().run()) {
      final f = pool.withResource(() => process(p));
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();
  });

  final Map report = {
    'packages': totalCount,
    'flutter': {
      'total': flutterCount,
      'plugins': flutterPlugins.length,
      'sdk': flutterSdks.length,
    },
    'tags': tags.sortedByCounts(),
    'homepage': homepageScheme.sortedByCounts(),
    'licenses': licenseNames.sortedByCounts(),
    'points': grantedPoints.sortedByKeysAsInt(),
  };
  final String json = JsonEncoder.withIndent('  ').convert(report);
  if (argv['output'] != null) {
    final File outputFile = File(argv['output'] as String);
    print('Writing report to ${outputFile.path}');
    await outputFile.parent.create(recursive: true);
    await outputFile.writeAsString(json + '\n');
  } else {
    print(json);
  }
}

class _Counter {
  final _values = <String, int>{};

  void increment(key, [int amount = 1]) {
    final strKey = key.toString();
    _values[strKey] = (_values[strKey] ?? 0) + amount;
  }

  Map<String, int> sortedByCounts() {
    final keys = _values.keys.toList();
    keys.sort((a, b) => -_values[a].compareTo(_values[b]));
    final result = <String, int>{};
    for (String key in keys) {
      result[key] = _values[key];
    }
    return result;
  }

  Map<String, int> sortedByKeysAsInt() {
    final keys = _values.keys.map(int.parse).toList();
    keys.sort((a, b) => a.compareTo(b));
    final result = <String, int>{};
    for (int key in keys) {
      final strKey = key.toString();
      result[strKey] = _values[strKey];
    }
    return result;
  }
}
