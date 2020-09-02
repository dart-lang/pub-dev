// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart' as shelf;

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:fake_pub_server/fake_analyzer_service.dart';
import 'package:fake_pub_server/fake_dartdoc_service.dart';
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
      defaultsTo: '8082', help: 'The HTTP port for the fake search service.')
  ..addOption('analyzer-port',
      defaultsTo: '8083', help: 'The HTTP port for the fake analyzer service.')
  ..addOption('dartdoc-port',
      defaultsTo: '8084', help: 'The HTTP port for the fake dartdoc service.')
  ..addOption('data-dir', help: 'The directory to store the local state.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  final port = int.parse(argv['port'] as String);
  final storagePort = int.parse(argv['storage-port'] as String);
  final searchPort = int.parse(argv['search-port'] as String);
  final analyzerPort = int.parse(argv['analyzer-port'] as String);
  final dartdocPort = int.parse(argv['dartdoc-port'] as String);

  Logger.root.onRecord.listen((r) {
    print([
      r.time.toIso8601String(),
      r.toString(),
      r.error,
      r.stackTrace?.toString(),
    ].where((e) => e != null).join(' '));
  });

  final state = _LocalServerState(dataDir: argv['data-dir'] as String);
  await state.init();

  final storage = state.storage;
  final datastore = state.datastore;

  final storageServer = FakeStorageServer(storage);
  final pubServer = FakePubServer(datastore, storage);
  final searchService = FakeSearchService(datastore, storage);
  final analyzerService = FakeAnalyzerService(datastore, storage);
  final dartdocService = FakeDartdocService(datastore, storage);

  final configuration = Configuration.fakePubServer(
    frontendPort: port,
    storageBaseUrl: 'http://localhost:$storagePort',
    searchPort: searchPort,
  );

  Future<shelf.Response> _updateUpstream(int port) async {
    final rs = await post('http://localhost:$port/fake-update-all');
    if (rs.statusCode == 200) {
      return shelf.Response.ok('OK');
    } else {
      return shelf.Response(503,
          body: 'Upstream service ($port) returned ${rs.statusCode}.');
    }
  }

  Future<shelf.Response> forwardUpdatesHandler(shelf.Request rq) async {
    if (rq.requestedUri.path == '/fake-update-all') {
      final analyzerRs = await _updateUpstream(analyzerPort);
      if (analyzerRs.statusCode != 200) return analyzerRs;
      final dartdocRs = await _updateUpstream(dartdocPort);
      if (dartdocRs.statusCode != 200) return dartdocRs;
      return await _updateUpstream(searchPort);
    }
    if (rq.requestedUri.path == '/fake-update-analyzer') {
      return await _updateUpstream(analyzerPort);
    }
    if (rq.requestedUri.path == '/fake-update-dartdoc') {
      return await _updateUpstream(dartdocPort);
    }
    if (rq.requestedUri.path == '/fake-update-search') {
      return await _updateUpstream(searchPort);
    }
    return null;
  }

  // Store the state (and then exit) on CTRL+C.
  ProcessSignal.sigint.watch().listen((e) async {
    print('Storing state...');
    await state.store();
    exit(0);
  });

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
      analyzerService.run(
        port: analyzerPort,
        configuration: configuration,
      ),
      dartdocService.run(
        port: dartdocPort,
        configuration: configuration,
      ),
    ],
    eagerError: true,
  );

  await state.store();
}

class _LocalServerState {
  final datastore = MemDatastore();
  final storage = MemStorage();
  Directory _dataDir;
  File _datastoreFile;
  File _storageFile;
  Completer _storingCompleter;

  _LocalServerState({String dataDir}) {
    if (dataDir != null) {
      _dataDir = Directory(dataDir);
      _datastoreFile = File(p.join(dataDir, 'datastore.jsonl'));
      _storageFile = File(p.join(dataDir, 'storage.jsonl'));
    }
  }

  Future<void> init() async {
    if (_datastoreFile != null && await _datastoreFile.exists()) {
      datastore.readFrom(await _datastoreFile.readAsLines());
    }
    if (_storageFile != null && await _storageFile.exists()) {
      storage.readFrom(await _storageFile.readAsLines());
    }
  }

  Future<void> store() async {
    while (_storingCompleter != null) {
      await _storingCompleter.future;
    }
    _storingCompleter = Completer();
    try {
      if (_dataDir != null) {
        await _dataDir.create(recursive: true);
      }
      if (_datastoreFile != null) {
        final sink = _datastoreFile.openWrite();
        datastore.writeTo(sink);
        await sink.close();
      }
      if (_storageFile != null) {
        final sink = _storageFile.openWrite();
        storage.writeTo(sink);
        await sink.close();
      }
    } finally {
      _storingCompleter.complete();
      _storingCompleter = null;
    }
  }
}
