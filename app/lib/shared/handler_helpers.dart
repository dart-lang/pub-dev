// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

Future runHandler(Logger logger, shelf.Handler handler, {bool shared: false}) {
  handler = redirectToHttpsWrapper(handler);
  handler = _logRequestWrapper(logger, handler);
  return runAppEngine((HttpRequest request) => handleRequest(request, handler),
      shared: shared ?? false);
}

Future handleRequest(HttpRequest request, shelf.Handler handler) =>
    shelf_io.handleRequest(request, handler);

shelf.Handler _logRequestWrapper(Logger logger, shelf.Handler handler) {
  return (shelf.Request request) async {
    logger.info('Handling request: ${request.requestedUri}');
    try {
      return await handler(request);
    } catch (error, st) {
      logger.severe('Request handler failed', error, st);
      return new shelf.Response.internalServerError();
    } finally {
      logger.info('Request handler done.');
    }
  };
}

shelf.Handler redirectToHttpsWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    if (context.isProductionEnvironment &&
        request.requestedUri.scheme != 'https') {
      final secureUri = request.requestedUri.replace(scheme: 'https');
      return new shelf.Response.seeOther(secureUri);
    } else {
      return handler(request);
    }
  };
}
