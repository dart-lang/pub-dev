// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library googleapis_auth.http_client_base_test;

import 'dart:async';

import 'package:googleapis_auth/src/http_client_base.dart';
import 'package:googleapis_auth/src/auth_http_utils.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';

import 'test_utils.dart';

class DelegatingClientImpl extends DelegatingClient {
  DelegatingClientImpl(Client base, {bool closeUnderlyingClient})
      : super(base, closeUnderlyingClient: closeUnderlyingClient);

  Future<StreamedResponse> send(BaseRequest request) => throw 'unsupported';
}

main() {
  group('http-utils', () {
    group('delegating-client', () {
      test('not-close-underlying-client', () {
        var mock = mockClient((_) {}, expectClose: false);
        new DelegatingClientImpl(mock, closeUnderlyingClient: false).close();
      });

      test('close-underlying-client', () {
        var mock = mockClient((_) {}, expectClose: true);
        new DelegatingClientImpl(mock, closeUnderlyingClient: true).close();
      });

      test('close-several-times', () {
        var mock = mockClient((_) {}, expectClose: true);
        var delegate =
            new DelegatingClientImpl(mock, closeUnderlyingClient: true);
        delegate.close();
        expect(() => delegate.close(), throwsA(isStateError));
      });
    });

    group('refcounted-client', () {
      test('not-close-underlying-client', () {
        var mock = mockClient((_) {}, expectClose: false);
        var client = new RefCountedClient(mock, initialRefCount: 3);
        client.close();
        client.close();
      });

      test('close-underlying-client', () {
        var mock = mockClient((_) {}, expectClose: true);
        var client = new RefCountedClient(mock, initialRefCount: 3);
        client.close();
        client.close();
        client.close();
      });

      test('acquire-release', () {
        var mock = mockClient((_) {}, expectClose: true);
        var client = new RefCountedClient(mock, initialRefCount: 1);
        client.acquire();
        client.release();
        client.acquire();
        client.release();
        client.release();
      });

      test('close-several-times', () {
        var mock = mockClient((_) {}, expectClose: true);
        var client = new RefCountedClient(mock, initialRefCount: 1);
        client.close();
        expect(() => client.close(), throwsA(isStateError));
      });
    });

    group('api-client', () {
      var key = 'foo%?bar';
      var keyEncoded = 'key=${Uri.encodeQueryComponent(key)}';

      RequestImpl request(String url) => new RequestImpl('GET', Uri.parse(url));
      Future<Response> responseF() =>
          new Future<Response>.value(new Response.bytes([], 200));

      test('no-query-string', () {
        var mock = mockClient((Request request) {
          expect('${request.url}', equals('http://localhost/abc?$keyEncoded'));
          return responseF();
        }, expectClose: true);

        var client = new ApiKeyClient(mock, key);
        expect(client.send(request('http://localhost/abc')), completes);
        client.close();
      });

      test('with-query-string', () {
        var mock = mockClient((Request request) {
          expect(
              '${request.url}', equals('http://localhost/abc?x&$keyEncoded'));
          return responseF();
        }, expectClose: true);

        var client = new ApiKeyClient(mock, key);
        expect(client.send(request('http://localhost/abc?x')), completes);
        client.close();
      });

      test('with-existing-key', () {
        var mock = mockClient(expectAsyncT((Request request) {}, count: 0),
            expectClose: true);

        var client = new ApiKeyClient(mock, key);
        expect(client.send(request('http://localhost/abc?key=a')), throws);
        client.close();
      });
    });

    test('non-closing-client', () {
      var mock = mockClient((_) {}, expectClose: false);
      nonClosingClient(mock).close();
    });
  });
}
