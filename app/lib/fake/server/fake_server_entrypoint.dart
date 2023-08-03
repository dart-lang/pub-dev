// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:http/http.dart';
import 'package:pub_dev/fake/backend/fake_dartdoc_runner.dart';
import 'package:pub_dev/fake/backend/fake_pana_runner.dart';
import 'package:pub_dev/fake/backend/fake_pub_worker.dart';
import 'package:pub_dev/fake/server/fake_analyzer_service.dart';
import 'package:pub_dev/fake/server/fake_dartdoc_service.dart';
import 'package:pub_dev/fake/server/fake_default_service.dart';
import 'package:pub_dev/fake/server/fake_search_service.dart';
import 'package:pub_dev/fake/server/fake_storage_server.dart';
import 'package:pub_dev/fake/server/local_server_state.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/logging.dart';
import 'package:pub_dev/task/cloudcompute/fakecloudcompute.dart';
import 'package:pub_dev/tool/test_profile/import_source.dart';
import 'package:pub_dev/tool/test_profile/importer.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:shelf/shelf.dart' as shelf;

/// Entry point for fake server.
class FakeServerCommand extends Command {
  @override
  String get description => 'Fake server implementation.';

  @override
  String get name => 'run';

  FakeServerCommand() {
    argParser
      ..addOption('port',
          defaultsTo: '8080', help: 'The HTTP port of the fake pub server.')
      ..addOption('storage-port',
          defaultsTo: '8081',
          help: 'The HTTP port for the fake storage server.')
      ..addOption('search-port',
          defaultsTo: '8082',
          help: 'The HTTP port for the fake search service.')
      ..addOption('analyzer-port',
          defaultsTo: '8083',
          help: 'The HTTP port for the fake analyzer service.')
      ..addOption('dartdoc-port',
          defaultsTo: '8084',
          help: 'The HTTP port for the fake dartdoc service.')
      ..addOption('data-file',
          help: 'The file to read and also to store the local state.')
      ..addFlag('watch',
          help: 'Monitor changes of local files and reload them.')
      ..addFlag('read-only',
          help: 'Only read the data from the data-file, do not store it.');
  }

  @override
  Future<void> run() async {
    final port = int.parse(argResults!['port'] as String);
    final storagePort = int.parse(argResults!['storage-port'] as String);
    final searchPort = int.parse(argResults!['search-port'] as String);
    final analyzerPort = int.parse(argResults!['analyzer-port'] as String);
    final dartdocPort = int.parse(argResults!['dartdoc-port'] as String);
    final readOnly = argResults!['read-only'] == true;
    final dataFile = argResults!['data-file'] as String?;
    final watch = argResults!['watch'] == true;

    setupDebugEnvBasedLogging();

    final state = LocalServerState();
    if (dataFile != null) {
      await state.loadIfExists(dataFile);
    }

    final storage = state.storage;
    final datastore = state.datastore;

    final cloudCompute = FakeCloudCompute();

    final storageServer = FakeStorageServer(storage);
    final pubServer = FakePubServer(
      datastore,
      storage,
      cloudCompute,
      watch: watch,
    );
    final searchService = FakeSearchService(datastore, storage, cloudCompute);
    final analyzerService = FakeAnalyzerService(
      datastore,
      storage,
      cloudCompute,
    );
    final dartdocService = FakeDartdocService(datastore, storage, cloudCompute);

    final configuration = Configuration.fakePubServer(
      frontendPort: port,
      storageBaseUrl: 'http://localhost:$storagePort',
      searchPort: searchPort,
    );

    Future<shelf.Response> _updateUpstream(int port) async {
      final rs =
          await post(Uri.parse('http://localhost:$port/fake-update-all'));
      if (rs.statusCode == 200) {
        return shelf.Response.ok('OK');
      } else {
        return shelf.Response(503,
            body: 'Upstream service ($port) returned ${rs.statusCode}.');
      }
    }

    Future<shelf.Response> forwardUpdatesHandler(shelf.Request rq) async {
      if (rq.method.toUpperCase() == 'POST' &&
          rq.requestedUri.path == '/fake-test-profile') {
        return await _chainHandlers([
          () => _testProfile(rq),
          () => _updateUpstream(searchPort),
        ]);
      }
      if (rq.requestedUri.path == '/fake-update-all') {
        return await _chainHandlers([
          () => _updateUpstream(analyzerPort),
          () => _updateUpstream(dartdocPort),
          () => _updateUpstream(searchPort),
        ]);
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
      return shelf.Response.notFound('Not Found.');
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

    if (!readOnly && dataFile != null) {
      await state.save(dataFile);
    }
    print('Server processes completed.');
  }
}

Future<shelf.Response> _testProfile(shelf.Request rq) async {
  final map = json.decode(await rq.readAsString()) as Map<String, dynamic>;
  final profile =
      TestProfile.fromJson(map['testProfile'] as Map<String, dynamic>);
  // ignore: invalid_use_of_visible_for_testing_member
  await importProfile(
    profile: profile,
    source: ImportSource.autoGenerated(),
  );
  await processJobsWithFakePanaRunner();
  await processJobsWithFakeDartdocRunner();
  await processTasksWithFakePanaAndDartdoc();
  return shelf.Response.ok('{}');
}

typedef RequestHandler = Future<shelf.Response> Function();

Future<shelf.Response> _chainHandlers(List<RequestHandler> handlers) async {
  late shelf.Response last;
  for (final h in handlers) {
    last = await h();
    if (last.statusCode != 200) return last;
  }
  return last;
}
