// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pub_dev/search/sdk_mem_index.dart';

/// Loads a Dart SDK search snapshot and executes queries on it, benchmarking their total time to complete.
Future<void> main() async {
  print(
    'Started. Current memory: ${ProcessInfo.currentRss ~/ 1024} KiB,  '
    'max memory: ${ProcessInfo.maxRss ~/ 1024} KiB',
  );
  final index = await createSdkMemIndex();
  print(
    'Loaded. Current memory: ${ProcessInfo.currentRss ~/ 1024} KiB,  '
    'max memory: ${ProcessInfo.maxRss ~/ 1024} KiB',
  );

  // NOTE: please add more queries to this list, especially if there is a performance bottleneck.
  final queries = ['chart', 'json', 'camera', 'android camera', 'sql database'];

  final sw = Stopwatch()..start();
  var count = 0;
  for (var i = 0; i < 100; i++) {
    index!.search(queries[i % queries.length]);
    count++;
  }
  sw.stop();
  print('${(sw.elapsedMilliseconds / count).toStringAsFixed(2)} ms/request');
  print(
    'Done. Current memory: ${ProcessInfo.currentRss ~/ 1024} KiB,  '
    'max memory: ${ProcessInfo.maxRss ~/ 1024} KiB',
  );
}
