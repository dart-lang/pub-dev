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

import 'package:pub_dartlang_org/models.dart';
import 'package:pub_dartlang_org/model_properties.dart';
import 'package:pub_dartlang_org/service_utils.dart';

Future main(List<String> args) async {
  final ArgParser parser = new ArgParser()
    ..addOption('output', help: 'The report output file (or stdout otherwise)');
  final ArgResults argv = parser.parse(args);

  int count = 0;
  int flutterCount = 0;
  final List<String> flutterPlugins = [];
  final List<String> flutterSdks = [];
  await withProdServices(() async {
    await for (Package p in dbService.query(Package).run()) {
      count++;
      if (count % 25 == 0) {
        print('Reading package #$count: ${p.name}');
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
    }
  });

  final Map report = {
    'counters': {
      'total': count,
      'flutter': {
        'total': flutterCount,
        'plugins': flutterPlugins.length,
        'sdk': flutterSdks.length,
      }
    },
    'flutter': {
      'plugins': flutterPlugins,
      'sdk': flutterSdks,
    }
  };
  final String json = new JsonEncoder.withIndent('  ').convert(report);
  if (argv['output'] != null) {
    final File outputFile = new File(argv['output']);
    print('Writing report to ${outputFile.path}');
    await outputFile.parent.create(recursive: true);
    await outputFile.writeAsString(json + '\n');
  } else {
    print(json);
  }
}
