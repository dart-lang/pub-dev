// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart' as shelf;

import 'package:pub_dev/search/handlers.dart';

Future<shelf.Response> issueGet(String path) async {
  final uri = 'https://search-dot-dartlang-pub.appspot.com$path';
  final request = shelf.Request('GET', Uri.parse(uri));
  return searchServiceHandler(request);
}

Future<shelf.Response> issuePost(String path, {Map body}) async {
  final uri = 'https://search-dot-dartlang-pub.appspot.com$path';
  final encodedBody = body == null ? null : json.encode(body);
  final request = shelf.Request('POST', Uri.parse(uri), body: encodedBody);
  return searchServiceHandler(request);
}
