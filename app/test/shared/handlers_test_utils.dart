// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

Future expectJsonResponse(shelf.Response response, {status: 200, body}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'application/json; charset="utf-8"');
  expect(JSON.decode(await response.readAsString()), body);
}

Future expectYamlResponse(shelf.Response response, {status: 200, body}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'text/yaml; charset="utf-8"');
  expect(JSON.decode(await response.readAsString()), body);
}

Future expectRedirectResponse(shelf.Response response, String url) async {
  expect(response.statusCode, 303);
  expect(response.headers['location'], url);
  expect(await response.readAsString(), '');
}

Future expectNotFoundResponse(shelf.Response response, {status: 404}) async {
  expect(response.statusCode, status);
}
