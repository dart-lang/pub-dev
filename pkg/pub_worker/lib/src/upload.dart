// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:_pub_shared/data/package_api.dart' show UploadInfo;
import 'package:http/http.dart'
    show MultipartRequest, MultipartFile, Client, Response;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:logging/logging.dart' show Logger;
import 'package:meta/meta.dart';
import 'package:retry/retry.dart' show retry;

final _log = Logger('pub_worker.upload');

/// Upload [content] to [destination] as returned from pub.dev task API.
///
/// Attach given [filename] and [contentType].
Future<void> upload(
  Client client,
  UploadInfo destination,
  Stream<List<int>> Function() content,
  int length, {
  required String filename,
  String contentType = 'application/octet-stream',
}) async =>
    await retry(() async {
      _log.info('Uploading $filename -> ${destination.url}');

      final req = MultipartRequest('POST', Uri.parse(destination.url))
        ..fields.addAll(destination.fields ?? {})
        ..followRedirects = false
        ..files.add(MultipartFile(
          'file',
          content(),
          length,
          filename: filename,
          contentType: MediaType.parse(contentType),
        ));
      final res = await Response.fromStream(await client.send(req));

      if (400 <= res.statusCode && res.statusCode < 500) {
        _log.shout('Failed to upload: $filename, status = ${res.statusCode}');
        throw UploadException(
          'HTTP error, status = ${res.statusCode}, body: ${res.body}',
        );
      }
      if (500 <= res.statusCode && res.statusCode < 600) {
        throw IntermittentUploadException(
          'HTTP intermittent error, status = ${res.statusCode}, body: ${res.body}',
        );
      }
      if (200 <= res.statusCode && res.statusCode < 300) {
        return;
      }

      // Unhandled response code -> retry
      _log.shout('Unhandled response code, status = ${res.statusCode}');
      throw UploadException(
        'Unhandled HTTP status = ${res.statusCode}, body: ${res.body}',
      );
    }, retryIf: (e) => e is IOException || e is IntermittentUploadException);

@sealed
class UploadException implements Exception {
  final String message;

  UploadException(this.message);

  @override
  String toString() => message;
}

@sealed
class IntermittentUploadException extends UploadException {
  IntermittentUploadException(String message) : super(message);
}
