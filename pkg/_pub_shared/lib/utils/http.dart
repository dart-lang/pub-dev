// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

final _transientStatusCodes = {
  // See: https://cloud.google.com/storage/docs/xml-api/reference-status
  429,
  500,
  502,
  503,
};

/// Creates a HTTP client that retries transient status codes.
///
/// When [lenient] is set, we retry on more errors and status codes.
http.Client httpRetryClient({
  http.Client? innerClient,
  int? retries,
  bool lenient = false,
}) {
  return _PubRetryClient(
    innerClient ?? http.Client(),
    retries ?? 1,
    lenient,
    innerClient != null,
  );
}

class _PubRetryClient extends http.BaseClient {
  final http.Client _inner;
  final int _attempts;
  final bool _closeInner;
  final bool _lenient;

  _PubRetryClient(
    this._inner,
    this._attempts,
    this._lenient,
    this._closeInner,
  );

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final requestBody = await request.finalize().toBytes();
    for (var i = 0; i < _attempts; i++) {
      try {
        // wait between attempts
        await Future.delayed(Duration(milliseconds: i * 100));

        // send new request through inner client
        final rs = await _inner.send(_copyRequest(request, requestBody));

        // collect response until the entire body is recieved
        final responseBody = await rs.stream.toBytes();

        // retry based on status code
        final shouldRetry = (_lenient && rs.statusCode >= 500) ||
            _transientStatusCodes.contains(rs.statusCode);
        if (shouldRetry) {
          continue;
        }
        return http.StreamedResponse(
          Stream.value(responseBody),
          rs.statusCode,
          contentLength: rs.contentLength,
          headers: rs.headers,
          isRedirect: rs.isRedirect,
          persistentConnection: rs.persistentConnection,
          reasonPhrase: rs.reasonPhrase,
          request: rs.request,
        );
      } catch (e) {
        // retry based on exception
        if (_lenient || e is IOException) {
          continue;
        }
        rethrow;
      }
    }
    throw http.ClientException('Retry exhausted.');
  }

  /// Returns a copy of [original] with the given [body].
  http.Request _copyRequest(http.BaseRequest original, Uint8List body) {
    return http.Request(original.method, original.url)
      ..followRedirects = original.followRedirects
      ..headers.addAll(original.headers)
      ..maxRedirects = original.maxRedirects
      ..persistentConnection = original.persistentConnection
      ..bodyBytes = body;
  }

  @override
  void close() {
    if (_closeInner) {
      _inner.close();
    }
  }
}
