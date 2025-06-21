// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:_pub_shared/search/search_form.dart';
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
  print('Loading...');
  final primaryRunner = await startSearchIsolate(snapshot: args.first);
  final reducedRunner = await startSearchIsolate(
    snapshot: args.first,
    removeTextContent: true,
  );
  print('Loaded.');

  for (var i = 0; i < 5; i++) {
    await _benchmark(primaryRunner, primaryRunner);
    await _benchmark(primaryRunner, reducedRunner);
    print('--');
  }

  await primaryRunner.close();
  await reducedRunner.close();
}

Future<void> _benchmark(IsolateRunner primary, IsolateRunner reduced) async {
  final index = IsolateSearchIndex(primary, reduced);
  final sw = Stopwatch()..start();
  for (var i = 0; i < 10; i++) {
    final random = Random(i);
    final items = queries
        .expand((q) => List.generate(10, (_) => q))
        .map((q) => ServiceSearchQuery.parse(
              query: q,
              tagsPredicate: TagsPredicate.regularSearch(),
            ))
        .toList();
    items.shuffle(random);
    await Future.wait(items.map((q) async => index.search(q)));
  }
  sw.stop();
  print(sw.elapsedMilliseconds);
}
