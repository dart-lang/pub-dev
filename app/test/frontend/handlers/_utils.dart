// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.frontend.handlers_test;

import 'dart:async';
import 'dart:convert';

import 'package:_pub_shared/validation/html/html_validation.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_dev/frontend/handlers.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/handler_helpers.dart';
import 'package:pub_dev/shared/urls.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

import '../../shared/utils.dart';

const pageSize = 10;
const topQueryLimit = 15;

void tScopedTest(String name, Future<void> Function() func) {
  scopedTest(name, () {
    return func();
  });
}

Future<shelf.Response> issueGet(
  String path, {
  String? host,
  Map<String, String>? headers,
}) async =>
    issueHttp(
      'GET',
      path,
      host: host,
      headers: headers,
    );

Future<shelf.Response> issueHttp(
  String method,
  String path, {
  String? scheme,
  String? host,
  Map<String, String>? headers,
  dynamic body,
}) async {
  final url =
      host == null ? '$siteRoot$path' : '${scheme ?? 'https'}://$host$path';
  final uri = Uri.parse(url);
  if (uri.path.contains('//')) {
    throw ArgumentError('Double-slash URL detected: "$url".');
  }
  return await _doHttp(
    method: method,
    uri: uri,
    headers: headers,
    body: body,
  );
}

Future<shelf.Response> _doHttp({
  required String method,
  required Uri uri,
  Map<String, String>? headers,
  body,
}) async {
  final request = shelf.Request(
    method,
    uri,
    headers: headers,
    body: body,
  );
  final handler = createAppHandler();
  final wrapped = wrapHandler(Logger('test'), handler, sanitize: true);
  return await ss.fork(() async {
    return await wrapped(request);
  }) as shelf.Response;
}

// TODO: migrate to use acquireFakeSessionCookies
Future<String> acquireSessionCookies(String email) async {
  final rs = await issueHttp(
    'GET',
    Uri(
      path: '/sign-in',
      queryParameters: {
        'fake-email': email,
        'go': '/',
      },
    ).toString(),
    scheme: activeConfiguration.primarySiteUri.scheme,
    host: activeConfiguration.primarySiteUri.host,
  );
  expect(rs.statusCode, 303);
  final cookieHeaders = rs.headersAll['set-cookie'] ?? <String>[];
  final result = cookieHeaders.map((h) => h.split(';').first).join('; ');

  // complete sign-in
  final nextStep = Uri.parse(rs.headers['location']!);
  await _doHttp(
    method: 'GET',
    uri: nextStep,
    headers: {'cookie': result},
  );
  return result;
}

Future<String> expectHtmlResponse(
  shelf.Response response, {
  int status = 200,
  List<Pattern> present = const [],
  List<Pattern> absent = const [],
}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'text/html; charset="utf-8"');
  final content = await response.readAsString();
  parseAndValidateHtml(content);
  expect(content, contains('<!DOCTYPE html>'));
  expect(content, contains('</html>'));
  for (Pattern p in present) {
    if (p.allMatches(content).isEmpty) {
      print(content);
      throw Exception('$p is missing from the content.');
    }
  }
  for (Pattern p in absent) {
    if (p.allMatches(content).isNotEmpty) {
      throw Exception('$p is present in the content.');
    }
  }
  return content;
}

Future<Map<String, dynamic>> expectJsonMapResponse(
  shelf.Response response, {
  int status = 200,
  Object? matcher,
}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'application/json; charset="utf-8"');
  final content = await response.readAsString();
  final map = json.decode(content) as Map<String, dynamic>;
  expect(map, matcher ?? isNotNull);
  return map;
}

Future<String> expectAtomXmlResponse(shelf.Response response,
    {int status = 200}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'],
      'application/atom+xml; charset="utf-8"');
  return await response.readAsString();
}
