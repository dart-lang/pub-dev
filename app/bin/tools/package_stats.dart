// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Reads the latest stable version of packages and creates a JSON report.
/// Example use:
///   dart bin/tools/package_stats.dart --output report.json

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/package/model_properties.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

Future main(List<String> args) async {
  final ArgParser parser = ArgParser()
    ..addOption('output', help: 'The report output file (or stdout otherwise)');
  final ArgResults argv = parser.parse(args);

  int totalCount = 0;
  int flutterCount = 0;

  final List<String> flutterPlugins = [];
  final List<String> flutterSdks = [];

  Map<String, int> homepageDomains = {};
  void addHomepage(String key) {
    homepageDomains[key] = (homepageDomains[key] ?? 0) + 1;
  }

  await withProdServices(() async {
    await for (Package p in dbService.query<Package>().run()) {
      totalCount++;
      if (totalCount % 25 == 0) {
        print('Reading package #$totalCount: ${p.name}');
      }

      final List<PackageVersion> versions =
          await dbService.lookup([p.latestVersionKey]);
      if (versions.isEmpty) continue;

      final PackageVersion latest = versions.first;
      final Pubspec pubspec = latest.pubspec;

      if (pubspec.hasFlutterPlugin) {
        flutterPlugins.add(p.name);
      }
      if (pubspec.dependsOnFlutterSdk) {
        flutterSdks.add(p.name);
      }
      if (pubspec.hasFlutterPlugin || pubspec.dependsOnFlutterSdk) {
        flutterCount++;
      }

      if (pubspec.homepage == null) {
        addHomepage('empty');
      } else {
        try {
          final uri = Uri.parse(pubspec.homepage);
          if (uri.scheme != 'http' && uri.scheme != 'https') {
            addHomepage('not_http');
          } else {
            addHomepage(uri.host);
          }
        } catch (_) {
          addHomepage('parse_error');
        }
      }
    }
  });
  homepageDomains = _sortDomains(homepageDomains);

  final Map report = {
    'counters': {
      'total': totalCount,
      'flutter': {
        'total': flutterCount,
        'plugins': flutterPlugins.length,
        'sdk': flutterSdks.length,
      },
    },
    'flutter': {
      'plugins': flutterPlugins,
      'sdk': flutterSdks,
    },
    'homepage': homepageDomains,
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

Map<String, int> _sortDomains(Map<String, int> counts) {
  final List<String> domains = counts.keys.toList();
  domains.sort((a, b) => -counts[a].compareTo(counts[b]));
  final result = <String, int>{};
  for (String domain in domains) {
    result[domain] = counts[domain];
  }
  return result;
}
