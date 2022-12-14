// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async' show FutureOr;
import 'dart:convert' show json, utf8;
import 'dart:io' show gzip;
import 'package:_pub_shared/data/task_payload.dart';
import 'package:pub_worker/src/analyze.dart' show analyze;
import 'package:pub_worker/src/testing/server.dart';
import 'package:test/test.dart';

void main() {
  void testWithServer(
    String name,
    FutureOr<void> Function(PubWorkerTestServer server) fn,
  ) {
    test(name, () async {
      final s = PubWorkerTestServer([]);
      try {
        await s.start();
        await fn(s);
      } finally {
        await s.stop();
      }
    }, timeout: Timeout(Duration(minutes: 5)));
  }

  testWithServer('analyze retry 3.0.0, 3.0.1', (server) async {
    // Add packages to the server
    server.packages.add(await Package.fromFiles([
      FileEntry.fromJson(name: 'pubspec.yaml', data: {
        'name': 'retry',
        'version': '3.0.0',
        'dependencies': {
          'meta': '^1.0.0',
        },
        'environment': {'sdk': '>=2.12.0-0 <3.0.0'},
      }),
      FileEntry.fromString(name: 'lib/retry.dart', contents: '''
        void retry(void Function() fn) { for (var i = 0; i < 5; i++) fn();}
      '''),
    ]));

    server.packages.add(await Package.fromFiles([
      FileEntry.fromJson(name: 'pubspec.yaml', data: {
        'name': 'retry',
        'version': '3.0.1',
        'dependencies': {
          'meta': '^1.0.0',
        },
        'environment': {'sdk': '>=2.12.0-0 <3.0.0'},
      }),
      FileEntry.fromString(name: 'lib/retry.dart', contents: '''
        import 'package:meta/meta.dart';
        @Sealed()
        void retry(void Function() fn) { for (var i = 0; i < 5; i++) fn();}
      '''),
    ]));

    server.packages.add(await Package.fromFiles([
      FileEntry.fromJson(name: 'pubspec.yaml', data: {
        'name': 'meta',
        'version': '1.0.0',
        'dependencies': {},
        'environment': {'sdk': '>=2.12.0-0 <3.0.0'},
      }),
      FileEntry.fromString(name: 'lib/meta.dart', contents: '''
        class Sealed {}
      '''),
    ]));

    // Start the worker
    final workerCompleted = analyze(Payload(
      package: 'retry',
      pubHostedUrl: '${server.baseUrl}',
      versions: [
        VersionTokenPair(
          version: '3.0.0',
          token: 'secret-token',
        ),
        VersionTokenPair(
          version: '3.0.1',
          token: 'secret-token',
        ),
      ],
    ));

    final result = await server.waitForResult('retry', '3.0.0');
    expect(result.index.blobId, isNotEmpty);

    final gzippedLog = result.lookup('log.txt');
    expect(gzippedLog, isNotNull);
    final log = utf8.fuse(gzip).decode(gzippedLog!);
    print(log);
    expect(log, contains('exited 0'));

    final catGzipped = result.lookup('doc/categories.json');
    expect(catGzipped, isNotNull);
    final categories = json.fuse(utf8).fuse(gzip).decode(catGzipped!);
    expect(categories, equals([]));

    expect(result.lookup('summary.json'), isNotNull);

    await server.waitForResult('retry', '3.0.1');

    await workerCompleted;
  });
}
