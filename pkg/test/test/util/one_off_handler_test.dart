// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;
import 'package:test/src/util/one_off_handler.dart';
import 'package:test/test.dart';

void main() {
  var handler;
  setUp(() => handler = new OneOffHandler());

  _handle(request) => new Future.sync(() => handler.handler(request));

  test("returns a 404 for a root URL", () async {
    var request = new shelf.Request("GET", Uri.parse("http://localhost/"));
    expect((await _handle(request)).statusCode, equals(404));
  });

  test("returns a 404 for an unhandled URL", () async {
    var request = new shelf.Request("GET", Uri.parse("http://localhost/1"));
    expect((await _handle(request)).statusCode, equals(404));
  });

  test("passes a request to a handler only once", () async {
    var path = handler.create(expectAsync1((request) {
      expect(request.method, equals("GET"));
      return new shelf.Response.ok("good job!");
    }));

    var request = new shelf.Request("GET", Uri.parse("http://localhost/$path"));
    var response = await _handle(request);
    expect(response.statusCode, equals(200));
    expect(response.readAsString(), completion(equals("good job!")));

    request = new shelf.Request("GET", Uri.parse("http://localhost/$path"));
    expect((await _handle(request)).statusCode, equals(404));
  });

  test("passes requests to the correct handlers", () async {
    var path1 = handler.create(expectAsync1((request) {
      expect(request.method, equals("GET"));
      return new shelf.Response.ok("one");
    }));

    var path2 = handler.create(expectAsync1((request) {
      expect(request.method, equals("GET"));
      return new shelf.Response.ok("two");
    }));

    var path3 = handler.create(expectAsync1((request) {
      expect(request.method, equals("GET"));
      return new shelf.Response.ok("three");
    }));

    var request =
        new shelf.Request("GET", Uri.parse("http://localhost/$path2"));
    var response = await _handle(request);
    expect(response.statusCode, equals(200));
    expect(response.readAsString(), completion(equals("two")));

    request = new shelf.Request("GET", Uri.parse("http://localhost/$path1"));
    response = await _handle(request);
    expect(response.statusCode, equals(200));
    expect(response.readAsString(), completion(equals("one")));

    request = new shelf.Request("GET", Uri.parse("http://localhost/$path3"));
    response = await _handle(request);
    expect(response.statusCode, equals(200));
    expect(response.readAsString(), completion(equals("three")));
  });
}
