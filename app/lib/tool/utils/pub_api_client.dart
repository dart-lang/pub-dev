// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pub_dev/frontend/handlers/experimental.dart';
import 'package:retry/retry.dart';

import '../../frontend/handlers/pubapi.client.dart';
import '../../service/services.dart';
import '../../shared/configuration.dart';
import 'http.dart';

/// Creates an API client with [authToken], [sessionId] and/or
/// [csrfToken] that uses the configured HTTP endpoints.
///
/// Services scopes are used to automatically close the client once we exit the current scope.
@visibleForTesting
PubApiClient createPubApiClient({
  String? authToken,
  String? sessionId,
  String? csrfToken,
}) {
  final httpClient = httpClientWithAuthorization(
    tokenProvider: () async => authToken,
    sessionIdProvider: () async => sessionId,
    csrfTokenProvider: () async => csrfToken,
  );
  registerScopeExitCallback(() async => httpClient.close());
  return PubApiClient(
    activeConfiguration.primaryApiUri!.toString(),
    client: _FakeTimeClient(httpClient),
  );
}

class _FakeTimeClient implements http.Client {
  final http.Client _client;
  _FakeTimeClient(this._client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers[fakeClockHeaderName] = clock.now().toIso8601String();
    return _client.send(request);
  }

  @override
  void close() => _client.close();

  @override
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) => _client.delete(url, headers: headers, body: body, encoding: encoding);

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) =>
      _client.get(url, headers: headers);

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) =>
      _client.head(url, headers: headers);

  @override
  Future<http.Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) => _client.patch(url, headers: headers, body: body, encoding: encoding);

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) => _client.post(url, headers: headers, body: body, encoding: encoding);

  @override
  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) => _client.put(url, headers: headers, body: body, encoding: encoding);

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) =>
      _client.read(url, headers: headers);

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) =>
      _client.readBytes(url, headers: headers);
}

/// Creates a pub.dev API client and executes [fn], making sure that the HTTP
/// resources are freed after the callback finishes.
/// The callback [fn] is retried on the transient network errors.
///
/// If [authToken], [sessionId] or [csrfToken] is specified, the corresponding
/// HTTP header will be sent alongside the request.
Future<R> withRetryPubApiClient<R>(
  /// The callback function that may be retried on transient errors.
  Future<R> Function(PubApiClient client) fn, {

  /// The token to use as the `Authorization` header in the format of `Bearer <token>`.
  String? authToken,

  /// The session id that will be part of the session cookie.
  String? sessionId,

  /// The CSRF token that will be the value of the CSRF header (`x-pub-csrf-token`).
  String? csrfToken,

  /// The base URL of the pub server.
  String? pubHostedUrl,

  /// The enabled experiments that will be part of the experimental cookie.
  Set<String>? experiments,
}) async {
  final httpClient = httpClientWithAuthorization(
    tokenProvider: () async => authToken,
    sessionIdProvider: () async => sessionId,
    csrfTokenProvider: () async => csrfToken,
    cookieProvider: () async => {
      if (experiments != null) experimentalCookieName: experiments.join(':'),
    },
    client: http.Client(),
  );
  return await retry(
    () async {
      try {
        final apiClient = PubApiClient(
          pubHostedUrl ?? activeConfiguration.primaryApiUri!.toString(),
          client: httpClient,
        );
        return await fn(apiClient);
      } finally {
        httpClient.close();
      }
    },
    maxAttempts: 3,
    retryIf: _retryIf,
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
  if (e is RequestException) {
    final status = e.status;
    return status >= 500; // 5xx errors are retried
  }
  return false;
}

extension PubApiClientExt on PubApiClient {
  @visibleForTesting
  Future<String> preparePackageUpload(List<int> bytes) async {
    final uploadInfo = await getPackageUploadUrl();

    final request = http.MultipartRequest('POST', Uri.parse(uploadInfo.url))
      ..headers[fakeClockHeaderName] = clock.now().toIso8601String()
      ..fields.addAll(uploadInfo.fields!)
      ..files.add(http.MultipartFile.fromBytes('file', bytes))
      ..followRedirects = false;
    final uploadRs = await request.send();
    if (uploadRs.statusCode != 303) {
      // NOTE: There are tests that fail with this on CI.
      // TODO: figure out what is causing these issues.
      final body = await uploadRs.stream.bytesToString();
      final headers = uploadRs.headers;
      throw AssertionError(
        'Expected HTTP redirect, got ${uploadRs.statusCode}.'
        '\nbody: $body\nheaders: $headers',
      );
    }

    final callbackUri = Uri.parse(
      uploadInfo.fields!['success_action_redirect']!,
    );
    return callbackUri.queryParameters['upload_id']!;
  }

  @visibleForTesting
  Future<SuccessMessage> uploadPackageBytes(List<int> bytes) async {
    final uploadId = await preparePackageUpload(bytes);
    return await finishPackageUpload(uploadId);
  }
}
