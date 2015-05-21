import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:appengine/src/appengine_context.dart';
import 'package:unittest/unittest.dart';

// HTTP client which requests /test and completes with the binary
// body.
Future<List<int>> x(int port) {
  var client;
  client = new HttpClient();
  return client.get('127.0.0.1', port, '/')
     .then((request) {
       return request.close();
     })
     .then((response) {
       expect(response.statusCode, 200);
       return response.drain();
     })
     .whenComplete(() {
       client.close();
     });
}

void main() {
  group('client context', () {
    var appServer;
    var appServerPort;

    // Mock application server which passes the Assets instance to the
    // request handler.
    Future startAppServer(mockRequestHandler) {
      assert(appServer == null);
      return HttpServer.bind('127.0.0.1', 0).then((server) {
        var appengineContext = new AppengineContext(
            'application id',  'dev',  'version',  'module', null, null);
        appServer = server;
        appServerPort = server.port;
        server.listen(mockRequestHandler);
        return server;
      });
    }

    tearDown(() {
      return appServer.close().then((_) {
        appServer = null;
      });
    });

    test('application', () {
      void requestHandler(HttpRequest request) {
      try {
        print(context);
        expect(context.application.id, 'application id');
        request.response.close();
      } catch (e) {
        print(e);
      }}
      return startAppServer(requestHandler).then((_) {
        return x(appServerPort);
      });
    });
  });
}