// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:api_builder/_client_utils.dart' show RequestException;
import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

Future expectApiException(Future future,
    {int status, String code, String message}) async {
  await expectLater(
      future,
      throwsA(isA<RequestException>()
          .having((e) => e.status, 'status', status)
          .having(
        (e) => e.bodyAsJson(),
        'bodyAsJson',
        {
          'error': {
            'code': code ?? isNotNull,
            'message': message == null ? isNotNull : contains(message),
          },
          // TODO: remove after the above gets deployed live
          'code': code ?? isNotNull,
          'message': message == null ? isNotNull : contains(message),
        },
      )));
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
