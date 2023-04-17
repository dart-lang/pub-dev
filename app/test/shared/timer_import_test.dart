// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  final exceptions = <String>{
    // Uses timer to break out from sleep cycle.
    // TODO: migrate polling to cached_value
    'lib/package/name_tracker.dart',

    // TODO: migrate snapshot update to use cached_value
    'lib/search/backend.dart',

    // TODO: migrate stats update to use cached_value
    'lib/search/updater.dart',

    // Periodically updated cached values should use this wrapper.
    'lib/shared/cached_value.dart',

    // Per-request Timer to log long-running requests.
    'lib/shared/handler_helpers.dart',

    // Periodically updates redis connection.
    // Periodically purges selected caches.
    // TODO: consider refactor/redesign
    'lib/shared/redis_cache.dart',

    // Uses timer to auto-kill worker isolates.
    'lib/service/entrypoint/_isolate.dart',

    // Uses timer to send stats periodically to the frontend isolate.
    'lib/service/entrypoint/analyzer.dart',

    // Uses timer to send stats periodically to the frontend isolate.
    'lib/service/entrypoint/dartdoc.dart',

    // Uses timer to timeout GlobalLock claim aquisition.
    'lib/tool/neat_task/pub_dev_tasks.dart',

    // Uses timer to track event loop latencies.
    'lib/tool/utils/event_loop_tracker.dart',
  };

  test('Timer is used only with a permitted pattern', () {
    final timerFiles = <String>[];
    for (final dir in ['bin', 'lib']) {
      final files = Directory(dir)
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .where((f) => !f.path.endsWith('.g.dart'))
          .toList();

      for (final file in files) {
        if (exceptions.contains(file.path)) continue;
        final content = file.readAsStringSync();
        if (content.contains('Timer(') || content.contains('Timer.periodic(')) {
          timerFiles.add(file.path);
        }
      }
    }

    expect(timerFiles, isEmpty);
  });
}
