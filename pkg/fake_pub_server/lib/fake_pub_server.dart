// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/testing/fake_auth_provider.dart';
import 'package:pub_dev/frontend/handlers.dart';
import 'package:pub_dev/package/name_tracker.dart';
import 'package:pub_dev/publisher/domain_verifier.dart';
import 'package:pub_dev/publisher/testing/fake_domain_verifier.dart';
import 'package:pub_dev/service/services.dart';
import 'package:pub_dev/service/spam/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/handler_helpers.dart';

final _logger = Logger('fake_server');

class FakePubServer {
  final MemDatastore _datastore;
  final MemStorage _storage;

  FakePubServer(this._datastore, this._storage);

  Future<void> run({
    @required int port,
    @required Configuration configuration,
    shelf.Handler extraHandler,
  }) async {
    await withFakeServices(
        configuration: configuration,
        datastore: _datastore,
        storage: _storage,
        fn: () async {
          registerAuthProvider(FakeAuthProvider(port));
          registerDomainVerifier(FakeDomainVerifier());

          nameTracker.startTracking();
          spamBackend.setSpamConfig(spamWords: ['SPAM-SPAM-SPAM']);

          final appHandler = createAppHandler();
          final handler = wrapHandler(_logger, appHandler, sanitize: true);

          final server = await IOServer.bind('localhost', port);
          serveRequests(server.server, (request) async {
            return await ss.fork(() async {
              return await extraHandler(request) ?? await handler(request);
            }) as shelf.Response;
          });
          _logger.info('running on port $port');

          await ProcessSignal.sigint.watch().first;

          _logger.info('shutting down');
          await server.close();
          _logger.info('closing');
        });
    _logger.info('closed');
  }
}
