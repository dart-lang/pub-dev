// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:_pub_shared/search/search_form.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/updater.dart';

/// Loads a search snapshot and executes queries on it, benchmarking their total time to complete.
Future<void> main(List<String> args) async {
  print('Started. Current memory: ${ProcessInfo.currentRss ~/ 1024} KiB,  '
      'max memory: ${ProcessInfo.maxRss ~/ 1024} KiB');
  // Assumes that the first argument is a search snapshot file.
  final index = await loadInMemoryPackageIndexFromFile(args.first);
  print('Loaded. Current memory: ${ProcessInfo.currentRss ~/ 1024} KiB,  '
      'max memory: ${ProcessInfo.maxRss ~/ 1024} KiB');

  // NOTE: please add more queries to this list, especially if there is a performance bottleneck.
  final queries = [
    'sdk:dart',
    'sdk:flutter platform:android',
    'is:flutter-favorite',
    'chart',
    'json',
    'camera',
    'android camera',
    'sql database',
  ];

  final sw = Stopwatch()..start();
  var count = 0;
  for (var i = 0; i < 100; i++) {
    index.search(ServiceSearchQuery.parse(
      query: queries[i % queries.length],
      tagsPredicate: TagsPredicate.regularSearch(),
    ));
    count++;
  }
  sw.stop();
  print('${(sw.elapsedMilliseconds / count).toStringAsFixed(2)} ms/request');
  print('Done. Current memory: ${ProcessInfo.currentRss ~/ 1024} KiB,  '
      'max memory: ${ProcessInfo.maxRss ~/ 1024} KiB');
}
