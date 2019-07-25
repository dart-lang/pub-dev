// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/urls.dart';

/// Send an API request for [method] and [uri] with an optional [jsonBody].
/// The request will use the wrapped frontend handler and will not use real HTTP
/// requests.
Future<shelf.Response> httpRequest(
  String method,
  dynamic uri, {
  String authToken,
  Map<String, dynamic> jsonBody,
}) async {
  if ('$uri'.startsWith('/')) {
    uri = '$siteRoot$uri';
  }
  final request = shelf.Request(
    method,
    uri is Uri ? uri : Uri.parse(uri.toString()),
    headers: {
      if (authToken != null) 'authorization': 'bearer $authToken',
      if (jsonBody != null) 'content-type': 'application/json; charset=utf-8',
      if (jsonBody != null) 'accept': 'application/json',
    },
    body: jsonBody == null ? null : json.encode(jsonBody),
  );
  final handler = wrapHandler(
    Logger.detached('test'),
    createAppHandler(null),
    sanitize: true,
  );
  return await handler(request);
}

Future expectJsonResponse(shelf.Response response, {status = 200, body}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'application/json; charset="utf-8"');
  expect(json.decode(await response.readAsString()), body);
}

Future expectYamlResponse(shelf.Response response, {status = 200, body}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'text/yaml; charset="utf-8"');
  expect(json.decode(await response.readAsString()), body);
}

Future expectRedirectResponse(shelf.Response response, String url) async {
  expect(response.statusCode, 303);
  expect(response.headers['location'], url);
  expect(await response.readAsString(), '');
}

Future expectNotFoundResponse(shelf.Response response, {status = 404}) async {
  expect(response.statusCode, status);
}
