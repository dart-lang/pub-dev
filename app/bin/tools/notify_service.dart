// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/search_client.dart';

void _printHelp() {
  print('Notifies the auxilliary services about a new package or version.');
  print('Syntax:');
  print('  dart bin/tools/notify_service.dart analyzer [package] [version]');
  print('  dart bin/tools/notify_service.dart dartdoc [package] [version]');
  print('  dart bin/tools/notify_service.dart search [package]');
}

/// Notifies the analyzer or the search service using a shared secret.
Future main(List<String> args) async {
  if (args.isEmpty) {
    _printHelp();
    return;
  }

  await withProdServices(() async {
    registerAnalyzerClient(new AnalyzerClient());
    registerDartdocClient(new DartdocClient());
    registerSearchClient(new SearchClient());
    final String service = args[0];
    if (service == 'analyzer' && args.length == 3) {
      await analyzerClient.triggerAnalysis(args[1], args[2], new Set<String>());
    } else if (service == 'dartdoc' && args.length == 3) {
      await dartdocClient.triggerDartdoc(args[1], args[2], new Set<String>());
    } else if (service == 'search' && args.length == 2) {
      await searchClient.triggerReindex(args[1]);
    } else {
      _printHelp();
    }
    await analyzerClient.close();
    await searchClient.close();
  });
}
