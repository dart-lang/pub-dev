// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library googleapis_auth.auth_code_test;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/src/oauth2_flows/auth_code.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

import '../test_utils.dart';

typedef Future<Response> RequestHandler(Request _);

main() {
  var clientId = new ClientId('id', 'secret');
  var scopes = ['s1', 's2'];

  // Validation + Responses from the authorization server.

  RequestHandler successFullResponse({bool manual}) {
    return (Request request) async {
      expect(request.method, equals('POST'));
      expect('${request.url}',
          equals('https://accounts.google.com/o/oauth2/token'));
      expect(
          request.headers['content-type']
              .startsWith('application/x-www-form-urlencoded'),
          isTrue);

      var pairs = request.body.split('&');
      expect(pairs, hasLength(5));
      expect(pairs[0], equals('grant_type=authorization_code'));
      expect(pairs[1], equals('code=mycode'));
      expect(pairs[3], equals('client_id=id'));
      expect(pairs[4], equals('client_secret=secret'));
      if (manual) {
        expect(pairs[2],
            equals('redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob'));
      } else {
        expect(pairs[2], startsWith('redirect_uri='));

        var url = Uri.parse(
            Uri.decodeComponent(pairs[2].substring('redirect_uri='.length)));
        expect(url.scheme, equals('http'));
        expect(url.host, equals('localhost'));
      }

      var result = {
        'token_type': 'Bearer',
        'access_token': 'tokendata',
        'expires_in': 3600,
        'refresh_token': 'my-refresh-token',
      };
      return new Response(JSON.encode(result), 200);
    };
  }

  Future<Response> invalidResponse(Request request) {
    // Missing expires_in field!
    var result = {
      'token_type': 'Bearer',
      'access_token': 'tokendata',
      'refresh_token': 'my-refresh-token',
    };
    return new Future.value(new Response(JSON.encode(result), 200));
  }

  // Validation functions for user prompt and access credentials.

  void validateAccessCredentials(AccessCredentials credentials) {
    expect(credentials.accessToken.data, equals('tokendata'));
    expect(credentials.accessToken.type, equals('Bearer'));
    expect(credentials.scopes, equals(['s1', 's2']));
    expect(credentials.refreshToken, equals('my-refresh-token'));
    expectExpiryOneHourFromNow(credentials.accessToken);
  }

  Uri validateUserPromptUri(String url, {bool manual: false}) {
    var uri = Uri.parse(url);
    expect(uri.scheme, equals('https'));
    expect(uri.host, equals('accounts.google.com'));
    expect(uri.path, equals('/o/oauth2/auth'));
    expect(uri.queryParameters['client_id'], equals(clientId.identifier));
    expect(uri.queryParameters['response_type'], equals('code'));
    expect(uri.queryParameters['scope'], equals('s1 s2'));
    expect(uri.queryParameters['redirect_uri'], isNotNull);

    var redirectUri = Uri.parse(uri.queryParameters['redirect_uri']);

    if (manual) {
      expect('$redirectUri', equals('urn:ietf:wg:oauth:2.0:oob'));
    } else {
      expect(uri.queryParameters['state'], isNotNull);
      expect(redirectUri.scheme, equals('http'));
      expect(redirectUri.host, equals('localhost'));
    }

    return redirectUri;
  }

  group('authorization-code-flow', () {
    group('manual-copy-paste', () {
      Future<String> manualUserPrompt(String url) {
        validateUserPromptUri(url, manual: true);
        return new Future.value('mycode');
      }

      test('successfull', () async {
        var flow = new AuthorizationCodeGrantManualFlow(
            clientId,
            scopes,
            mockClient(successFullResponse(manual: true), expectClose: false),
            manualUserPrompt);
        validateAccessCredentials(await flow.run());
      });

      test('user-exception', () {
        // We use a TransportException here for convenience.
        Future<String> manualUserPromptError(String url) {
          return new Future.error(new TransportException());
        }

        var flow = new AuthorizationCodeGrantManualFlow(
            clientId,
            scopes,
            mockClient(successFullResponse(manual: true), expectClose: false),
            manualUserPromptError);
        expect(flow.run(), throwsA(isTransportException));
      });

      test('transport-exception', () {
        var flow = new AuthorizationCodeGrantManualFlow(
            clientId, scopes, transportFailure, manualUserPrompt);
        expect(flow.run(), throwsA(isTransportException));
      });

      test('invalid-server-response', () {
        var flow = new AuthorizationCodeGrantManualFlow(clientId, scopes,
            mockClient(invalidResponse, expectClose: false), manualUserPrompt);
        expect(flow.run(), throwsA(isException));
      });
    });

    group('http-server', () {
      void callRedirectionEndpoint(Uri authCodeCall) {
        var ioClient = new HttpClient();
        ioClient
            .getUrl(authCodeCall)
            .then((request) => request.close())
            .then((response) => response.drain())
            .whenComplete(expectAsyncT(() {
          ioClient.close();
        }));
      }

      void userPrompt(String url) {
        var redirectUri = validateUserPromptUri(url);
        var authCodeCall = new Uri(
            scheme: redirectUri.scheme,
            host: redirectUri.host,
            port: redirectUri.port,
            path: redirectUri.path,
            queryParameters: {
              'state': Uri.parse(url).queryParameters['state'],
              'code': 'mycode',
            });
        callRedirectionEndpoint(authCodeCall);
      }

      void userPromptInvalidAuthCodeCallback(String url) {
        var redirectUri = validateUserPromptUri(url);
        var authCodeCall = new Uri(
            scheme: redirectUri.scheme,
            host: redirectUri.host,
            port: redirectUri.port,
            path: redirectUri.path,
            queryParameters: {
              'state': Uri.parse(url).queryParameters['state'],
              'error': 'failed to authenticate',
            });
        callRedirectionEndpoint(authCodeCall);
      }

      test('successfull', () async {
        var flow = new AuthorizationCodeGrantServerFlow(
            clientId,
            scopes,
            mockClient(successFullResponse(manual: false), expectClose: false),
            expectAsyncT(userPrompt));
        validateAccessCredentials(await flow.run());
      });

      test('transport-exception', () {
        var flow = new AuthorizationCodeGrantServerFlow(
            clientId, scopes, transportFailure, expectAsyncT(userPrompt));
        expect(flow.run(), throwsA(isTransportException));
      });

      test('invalid-server-response', () {
        var flow = new AuthorizationCodeGrantServerFlow(
            clientId,
            scopes,
            mockClient(invalidResponse, expectClose: false),
            expectAsyncT(userPrompt));
        expect(flow.run(), throwsA(isException));
      });

      test('failed-authentication', () {
        var flow = new AuthorizationCodeGrantServerFlow(
            clientId,
            scopes,
            mockClient(successFullResponse(manual: false), expectClose: false),
            expectAsyncT(userPromptInvalidAuthCodeCallback));
        expect(flow.run(), throwsA(isUserConsentException));
      });
    });
  });

  group('scopes-from-tokeninfo-endpoint', () {
    var successfulResponseJson = JSON.encode({
      "issued_to": "XYZ.apps.googleusercontent.com",
      "audience": "XYZ.apps.googleusercontent.com",
      "scope": "scopeA scopeB",
      "expires_in": 3210,
      "access_type": "offline"
    });
    var expectedUri =
        'https://www.googleapis.com/oauth2/v2/tokeninfo?access_token=my_token';

    test('successfull', () async {
      var http = mockClient(expectAsyncT((BaseRequest request) async {
        expect(request.url.toString(), expectedUri);
        return new Response(successfulResponseJson, 200);
      }), expectClose: false);
      List<String> scopes = await obtainScopesFromAccessToken('my_token', http);
      expect(scopes, equals(['scopeA', 'scopeB']));
    });

    test('non-200-status-code', () {
      var http = mockClient(expectAsyncT((BaseRequest request) async {
        expect(request.url.toString(), expectedUri);
        return new Response(successfulResponseJson, 201);
      }), expectClose: false);
      expect(obtainScopesFromAccessToken('my_token', http), throws);
    });

    test('no-scope', () {
      var http = mockClient(expectAsyncT((BaseRequest request) async {
        expect(request.url.toString(), expectedUri);
        return new Response(JSON.encode({}), 200);
      }), expectClose: false);
      expect(obtainScopesFromAccessToken('my_token', http), throws);
    });
  });
}
