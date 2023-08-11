// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';

import '../../search/backend.dart';
import '../../search/handlers.dart';
import '../../service/services.dart';
import '../../shared/env_config.dart';
import '../../shared/handler_helpers.dart';
import '../../shared/popularity_storage.dart';
import '../../tool/neat_task/pub_dev_tasks.dart';

import '_isolate.dart';
import 'search_index.dart';

final Logger _logger = Logger('pub.search');

class SearchCommand extends Command {
  @override
  String get name => 'search';

  @override
  String get description => 'The search service entrypoint.';

  @override
  Future<void> run() async {
    final servicesWrapperFn =
        envConfig.isRunningInAppengine ? withServices : fakeServicesWrapper;
    envConfig.checkServiceEnvironment(name);
    await runIsolates(
      logger: _logger,
      frontendEntryPoint: _main,
      workerEntryPoint: _worker,
      indexSpawnUri:
          Uri.parse('package:pub_dev/service/entrypoint/search_index.dart'),
      indexRenewTrigger: Stream.periodic(Duration(minutes: 15)),
      frontendCount: 1,
      servicesWrapperFn: servicesWrapperFn,
    );
  }
}

Future _main(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());
  registerSearchIndex(IsolateSearchIndex(message.protocolSendPort));
  await runHandler(_logger, searchServiceHandler);
}

Future _worker(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());
  await popularityStorage.start();
  setupSearchPeriodicTasks();
  await searchBackend.updateSnapshotInForeverLoop();
}
