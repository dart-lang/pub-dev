// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:gcloud/service_scope.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/account/testing/fake_auth_provider.dart';
import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/frontend/handlers/pubapi.client.dart';
import 'package:pub_dartlang_org/publisher/domain_verifier.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/search/backend.dart';
import 'package:pub_dartlang_org/search/handlers.dart';
import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/exceptions.dart'
    show AuthorizationException;
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/popularity_storage.dart';
import 'package:pub_dartlang_org/shared/redis_cache.dart';
import 'package:pub_dartlang_org/shared/search_client.dart';
import 'package:pub_dartlang_org/shared/services.dart';

import '../shared/utils.dart';
import 'test_models.dart';

/// Setup scoped services (including fake datastore with pre-populated base data
/// and fake storage) for tests.
void testWithServices(String name, Future fn()) {
  scopedTest(name, () async {
    _setupLogging();

    // registering config with bad ports, as we won't access them via network
    registerActiveConfiguration(Configuration.fakePubServer(
      port: 0,
      storageBaseUrl: 'http://localhost:0',
    ));

    await withCache(() async {
      final db = DatastoreDB(MemDatastore());
      await db.commit(inserts: [
        foobarPackage,
        foobarStablePV,
        foobarDevPV,
        testUserA,
        hansUser,
        joeUser,
        hydrogen.package,
        ...hydrogen.versions,
        helium.package,
        ...helium.versions,
        lithium.package,
        ...lithium.versions,
        exampleComPublisher,
        exampleComHansAdmin,
      ]);
      registerDbService(db);
      registerStorageService(MemStorage());

      await withPubServices(() async {
        popularityStorage.updateValues({
          hydrogen.package.name: 0.8,
          helium.package.name: 1.0,
          lithium.package.name: 0.7,
        });

        await scoreCardBackend.updateReport(
            helium.package.name,
            helium.package.latestVersion,
            generatePanaReport(platformTags: ['flutter']));
        await scoreCardBackend.updateScoreCard(
            helium.package.name, helium.package.latestVersion);

        await fork(() async {
          registerAccountBackend(
              AccountBackend(db, authProvider: FakeAuthProvider()));
          registerDomainVerifier(_FakeDomainVerifier());

          await dartSdkIndex.merge();

          packageIndex.addPackage(
              await searchBackend.loadDocument(hydrogen.package.name));
          packageIndex.addPackage(
              await searchBackend.loadDocument(helium.package.name));
          packageIndex.addPackage(
              await searchBackend.loadDocument(lithium.package.name));
          await packageIndex.merge();

          registerSearchClient(
              SearchClient(_httpClient(handler: searchServiceHandler)));

          registerScopeExitCallback(searchClient.close);

          await fork(() async {
            await fn();
          });
        });
      });
    });
  });
}

/// Creates local, non-HTTP-based API client with [authToken].
PubApiClient createPubApiClient({String authToken}) =>
    PubApiClient('http://localhost:0/',
        client: _httpClient(authToken: authToken));

/// Returns a HTTP client that bridges HTTP requests and shelf handlers without
/// the actual HTTP transport layer.
///
/// If [handler] is not specified, it will use the default frontend handler.
http_testing.MockClient _httpClient({
  shelf.Handler handler,
  String authToken,
}) {
  handler ??= createAppHandler(null);
  handler = wrapHandler(
    Logger.detached('test'),
    handler,
    sanitize: true,
  );
  return http_testing.MockClient(
      _wrapShelfHandler(handler, authToken: authToken));
}

http_testing.MockClientHandler _wrapShelfHandler(
  shelf.Handler handler, {
  String authToken,
}) {
  return (rq) async {
    final shelfRq = shelf.Request(
      rq.method,
      rq.url,
      body: rq.body,
      headers: <String, String>{
        if (authToken != null) 'authorization': 'bearer $authToken',
        ...rq.headers,
      },
    );
    shelf.Response rs;
    // Need to fork a service scope to create a separate RequestContext in the
    // search service handler.
    await fork(() async {
      rs = await handler(shelfRq);
    });
    return http.Response(
      await rs.readAsString(),
      rs.statusCode,
      headers: rs.headers,
    );
  };
}

/// Fake implementation of [DomainVerifier] for testing.
class _FakeDomainVerifier implements DomainVerifier {
  @override
  Future<bool> verifyDomainOwnership(String domain, String accessToken) async {
    if (domain == 'verified.com') {
      return true;
    }
    if (domain == 'notverified.net') {
      return false;
    }
    throw AuthorizationException.missingSearchConsoleReadAccess();
  }
}

bool _loggingDone = false;

/// Setup logging if environment variable `DEBUG` is defined.
void _setupLogging() {
  if (_loggingDone) {
    return;
  }
  _loggingDone = true;
  if ((Platform.environment['DEBUG'] ?? '') == '') {
    return;
  }
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
    if (rec.error != null) {
      print('ERROR: ${rec.error}, ${rec.stackTrace}');
    }
  });
}
