// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show DetailedApiRequestError;
import 'package:gcloud/db.dart' as db;
import 'package:logging/logging.dart';

import 'package:pub_dartlang_org/dartdoc/backend.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/popularity_storage.dart';
import 'package:pub_dartlang_org/shared/scheduler_stats.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';
import 'package:pub_dartlang_org/shared/task_client.dart';
import 'package:pub_dartlang_org/shared/task_scheduler.dart';
import 'package:pub_dartlang_org/shared/task_sources.dart';
import 'package:pub_dartlang_org/shared/versions.dart';
import 'package:pub_dartlang_org/shared/urls.dart';
import 'package:pub_dartlang_org/shared/services.dart';

import 'package:pub_dartlang_org/search/backend.dart';
import 'package:pub_dartlang_org/search/handlers.dart';
import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/search/updater.dart';

final Logger _logger = Logger('pub.search');

Future main() async {
  await startIsolates(logger: _logger, frontendEntryPoint: _main);
}

Future _main(FrontendEntryMessage message) async {
  setupServiceIsolate();

  final statsConsumer = ReceivePort();
  registerSchedulerStatsStream(statsConsumer.cast<Map>());
  message.protocolSendPort.send(FrontendProtocolMessage(
    statsConsumerPort: statsConsumer.sendPort,
  ));

  await withServices(() async {
    await popularityStorage.init();

    snapshotStorage.scheduleOldDataGC();

    final ReceivePort taskReceivePort = ReceivePort();
    registerDartSdkIndex(
        SimplePackageIndex.sdk(urlPrefix: dartSdkMainUrl(toolEnvSdkVersion)));
    registerPackageIndex(SimplePackageIndex());
    registerTaskSendPort(taskReceivePort.sendPort);

    // Don't block on SDK index updates, as it may take several minutes before
    // the dartdoc service produces the required output.
    _updateDartSdkIndex().whenComplete(() {});

    // Don't block on init, we need to serve liveliness and readiness checks.
    scheduleMicrotask(() async {
      try {
        await indexUpdater.init();
      } catch (e, st) {
        _logger.shout('Error initializing search service.', e, st);
        exit(1);
      }

      final scheduler = TaskScheduler(
        indexUpdater,
        [
          ManualTriggerTaskSource(taskReceivePort.cast<Task>()),
          IndexUpdateTaskSource(db.dbService, indexUpdater),
          DatastoreHeadTaskSource(
            db.dbService,
            TaskSourceModel.scorecard,
            sleep: const Duration(minutes: 10),
            skipHistory: true,
          ),
          indexUpdater.periodicUpdateTaskSource,
        ],
      );
      scheduler.run();

      Timer.periodic(const Duration(minutes: 5), (_) {
        updateLatestStats(scheduler.stats());
      });
    });

    await runHandler(_logger, searchServiceHandler);
  });
}

Future _updateDartSdkIndex() async {
  for (int i = 0;; i++) {
    try {
      _logger.info('Trying to load SDK index.');
      final data = await dartdocBackend.getDartSdkDartdocData();
      if (data != null) {
        final docs =
            splitLibraries(data).map((lib) => createSdkDocument(lib)).toList();
        await dartSdkIndex.addPackages(docs);
        await dartSdkIndex.merge();
        _logger.info('Dart SDK index loaded successfully.');
        return;
      }
    } on DetailedApiRequestError catch (e, st) {
      if (e.status == 404) {
        _logger.info('Error loading Dart SDK index.', e, st);
      } else {
        _logger.warning('Error loading Dart SDK index.', e, st);
      }
    } catch (e, st) {
      _logger.warning('Error loading Dart SDK index.', e, st);
    }
    if (i % 10 == 0) {
      _logger.warning('Unable to load Dart SDK index. Attempt: $i');
    }
    await Future.delayed(const Duration(minutes: 1));
  }
}
