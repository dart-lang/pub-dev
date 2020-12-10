// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async' show FutureOr;

import 'package:appengine/appengine.dart';
import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:meta/meta.dart';

import '../account/backend.dart';
import '../account/consent_backend.dart';
import '../account/google_oauth2.dart';
import '../admin/backend.dart';
import '../analyzer/analyzer_client.dart';
import '../dartdoc/backend.dart';
import '../dartdoc/dartdoc_client.dart';
import '../fake/backend/fake_auth_provider.dart';
import '../fake/backend/fake_domain_verifier.dart';
import '../fake/backend/fake_email_sender.dart';
import '../fake/backend/fake_upload_signer_service.dart';
import '../frontend/email_sender.dart';
import '../history/backend.dart';
import '../job/backend.dart';
import '../package/backend.dart';
import '../package/name_tracker.dart';
import '../package/search_adapter.dart';
import '../package/upload_signer_service.dart';
import '../publisher/backend.dart';
import '../publisher/domain_verifier.dart';
import '../scorecard/backend.dart';
import '../search/backend.dart';
import '../search/mem_index.dart';
import '../search/search_client.dart';
import '../search/updater.dart';
import '../shared/configuration.dart';
import '../shared/datastore.dart';
import '../shared/popularity_storage.dart';
import '../shared/redis_cache.dart' show setupCache;
import '../shared/storage.dart';
import '../shared/urls.dart';
import '../shared/versions.dart';
import '../tool/utils/http.dart';

import 'announcement/backend.dart';
import 'secret/backend.dart';
import 'spam/backend.dart';

/// Run [fn] with services;
///
///  * AppEngine: storage and datastore,
///  * Redis cache, and,
///  * storage wrapped with retry.
Future<void> withServices(FutureOr<void> Function() fn) async {
  return withAppEngineServices(() async {
    return await fork(() async {
      // retrying auth client for storage service
      final authClient = await auth
          .clientViaApplicationDefaultCredentials(scopes: [...Storage.SCOPES]);
      final retryingAuthClient = httpRetryClient(innerClient: authClient);
      registerScopeExitCallback(() async => retryingAuthClient.close());

      // override storageService with retrying http client
      registerStorageService(
          Storage(retryingAuthClient, activeConfiguration.projectId));

      // register services with external dependencies
      registerAuthProvider(GoogleOauth2AuthProvider(
        <String>[
          activeConfiguration.pubClientAudience,
          activeConfiguration.pubSiteAudience,
          activeConfiguration.adminAudience,
        ],
      ));
      registerDomainVerifier(DomainVerifier());
      registerEmailSender(
        activeConfiguration.gmailRelayServiceAccount != null &&
                activeConfiguration.gmailRelayImpersonatedGSuiteUser != null
            ? createGmailRelaySender(
                activeConfiguration.gmailRelayServiceAccount,
                activeConfiguration.gmailRelayImpersonatedGSuiteUser,
              )
            : loggingEmailSender,
      );
      registerUploadSigner(await createUploadSigner(retryingAuthClient));

      return await _withPubServices(fn);
    });
  });
}

/// Run [fn] with services.
Future<void> withFakeServices({
  @required Configuration configuration,
  @required FutureOr<void> Function() fn,
  MemDatastore datastore,
  MemStorage storage,
}) async {
  if (!envConfig.isRunningLocally) {
    throw StateError("Mustn't use fake services inside AppEngine.");
  }
  return await fork(() async {
    registerActiveConfiguration(configuration);
    registerDbService(DatastoreDB(datastore ?? MemDatastore()));
    registerStorageService(storage ?? MemStorage());

    // register fake services that would have external dependencies
    registerAuthProvider(FakeAuthProvider());
    registerDomainVerifier(FakeDomainVerifier());
    registerEmailSender(FakeEmailSender());
    registerUploadSigner(FakeUploadSignerService(configuration.storageBaseUrl));
    return await _withPubServices(fn);
  });
}

/// Run [fn] with pub services that are shared between server instances, CLI
/// tools and integration tests.
Future<void> _withPubServices(FutureOr<void> Function() fn) async {
  return fork(() async {
    registerAccountBackend(AccountBackend(dbService));
    registerAdminBackend(AdminBackend(dbService));
    registerAnalyzerClient(AnalyzerClient());
    registerAnnouncementBackend(AnnouncementBackend());
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
        InMemoryPackageIndex.sdk(urlPrefix: dartSdkMainUrl(toolEnvSdkVersion)));
    registerHistoryBackend(HistoryBackend(dbService));
    registerJobBackend(JobBackend(dbService));
    registerNameTracker(NameTracker(dbService));
    registerPackageIndex(InMemoryPackageIndex());
    registerIndexUpdater(IndexUpdater(dbService, packageIndex));
    registerPopularityStorage(
      PopularityStorage(await getOrCreateBucket(
          storageService, activeConfiguration.popularityDumpBucketName)),
    );
    registerPublisherBackend(PublisherBackend(dbService));
    registerScoreCardBackend(ScoreCardBackend(dbService));
    registerSearchBackend(SearchBackend(dbService));
    registerSearchClient(SearchClient());
    registerSearchAdapter(SearchAdapter());
    registerSecretBackend(SecretBackend(dbService));
    registerSnapshotStorage(SnapshotStorage(await getOrCreateBucket(
        storageService, activeConfiguration.searchSnapshotBucketName)));
    registerSpamBackend(SpamBackend());
    registerTarballStorage(
      TarballStorage(
          storageService,
          await getOrCreateBucket(
              storageService, activeConfiguration.packageBucketName),
          null),
    );

    // depends on previously registered services
    registerPackageBackend(PackageBackend(dbService, tarballStorage));
    await setupCache();

    registerScopeExitCallback(announcementBackend.close);
    registerScopeExitCallback(() async => nameTracker.stopTracking());
    registerScopeExitCallback(snapshotStorage.close);
    registerScopeExitCallback(indexUpdater.close);
    registerScopeExitCallback(authProvider.close);
    registerScopeExitCallback(dartdocClient.close);
    registerScopeExitCallback(searchClient.close);
    registerScopeExitCallback(searchAdapter.close);
    registerScopeExitCallback(spamBackend.close);

    return await fork(() async => fn());
  });
}
