// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:math';

import 'package:_pub_shared/search/search_form.dart';
import 'package:collection/collection.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/service/entrypoint/_isolate.dart';
import 'package:pub_dev/service/entrypoint/search_index.dart';

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

Future<void> main(List<String> args) async {
  print('Started. Current memory: ${ProcessInfo.currentRss ~/ 1024} KiB,  '
      'max memory: ${ProcessInfo.maxRss ~/ 1024} KiB');
  final runner = await startSearchIsolate(snapshot: args.first);
  print('Loaded. Current memory: ${ProcessInfo.currentRss ~/ 1024} KiB,  '
      'max memory: ${ProcessInfo.maxRss ~/ 1024} KiB');

  for (var i = 0; i < 5; i++) {
    await _benchmark(runner);
    print('--');
  }

  await runner.close();
  print('Done. Current memory: ${ProcessInfo.currentRss ~/ 1024} KiB,  '
      'max memory: ${ProcessInfo.maxRss ~/ 1024} KiB');
}

Future<void> _benchmark(IsolateRunner primary) async {
  final index = IsolateSearchIndex(primary);
  final durations = <String, List<int>>{};
  for (var i = 0; i < 100; i++) {
    final random = Random(i);
    final items = queries
        .map((q) => ServiceSearchQuery.parse(
              query: q,
              tagsPredicate: TagsPredicate.regularSearch(),
            ))
        .toList();
    items.shuffle(random);
    await Future.wait(items.map((q) async {
      final sw = Stopwatch()..start();
      await index.search(q);
      final d = sw.elapsed.inMicroseconds;
      durations.putIfAbsent('all', () => []).add(d);
      final key = q.parsedQuery.hasFreeText ? 'primary' : 'reduced';
      durations.putIfAbsent(key, () => []).add(d);
    }));
  }
  for (final e in durations.entries) {
    e.value.sort();
    print('${e.key.padLeft(10)}: '
        '${e.value.average.round().toString().padLeft(10)} avg '
        '${e.value[e.value.length * 90 ~/ 100].toString().padLeft(10)} p90');
  }
}
