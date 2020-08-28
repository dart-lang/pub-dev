// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart';

import 'package:pub_dev/analyzer/handlers.dart';
import 'package:pub_dev/analyzer/pana_runner.dart';
import 'package:pub_dev/job/job.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/handler_helpers.dart';
import 'package:pub_dev/service/services.dart';

final _logger = Logger('fake_analyzer_service');

class FakeAnalyzerService {
  final MemDatastore _datastore;
  final MemStorage _storage;

  FakeAnalyzerService(this._datastore, this._storage);

  Future<void> run({
    int port = 8083,
    @required Configuration configuration,
  }) async {
    await ss.fork(() async {
      final db = DatastoreDB(_datastore);
      registerDbService(db);
      registerStorageService(_storage);
      registerActiveConfiguration(configuration);

      await withPubServices(() async {
        await ss.fork(() async {
          final jobProcessor = AnalyzerJobProcessor(aliveCallback: null);
          final jobMaintenance = JobMaintenance(dbService, jobProcessor);

          final handler = wrapHandler(_logger, analyzerServiceHandler);
          final server = await IOServer.bind('localhost', port);
          serveRequests(server.server, (request) async {
            return await ss.fork(() async {
              if (request.requestedUri.path == '/fake-update-all') {
                // ignore: invalid_use_of_visible_for_testing_member
                await jobMaintenance.scanUpdateAndRunOnce();
                return shelf.Response.ok('');
              }
              return await handler(request);
            }) as shelf.Response;
          });
          _logger.info('running on port $port');

          await ProcessSignal.sigterm.watch().first;

          _logger.info('shutting down');
          await server.close();
          _logger.info('closing');
        });
      });
    });
    _logger.info('closed');
  }
}
