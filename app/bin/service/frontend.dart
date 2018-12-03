// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:logging/logging.dart';
import 'package:pub_server/shelf_pubserver.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'package:pub_dartlang_org/dartdoc/backend.dart';
import 'package:pub_dartlang_org/history/backend.dart';
import 'package:pub_dartlang_org/history/models.dart';
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

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/frontend/email_sender.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/name_tracker.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/frontend/upload_signer_service.dart';

final Logger _logger = new Logger('pub');

Future main() async {
  await startIsolates(logger: _logger, frontendEntryPoint: _main);
}

Future _main(FrontendEntryMessage message) async {
  setupServiceIsolate();
  message.protocolSendPort
      .send(new FrontendProtocolMessage(statsConsumerPort: null));

  await updateLocalBuiltFiles();
  await withAppEngineServices(() async {
    final shelf.Handler apiHandler = await setupServices(activeConfiguration);
    final shelf.Handler frontendHandler =
        (shelf.Request request) => appHandler(request, apiHandler);
    await runHandler(_logger, frontendHandler, sanitize: true);
  });
}

Future<shelf.Handler> setupServices(Configuration configuration) async {
  registerEmailSender(new EmailSender(db.dbService));

  final popularityBucket = await getOrCreateBucket(
      storageService, activeConfiguration.popularityDumpBucketName);
  registerPopularityStorage(
      new PopularityStorage(storageService, popularityBucket));
  await popularityStorage.init();

  final AnalyzerClient analyzerClient = new AnalyzerClient();
  registerAnalyzerClient(analyzerClient);
  registerScopeExitCallback(analyzerClient.close);

  final Bucket dartdocBucket = await getOrCreateBucket(
      storageService, activeConfiguration.dartdocStorageBucketName);
  registerDartdocBackend(new DartdocBackend(db.dbService, dartdocBucket));

  registerDartdocMemcache(new DartdocMemcache(memcacheService));
  final dartdocClient = new DartdocClient();
  registerDartdocClient(dartdocClient);
  registerScopeExitCallback(dartdocClient.close);

  final SearchClient searchClient = new SearchClient();
  registerSearchClient(searchClient);
  registerScopeExitCallback(searchClient.close);

  registerHistoryBackend(new HistoryBackend(db.dbService));
  registerJobBackend(new JobBackend(db.dbService));

  registerScoreCardMemcache(new ScoreCardMemcache(memcacheService));
  registerScoreCardBackend(new ScoreCardBackend(db.dbService));

  new NameTrackerUpdater(db.dbService).startNameTrackerUpdates();

  final pkgBucket =
      await getOrCreateBucket(storageService, configuration.packageBucketName);
  final tarballStorage = new TarballStorage(storageService, pkgBucket, null);
  registerTarballStorage(tarballStorage);

  initOAuth2Service();

  initSearchService();

  // The future will complete once the initial database has been scanned and a
  // graph has been built.  It will nonetheless continue to monitor the database
  // in the background and maintains a global set of package dependencies.
  //
  // It can take up to 1 minute until this future completes.  Though normally we
  // don't have a new package upload within the first minute of deployment, so
  // for all practical purposes this future will be ready.
  final Future<PackageDependencyBuilder> depsGraphBuilderFuture =
      PackageDependencyBuilder.loadInitialGraphFromDb(db.dbService);

  Future uploadFinished(PackageVersion pv) async {
    await historyBackend.store(new History.package(
      source: HistorySource.account,
      event: new PackageUploaded(
        packageName: pv.package,
        packageVersion: pv.version,
        uploaderEmail: pv.uploaderEmail,
        timestamp: pv.created,
      ),
    ));

    // Future is not awaited: upload should not be blocked on the package graph initialization.
    depsGraphBuilderFuture.then((depsGraphBuilder) async {
      // Even though the deps graph builder would pick up the new [pv] eventually,
      // we'll add it explicitly here right after the upload to ensure the graph
      // is up-to-date.
      depsGraphBuilder.addPackageVersion(pv);

      // Notify analyzer services about a new version, and *DO NOT* do the
      // same with search service.  The later will get notified after analyzer
      // ran the first analysis on the new version.
      //
      // Note: We provide the analyzer service with a list of packages which need
      // re-analysis.
      final Set<String> dependentPackages =
          depsGraphBuilder.affectedPackages(pv.package);

      _logger.info(
          'Found ${dependentPackages.length} dependent packages for ${pv.package}.');

      await analyzerClient.triggerAnalysis(
          pv.package, pv.version, dependentPackages);
      await dartdocClient.triggerDartdoc(
          pv.package, pv.version, dependentPackages);
    });
  }

  final cache = new AppEnginePackageMemcache(memcacheService);
  initBackend(cache: cache, finishCallback: uploadFinished);
  registerSearchMemcache(new SearchMemcache(memcacheService));

  UploadSignerService uploadSigner;
  if (configuration.hasCredentials) {
    final credentials = configuration.credentials;
    uploadSigner = new ServiceAccountBasedUploadSigner(credentials);
  } else {
    final authClient = await auth.clientViaMetadataServer();
    registerScopeExitCallback(() async => authClient.close());
    final email = await obtainServiceAccountEmail();
    uploadSigner =
        new IamBasedUploadSigner(configuration.projectId, email, authClient);
  }
  registerUploadSigner(uploadSigner);

  return new ShelfPubServer(backend.repository, cache: cache).requestHandler;
}
