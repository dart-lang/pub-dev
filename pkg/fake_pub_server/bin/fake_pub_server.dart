// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:fake_pub_server/fake_pub_server.dart';
import 'package:fake_pub_server/fake_search_service.dart';
import 'package:fake_pub_server/fake_storage_server.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/shared/configuration.dart';

final _argParser = ArgParser()
  ..addOption('port',
      defaultsTo: '8080', help: 'The HTTP port of the fake pub server.')
  ..addOption('storage-port',
      defaultsTo: '8081', help: 'The HTTP port for the fake storage server.')
  ..addOption('search-port',
      defaultsTo: '8082', help: 'The HTTP port for the fake search service.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  final port = int.parse(argv['port'] as String);
  final storagePort = int.parse(argv['storage-port'] as String);
  final searchPort = int.parse(argv['search-port'] as String);

  Logger.root.onRecord.listen((r) {
    print([
      r.time.toIso8601String(),
      r.toString(),
      r.error,
      r.stackTrace?.toString(),
    ].where((e) => e != null).join(' '));
  });

  final datastore = MemDatastore();
  final storage = MemStorage();

  final storageServer = FakeStorageServer(storage);
  final pubServer = FakePubServer(datastore, storage);
  final searchService = FakeSearchService(datastore, storage);

  final configuration = Configuration.fakePubServer(
    frontendPort: port,
    storageBaseUrl: 'http://localhost:$storagePort',
    searchPort: searchPort,
  );

  Future<shelf.Response> forwardUpdatesHandler(shelf.Request rq) async {
    if (rq.requestedUri.path == '/fake-update-search') {
      final rs = await post('http://localhost:$searchPort/fake-update-all');
      if (rs.statusCode == 200) {
        return shelf.Response.ok('OK');
      } else {
        return shelf.Response(503,
            body: 'Upstream service returned ${rs.statusCode}.');
      }
    }
    return null;
  }

  await updateLocalBuiltFilesIfNeeded();
  await Future.wait(
    [
      storageServer.run(port: storagePort),
      pubServer.run(
        port: port,
        configuration: configuration,
        extraHandler: forwardUpdatesHandler,
      ),
      searchService.run(
        port: searchPort,
        configuration: configuration,
      ),
    ],
    eagerError: true,
  );
}
