// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:http_multi_server/http_multi_server.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_test_handler/shelf_test_handler.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// A class that serves Dart and/or JS code and receives WebSocket connections.
class CodeServer {
  /// The handler for [_server].
  final ShelfTestHandler _handler;

  /// The URL of the server (including the port).
  final Uri url;

  static Future<CodeServer> start() async {
    var server = await HttpMultiServer.loopback(0);
    var handler = new ShelfTestHandler();
    shelf_io.serveRequests(server, (request) {
      if (request.method == "GET" && request.url.path == "favicon.ico") {
        return new shelf.Response.notFound(null);
      } else {
        return handler(request);
      }
    });

    return new CodeServer._(
        handler, Uri.parse("http://localhost:${server.port}"));
  }

  CodeServer._(this._handler, this.url);

  /// Sets up a handler for the root of the server, "/", that serves a basic
  /// HTML page with a script tag that will run [dart].
  void handleDart(String dart) {
    _handler.expect("GET", "/", (_) {
      return new shelf.Response.ok("""
<!doctype html>
<html>
<head>
  <script type="application/dart" src="index.dart"></script>
</head>
</html>
""", headers: {'content-type': 'text/html'});
    });

    _handler.expect("GET", "/index.dart", (_) {
      return new shelf.Response.ok('''
import "dart:html";

main() async {
  $dart
}
''', headers: {'content-type': 'application/dart'});
    });
  }

  /// Sets up a handler for the root of the server, "/", that serves a basic
  /// HTML page with a script tag that will run [javaScript].
  void handleJavaScript(String javaScript) {
    _handler.expect("GET", "/", (_) {
      return new shelf.Response.ok("""
<!doctype html>
<html>
<head>
  <script src="index.js"></script>
</head>
</html>
""", headers: {'content-type': 'text/html'});
    });

    _handler.expect("GET", "/index.js", (_) {
      return new shelf.Response.ok(javaScript,
          headers: {'content-type': 'application/javascript'});
    });
  }

  /// Handles a WebSocket connection to the root of the server, and returns a
  /// future that will complete to the WebSocket.
  Future<WebSocketChannel> handleWebSocket() {
    var completer = new Completer<WebSocketChannel>();
    _handler.expect("GET", "/", webSocketHandler(completer.complete));
    return completer.future;
  }
}
