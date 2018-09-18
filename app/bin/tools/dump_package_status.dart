// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Collects and dumps package status information and outputs a JSON file.
/// dart bin/tools/dump_package_status.dart -o output.json

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:pool/pool.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/search/scoring.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/analyzer_memcache.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/popularity_storage.dart';

Future main(List<String> arguments) async {
  final ArgParser parser = new ArgParser()
    ..addOption('output',
        abbr: 'o', help: 'The report output file (or stdout otherwise)');
  final ArgResults args = parser.parse(arguments);
  final pool = new Pool(10);

  final packages = <String, dynamic>{};
  final report = <String, dynamic>{'packages': packages};

  await withProdServices(() async {
    final Bucket popularityBucket =
        storageService.bucket(activeConfiguration.popularityDumpBucketName);
    registerPopularityStorage(
        new PopularityStorage(storageService, popularityBucket));
    await popularityStorage.init();

    registerAnalyzerMemcache(new AnalyzerMemcache(memcacheService));
    registerAnalyzerClient(new AnalyzerClient());

    final futures = <Future>[];
    await for (Package p in dbService.query<Package>().run()) {
      final f = pool.withResource(() async {
        final pvs = await dbService
            .lookup([p.key.append(PackageVersion, id: p.latestVersion)]);
        final PackageVersion pv = pvs[0];
        if (pv == null) return;

        final analysisView = await analyzerClient
            .getAnalysisView(new AnalysisKey(p.name, pv.version));
        final dependencies = new Set<String>();

        analysisView.directDependencies
            ?.map((pd) => pd.package)
            ?.forEach(dependencies.add);
        analysisView.transitiveDependencies
            ?.map((pd) => pd.package)
            ?.forEach(dependencies.add);

        packages[p.name] = <String, dynamic>{
          'name': p.name,
          'popularity': popularityStorage.lookup(p.name) ?? 0.0,
          'flags': {
            'isDiscontinued': p.isDiscontinued ?? false,
            'doNotAdvertise': p.doNotAdvertise ?? false,
          },
          'first': {
            'published': p.created.toIso8601String(),
          },
          'latest': {
            'version': pv.version,
            'published': pv.created.toIso8601String(),
            'usesFlutter': pv.pubspec.usesFlutter,
            'analyzed': analysisView.timestamp?.toIso8601String(),
            'health': analysisView.health ?? 0.0,
            'maintenance': analysisView.maintenanceScore ?? 0.0,
            'overall': calculateOverallScore(
              health: analysisView.health ?? 0.0,
              maintenance: analysisView.maintenanceScore ?? 0.0,
              popularity: popularityStorage.lookup(p.name) ?? 0.0,
            ),
            'dependencies': analysisView.hasPanaSummary
                ? (dependencies.toList()..sort())
                : null,
            'platforms': analysisView.platforms,
          },
        };

        if (packages.length % 25 == 0) {
          stderr.writeln('Processed: ${packages.length}');
        }
      });
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();

    await analyzerClient.close();
    await popularityStorage.close();
  });

  final String json = new JsonEncoder.withIndent('  ').convert(report);
  if (args['output'] != null) {
    final File outputFile = new File(args['output'] as String);
    await outputFile.parent.create(recursive: true);
    await outputFile.writeAsString(json + '\n');
  } else {
    print(json);
  }
}
