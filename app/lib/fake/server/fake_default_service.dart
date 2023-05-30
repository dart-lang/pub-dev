// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_dev/fake/backend/fake_popularity.dart';
import 'package:pub_dev/fake/backend/fake_topics.dart';
import 'package:pub_dev/frontend/handlers.dart';
import 'package:pub_dev/package/name_tracker.dart';
import 'package:pub_dev/service/entrypoint/frontend.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/service/services.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/handler_helpers.dart';
import 'package:pub_dev/task/cloudcompute/fakecloudcompute.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart';

final _logger = Logger('fake_server');

class FakePubServer {
  final MemDatastore _datastore;
  final MemStorage _storage;
  final bool _watch;
  final FakeCloudCompute _cloudCompute;

  FakePubServer(this._datastore, this._storage, this._cloudCompute,
      {bool? watch})
      : _watch = watch ?? false;

  Future<void> run({
    required int port,
    required Configuration configuration,
    required shelf.Handler extraHandler,
  }) async {
    await withFakeServices(
        configuration: configuration,
        datastore: _datastore,
        storage: _storage,
        cloudCompute: _cloudCompute,
        fn: () async {
          if (_watch) {
            await watchForResourceChanges();
          }

          await generateFakePopularityValues();
          await generateFakeTopicValues();
          await nameTracker.startTracking();

          final appHandler = createAppHandler();
          final handler = wrapHandler(Logger('fake_server.default'), appHandler,
              sanitize: true);

          final server = await IOServer.bind('localhost', port);
          serveRequests(server.server, (request) async {
            return (await ss.fork(() async {
              final rs = await extraHandler(request);
              if (rs.statusCode != 404) return rs;
              return await handler(request);
            }) as shelf.Response?)!;
          });
          print('running on port $port');

          await waitForProcessSignalTermination();

          _logger.info('shutting down');
          await server.close();
          _logger.info('closing');
        });
    _logger.info('closed');
  }
}
