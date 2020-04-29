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

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/testing/fake_auth_provider.dart';
import 'package:pub_dev/frontend/email_sender.dart';
import 'package:pub_dev/frontend/handlers.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';
import 'package:pub_dev/frontend/testing/fake_upload_signer_service.dart';
import 'package:pub_dev/package/upload_signer_service.dart';
import 'package:pub_dev/publisher/domain_verifier.dart';
import 'package:pub_dev/publisher/testing/fake_domain_verifier.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/search/handlers.dart';
import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/updater.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/email.dart';
import 'package:pub_dev/shared/handler_helpers.dart';
import 'package:pub_dev/shared/integrity.dart';
import 'package:pub_dev/shared/popularity_storage.dart';
import 'package:pub_dev/search/search_client.dart';
import 'package:pub_dev/service/services.dart';

import '../shared/utils.dart';
import 'test_models.dart';

/// Setup scoped services for tests.
///
/// If [omitData] is not set to `true`, a default set of user and package data
/// will be populated and indexed in search.
void testWithServices(
  String name,
  Future<void> Function() fn, {
  bool omitData = false,
}) {
  scopedTest(name, () async {
    _setupLogging();
    registerActiveConfiguration(Configuration.test());

    final db = DatastoreDB(MemDatastore());
    registerDbService(db);
    registerStorageService(MemStorage());

    await withPubServices(() async {
      await fork(() async {
        registerAuthProvider(FakeAuthProvider());
        registerDomainVerifier(FakeDomainVerifier());
        registerEmailSender(FakeEmailSender());
        registerUploadSigner(FakeUploadSignerService('https://storage.url'));

        if (!omitData) {
          await _populateDefaultData();
        }
        await dartSdkIndex.markReady();
        await indexUpdater.updateAllPackages();

        registerSearchClient(
            SearchClient(_httpClient(handler: searchServiceHandler)));

        registerScopeExitCallback(searchClient.close);

        await fork(() async {
          await fn();
          // post-test integrity check
          final problems = await IntegrityChecker(dbService).check();
          if (problems.isNotEmpty) {
            throw Exception(
                '${problems.length} integrity problems detected. First: ${problems.first}');
          }
        });
      });
    });
  });
}

Future<void> _populateDefaultData() async {
  await dbService.commit(inserts: [
    foobarPackage,
    foobarStablePV,
    foobarDevPV,
    ...pvModels(foobarStablePV),
    ...pvModels(foobarDevPV),
    testUserA,
    hansUser,
    joeUser,
    adminUser,
    adminOAuthUserID,
    hydrogen.package,
    ...hydrogen.versions.map(pvModels).expand((m) => m),
    helium.package,
    ...helium.versions.map(pvModels).expand((m) => m),
    lithium.package,
    ...lithium.versions.map(pvModels).expand((m) => m),
    moderatedPackage,
    exampleComPublisher,
    exampleComHansAdmin,
  ]);

  popularityStorage.updateValues({
    hydrogen.package.name: 0.8,
    helium.package.name: 1.0,
    lithium.package.name: 0.7,
  });

  await scoreCardBackend.updateReport(
      helium.package.name,
      helium.package.latestVersion,
      generatePanaReport(derivedTags: ['sdk:flutter']));
  await scoreCardBackend.updateScoreCard(
      helium.package.name, helium.package.latestVersion);
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
  handler ??= createAppHandler();
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

FakeEmailSender get fakeEmailSender => emailSender as FakeEmailSender;

class FakeEmailSender implements EmailSender {
  final sentMessages = <EmailMessage>[];

  @override
  Future<void> sendMessage(EmailMessage message) async {
    sentMessages.add(message);
    return;
  }
}
