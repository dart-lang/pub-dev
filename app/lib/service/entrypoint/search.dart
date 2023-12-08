// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

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

class SearchCommand extends Command {
  @override
  String get name => 'search';

  @override
  String get description => 'The search service entrypoint.';

  @override
  Future<void> run() async {
    envConfig.checkServiceEnvironment(name);
    await withServices(() async {
      final index = await startQueryIsolate(
        logger: _logger,
        spawnUri:
            Uri.parse('package:pub_dev/service/entrypoint/search_index.dart'),
      );
      registerScopeExitCallback(index.close);

      registerSearchIndex(IsolateSearchIndex(index));

      final renewTimer = Timer.periodic(Duration(minutes: 15), (_) async {
        await index.renew(count: 1, wait: Duration(minutes: 2));
      });
      registerScopeExitCallback(() => renewTimer.cancel());

      await runHandler(_logger, searchServiceHandler);
    });
  }
}
