import 'dart:async' show FutureOr;

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';

import '../account/backend.dart';
import '../dartdoc/backend.dart';
import '../frontend/backend.dart';
import '../frontend/email_sender.dart';
import '../history/backend.dart';
import '../job/backend.dart';
import '../publisher/backend.dart';
import '../scorecard/backend.dart';
import '../shared/analyzer_client.dart';
import '../shared/configuration.dart';
import '../shared/dartdoc_client.dart';
import '../shared/storage.dart';

import 'redis_cache.dart' show withAppEngineAndCache;
import 'storage_retry.dart' show withStorageRetry;

/// Run [fn] with services;
///
///  * AppEngine: storage and datastore,
///  * Redis cache, and,
///  * storage wrapped with retry.
Future<void> withServices(FutureOr<void> Function() fn) async {
  return await withAppEngineAndCache(() async {
    return await withStorageRetry(() async {
      return await withPubServices(fn);
    });
  });
}

/// Run [fn] with pub services that are shared between server instances, CLI
/// tools and integration tests.
Future<void> withPubServices(FutureOr<void> Function() fn) async {
  return fork(() async {
    registerAccountBackend(AccountBackend(dbService));
    registerAnalyzerClient(AnalyzerClient());
    registerDartdocBackend(
      DartdocBackend(
        dbService,
        await getOrCreateBucket(
            storageService, activeConfiguration.dartdocStorageBucketName),
      ),
    );
    registerDartdocClient(DartdocClient());
    registerEmailSender(
        EmailSender(dbService, activeConfiguration.blockEmails));
    registerHistoryBackend(HistoryBackend(dbService));
    registerJobBackend(JobBackend(dbService));
    registerPublisherBackend(PublisherBackend(dbService));
    registerScoreCardBackend(ScoreCardBackend(dbService));
    registerTarballStorage(
      TarballStorage(
          storageService,
          await getOrCreateBucket(
              storageService, activeConfiguration.packageBucketName),
          null),
    );

    // depends on previously registered services
    registerBackend(Backend(dbService, tarballStorage));

    registerScopeExitCallback(accountBackend.close);
    registerScopeExitCallback(dartdocClient.close);

    return await fn();
  });
}
