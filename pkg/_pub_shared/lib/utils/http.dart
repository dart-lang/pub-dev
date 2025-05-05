// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:retry/retry.dart';

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
  return RetryClient(
    innerClient ?? http.Client(),
    when: (r) =>
        (lenient && r.statusCode >= 500) ||
        _transientStatusCodes.contains(r.statusCode),
    retries: retries ?? 5,
    // TODO: Consider implementing whenError to handle DNS + handshake errors.
    //       These are safe, retrying after partially sending data is more
    //       sketchy, but probably safe in our application.
    whenError: (e, st) => lenient || e is SocketException,
  );
}

/// Creates a HTTP client and executes a GET request to the specified [uri],
/// making sure that the HTTP resources are freed after the [responseFn]
/// callback finishes.
/// The HTTP GET and the [responseFn] callback is retried on the transient
/// network errors.
Future<K> httpGetWithRetry<K>(
  Uri uri, {
  required FutureOr<K> Function(http.Response response) responseFn,
  int maxAttempts = 3,

  /// The HTTP client to use.
  ///
  /// Note: when the client is not specified, the inner loop will create a new [http.Client] object on each retry attempt.
  http.Client? client,
  Map<String, String>? headers,

  /// Per-request time amount that will be applied on the overall HTTP request.
  Duration? perRequestTimeout,

  /// Additional retry conditions (on top of the default ones).
  /// Note: check for [UnexpectedStatusException] to allow non-200 response status codes.
  bool Function(Exception e)? retryIf,
}) async {
  return await retry(
    () async {
      final closeClient = client == null;
      final effectiveClient = client ?? http.Client();
      try {
        var f = effectiveClient.get(uri, headers: headers);
        if (perRequestTimeout != null) {
          f = f.timeout(perRequestTimeout);
        }
        final rs = await f;
        if (rs.statusCode == 200) {
          return responseFn(rs);
        }
        throw UnexpectedStatusException(rs.statusCode, uri);
      } finally {
        if (closeClient) {
          effectiveClient.close();
        }
      }
    },
    maxAttempts: maxAttempts,
    retryIf: (e) => _retryIf(e) || (retryIf != null && retryIf(e)),
  );
}

bool _retryIf(Exception e) {
  if (e is TimeoutException) {
    return true; // Timeouts we can retry
  }
  if (e is IOException) {
    return true; // I/O issues are worth retrying
  }
  if (e is http.ClientException) {
    return true; // HTTP issues are worth retrying
  }
  if (e is UnexpectedStatusException) {
    return _transientStatusCodes.contains(e.statusCode);
  }
  return false;
}

/// Thrown when status code is not 200.
class UnexpectedStatusException implements Exception {
  final int statusCode;
  final String message;

  UnexpectedStatusException(this.statusCode, Uri uri)
      : message = 'Unexpected status code for $uri: $statusCode.';

  @override
  String toString() => 'UnexpectedStatusException: $message';
}
