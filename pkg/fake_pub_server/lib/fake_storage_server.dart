// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:buffer/buffer.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:mime/mime.dart';

import 'package:fake_gcloud/mem_storage.dart';

final _logger = Logger('storage');

class FakeStorageServer {
  final MemStorage _storage;
  FakeStorageServer(this._storage);

  Future<void> run({int port = 8081}) async {
    final server = await IOServer.bind('localhost', port);
    serveRequests(server.server, _handler);
    _logger.info('Storage server running on port $port');
    await ProcessSignal.sigterm.watch().first;
    await server.close();
  }

  Future<Response> _handler(Request request) async {
    if (request.method == 'GET') {
      _logger.info('Requested: ${request.requestedUri.path}');
      final segments = request.requestedUri.pathSegments;
      if (segments.length < 2) {
        return Response.notFound('404 Not Found');
      }
      final bucketName = segments.first;
      final objectName = segments.skip(1).join('/');
      final bucket = _storage.bucket(bucketName);
      final exists = await bucket.info(objectName);
      if (exists == null) {
        return Response.notFound('404 Not Found');
      }
      return Response.ok(bucket.read(objectName));
    } else if (request.method == 'POST') {
      _logger.info('Uploading: ${request.requestedUri.path}');
      final contentHeader = _parse(request.headers['content-type']);
      final segments = request.requestedUri.pathSegments;
      if (segments.length < 2) {
        return Response.notFound('404 Not Found');
      }
      String bucketName = segments.first;
      String objectName = segments.skip(1).join('/');

      final formData = <String, String>{};
      final transformer = MimeMultipartTransformer(contentHeader['boundary']);
      await for (final m in request.read().transform(transformer)) {
        final disposition = _parse(m.headers['content-disposition']);
        final name = disposition['name'];
        final data = await readAsBytes(m);
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

      return Response.seeOther(formData['success_action_redirect']);
    }
    return Response.notFound('404 Not Found');
  }
}

Map<String, String> _parse(String value) {
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
