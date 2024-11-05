// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:pub_dev/package/overrides.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/models.dart';
import 'package:pub_dev/search/search_service.dart';

/// Loads a search snapshot and executes queries on it, benchmarking their total time to complete.
Future<void> main(List<String> args) async {
  // Assumes that the first argument is a search snapshot file.
  final file = File(args.first);
  final content =
      json.decode(utf8.decode(gzip.decode(await file.readAsBytes())))
          as Map<String, Object?>;
  final snapshot = SearchSnapshot.fromJson(content);
  snapshot.documents!
      .removeWhere((packageName, doc) => isSoftRemoved(packageName));
  final index = InMemoryPackageIndex(documents: snapshot.documents!.values);

  // NOTE: please add more queries to this list, especially if there is a performance bottleneck.
  final queries = [
    'json',
    'camera',
    'android camera',
    'sql database',
  ];

  final sw = Stopwatch()..start();
  var count = 0;
  for (var i = 0; i < 100; i++) {
    index.search(ServiceSearchQuery.parse(query: queries[i % queries.length]));
    count++;
  }
  sw.stop();
  print('${(sw.elapsedMilliseconds / count).toStringAsFixed(2)} ms/request');
}
