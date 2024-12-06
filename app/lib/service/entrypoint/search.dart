// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:args/command_runner.dart';
import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/service/entrypoint/search_index.dart';

import '../../search/backend.dart';
import '../../search/handlers.dart';
import '../../service/services.dart';
import '../../shared/env_config.dart';
import '../../shared/handler_helpers.dart';

import '_isolate.dart';

final Logger _logger = Logger('pub.search');
final _random = Random.secure();

class SearchCommand extends Command {
  @override
  String get name => 'search';

  @override
  String get description => 'The search service entrypoint.';

  @override
  Future<void> run() async {
    // An instance-specific additional drift, to make sure that the index updates
    // are stretched out over time.
    final delayDrift = _random.nextInt(60);

    envConfig.checkServiceEnvironment(name);
    await withServices(() async {
      final index = await startQueryIsolate(
        logger: _logger,
        spawnUri:
            Uri.parse('package:pub_dev/service/entrypoint/search_index.dart'),
      );
      registerScopeExitCallback(index.close);

      registerSearchIndex(IsolateSearchIndex(index));

      void scheduleRenew() {
        scheduleMicrotask(() async {
          // 12 - 17 minutes delay
          final delay =
              Duration(minutes: 12, seconds: delayDrift + _random.nextInt(240));
          await Future.delayed(delay);

          // create a new index and handover with a 2-minute maximum wait
          await index.renew(count: 1, wait: Duration(minutes: 2));

          // schedule the renewal again
          scheduleRenew();
        });
      }

      scheduleRenew();

      await runHandler(_logger, searchServiceHandler);
    });
  }
}
