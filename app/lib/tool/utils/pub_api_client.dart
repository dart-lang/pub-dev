// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import '../../frontend/handlers/pubapi.client.dart';

import 'http.dart';
import 'http_client_to_shelf_handler.dart';

/// Creates local, non-HTTP-based API client with [authToken].
PubApiClient createLocalPubApiClient({String authToken}) =>
    PubApiClient('http://localhost:0/',
        client: httpClientToShelfHandler(authToken: authToken));

/// Creates a pub.dev API client and executes [fn], making sure that the HTTP
/// resources are freed after the callback finishes.
///
/// If [bearerToken] is specified, the Authorization HTTP header will be sent
/// with a Bearer token.
///
/// If [pubHostedUrl] is specified, the HTTP client will connect to this
/// endpoint, otherwise only local API calls will be made.
Future<R> withPubApiClient<R>({
  String bearerToken,
  String pubHostedUrl,
  @required Future<R> Function(PubApiClient client) fn,
}) async {
  final httpClient = pubHostedUrl == null
      ? httpClientToShelfHandler(authToken: bearerToken)
      : httpClientWithAuthorization(tokenProvider: () async => bearerToken);
  try {
    final apiClient = PubApiClient(
      pubHostedUrl ?? 'http://localhost:0/',
      client: httpClient,
    );
    return await fn(apiClient);
  } finally {
    httpClient.close();
  }
}
