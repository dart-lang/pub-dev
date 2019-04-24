// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:logging/logging.dart';
import 'package:pub_server/shelf_pubserver.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/dartdoc/backend.dart';
import 'package:pub_dartlang_org/history/backend.dart';
import 'package:pub_dartlang_org/job/backend.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/scorecard/scorecard_memcache.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_memcache.dart';
import 'package:pub_dartlang_org/shared/deps_graph.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/package_memcache.dart';
import 'package:pub_dartlang_org/shared/popularity_storage.dart';
import 'package:pub_dartlang_org/shared/search_client.dart';
import 'package:pub_dartlang_org/shared/search_memcache.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';
import 'package:pub_dartlang_org/shared/storage.dart';
import 'package:pub_dartlang_org/shared/redis_cache.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/cronjobs.dart' show CronJobs;
import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/frontend/email_sender.dart';
import 'package:pub_dartlang_org/frontend/name_tracker.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/frontend/upload_signer_service.dart';

final Logger _logger = Logger('pub');
final _random = Random.secure();

Future main() async {
  await startIsolates(
    logger: _logger,
    frontendEntryPoint: _main,
    workerEntryPoint: _worker,
  );
}

Future _main(FrontendEntryMessage message) async {
  setupServiceIsolate();
  message.protocolSendPort
      .send(FrontendProtocolMessage(statsConsumerPort: null));

  await updateLocalBuiltFiles();
  await withAppEngineAndCache(() async {
    final shelf.Handler apiHandler = await setupServices(activeConfiguration);

    // Add randomization to reduce race conditions.
    Timer.periodic(Duration(hours: 8, minutes: _random.nextInt(240)), (_) {
      backend.deleteObsoleteInvites();
    });

    final cron = CronJobs(await getOrCreateBucket(
      storageService,
      activeConfiguration.backupSnapshotBucketName,
    ));
    await runHandler(
      _logger,
      (shelf.Request request) => appHandler(request, apiHandler),
      sanitize: true,
      cronHandler: cron.handler,
    );
  });
}

Future<shelf.Handler> setupServices(Configuration configuration) async {
  registerEmailSender(EmailSender(db.dbService));

  registerAccountBackend(AccountBackend(db.dbService));
  registerScopeExitCallback(accountBackend.close);

  final popularityBucket = await getOrCreateBucket(
      storageService, activeConfiguration.popularityDumpBucketName);
  registerPopularityStorage(
      PopularityStorage(storageService, popularityBucket));
  await popularityStorage.init();

  final AnalyzerClient analyzerClient = AnalyzerClient();
  registerAnalyzerClient(analyzerClient);
  registerScopeExitCallback(analyzerClient.close);

  final Bucket dartdocBucket = await getOrCreateBucket(
      storageService, activeConfiguration.dartdocStorageBucketName);
  registerDartdocBackend(DartdocBackend(db.dbService, dartdocBucket));

  registerDartdocMemcache(DartdocMemcache());
  final dartdocClient = DartdocClient();
  registerDartdocClient(dartdocClient);
  registerScopeExitCallback(dartdocClient.close);

  final SearchClient searchClient = SearchClient();
  registerSearchClient(searchClient);
  registerScopeExitCallback(searchClient.close);

  registerHistoryBackend(HistoryBackend(db.dbService));
  registerJobBackend(JobBackend(db.dbService));

  registerScoreCardMemcache(ScoreCardMemcache());
  registerScoreCardBackend(ScoreCardBackend(db.dbService));

  NameTrackerUpdater(db.dbService).startNameTrackerUpdates();

  final pkgBucket =
      await getOrCreateBucket(storageService, configuration.packageBucketName);
  final tarballStorage = TarballStorage(storageService, pkgBucket, null);
  registerTarballStorage(tarballStorage);

  initSearchService();

  final cache = AppEnginePackageMemcache();
  initBackend(cache: cache);
  registerSearchMemcache(SearchMemcache());

  UploadSignerService uploadSigner;
  if (envConfig.hasCredentials) {
    final credentials = configuration.credentials;
    uploadSigner = ServiceAccountBasedUploadSigner(credentials);
  } else {
    final authClient = await auth.clientViaMetadataServer();
    registerScopeExitCallback(() async => authClient.close());
    final email = await obtainServiceAccountEmail();
    uploadSigner =
        IamBasedUploadSigner(configuration.projectId, email, authClient);
  }
  registerUploadSigner(uploadSigner);

  return ShelfPubServer(backend.repository, cache: cache).requestHandler;
}

Future _worker(WorkerEntryMessage message) async {
  setupServiceIsolate();
  message.protocolSendPort.send(WorkerProtocolMessage());

  await withAppEngineAndCache(() async {
    registerAnalyzerClient(AnalyzerClient());
    registerDartdocClient(DartdocClient());
    registerJobBackend(JobBackend(db.dbService));

    // Updates job entries for analyzer and dartdoc.
    Future triggerDependentAnalysis(
        String package, String version, Set<String> affected) async {
      await analyzerClient.triggerAnalysis(package, version, affected);
      await dartdocClient.triggerDartdoc(package, version, affected);
    }

    final pdb = await PackageDependencyBuilder.loadInitialGraphFromDb(
        db.dbService, triggerDependentAnalysis);
    await pdb.monitorInBackground(); // never returns
  });
}
