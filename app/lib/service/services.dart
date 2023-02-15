// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async' show FutureOr, Zone;

import 'package:appengine/appengine.dart';
import 'package:clock/clock.dart';
import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart';

import '../account/backend.dart';
import '../account/consent_backend.dart';
import '../account/default_auth_provider.dart';
import '../account/like_backend.dart';
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
import '../search/top_packages.dart';
import '../search/updater.dart';
import '../service/email/backend.dart';
import '../service/youtube/backend.dart';
import '../shared/configuration.dart';
import '../shared/datastore.dart';
import '../shared/env_config.dart';
import '../shared/handler_helpers.dart';
import '../shared/popularity_storage.dart';
import '../shared/redis_cache.dart' show setupCache;
import '../shared/storage.dart';
import '../shared/versions.dart';
import '../task/backend.dart';
import '../task/cloudcompute/fakecloudcompute.dart';
import '../task/cloudcompute/googlecloudcompute.dart';
import '../tool/utils/http.dart';
import 'announcement/backend.dart';
import 'secret/backend.dart';

final _logger = Logger('pub.services');
final _pubDevServicesInitializedKey = '_pubDevServicesInitializedKey';

/// Run [fn] with services;
///
///  * AppEngine: storage and datastore,
///  * Redis cache, and,
///  * storage wrapped with retry.
Future<void> withServices(FutureOr<void> Function() fn) async {
  if (Zone.current[_pubDevServicesInitializedKey] == true) {
    throw StateError('Already in withServices scope.');
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
      registerAuthProvider(DefaultAuthProvider());
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

      // Confiugure a CloudCompute pool for later use in TaskBackend
      //
      // This should not be wrapped with [httpRetryClient] because entire
      // requests are retried by our GCE logic.
      final gceClient = await auth.clientViaApplicationDefaultCredentials(
        scopes: [googleCloudComputeScope],
      );
      registerCloudComputeClient(gceClient);
      registerScopeExitCallback(gceClient.close);
      registertaskWorkerCloudCompute(createGoogleCloudCompute(
        project: activeConfiguration.taskWorkerProject!,
        network: activeConfiguration.taskWorkerNetwork!,
        poolLabel:
            '${activeConfiguration.projectId}_${runtimeVersion.replaceAll('.', '-')}_worker',
        taskWorkerServiceAccount: activeConfiguration.taskWorkerServiceAccount!,
        cosImage: activeConfiguration.cosImage!,
        maxRunDuration: Duration(hours: activeConfiguration.maxTaskRunHours),
      ));

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
  FakeCloudCompute? cloudCompute,
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
    for (final bucketName in configuration!.allBucketNames) {
      await storage.createBucket(bucketName);
    }

    // register fake services that would have external dependencies

    // Local override for OAuth services when developing for external servers.
    if (envConfig.fakeOauthSiteAudience != null &&
        envConfig.fakeOauthSiteAudienceSecret != null) {
      registerAuthProvider(DefaultAuthProvider(
        oauthSiteAudience: envConfig.fakeOauthSiteAudience,
        oauthSiteAudienceSecret: envConfig.fakeOauthSiteAudienceSecret,
      ));
    } else {
      registerAuthProvider(FakeAuthProvider());
    }
    registerScopeExitCallback(authProvider.close);
    registerDomainVerifier(FakeDomainVerifier());
    registerEmailSender(FakeEmailSender());
    registerUploadSigner(
        FakeUploadSignerService(configuration!.storageBaseUrl!));

    registertaskWorkerCloudCompute(cloudCompute ?? FakeCloudCompute());

    return await _withPubServices(() async {
      await topPackages.start();
      await youtubeBackend.start();
      if (frontendServer != null) {
        final handler = wrapHandler(
            _logger, _fakeClockWrapper(createAppHandler()),
            sanitize: true);
        final fsSubscription = frontendServer.server.listen((rq) async {
          await fork(() => handleRequest(rq, handler));
        });
        registerScopeExitCallback(fsSubscription.cancel);
      }
      return await fn();
    });
  }) as R;
}

