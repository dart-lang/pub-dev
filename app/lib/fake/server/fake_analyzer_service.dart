// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_dev/analyzer/handlers.dart';
import 'package:pub_dev/fake/backend/fake_popularity.dart';
import 'package:pub_dev/service/services.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/handler_helpers.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/cloudcompute/fakecloudcompute.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart';

final _logger = Logger('fake_analyzer_service');

class FakeAnalyzerService {
  final MemDatastore _datastore;
  final MemStorage _storage;
  final FakeCloudCompute _cloudCompute;

  FakeAnalyzerService(this._datastore, this._storage, this._cloudCompute);

  Future<void> run({
    int port = 8083,
    required Configuration configuration,
  }) async {
    await withFakeServices(
        configuration: configuration,
        datastore: _datastore,
        storage: _storage,
        cloudCompute: _cloudCompute,
        fn: () async {
          await generateFakeDownloadCounts();
          await generateFakePopularityValues();

          final handler = wrapHandler(_logger, analyzerServiceHandler);
          final server = await IOServer.bind('localhost', port);
          serveRequests(server.server, (request) async {
            return (await ss.fork(() async {
              if (request.requestedUri.path == '/fake-update-all') {
                return shelf.Response.badRequest(
                    body: 'endpoint no longer supported');
              }
              return await handler(request);
            }) as shelf.Response?)!;
          });
          _logger.info('running on port $port');

          (taskWorkerCloudCompute as FakeCloudCompute).startInstanceExecution();
          ss.registerScopeExitCallback(
              (taskWorkerCloudCompute as FakeCloudCompute)
                  .stopInstanceExecution);
          await taskBackend.backfillTrackingState();
          await taskBackend.start();

          await ProcessSignal.sigint.watch().first;

          _logger.info('shutting down');
          await server.close();
          _logger.info('closing');
        });
    _logger.info('closed');
  }
}
