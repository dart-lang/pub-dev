import 'dart:async' show FutureOr;

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';

import '../account/backend.dart';
import '../account/consent_backend.dart';
import '../dartdoc/backend.dart';
import '../frontend/backend.dart';
import '../frontend/email_sender.dart';
import '../frontend/name_tracker.dart';
import '../frontend/search_service.dart';
import '../history/backend.dart';
import '../job/backend.dart';
import '../publisher/backend.dart';
import '../publisher/domain_verifier.dart';
import '../scorecard/backend.dart';
import '../search/backend.dart';
import '../search/index_simple.dart';
import '../search/updater.dart';
import '../shared/analyzer_client.dart';
import '../shared/configuration.dart';
import '../shared/dartdoc_client.dart';
import '../shared/popularity_storage.dart';
import '../shared/redis_cache.dart' show withAppEngineAndCache;
import '../shared/search_client.dart';
import '../shared/storage.dart';
import '../shared/storage_retry.dart' show withStorageRetry;
import '../shared/urls.dart';
import '../shared/versions.dart';

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
    registerConsentBackend(ConsentBackend(dbService));
    registerDartdocBackend(
      DartdocBackend(
        dbService,
        await getOrCreateBucket(
            storageService, activeConfiguration.dartdocStorageBucketName),
      ),
    );
    registerDartdocClient(DartdocClient());
    registerDartSdkIndex(
        SimplePackageIndex.sdk(urlPrefix: dartSdkMainUrl(toolEnvSdkVersion)));
    registerEmailSender(
        EmailSender(dbService, activeConfiguration.blockEmails));
    registerHistoryBackend(HistoryBackend(dbService));
    registerIndexUpdater(IndexUpdater(dbService));
    registerJobBackend(JobBackend(dbService));
    registerNameTracker(NameTracker(dbService));
    registerPackageIndex(SimplePackageIndex());
    registerPopularityStorage(
      PopularityStorage(await getOrCreateBucket(
          storageService, activeConfiguration.popularityDumpBucketName)),
    );
    registerDomainVerifier(DomainVerifier());
    registerPublisherBackend(PublisherBackend(dbService));
    registerScoreCardBackend(ScoreCardBackend(dbService));
    registerSearchBackend(SearchBackend(dbService));
    registerSearchClient(SearchClient());
    registerSearchService(SearchService());
    registerSnapshotStorage(SnapshotStorage(await getOrCreateBucket(
        storageService, activeConfiguration.searchSnapshotBucketName)));
    registerTarballStorage(
      TarballStorage(
          storageService,
          await getOrCreateBucket(
              storageService, activeConfiguration.packageBucketName),
          null),
    );

    // depends on previously registered services
    registerBackend(Backend(dbService, tarballStorage));

    registerScopeExitCallback(indexUpdater.close);
    registerScopeExitCallback(accountBackend.close);
    registerScopeExitCallback(dartdocClient.close);
    registerScopeExitCallback(searchClient.close);
    registerScopeExitCallback(searchService.close);

    return await fn();
  });
}
