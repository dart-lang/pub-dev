import 'dart:async';
import 'dart:io';

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:pub_dartlang_org/search/search_service.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/account/testing/fake_auth_provider.dart';
import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/frontend/testing/fake_upload_signer_service.dart';
import 'package:pub_dartlang_org/package/backend.dart';
import 'package:pub_dartlang_org/package/name_tracker.dart';
import 'package:pub_dartlang_org/package/upload_signer_service.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/search/search_client.dart';
import 'package:pub_dartlang_org/service/services.dart';

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
      registerStorageService(_storage);
      registerActiveConfiguration(Configuration.fakePubServer(
        port: port,
        storageBaseUrl: storageBaseUrl,
      ));

      await withPubServices(() async {
        await ss.fork(() async {
          registerAccountBackend(
              AccountBackend(db, authProvider: FakeAuthProvider(port)));
          registerUploadSigner(FakeUploadSignerService(storageBaseUrl));
          registerSearchClient(MockSearchClient());

          nameTracker.startTracking();

          final apiHandler = packageBackend.pubServer.requestHandler;

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
  }
}

class MockSearchClient implements SearchClient {
  @override
  Future<PackageSearchResult> search(SearchQuery query) async {
    throw UnimplementedError();
  }

  @override
  Future triggerReindex(String package, String version) async {}

  @override
  Future close() async {}
}
