// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library application;

import 'dart:async';
import 'dart:convert' show UTF8;
import 'dart:io';

import 'context_registry.dart';
import 'http_wrapper.dart';

void _info(String message) {
  var formattedMessage = "${new DateTime.now()}: " + message;
  print(formattedMessage);
}

class AppEngineHttpServer {
  final ContextRegistry _contextRegistry;

  final String _hostname;
  final int _port;

  final Completer _shutdownCompleter = new Completer();
  int _pendingRequests = 0;

  HttpServer _httpServer;

  AppEngineHttpServer(this._contextRegistry,
                      {String hostname: '0.0.0.0', int port: 8080})
      : _hostname = hostname, _port = port;

  Future get done => _shutdownCompleter.future;

  void run(applicationHandler(request, context)) {
    var serviceHandlers = {
        '/_ah/start' : _start,
        '/_ah/health' : _health,
        '/_ah/stop' : _stop
    };

    HttpServer.bind(_hostname, _port).then((HttpServer server) {
      _httpServer = server;

      server.listen((HttpRequest request) {
        var appengineRequest = new AppengineHttpRequest(request);

        // Default handling is sending the request to the aplication.
        var handler = applicationHandler;

        // Check if the request path is one of the service handlers.
        String path = appengineRequest.uri.path;
        for (var pattern in serviceHandlers.keys) {
          if (path.startsWith(pattern)) {
            handler = serviceHandlers[pattern];
            break;
          }
        }

        _pendingRequests++;
        var context = _contextRegistry.add(appengineRequest);
        appengineRequest.response.registerHook(
            () => _contextRegistry.remove(appengineRequest));

        appengineRequest.response.done.catchError((error) {
          _info("Error while handling response: $error");
          _pendingRequests--;
          _checkShutdown();
        });

        handler(appengineRequest, context);
      });
    });
  }

  void _start(HttpRequest request, _) {
    request.drain().then((_) {
      _sendResponse(request.response, HttpStatus.OK, "ok");
    });
  }

  void _health(HttpRequest request, _) {
    request.drain().then((_) {
      _sendResponse(request.response, HttpStatus.OK, "ok");
    });
  }

  void _stop(HttpRequest request, _) {
    request.drain().then((_) {
      if (_httpServer != null) {
        _httpServer.close().then((_) {
          _httpServer = null;
          _sendResponse(request.response, HttpStatus.OK, "ok");
        });
      } else {
        _sendResponse(request.response, HttpStatus.CONFLICT, "fail");
      }
    });
  }

  _checkShutdown() {
    if (_pendingRequests == 0 && _httpServer == null) {
      _shutdownCompleter.complete();
    }
  }

  void _sendResponse(HttpResponse response, int statusCode, String message) {
    var data = UTF8.encode(message);
    response.headers.contentType =
        new ContentType('text', 'plain', charset: 'utf-8');
    response.headers.set("Cache-Control", "no-cache");
    response.headers.set("Server", _hostname);
    response.contentLength = data.length;
    response.statusCode = statusCode;
    response.add(data);
    response.close();
  }
}
