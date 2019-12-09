// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/analyzer/analyzer_client.dart';
import 'package:pub_dev/dartdoc/dartdoc_client.dart';
import 'package:pub_dev/search/search_client.dart';

void _printHelp() {
  print('Notifies the auxilliary services about a new package or version.');
  print('Syntax:');
  print('  dart bin/tools/notify_service.dart analyzer [package] [version]');
  print('  dart bin/tools/notify_service.dart dartdoc [package] [version]');
  print('  dart bin/tools/notify_service.dart search [package] [version]');
}

/// Notifies the analyzer or the search service using a shared secret.
Future main(List<String> args) async {
  if (args.isEmpty) {
    _printHelp();
    return;
  }

  await withProdServices(() async {
    final String service = args[0];
    if (service == 'analyzer' && args.length == 3) {
      await analyzerClient.triggerAnalysis(args[1], args[2], <String>{},
          isHighPriority: true);
    } else if (service == 'dartdoc' && args.length == 3) {
      await dartdocClient.triggerDartdoc(args[1], args[2], <String>{},
          isHighPriority: true);
    } else if (service == 'search' && args.length == 3) {
      await searchClient.triggerReindex(args[1], args[2]);
    } else {
      _printHelp();
    }
    await searchClient.close();
  });
}
