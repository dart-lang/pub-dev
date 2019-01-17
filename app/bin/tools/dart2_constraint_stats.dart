// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Reads the latest stable version of packages and creates a JSON report.
/// Example use:
///   dart bin/tools/dart2_constraint_stats.dart --output report.json

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/model_properties.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/popularity_storage.dart';

final dart1Latest = new Version.parse('1.24.3');
final dartDevRange = new VersionConstraint.parse('>=1.25.0 <=2.0.0-dev.99.0');
final dart2First = new Version.parse('2.0.0');

Future main(List<String> args) async {
  final ArgParser parser = new ArgParser()
    ..addOption('output', help: 'The report output file (or stdout otherwise)')
    ..addOption('top',
        help: 'Select the top N popular package for notification')
    ..addOption('age', help: 'Maximum age of the latest update, in days.');
  final ArgResults argv = parser.parse(args);
  final top = int.tryParse(argv['top'] as String ?? '0') ?? 0;
  final age = int.tryParse(argv['age'] as String ?? '0') ?? 0;

  int totalCount = 0;
  int noConstraint = 0;
  int allowsDart1Count = 0;
  int onlyDart1Count = 0;
  int allowsDartDevCount = 0;
  int onlyDartDevCount = 0;
  int allowsDart2Count = 0;
  int onlyDart2Count = 0;
  final packagesToNotify = <String>[];
  final authorsToNotify = new Set<String>();
  final onlyDart2Packages = <String>[];

  await withProdServices(() async {
    final bucket =
        storageService.bucket(activeConfiguration.popularityDumpBucketName);
    registerPopularityStorage(new PopularityStorage(storageService, bucket));
    await popularityStorage.fetch('init');

    final topThreshold =
        top == 0 ? 0.0 : 1.0 - (top + 1) * (1.0 / popularityStorage.count);

    final now = new DateTime.now().toUtc();
    await for (Package p in dbService.query<Package>().run()) {
      totalCount++;
      if (totalCount % 25 == 0) {
        stderr.writeln('Reading package #$totalCount: ${p.name}');
      }

      final versions = await dbService.lookup([p.latestVersionKey]);
      if (versions.isEmpty) continue;

      final latest = versions.first as PackageVersion;
      if (age > 0 && now.difference(latest.created).inDays > age) {
        continue;
      }

      final Pubspec pubspec = latest.pubspec;

      if (pubspec.sdkConstraint == null) {
        noConstraint++;
        continue;
      }

      final popularityScore = popularityStorage.lookup(p.name) ?? 0.0;
      final selectForNotification = popularityScore >= topThreshold;

      final vc = new VersionConstraint.parse(pubspec.sdkConstraint);
      final allowsDart1 = vc.allows(dart1Latest);
      final allowsDartDev = vc.allowsAny(dartDevRange);
      final allowsDart2 = vc.allows(dart2First);
      if (allowsDart1) {
        allowsDart1Count++;
        if (!allowsDartDev && !allowsDart2) {
          onlyDart1Count++;
        }
      }
      if (allowsDartDev) {
        allowsDartDevCount++;
        if (!allowsDart2) {
          onlyDartDevCount++;
        }
      }
      if (allowsDart2) {
        allowsDart2Count++;
        if (!allowsDartDev && !allowsDart1) {
          onlyDart2Count++;
          onlyDart2Packages.add(p.name);
        }
      }
      if (selectForNotification && allowsDartDev && !allowsDart2) {
        authorsToNotify.add(latest.uploaderEmail);
        packagesToNotify.add(p.name);
      }
    }
  });

  packagesToNotify.sort();
  final Map report = {
    'counters': {
      'total': totalCount,
      'noConstraint': noConstraint,
      'allowsDart1': allowsDart1Count,
      'onlyDart1': onlyDart1Count,
      'allowsDartDev': allowsDartDevCount,
      'onlyDartDev': onlyDartDevCount,
      'allowsDart2': allowsDart2Count,
      'onlyDart2': onlyDart2Count,
      'packagesToNotify': packagesToNotify.length,
      'authorsToNotify': authorsToNotify.length,
    },
    'packagesToNotify': packagesToNotify,
    'authorsToNotify': authorsToNotify.toList()..sort(),
    'onlyDart2Packages': onlyDart2Packages,
  };
  final String json = new JsonEncoder.withIndent('  ').convert(report);
  if (argv['output'] != null) {
    final File outputFile = new File(argv['output'] as String);
    stderr.writeln('Writing report to ${outputFile.path}');
    await outputFile.parent.create(recursive: true);
    await outputFile.writeAsString(json + '\n');
  } else {
    print(json);
  }
}
