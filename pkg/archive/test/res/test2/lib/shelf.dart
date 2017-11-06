library shelf;

import 'dart:async';
import 'dart:io';

Shelf startShelf() => new Shelf();

class Shelf {
  final List<ShelfHandler> _handlers = new List<ShelfHandler>();

  Future<ShelfResponse> handleRequest(HttpRequest request) {
    return new Future.sync(() => _default(request));
  }

  Future listen(int port) {
    return HttpServer.bind(InternetAddress.ANY_IP_V6, port)
        .then((HttpServer server) => server.listen(_handleRequest))
        .then((_) => null);
  }

  void _handleRequest(HttpRequest request) {
    HttpResponse response = request.response;
    handleRequest(request)
      .then((ShelfResponse value) {
        response.statusCode = value.code;
        response.write(value.body);
        return response.close();
      })
      .catchError((Object err, StackTrace stack) {
        response.statusCode = 500;
        response.writeln(err);
        response.writeln(stack);
        return response.close();
      });
  }
}

class ShelfResponse {
  final int code;
  final Map<String, String> headers;
  final String body;

  ShelfResponse(this.code, this.headers, this.body);

  ShelfResponse.noop(Uri uri) :
    this.code = 404,
    this.headers = const {},
    this.body = 'Could not find a resource for $uri';
}

typedef dynamic ShelfHandler(HttpRequest request, [dynamic next(ShelfResponse)]);

dynamic _default(HttpRequest request, [Function next]) {
  return next((ShelfResponse response) {
    if(response == null) {
      return new ShelfResponse.noop(request.uri);
    }
    return response;
  });
}
