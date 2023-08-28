// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:stream_transform/stream_transform.dart' show RateLimit;
import 'package:watcher/watcher.dart';

import '../../frontend/handlers.dart';
import '../../frontend/static_files.dart';
import '../../package/name_tracker.dart';
import '../../search/top_packages.dart';
import '../../service/announcement/backend.dart';
import '../../service/youtube/backend.dart';
import '../../shared/env_config.dart';
import '../../shared/handler_helpers.dart';
import '../../shared/popularity_storage.dart';

import '_isolate.dart';

final Logger _logger = Logger('pub');

class DefaultCommand extends Command {
  @override
  String get name => 'default';

  @override
  String get description => 'The default frontend service entrypoint.';

  @override
  Future<void> run() async {
    envConfig.checkServiceEnvironment(name);
    await runIsolates(
      logger: _logger,
      frontendEntryPoint: _main,
      frontendCount: envConfig.isRunningInAppengine ? 4 : 1,
    );
  }
}

Future _main(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());

  await updateLocalBuiltFilesIfNeeded();
  final appHandler = createAppHandler();

  if (envConfig.isRunningLocally) {
    await watchForResourceChanges();
  }
  await popularityStorage.start();
  await nameTracker.startTracking();
  await announcementBackend.start();
  await topPackages.start();
  await youtubeBackend.start();

  await runHandler(_logger, appHandler, sanitize: true);
}

/// Setup local filesystem change notifications and force-reload resource files
Future<void> watchForResourceChanges() async {
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
