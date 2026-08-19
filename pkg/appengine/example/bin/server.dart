// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:appengine/appengine.dart';
import 'package:logging/logging.dart';

final _log = Logger('server');

requestHandler(HttpRequest request) {
  // Handle liveness checks, this is to show that the server is alive.
  //
  // The path for this is configured in app.yaml
  if (request.requestedUri.path == '/liveness_check') {
    request.response
      ..statusCode = 200
      ..write('server is alive')
      ..close();
    return;
  }
  // Handle readiness checks, responding 200 OK, shows that we're ready to serve
  // traffic. If we had to establish database connections and do other setup
  // we might respond 503 until such time that we are ready.
  //
  // The path for this is configured in app.yaml
  if (request.requestedUri.path == '/readiness_check') {
    request.response
      ..statusCode = 200
      ..write('server is ready')
      ..close();
    return;
  }

  // Log the request
  _log.info('request for path: ${request.requestedUri.path}');
  try {
    if (request.requestedUri.path == '/error') {
      throw Exception('Something bad happens when hitting this path');
    }
  } on Exception catch (e, st) {
    // This will log the message to stackdriver logging along with the error
    // and stack trace. This will also send error and stack trace to stackdriver
    // error reporting service.
    _log.severe('a bad thing happend', e, st);
  }

  // Respond hello world, when serving normal traffic.
  request.response
    ..statusCode = 200
    ..write('Hello, world!')
    ..close();
}

main() async {
  await withAppEngineServices(() async {
    useLoggingPackageAdaptor();

    await runAppEngine(requestHandler);
  });
}
