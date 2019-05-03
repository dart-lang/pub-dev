// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.frontend.handlers_test;

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/shared/urls.dart';

import '../../shared/utils.dart';

const pageSize = 10;
const topQueryLimit = 15;

void tScopedTest(String name, Future func()) {
  scopedTest(name, () {
    return func();
  });
}

Future<shelf.Response> issueGet(String path, {String host}) {
  final uri = host == null ? '$siteRoot$path' : 'https://$host$path';
  return issueGetUri(Uri.parse(uri));
}

Future<shelf.Response> issueGetUri(Uri uri) async {
  final request = shelf.Request('GET', uri);
  return appHandler(request, null);
}

Future expectHtmlResponse(shelf.Response response, {int status = 200}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'], 'text/html; charset="utf-8"');
  final content = await response.readAsString();
  expect(content, contains('<!DOCTYPE html>'));
  expect(content, contains('</html>'));
}

Future expectAtomXmlResponse(shelf.Response response,
    {int status = 200, String regexp}) async {
  expect(response.statusCode, status);
  expect(response.headers['content-type'],
      'application/atom+xml; charset="utf-8"');
  final text = await response.readAsString();
  expect(RegExp(regexp).hasMatch(text), isTrue);
}
