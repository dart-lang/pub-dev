// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import '../client_context.dart';
import 'context_registry.dart';

void _info(String message) {
  final formattedMessage = '${DateTime.now()}: $message';
  stderr.writeln(formattedMessage);
}

class AppEngineHttpServer {
  final ContextRegistry _contextRegistry;

  final String _hostname;
  final int _port;
  final bool _shared;

  final Completer _shutdownCompleter = Completer();

  AppEngineHttpServer(this._contextRegistry,
      {String hostname = '0.0.0.0', int port = 8080, bool shared = false})
      : _hostname = hostname,
        _port = port,
        _shared = shared;

  Future get done => _shutdownCompleter.future;

  void run(
    Function(HttpRequest request, ClientContext context) applicationHandler, {
    void Function(InternetAddress address, int port)? onAcceptingConnections,
  }) {
    HttpServer.bind(_hostname, _port, shared: _shared)
        .then((HttpServer server) {
      if (onAcceptingConnections != null) {
        onAcceptingConnections(server.address, server.port);
      }

      server.listen((HttpRequest request) {
        final context = _contextRegistry.add(request);
        request.response.done.whenComplete(() {
          _contextRegistry.remove(request);
        });

        request.response.done.catchError((error) {
          if (!_contextRegistry.isDevelopmentEnvironment) {
            _info('Error while handling response: $error');
          }
        });

        applicationHandler(request, context);
      });
    });
  }
}
