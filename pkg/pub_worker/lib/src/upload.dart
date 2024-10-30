// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/data/package_api.dart' show UploadInfo;
import 'package:http/http.dart'
    show Client, ClientException, MultipartFile, MultipartRequest, Response;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:logging/logging.dart' show Logger;
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

      // Special case `TaskAborted` response code, it means that the analysis
      // is no longer selected or the secret token timed out / was replaced
      // (it may need a different analysis round).
      if (res.statusCode == 400 &&
          _extractExceptionCode(res) == 'TaskAborted') {
        _log.warning(
            'Task aborted, failed to upload: $filename, status = ${res.statusCode}');
        throw TaskAbortedException(res.body);
      }
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
    },
        retryIf: (e) =>
            e is IOException ||
            e is IntermittentUploadException ||
            e is ClientException ||
            e is TimeoutException,
        delayFactor: Duration(seconds: 5));

final class UploadException implements Exception {
  final String message;

  UploadException(this.message);

  @override
  String toString() => message;
}

final class IntermittentUploadException extends UploadException {
  IntermittentUploadException(String message) : super(message);
}

final class TaskAbortedException extends UploadException {
  TaskAbortedException(String message) : super(message);
}

String? _extractExceptionCode(Response res) {
  try {
    final map = json.decode(res.body);
    if (map is! Map) {
      return null;
    }
    final error = map['error'];
    if (error is! Map) {
      return null;
    }
    final code = error['code'];
    return code?.toString();
  } on FormatException catch (_) {
    // ignore
  }
  return null;
}
