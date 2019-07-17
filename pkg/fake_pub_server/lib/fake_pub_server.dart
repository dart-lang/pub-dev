import 'dart:async';
import 'dart:io';

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_server/repository.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/account/testing/fake_auth_provider.dart';
import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/email_sender.dart';
import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/frontend/name_tracker.dart';
import 'package:pub_dartlang_org/frontend/search_service.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/frontend/upload_signer_service.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/redis_cache.dart';
import 'package:pub_dartlang_org/shared/services.dart';
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
      registerActiveConfiguration(Configuration.fakePubServer(
        port: port,
        storageBaseUrl: storageBaseUrl,
      ));

      await withCache(() async {
        await withPubServices(() async {
          await ss.fork(() async {
            registerAccountBackend(
                AccountBackend(db, authProvider: FakeAuthProvider(port)));

            registerDartdocClient(DartdocClient());
            registerEmailSender(
                EmailSender(db, activeConfiguration.blockEmails));
            registerNameTracker(NameTracker(db));
            nameTracker.startTracking();
            registerSearchService(SearchService());

            registerUploadSigner(FakeUploaderSignerService(storageBaseUrl));

            final pkgBucket = await getOrCreateBucket(
                _storage, activeConfiguration.packageBucketName);
            registerTarballStorage(TarballStorage(_storage, pkgBucket, null));

            registerBackend(Backend(db, tarballStorage));

            final apiHandler = backend.pubServer.requestHandler;

            final appHandler = createAppHandler(apiHandler);
            final handler = wrapHandler(_logger, appHandler, sanitize: true);

            final server = await IOServer.bind('localhost', port);
            serveRequests(server.server, (request) async {
              return await ss.fork(() async {
                return await handler(request);
              }) as shelf.Response;
            });
            _logger.info('fake_pub_server running on port $port');

            await ProcessSignal.sigterm.watch().first;

            _logger.info('fake_pub_server shutting down');
            await server.close();
            nameTracker.stopTracking();
            _logger.info('closing');
          });
        });
      });
    });
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
