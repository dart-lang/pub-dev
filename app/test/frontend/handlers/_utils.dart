// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.frontend.handlers_test;

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

import 'package:pub_dev/frontend/handlers.dart';
import 'package:pub_dev/shared/handler_helpers.dart';
import 'package:pub_dev/shared/urls.dart';

import '../../shared/utils.dart';

const pageSize = 10;
const topQueryLimit = 15;

void tScopedTest(String name, Future<void> Function() func) {
  scopedTest(name, () {
    return func();
  });
}

Future<shelf.Response> issueGet(String path, {String host}) async {
  final uri = host == null ? '$siteRoot$path' : 'https://$host$path';
  final request = shelf.Request('GET', Uri.parse(uri));
  final handler = createAppHandler();
  final wrapped = wrapHandler(Logger('test'), handler, sanitize: true);
  return await ss.fork(() async {
    return await wrapped(request);
  }) as shelf.Response;
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
  expect(content, contains('<!DOCTYPE html>'));
  expect(content, contains('</html>'));
  for (Pattern p in present) {
    if (p.allMatches(content).isEmpty) {
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

Future<String> expectAtomXmlResponse(shelf.Response response,
    {int status = 200}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'],
      'application/atom+xml; charset="utf-8"');
  return await response.readAsString();
}
