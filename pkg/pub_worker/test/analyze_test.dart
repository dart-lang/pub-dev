// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async' show Completer;
import 'dart:convert' show json, utf8;
import 'dart:io' show HttpServer, gzip;
import 'dart:typed_data';

import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/data/task_api.dart';
import 'package:indexed_blob/indexed_blob.dart';
import 'package:logging/logging.dart' show Logger, Level, LogRecord;
import 'package:pub_worker/pana_report.dart';
import 'package:pub_worker/payload.dart';
import 'package:pub_worker/src/analyze.dart' show analyze;
import 'package:pub_worker/src/utils.dart' show streamToBuffer;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:test/test.dart';

import 'multipart.dart' show readMultiparts;

void main() {
  late Map<String, Uint8List> files;
  late Map<String, Completer<void>> _finished;
  setUp(() {
    files = {};
    _finished = {};
  });

  Future<void> waitFor(String package, String version) => _finished
      .putIfAbsent('$package/$version', () => Completer<void>())
      .future;

  late HttpServer server;
  setUpAll(() async {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
      if (rec.error != null) {
        print('ERROR: ${rec.error}, ${rec.stackTrace}');
      }
    });

    final app = Router();

    app.post('/api/tasks/<package>/<version>/upload', (
      Request request,
      String package,
      String version,
    ) {
      final baseUrl = 'http://localhost:${server.port}';
      return Response.ok(json.encode(UploadTaskResultResponse(
        panaLogId: '42',
        dartdocBlobId: '35',
        dartdocBlob: UploadInfo(
          url: '$baseUrl/upload/$package/$version/dartdoc-data-35.blob',
          fields: {},
        ),
        dartdocIndex: UploadInfo(
          url: '$baseUrl/upload/$package/$version/dartdoc-index.json',
          fields: {},
        ),
        panaLog: UploadInfo(
          url: '$baseUrl/upload/$package/$version/pana-log-42.txt',
          fields: {},
        ),
        panaReport: UploadInfo(
          url: '$baseUrl/upload/$package/$version/pana-report.json',
          fields: {},
        ),
      )));
    });

    app.post('/api/tasks/<package>/<version>/finished', (
      Request request,
      String package,
      String version,
    ) {
      _finished
          .putIfAbsent('$package/$version', () => Completer<void>())
          .complete();
      return Response.ok('{}');
    });

    app.post('/upload/<package>/<version>/<name>', (
      Request request,
      String package,
      String version,
      String name,
    ) async {
      if (request.mimeType != 'multipart/form-data') {
        return Response.forbidden('request must be multipart');
      }
      await for (final part in readMultiparts(request)) {
        final contentDisposition = part.headers['content-disposition'] ?? '';
        final field = contentDisposition
            .split(';')
            .map((s) => s.trim())
            .where((s) => s.startsWith('name='))
            .first
            .replaceFirst('name="', '')
            .replaceAll('"', '');
        if (field == 'file') {
          files['$package/$version/$name'] = await streamToBuffer(part);
        } else {
          await part.drain();
        }
      }
      return Response.ok('{}');
    });

    server = await io.serve(app, 'localhost', 0);
  });

  tearDownAll(() async {
    await server.close(force: true);
  });

  test('analyze retry 3.0.0, 3.0.1', () async {
    await Future.wait([
      analyze(Payload(
        package: 'retry',
        callbackUrl: 'http://localhost:${server.port}',
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
      )),
      () async {
        await waitFor('retry', '3.0.0');

        expect(files, contains('retry/3.0.0/pana-log-42.txt'));
        expect(files, contains('retry/3.0.0/pana-report.json'));
        expect(files, contains('retry/3.0.0/dartdoc-data-35.blob'));
        expect(files, contains('retry/3.0.0/dartdoc-index.json'));

        // Check that index contains blobId
        final index = BlobIndex.fromBytes(
          files['retry/3.0.0/dartdoc-index.json']!,
        );
        expect(index.blobId, '35');

        // Check that blob can be read using index using categories.json which
        // should be an empty list for retry 3.0.0
        final blob = files['retry/3.0.0/dartdoc-data-35.blob'];
        final range = index.lookup('categories.json');
        final categories = json.fuse(utf8).fuse(gzip).decode(blob!.sublist(
              range!.start,
              range.end,
            ));
        expect(categories, equals([]));

        // Check that report contains the logId
        final report = PanaReport.fromJson(
          json.fuse(utf8).decode(files['retry/3.0.0/pana-report.json']!)
              as Map<String, dynamic>,
        );
        expect(report.logId, '42');

        // Check that log contains "exited 0"
        expect(utf8.decode(files['retry/3.0.0/pana-log-42.txt']!),
            contains('exited 0'));

        await waitFor('retry', '3.0.1');

        expect(files, contains('retry/3.0.1/pana-log-42.txt'));
        expect(files, contains('retry/3.0.1/pana-report.json'));
        expect(files, contains('retry/3.0.1/dartdoc-data-35.blob'));
        expect(files, contains('retry/3.0.1/dartdoc-index.json'));
      }(),
    ]);
  }, timeout: Timeout(Duration(minutes: 5)));
}
