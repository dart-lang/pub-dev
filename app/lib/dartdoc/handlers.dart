// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import '../shared/handlers.dart';
import '../shared/urls.dart' as urls;

/// Handlers for the dartdoc service.
Future<shelf.Response> dartdocServiceHandler(shelf.Request request) async {
  final path = request.requestedUri.path;
  final shelf.Handler handler = {
    '/debug': _debugHandler,
    '/liveness_check': (_) => htmlResponse('OK'),
    '/readiness_check': (_) => htmlResponse('OK'),
    '/robots.txt': rejectRobotsHandler,
  }[path];

  final host = request.requestedUri.host;
  if (host == 'www.dartdocs.org' || host == 'dartdocs.org') {
    return redirectResponse(
        request.requestedUri.replace(host: urls.primaryHost).toString());
  }

  if (handler != null) {
    return await handler(request);
  } else {
    return notFoundHandler(request);
  }
}

/// Handler /debug requests
shelf.Response _debugHandler(shelf.Request request) => debugResponse();