const fakeClockHeaderName = '_fake_clock';

/// In the fake server a request can send a '_fake_clock' header to specify at
/// what timestamp the request should be handled.
shelf.Handler _fakeClockWrapper(shelf.Handler handler) {
  return (shelf.Request request) {
    final t = request.headers[fakeClockHeaderName];
    if (t == null) {
      return handler(request);
    } else {
      return withClock(Clock.fixed(DateTime.parse(t)), () => handler(request));
    }
  };
}

/// Run [fn] with pub services that are shared between server instances, CLI
/// tools and integration tests.
Future<R> _withPubServices<R>(FutureOr<R> Function() fn) async {
  return fork(() async {
    // verify the existence of all storage buckets
    for (final bucketName in activeConfiguration.allBucketNames) {
      await storageService.verifyBucketExistenceAndAccess(bucketName);
    }

    registerAccountBackend(AccountBackend(dbService));
    registerAdminBackend(AdminBackend(dbService));
    registerAnnouncementBackend(AnnouncementBackend());
    registerAuditBackend(AuditBackend(dbService));
    registerConsentBackend(ConsentBackend(dbService));
    registerDartdocBackend(
      DartdocBackend(
        dbService,
        storageService.bucket(activeConfiguration.dartdocStorageBucketName!),
      ),
    );
    registerDartSdkMemIndex(DartSdkMemIndex());
    registerEmailBackend(EmailBackend(dbService));
    registerFlutterSdkMemIndex(FlutterSdkMemIndex());
    registerJobBackend(JobBackend(dbService));
    registerLikeBackend(LikeBackend(dbService));
    registerNameTracker(NameTracker(dbService));
    registerPackageIndex(InMemoryPackageIndex(
      popularityValueFn: (p) => popularityStorage.lookup(p),
    ));
    registerIndexUpdater(IndexUpdater(dbService, packageIndex));
    registerPopularityStorage(
      PopularityStorage(
          storageService.bucket(activeConfiguration.popularityDumpBucketName!)),
    );
    registerPublisherBackend(PublisherBackend(dbService));
    registerScoreCardBackend(ScoreCardBackend(dbService));
    registerSearchBackend(SearchBackend(dbService));
    registerSearchClient(SearchClient());
    registerSearchAdapter(SearchAdapter());
    registerSecretBackend(SecretBackend(dbService));
    registerSnapshotStorage(SnapshotStorage(
        storageService.bucket(activeConfiguration.searchSnapshotBucketName!)));
    registerImageStorage(ImageStorage(
        storageService.bucket(activeConfiguration.imageBucketName!)));
    registerTopPackages(TopPackages());
    registerYoutubeBackend(YoutubeBackend());

    // depends on previously registered services
    registerPackageBackend(PackageBackend(
      dbService,
      storageService,
      storageService.bucket(activeConfiguration.incomingPackagesBucketName!),
      storageService.bucket(activeConfiguration.canonicalPackagesBucketName!),
      storageService.bucket(activeConfiguration.publicPackagesBucketName!),
    ));
    registerTaskBackend(TaskBackend(
      dbService,
      taskWorkerCloudCompute,
      storageService.bucket(activeConfiguration.taskResultBucketName!),
    ));

    await setupCache();

    registerScopeExitCallback(taskBackend.stop);
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
    registerScopeExitCallback(topPackages.close);
    registerScopeExitCallback(youtubeBackend.close);

    // Create a zone-local flag to indicate that services setup has been completed.
    return await fork(
      () => Zone.current.fork(zoneValues: {
        _pubDevServicesInitializedKey: true,
      }).run(
        () async {
          _logger.info('Started running inside services scope...');
          try {
            return await fn();
          } catch (e, st) {
            _logger.severe('Uncaught exception inside services scope.', e, st);
            rethrow;
          } finally {
            _logger.warning('Exiting services scope.');
          }
        },
      ),
    );
  }) as R;
}
