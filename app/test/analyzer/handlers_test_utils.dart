// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import 'package:pub_dartlang_org/analyzer/handlers.dart';
import 'package:pub_dartlang_org/shared/urls.dart';

Future<shelf.Response> issueGet(String path) async {
  final uri = '$siteRoot$path';
  final request = new shelf.Request('GET', Uri.parse(uri));
  return analyzerServiceHandler(request);
}

Future<shelf.Response> issuePost(String path) async {
  final uri = '$siteRoot$path';
  final request = new shelf.Request('POST', Uri.parse(uri));
  return analyzerServiceHandler(request);
}
