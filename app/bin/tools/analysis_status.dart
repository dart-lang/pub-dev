// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/analyzer/analyzer_client.dart';
import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';

import 'package:pub_dev/package/models.dart';

void _printHelp() {
  print('Display analysis status');
  print('Syntax:');
  print('  dart bin/tools/analysis_status.dart --all');
  print('  dart bin/tools/analysis_status.dart [package] [version]');
}

/// Notifies the analyzer or the search service using a shared secret.
Future main(List<String> args) async {
  if (args.isEmpty) {
    _printHelp();
    return;
  }
  await withProdServices(() async {
    if (args[0] == '--all') {
      final pool = Pool(100);
      final futures = <Future>[];

      int count = 0;
      int done = 0;
      await for (Package p in dbService.query<Package>().run()) {
        final f = pool.withResource(() async {
          if (await _isAnalysisDone(p.name, p.latestVersion)) {
            done++;
          }
          count++;
        });
        futures.add(f);
      }

      await Future.wait(futures);
      await pool.close();
      print('');
      print('Done with $done of $count packages');
    } else if (args.length == 2) {
      await _isAnalysisDone(args[0], args[1]);
    } else {
      _printHelp();
    }
  });
}

Future<bool> _isAnalysisDone(String package, String version) async {
  final view = await analyzerClient.getAnalysisView(package, version);
  print('$package $version: ${view.isLatestRuntimeVersion}');
  return view.isLatestRuntimeVersion;
}
