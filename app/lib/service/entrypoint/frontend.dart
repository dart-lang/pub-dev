// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:args/command_runner.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:stream_transform/stream_transform.dart' show RateLimit;
import 'package:watcher/watcher.dart';

import '../../account/backend.dart';
import '../../account/consent_backend.dart';
import '../../analyzer/analyzer_client.dart';
import '../../audit/backend.dart';
import '../../frontend/handlers.dart';
import '../../frontend/static_files.dart';
import '../../frontend/templates/_cache.dart';
import '../../package/deps_graph.dart';
import '../../package/name_tracker.dart';
import '../../service/announcement/backend.dart';
import '../../service/spam/backend.dart';
import '../../shared/configuration.dart';
import '../../shared/datastore.dart' as db;
import '../../shared/handler_helpers.dart';
import '../../shared/popularity_storage.dart';
import '../../shared/storage.dart';
import '../services.dart';

import '_cronjobs.dart' show CronJobs;
import '_isolate.dart';

final Logger _logger = Logger('pub');
final _random = Random.secure();

class DefaultCommand extends Command {
  @override
  String get name => 'default';

  @override
  String get description => 'The default frontend service entrypoint.';

  @override
  Future<void> run() async {
    // Ensure that we're running in the right environment, or is running locally
    if (envConfig.gaeService != null && envConfig.gaeService != name) {
      throw StateError(
        'Cannot start "$name" in "${envConfig.gaeService}" environment',
      );
    }

    await startIsolates(
      logger: _logger,
      frontendEntryPoint: _main,
      workerEntryPoint: envConfig.isRunningLocally ? null : _worker,
    );
  }
}

Future _main(FrontendEntryMessage message) async {
  setupServiceIsolate();
  message.protocolSendPort
      .send(FrontendProtocolMessage(statsConsumerPort: null));

  await updateLocalBuiltFilesIfNeeded();
  await withServices(() async {
    final cron = CronJobs(await getOrCreateBucket(
      storageService,
      activeConfiguration.backupSnapshotBucketName,
    ));
    final appHandler = createAppHandler();

    if (envConfig.isRunningLocally) {
      await _watchForResourceChanges();
    }
    await popularityStorage.init();
    nameTracker.startTracking();
    await announcementBackend.update();
    announcementBackend.scheduleRegularUpdates();
    await spamBackend.update();
    spamBackend.scheduleRegularUpdates();

    await runHandler(_logger, appHandler,
        sanitize: true, cronHandler: cron.handler);
  });
}

/// Setup local filesystem change notifications and force-reload resource files
Future<void> _watchForResourceChanges() async {
  _logger.info('Watching for resource changes...');

  void setupWatcher(
      String name, String path, FutureOr<void> Function() updateFn) {
    final w = Watcher(path, pollingDelay: Duration(seconds: 3));
    final subs = w.events.debounce(Duration(milliseconds: 200)).listen(
      (_) async {
        _logger.info('Updating $name...');
        await updateFn();
        _logger.info('$name updated.');
      },
    );
    registerScopeExitCallback(subs.cancel);
  }

  // watch mustache templates
  setupWatcher(
      'mustache templates', templateViewsDir, () => templateCache.update());

  // watch pkg/web_app
  setupWatcher('/pkg/web_app', path.join(resolveWebAppDirPath(), 'lib'),
      () => updateWebAppBuild());

  // watch pkg/web_css
  setupWatcher('/pkg/web_css', path.join(resolveWebCssDirPath(), 'lib'),
      () => updateWebCssBuild());

  // watch /static files
  setupWatcher('/static', resolveStaticDirPath(),
      () => registerStaticFileCacheForTest(StaticFileCache.withDefaults()));
}

Future _worker(WorkerEntryMessage message) async {
  setupServiceIsolate();
  message.protocolSendPort.send(WorkerProtocolMessage());

  await withServices(() async {
    // TODO: use package:neat_periodic_task
    // Randomization reduces race conditions.
    Timer.periodic(Duration(hours: 8, minutes: _random.nextInt(240)),
        (_) async {
      await consentBackend.deleteObsoleteConsents();
      await accountBackend.deleteObsoleteSessions();
      await auditBackend.deleteExpiredRecords();
    });

    // Updates job entries for analyzer and dartdoc.
    Future<void> triggerDependentAnalysis(
        String package, String version, Set<String> affected) async {
      await analyzerClient.triggerAnalysis(package, version, affected);
      // TODO: re-enable this after we have added some stop-gaps on the frequency
      // await dartdocClient.triggerDartdoc(package, version,
      //    dependentPackages: affected);
    }

    final pdb = await PackageDependencyBuilder.loadInitialGraphFromDb(
        db.dbService, triggerDependentAnalysis);
    await pdb.monitorInBackground(); // never returns
  });
}
