// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/fake/server/fake_search_service.dart';
import 'package:pub_dev/service/entrypoint/search.dart';
import 'package:shelf/shelf_io.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('Main search isolate controller', () {
    testWithProfile(
      'update the package index isolate',
      fn: () async {
        final snapshotServer = await setupLocalSnapshotServer();
        final renewController = StreamController<Completer>.broadcast();
        final processTerminationCompleter = Completer();
        final handlerStartedCompleter = Completer();
        try {
          final port = await _detectFreePort();
          final doneFuture = runSearchInstanceController(
            port: port,
            renewPackageIndex: renewController.stream,
            processTerminationSignal: () async {
              handlerStartedCompleter.complete();
              return await processTerminationCompleter.future;
            },
            renewWait: Duration.zero,
            snapshot: 'http://localhost:${snapshotServer.server.port}/',
          );
          await handlerStartedCompleter.future;

          // force renew
          final c = Completer();
          renewController.add(c);
          await c.future;

          processTerminationCompleter.complete();
          await doneFuture;
        } finally {
          await snapshotServer.close();
          await renewController.close();
        }
      },
      timeout: Timeout.factor(8),
    );
  });
}

Future<int> _detectFreePort() async {
  final server = await IOServer.bind('localhost', 0);
  final port = server.server.port;
  await server.close();
  return port;
}
