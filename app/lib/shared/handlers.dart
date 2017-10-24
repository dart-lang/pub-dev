// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'package:pub_dartlang_org/frontend/keys.dart';

final _pubHeaderLogger = new Logger('pub.header_logger');

const String default404NotFound = '404 Not Found';

Map _latestSchedulerStats;

void registerSchedulerStatsStream(Stream<Map> stream) {
  stream.listen((stats) {
    _latestSchedulerStats = stats;
  });
}

Map get latestSchedulerStats => _latestSchedulerStats;

shelf.Response redirectResponse(String url) => new shelf.Response.seeOther(url);

shelf.Response atomXmlResponse(String content, {int status: 200}) =>
    new shelf.Response(
      status,
      body: content,
      headers: {'content-type': 'application/atom+xml; charset="utf-8"'},
    );

shelf.Response yamlResponse(String yamlString, {int status: 200}) =>
    new shelf.Response(status,
        body: yamlString,
        headers: {'content-type': 'text/yaml; charset="utf-8"'});

shelf.Response jsonResponse(Map json, {int status: 200, bool indent: false}) {
  final body = indent
      ? new JsonEncoder.withIndent('  ').convert(json)
      : JSON.encode(json);
  return new shelf.Response(
    status,
    body: body,
    headers: {'content-type': 'application/json; charset="utf-8"'},
  );
}

shelf.Response htmlResponse(String content, {int status: 200}) =>
    new shelf.Response(
      status,
      body: content,
      headers: {'content-type': 'text/html; charset="utf-8"'},
    );

shelf.Response notFoundHandler(shelf.Request request,
        {String body: default404NotFound}) =>
    htmlResponse(body, status: 404);

void logPubHeaders(shelf.Request request) {
  request.headers.forEach((String key, String value) {
    final lowerCaseKey = key.toLowerCase();
    if (lowerCaseKey.startsWith('x-pub')) {
      _pubHeaderLogger.info('$key: $value');
    }
  });
}

Future<bool> validateNotificationSecret(shelf.Request request) async {
  final received = request.headers['x-notification-secret'];
  if (received == null) return false;
  final secret = await getNotificationSecret();
  return received == secret;
}

Future<Map<String, String>> prepareNotificationHeaders() async => {
      'x-notification-secret': await getNotificationSecret(),
    };
