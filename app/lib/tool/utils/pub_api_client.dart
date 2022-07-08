// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart';

import '../../frontend/handlers/pubapi.client.dart';
import '../../shared/configuration.dart';

import 'http.dart';

/// Creates an API client with [authToken] that uses the configured HTTP endpoints.
///
/// Services scopes are used to automatically close the client once we exit the current scope.
PubApiClient createPubApiClient({String? authToken}) {
  final httpClient =
      httpClientWithAuthorization(tokenProvider: () async => authToken);
  registerScopeExitCallback(() async => httpClient.close());
  return PubApiClient(
    activeConfiguration.primaryApiUri!.toString(),
    client: httpClient,
  );
}

/// Creates a pub.dev API client and executes [fn], making sure that the HTTP
/// resources are freed after the callback finishes.
///
/// If [bearerToken] is specified, the Authorization HTTP header will be sent
/// with a Bearer token.
Future<R> withHttpPubApiClient<R>({
  String? bearerToken,
  String? pubHostedUrl,
  required Future<R> Function(PubApiClient client) fn,
}) async {
  final httpClient =
      httpClientWithAuthorization(tokenProvider: () async => bearerToken);
  try {
    final apiClient = PubApiClient(
      pubHostedUrl ?? activeConfiguration.primaryApiUri!.toString(),
      client: httpClient,
    );
    return await fn(apiClient);
  } finally {
    httpClient.close();
  }
}
