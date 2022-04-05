// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async' show FutureOr, Zone;

import 'package:appengine/appengine.dart';
import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:shelf/shelf_io.dart';

import '../account/backend.dart';
import '../account/consent_backend.dart';
import '../account/google_oauth2.dart';
import '../admin/backend.dart';
import '../audit/backend.dart';
import '../dartdoc/backend.dart';
import '../fake/backend/fake_auth_provider.dart';
import '../fake/backend/fake_domain_verifier.dart';
import '../fake/backend/fake_email_sender.dart';
import '../fake/backend/fake_upload_signer_service.dart';
import '../fake/server/fake_client_context.dart';
import '../fake/server/fake_storage_server.dart';
import '../frontend/email_sender.dart';
import '../frontend/handlers.dart';
import '../job/backend.dart';
import '../package/backend.dart';
import '../package/name_tracker.dart';
import '../package/screenshots/backend.dart';
import '../package/search_adapter.dart';
import '../package/upload_signer_service.dart';
import '../publisher/backend.dart';
import '../publisher/domain_verifier.dart';
import '../scorecard/backend.dart';
import '../search/backend.dart';
import '../search/dart_sdk_mem_index.dart';
import '../search/flutter_sdk_mem_index.dart';
import '../search/mem_index.dart';
import '../search/search_client.dart';
import '../search/updater.dart';
import '../service/youtube/backend.dart';
import '../shared/configuration.dart';
import '../shared/datastore.dart';
import '../shared/env_config.dart';
import '../shared/popularity_storage.dart';
import '../shared/redis_cache.dart' show setupCache;
import '../shared/storage.dart';
import '../tool/utils/http.dart';

import 'announcement/backend.dart';
import 'secret/backend.dart';

final _pubDevServicesInitializedKey = '_pubDevServicesInitializedKey';

/// Run [fn] with services;
///
///  * AppEngine: storage and datastore,
///  * Redis cache, and,
///  * storage wrapped with retry.
Future<void> withServices(FutureOr<void> Function() fn) async {
  if (Zone.current[_pubDevServicesInitializedKey] == true) {
    return await fork(() async => await fn());
  }
  return withAppEngineServices(() async {
    return await fork(() async {
      // retrying Datastore client
      final origDbService = dbService;
      registerDbService(RetryDatastoreDB(origDbService));

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
          activeConfiguration.pubClientAudience!,
          activeConfiguration.pubSiteAudience!,
          activeConfiguration.adminAudience!,
        ],
      ));
      registerScopeExitCallback(authProvider.close);
      registerDomainVerifier(DomainVerifier());
      registerEmailSender(
        activeConfiguration.gmailRelayServiceAccount != null &&
                activeConfiguration.gmailRelayImpersonatedGSuiteUser != null
            ? createGmailRelaySender(
                activeConfiguration.gmailRelayServiceAccount!,
                activeConfiguration.gmailRelayImpersonatedGSuiteUser!,
                authClient,
              )
            : loggingEmailSender,
      );
      registerUploadSigner(await createUploadSigner(retryingAuthClient));

      return await _withPubServices(fn);
    });
  });
}

