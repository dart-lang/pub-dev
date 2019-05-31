import 'dart:async';
import 'dart:io';

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_server/repository.dart';
import 'package:pub_server/shelf_pubserver.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/email_sender.dart';
import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/frontend/upload_signer_service.dart';
import 'package:pub_dartlang_org/history/backend.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/scorecard/scorecard_memcache.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/package_memcache.dart';
import 'package:pub_dartlang_org/shared/redis_cache.dart';
import 'package:pub_dartlang_org/shared/storage.dart';

final _logger = Logger('fake_server');

class FakePubServer {
  final MemStorage _storage;
  final _datastore = MemDatastore();

  FakePubServer(this._storage);

  Future run({
    int port = 8080,
    String storageBaseUrl = 'http://localhost:8081',
  }) async {
    await updateLocalBuiltFiles();
    await ss.fork(() async {
      final db = DatastoreDB(_datastore);
      registerDbService(db);

      await withCache(() async {
        registerActiveConfiguration(Configuration(
          projectId: 'dartlang-pub-fake',
          packageBucketName: 'fake-bucket-pub',
          dartdocStorageBucketName: 'fake-bucket-dartdoc',
          popularityDumpBucketName: 'fake-bucket-popularity',
          searchSnapshotBucketName: 'fake-bucket-search',
          backupSnapshotBucketName: 'fake-bucket-backup',
          searchServicePrefix: 'http://localhost:$port',
          pubHostedUrl: 'http://localhost:$port',
          storageBaseUrl: storageBaseUrl,
          pubClientAudience: null,
          pubSiteAudience: null,
          credentials: null,
          blockRobots: true,
          productionHosts: ['localhost'],
        ));
        registerAccountBackend(
            AccountBackend(db, authProvider: FakeAuthProvider()));
        registerAnalyzerClient(AnalyzerClient());
        registerDartdocClient(DartdocClient());
        registerEmailSender(EmailSender(db));
        registerHistoryBackend(HistoryBackend(db));
        registerScoreCardBackend(ScoreCardBackend(db));
        registerScoreCardMemcache(ScoreCardMemcache());

        registerUploadSigner(FakeUploaderSignerService(storageBaseUrl));

        final pkgBucket = await getOrCreateBucket(
            _storage, activeConfiguration.packageBucketName);
        registerTarballStorage(TarballStorage(_storage, pkgBucket, null));

        final cache = AppEnginePackageMemcache();
        registerBackend(Backend(db, tarballStorage, cache: cache));

        final apiHandler =
            ShelfPubServer(backend.repository, cache: cache).requestHandler;

        final handler = wrapHandler(
            _logger, (shelf.Request request) => appHandler(request, apiHandler),
            sanitize: true);

        final server = await IOServer.bind('localhost', port);
        serveRequests(server.server, (request) async {
          return await ss.fork(() async {
            return await handler(request);
          }) as shelf.Response;
        });
        _logger.info('fake_pub_server running on port $port');

        StreamSubscription sigsubs;
        sigsubs = ProcessSignal.sighup.watch().listen((_) async {
          await sigsubs.cancel();
          await server.close();
        });
        await sigsubs.asFuture();
      });
    });
  }
}

class FakeAuthProvider implements AuthProvider {
  @override
  Future<String> authCodeToAccessToken(String redirectUrl, String code) async {
    return code;
  }

  @override
  String authorizationUrl(String redirectUrl, String state) {
    return redirectUrl;
  }

  @override
  Future close() async {}

  @override
  Future<AuthResult> tryAuthenticate(String accessToken) async {
    return AuthResult('user-example-com', 'user@example.com');
  }
}

class FakeUploaderSignerService implements UploadSignerService {
  final String _storagePrefix;
  FakeUploaderSignerService(this._storagePrefix);

  @override
  Future<AsyncUploadInfo> buildUpload(
    String bucket,
    String object,
    Duration lifetime,
    String successRedirectUrl, {
    String predefinedAcl = 'project-private',
    int maxUploadSize = UploadSignerService.maxUploadSize,
  }) async {
    return AsyncUploadInfo(Uri.parse('$_storagePrefix/$bucket/$object'), {
      'key': '$bucket/$object',
      'success_action_redirect': successRedirectUrl,
    });
  }

  @override
  Future<SigningResult> sign(List<int> bytes) async {
    return SigningResult('google-access-id', [1, 2, 3, 4]);
  }
}
