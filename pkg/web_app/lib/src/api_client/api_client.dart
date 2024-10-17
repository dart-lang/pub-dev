// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:_pub_shared/pubapi.dart';
import 'package:api_builder/_client_utils.dart';

import '../deferred/http.dart' as http;

export '_rpc.dart';

String get _baseUrl {
  final location = Uri.parse(window.location.href);
  return Uri(
    scheme: location.scheme,
    host: location.host,
    port: location.port,
  ).toString();
}

/// The pub API client to use without credentials.
PubApiClient get unauthenticatedClient =>
    PubApiClient(_baseUrl, client: http.Client());

/// The pub API client to use with account credentials.
PubApiClient get client =>
    PubApiClient(_baseUrl, client: http.createClientWithCsrf());

/// Sends a JSON request to the [path] endpoint using
/// [verb] method with [body] content.
///
/// Sets the `Content-Type` header to `application/json; charset="utf-8` and
/// expects a valid JSON response body.
Future<Map<String, Object?>> sendJson({
  required String verb,
  required String path,
  required Map<String, Object?>? body,
}) async {
  final client = http.createClientWithCsrf();
  try {
    final c = Client(_baseUrl, client: client);
    return await c.requestJson(verb: verb, path: path, body: body);
  } finally {
    client.close();
  }
}
