// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:pub_dev/shared/handler_helpers.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

void main() {
  group('serveHttpRequests', () {
    late HttpServer server;
    late _CapturingStdout capturedStderr;
    late List<LogRecord> records;
    late StreamSubscription<LogRecord> logSubscription;

    setUp(() async {
      capturedStderr = _CapturingStdout();
      records = <LogRecord>[];
      final logger = Logger.detached('handler_helpers_test')..level = Level.ALL;
      logSubscription = logger.onRecord.listen(records.add);
      server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      IOOverrides.runZoned(
        () => serveHttpRequests(
          logger,
          server,
          (request) =>
              shelf.Response.ok('ok:${request.url.pathSegments.join('/')}'),
        ),
        stderr: () => capturedStderr,
      );
    });

    tearDown(() async {
      await server.close(force: true);
      await logSubscription.cancel();
      await capturedStderr.close();
    });

    test('passes requests with a valid URI to the handler', () async {
      final response = await _rawGet(server.port, '/a%20b?q=%C3%A9');
      expect(response, startsWith('HTTP/1.1 200'));
      expect(response, endsWith('ok:a b'));
      expect(capturedStderr.text, isEmpty);
      expect(records, isEmpty);
    });

    // The first three give the errors reported in #9332.
    for (final target in [
      '/%FF', // Invalid UTF-8 byte
      '/%E0%80%80', // Overlong encoding
      '/%E2%82abc', // Missing extension byte
      '/abc%E2%82', // Unfinished UTF-8 octet sequence
      '/?q=%FF',
    ]) {
      test('rejects $target without writing to stderr', () async {
        final response = await _rawGet(server.port, target);
        expect(response, startsWith('HTTP/1.1 400'));
        expect(response, endsWith('Bad Request'));
        expect(capturedStderr.text, isEmpty);
        expect(records, hasLength(1));
        expect(records.single.level, Level.INFO);
        expect(records.single.message, contains(target));
      });
    }
  });
}

/// Sends [target] as is, so the client can't normalize the escapes.
Future<String> _rawGet(int port, String target) async {
  final socket = await Socket.connect(InternetAddress.loopbackIPv4, port);
  socket.write(
    'GET $target HTTP/1.1\r\nHost: localhost\r\nConnection: close\r\n\r\n',
  );
  await socket.flush();
  final response = await utf8.decoder.bind(socket).join();
  socket.destroy();
  return response;
}

class _CapturingStdout implements Stdout {
  final _buffer = StringBuffer();

  String get text => _buffer.toString();

  @override
  void write(Object? object) => _buffer.write(object);

  @override
  void writeln([Object? object = '']) => _buffer.writeln(object);

  @override
  Future<void> close() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