/// Run [fn] with services.
Future<R> withFakeServices<R>({
  required FutureOr<R> Function() fn,
  Configuration? configuration,
  MemDatastore? datastore,
  MemStorage? storage,
}) async {
  if (Zone.current[_pubDevServicesInitializedKey] == true) {
    return await fork(() async => await fn()) as R;
  }
  if (!envConfig.isRunningLocally) {
    throw StateError("Mustn't use fake services inside AppEngine.");
  }
  datastore ??= MemDatastore();
  storage ??= MemStorage();
  // TODO: update `package:gcloud` to have a typed fork.
  return await fork(() async {
    register(#appengine.context, FakeClientContext());
    registerDbService(RetryDatastoreDB(DatastoreDB(datastore!)));
    registerStorageService(storage!);
    IOServer? frontendServer;
    if (configuration == null) {
      // start storage server
      final storageServer = FakeStorageServer(storage);
      await storageServer.start();
      registerScopeExitCallback(storageServer.close);

      frontendServer = await IOServer.bind('localhost', 0);
      final frontendServerUri =
          Uri.parse('http://localhost:${frontendServer.server.port}');
      registerScopeExitCallback(frontendServer.close);

      // update configuration
      configuration = Configuration.test(
        storageBaseUrl: 'http://localhost:${storageServer.port}',
        primaryApiUri: frontendServerUri,
        primarySiteUri: frontendServerUri,
      );
    }
    registerActiveConfiguration(configuration!);
    final bucketsToCreate = [
      configuration!.canonicalPackagesBucketName!,
      configuration!.publicPackagesBucketName!,
      configuration!.incomingPackagesBucketName!,
      configuration!.packageBucketName!,
    ];
    for (final bucketName in bucketsToCreate) {
      await getOrCreateBucket(storage, bucketName);
    }

    // register fake services that would have external dependencies
    registerAuthProvider(FakeAuthProvider());
    registerScopeExitCallback(authProvider.close);
    registerDomainVerifier(FakeDomainVerifier());
    registerEmailSender(FakeEmailSender());
    registerUploadSigner(
        FakeUploadSignerService(configuration!.storageBaseUrl!));
    return await _withPubServices(() async {
      await youtubeBackend.start();
      if (frontendServer != null) {
        final frontendServerSubscription = frontendServer.server
            .listen((rq) => handleRequest(rq, createAppHandler()));
        registerScopeExitCallback(frontendServerSubscription.cancel);
      }
      return await fn();
    });
  }) as R;
}

/// Run [fn] with pub services that are shared between server instances, CLI
/// tools and integration tests.
Future<R> _withPubServices<R>(FutureOr<R> Function() fn) async {
  return fork(() async {
    registerAccountBackend(AccountBackend(dbService));
    registerAdminBackend(AdminBackend(dbService));
    registerAnnouncementBackend(AnnouncementBackend());
    registerAuditBackend(AuditBackend(dbService));
    registerConsentBackend(ConsentBackend(dbService));
    registerDartdocBackend(
      DartdocBackend(
        dbService,
        await getOrCreateBucket(
            storageService, activeConfiguration.dartdocStorageBucketName!),
      ),
    );
    registerDartSdkMemIndex(DartSdkMemIndex());
    registerFlutterSdkMemIndex(FlutterSdkMemIndex());
    registerJobBackend(JobBackend(dbService));
    registerNameTracker(NameTracker(dbService));
    registerPackageIndex(InMemoryPackageIndex());
    registerIndexUpdater(IndexUpdater(dbService, packageIndex));
    registerPopularityStorage(
      PopularityStorage(await getOrCreateBucket(
          storageService, activeConfiguration.popularityDumpBucketName!)),
    );
    registerPublisherBackend(PublisherBackend(dbService));
    registerScoreCardBackend(ScoreCardBackend(dbService));
    registerSearchBackend(SearchBackend(dbService));
    registerSearchClient(SearchClient());
    registerSearchAdapter(SearchAdapter());
    registerSecretBackend(SecretBackend(dbService));
    registerSnapshotStorage(SnapshotStorage(await getOrCreateBucket(
        storageService, activeConfiguration.searchSnapshotBucketName!)));
    registerImageStorage(ImageStorage(await getOrCreateBucket(
        storageService, activeConfiguration.imageBucketName!)));

    registerYoutubeBackend(YoutubeBackend());

    // depends on previously registered services
    registerPackageBackend(PackageBackend(
      dbService,
      storageService,
      storageService.bucket(activeConfiguration.packageBucketName!),
    ));
    await setupCache();

    registerScopeExitCallback(announcementBackend.close);
    registerScopeExitCallback(searchBackend.close);
    registerScopeExitCallback(() async => nameTracker.stopTracking());
    registerScopeExitCallback(snapshotStorage.close);
    registerScopeExitCallback(indexUpdater.close);
    registerScopeExitCallback(dartSdkMemIndex.close);
    registerScopeExitCallback(flutterSdkMemIndex.close);
    registerScopeExitCallback(popularityStorage.close);
    registerScopeExitCallback(scoreCardBackend.close);
    registerScopeExitCallback(searchClient.close);
    registerScopeExitCallback(youtubeBackend.close);

    // Create a zone-local flag to indicate that services setup has been completed.
    return await fork(() => Zone.current.fork(zoneValues: {
          _pubDevServicesInitializedKey: true,
        }).run(() async => await fn()));
  }) as R;
}
