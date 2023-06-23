// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chunked_stream/chunked_stream.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:logging/logging.dart';
import 'package:mime/mime.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import '../../shared/storage.dart' show BucketExt;

final _logger = Logger('storage');

class FakeStorageServer {
  final MemStorage _storage;
  IOServer? _server;
  FakeStorageServer(this._storage);

  int? get port => _server?.server.port;

  Future<void> run({int port = 8081}) async {
    await start(port: port);
    await ProcessSignal.sigint.watch().first;
    await close();
  }

  Future<void> start({int? port}) async {
    if (_server != null) {
      throw StateError('Server is already running.');
    }
    _server = await IOServer.bind('localhost', port ?? 0);
    serveRequests(_server!.server, _handler);
    _logger.info('Storage _server running on port ${this.port}');
  }

  Future<void> close() async {
    await _server!.close();
    _server = null;
  }

  Future<Response> _handler(Request request) async {
    if (request.method == 'GET') {
      _logger.info('Requested: ${request.requestedUri.path}');
      final segments = request.requestedUri.pathSegments;
      if (segments.length < 2) {
        return Response.notFound('404 Not Found (SL: $segments)');
      }
      final bucketName = segments.first;
      final objectName = segments.skip(1).join('/');
      final bucket = _storage.bucket(bucketName);
      final exists = await bucket.tryInfo(objectName);
      if (exists == null) {
        return Response.notFound(
            '404 Not Found $objectName does not exists in $bucketName.');
      }
      final contentType = lookupMimeType(objectName);
      return Response.ok(bucket.read(objectName),
          headers: {if (contentType != null) 'Content-Type': contentType});
    } else if (request.method == 'POST') {
      _logger.info('Uploading: ${request.requestedUri.path}');
      final contentHeader = _parse(request.headers['content-type']);
      final segments = request.requestedUri.pathSegments;
      if (segments.length < 2) {
        return Response.notFound('404 Not Found (SL: $segments)');
      }
      String bucketName = segments.first;
      String objectName = segments.skip(1).join('/');

      final formData = <String, String>{};
      final transformer = MimeMultipartTransformer(contentHeader['boundary']!);
      // The map below makes the runtime type checker happy.
      final stream = request.read().map((a) => a).transform(transformer);
      await for (final m in stream) {
        final disposition = _parse(m.headers['content-disposition']);
        final name = disposition['name']!;
        final data = await readByteStream(m);
        if (name == 'file') {
          final key = formData['key'];
          if (key != null) {
            final parts = key.split('/');
            bucketName = parts.first;
            objectName = parts.skip(1).join('/');
          }
          final bucket = _storage.bucket(bucketName);
          await bucket.writeBytes(objectName, data);
        } else {
          formData[name] = utf8.decode(data);
        }
      }

      final redirectUrl = formData['success_action_redirect'];
      if (redirectUrl == null) {
        return Response.ok('success');
      }
      return Response.seeOther(redirectUrl);
    }
    return Response.notFound('404 Not Found (generic)');
  }
}

Map<String, String> _parse(String? value) {
  final result = <String, String>{};
  if (value == null || value.isEmpty) {
    return result;
  }
  value.split(';').forEach((p) {
    final parts = p.trim().split('=');
    final key = parts.first;
    String v = parts.last.trim();
    if (v.startsWith('"') && v.endsWith('"')) {
      v = v.substring(1, v.length - 1);
    }
    result[key] = v;
  });
  return result;
}
