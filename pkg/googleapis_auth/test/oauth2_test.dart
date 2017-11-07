// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library googleapis_auth.oauth2_test;

import 'dart:async';
import 'dart:convert';

import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/src/utils.dart';
import 'package:googleapis_auth/src/http_client_base.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';

import 'test_utils.dart';

main() {
  test('access-token', () {
    var expiry = new DateTime.now().subtract(const Duration(seconds: 1));
    var expiryUtc = expiry.toUtc();

    expect(() => new AccessToken(null, 'bar', expiryUtc), throwsArgumentError);
    expect(() => new AccessToken('foo', null, expiryUtc), throwsArgumentError);
    expect(() => new AccessToken('foo', 'bar', null), throwsArgumentError);
    expect(() => new AccessToken('foo', 'bar', expiry), throwsArgumentError);

    var token = new AccessToken('foo', 'bar', expiryUtc);
    expect(token.type, equals('foo'));
    expect(token.data, equals('bar'));
    expect(token.expiry, equals(expiryUtc));
    expect(token.hasExpired, isTrue);

    var nonExpiredToken =
        new AccessToken('foo', 'bar', expiryUtc.add(const Duration(days: 1)));
    expect(nonExpiredToken.hasExpired, isFalse);
  });

  test('access-credentials', () {
    var expiry = new DateTime.now().add(const Duration(days: 1)).toUtc();
    var aToken = new AccessToken('foo', 'bar', expiry);

    expect(() => new AccessCredentials(null, 'refresh', ['scope']),
        throwsArgumentError);
    expect(() => new AccessCredentials(aToken, 'refresh', null),
        throwsArgumentError);

    var credentials = new AccessCredentials(aToken, 'refresh', ['scope']);
    expect(credentials.accessToken, equals(aToken));
    expect(credentials.refreshToken, equals('refresh'));
    expect(credentials.scopes, equals(['scope']));
  });

  test('client-id', () {
    expect(() => new ClientId(null, 'secret'), throwsArgumentError);
    expect(() => new ClientId.serviceAccount(null), throwsArgumentError);

    var clientId = new ClientId('id', 'secret');
    expect(clientId.identifier, equals('id'));
    expect(clientId.secret, equals('secret'));
  });

  group('service-account-credentials', () {
    var clientId = new ClientId.serviceAccount('id');

    var credentials = const {
      "private_key_id": "301029",
      "private_key": TestPrivateKeyString,
      "client_email": "a@b.com",
      "client_id": "myid",
      "type": "service_account"
    };

    test('from-invalid-individual-params', () {
      expect(
          () => new ServiceAccountCredentials(
              null, clientId, TestPrivateKeyString),
          throwsArgumentError);
      expect(
          () => new ServiceAccountCredentials(
              'email', null, TestPrivateKeyString),
          throwsArgumentError);
      expect(() => new ServiceAccountCredentials('email', clientId, null),
          throwsArgumentError);
    });

    test('from-valid-individual-params', () {
      var credentials = new ServiceAccountCredentials(
          'email', clientId, TestPrivateKeyString);
      expect(credentials.email, equals('email'));
      expect(credentials.clientId, equals(clientId));
      expect(credentials.privateKey, equals(TestPrivateKeyString));
      expect(credentials.impersonatedUser, isNull);
    });

    test('from-valid-individual-params-with-user', () {
      var credentials = new ServiceAccountCredentials(
          'email', clientId, TestPrivateKeyString,
          impersonatedUser: 'x@y.com');
      expect(credentials.email, equals('email'));
      expect(credentials.clientId, equals(clientId));
      expect(credentials.privateKey, equals(TestPrivateKeyString));
      expect(credentials.impersonatedUser, equals('x@y.com'));
    });

    test('from-json-string', () {
      var credentialsFromJson =
          new ServiceAccountCredentials.fromJson(JSON.encode(credentials));
      expect(credentialsFromJson.email, equals('a@b.com'));
      expect(credentialsFromJson.clientId.identifier, equals('myid'));
      expect(credentialsFromJson.clientId.secret, isNull);
      expect(credentialsFromJson.privateKey, equals(TestPrivateKeyString));
      expect(credentialsFromJson.impersonatedUser, isNull);
    });

    test('from-json-string-with-user', () {
      var credentialsFromJson = new ServiceAccountCredentials.fromJson(
          JSON.encode(credentials),
          impersonatedUser: 'x@y.com');
      expect(credentialsFromJson.email, equals('a@b.com'));
      expect(credentialsFromJson.clientId.identifier, equals('myid'));
      expect(credentialsFromJson.clientId.secret, isNull);
      expect(credentialsFromJson.privateKey, equals(TestPrivateKeyString));
      expect(credentialsFromJson.impersonatedUser, equals('x@y.com'));
    });

    test('from-json-map', () {
      var credentialsFromJson =
          new ServiceAccountCredentials.fromJson(credentials);
      expect(credentialsFromJson.email, equals('a@b.com'));
      expect(credentialsFromJson.clientId.identifier, equals('myid'));
      expect(credentialsFromJson.clientId.secret, isNull);
      expect(credentialsFromJson.privateKey, equals(TestPrivateKeyString));
      expect(credentialsFromJson.impersonatedUser, isNull);
    });

    test('from-json-map-with-user', () {
      var credentialsFromJson = new ServiceAccountCredentials.fromJson(
          credentials,
          impersonatedUser: 'x@y.com');
      expect(credentialsFromJson.email, equals('a@b.com'));
      expect(credentialsFromJson.clientId.identifier, equals('myid'));
      expect(credentialsFromJson.clientId.secret, isNull);
      expect(credentialsFromJson.privateKey, equals(TestPrivateKeyString));
      expect(credentialsFromJson.impersonatedUser, equals('x@y.com'));
    });
  });

  group('client-wrappers', () {
    var clientId = new ClientId('id', 'secret');
    var tomorrow = new DateTime.now().add(const Duration(days: 1)).toUtc();
    var yesterday =
        new DateTime.now().subtract(const Duration(days: 1)).toUtc();
    var aToken = new AccessToken('Bearer', 'bar', tomorrow);
    var credentials = new AccessCredentials(aToken, 'refresh', ['s1', 's2']);

    Future<Response> successfulRefresh(Request request) {
      expect(request.method, equals('POST'));
      expect('${request.url}',
          equals('https://accounts.google.com/o/oauth2/token'));
      expect(
          request.body,
          equals('client_id=id&'
              'client_secret=secret&'
              'refresh_token=refresh&'
              'grant_type=refresh_token'));
      var body = JSON.encode({
        'token_type': 'Bearer',
        'access_token': 'atoken',
        'expires_in': 3600,
      });

      return new Future.value(
          new Response(body, 200, headers: _JsonContentType));
    }

    Future<Response> refreshErrorResponse(Request request) {
      var body = JSON.encode({'error': 'An error occured'});
      return new Future<Response>.value(
          new Response(body, 400, headers: _JsonContentType));
    }

    Future<Response> serverError(Request request) {
      return new Future<Response>.error(
          new Exception('transport layer exception'));
    }

    test('refreshCredentials-successfull', () async {
      var newCredentials = await refreshCredentials(clientId, credentials,
          mockClient(expectAsyncT(successfulRefresh), expectClose: false));
      var expectedResultUtc = new DateTime.now().toUtc().add(
          const Duration(seconds: 3600 - MAX_EXPECTED_TIMEDIFF_IN_SECONDS));

      var accessToken = newCredentials.accessToken;
      expect(accessToken.type, equals('Bearer'));
      expect(accessToken.data, equals('atoken'));
      expect(accessToken.expiry.difference(expectedResultUtc).inSeconds,
          equals(0));

      expect(newCredentials.refreshToken, equals('refresh'));
      expect(newCredentials.scopes, equals(['s1', 's2']));
    });

    test('refreshCredentials-http-error', () {
      refreshCredentials(clientId, credentials,
              mockClient(serverError, expectClose: false))
          .catchError(expectAsyncT((error) {
        expect(
            error.toString(), equals('Exception: transport layer exception'));
      }));
    });

    test('refreshCredentials-error-response', () {
      refreshCredentials(clientId, credentials,
              mockClient(refreshErrorResponse, expectClose: false))
          .catchError(expectAsyncT((error) {
        expect(error is RefreshFailedException, isTrue);
      }));
    });

    group('authenticatedClient', () {
      var url = Uri.parse('http://www.example.com');

      test('successfull', () async {
        var client = authenticatedClient(
            mockClient(expectAsyncT((request) {
              expect(request.method, equals('POST'));
              expect(request.url, equals(url));
              expect(request.headers.length, equals(1));
              expect(request.headers['Authorization'], equals('Bearer bar'));

              return new Future.value(new Response('', 204));
            }), expectClose: false),
            credentials);
        expect(client.credentials, equals(credentials));

        var response = await client.send(new RequestImpl('POST', url));
        expect(response.statusCode, equals(204));
      });

      test('access-denied', () {
        var client = authenticatedClient(
            mockClient(expectAsyncT((request) {
              expect(request.method, equals('POST'));
              expect(request.url, equals(url));
              expect(request.headers.length, equals(1));
              expect(request.headers['Authorization'], equals('Bearer bar'));

              var headers = const {'www-authenticate': 'foobar'};
              return new Future.value(new Response('', 401, headers: headers));
            }), expectClose: false),
            credentials);
        expect(client.credentials, equals(credentials));

        expect(client.send(new RequestImpl('POST', url)),
            throwsA(isAccessDeniedException));
      });

      test('non-bearer-token', () {
        var aToken = credentials.accessToken;
        var nonBearerCredentials = new AccessCredentials(
            new AccessToken('foobar', aToken.data, aToken.expiry),
            'refresh',
            ['s1', 's2']);

        expect(
            () => authenticatedClient(
                mockClient((_) {}, expectClose: false), nonBearerCredentials),
            throwsA(isArgumentError));
      });
    });

    group('autoRefreshingClient', () {
      var url = Uri.parse('http://www.example.com');

      test('up-to-date', () async {
        var client = autoRefreshingClient(
            clientId,
            credentials,
            mockClient(expectAsyncT((request) {
              return new Future.value(new Response('', 200));
            }), expectClose: false));
        expect(client.credentials, equals(credentials));

        var response = await client.send(new RequestImpl('POST', url));
        expect(response.statusCode, equals(200));
      });

      test('no-refresh-token', () {
        var credentials = new AccessCredentials(
            new AccessToken('Bearer', 'bar', yesterday), null, ['s1', 's2']);

        expect(
            () => autoRefreshingClient(
                clientId, credentials, mockClient((_) {}, expectClose: false)),
            throwsA(isArgumentError));
      });

      test('refresh-failed', () {
        var credentials = new AccessCredentials(
            new AccessToken('Bearer', 'bar', yesterday),
            'refresh',
            ['s1', 's2']);

        var client = autoRefreshingClient(
            clientId,
            credentials,
            mockClient(expectAsyncT((request) {
              // This should be a refresh request.
              expect(request.headers['foo'], isNull);
              return refreshErrorResponse(request);
            }), expectClose: false));
        expect(client.credentials, equals(credentials));

        var request = new RequestImpl('POST', url);
        request.headers.addAll({'foo': 'bar'});
        expect(client.send(request), throwsA(isRefreshFailedException));
      });

      test('invalid-content-type', () {
        var credentials = new AccessCredentials(
            new AccessToken('Bearer', 'bar', yesterday),
            'refresh',
            ['s1', 's2']);

        var client = autoRefreshingClient(
            clientId,
            credentials,
            mockClient(expectAsyncT((request) {
              // This should be a refresh request.
              expect(request.headers['foo'], isNull);
              var headers = {'content-type': 'image/png'};

              return new Future.value(new Response('', 200, headers: headers));
            }), expectClose: false));
        expect(client.credentials, equals(credentials));

        var request = new RequestImpl('POST', url);
        request.headers.addAll({'foo': 'bar'});
        expect(client.send(request), throwsA(isException));
      });

      test('successful-refresh', () async {
        int serverInvocation = 0;

        var credentials = new AccessCredentials(
            new AccessToken('Bearer', 'bar', yesterday), 'refresh', ['s1']);

        var client = autoRefreshingClient(
            clientId,
            credentials,
            mockClient(
                expectAsyncT((request) {
                  if (serverInvocation++ == 0) {
                    // This should be a refresh request.
                    expect(request.headers['foo'], isNull);
                    return successfulRefresh(request);
                  } else {
                    // This is the real request.
                    expect(request.headers['foo'], equals('bar'));
                    return new Future.value(new Response('', 200));
                  }
                }, count: 2),
                expectClose: false));
        expect(client.credentials, equals(credentials));

        bool executed = false;
        client.credentialUpdates.listen(expectAsyncT((newCredentials) {
          expect(newCredentials.accessToken.type, equals('Bearer'));
          expect(newCredentials.accessToken.data, equals('atoken'));
          executed = true;
        }), onDone: expectAsyncT(() {}));

        var request = new RequestImpl('POST', url);
        request.headers.addAll({'foo': 'bar'});

        var response = await client.send(request);
        expect(response.statusCode, equals(200));

        // The `client.send()` will have trigged a credentials refresh.
        expect(executed, isTrue);

        await client.close();
      });
    });
  });
}

final _JsonContentType = const {'content-type': 'application/json'};
