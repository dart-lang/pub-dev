// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library googleapis_auth.jwt_test;

import 'dart:async';
import 'dart:convert';

import 'package:googleapis_auth/src/oauth2_flows/jwt.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

import '../test_utils.dart';

main() {
  var tokenUrl = 'https://accounts.google.com/o/oauth2/token';

  Future<Response> successfullSignRequest(Request request) {
    expect(request.method, equals('POST'));
    expect(request.url.toString(), equals(tokenUrl));

    // We are not asserting what comes after '&assertion=' because this is
    // time dependend.
    expect(
        request.body,
        startsWith(
            'grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer'
            '&assertion='));
    var body = JSON.encode({
      'access_token': 'atok',
      'expires_in': 3600,
      'token_type': 'Bearer',
    });
    return new Future.value(new Response(body, 200));
  }

  Future<Response> invalidAccessToken(Request request) {
    var body = JSON.encode({
      // Missing 'expires_in' entry
      'access_token': 'atok',
      'token_type': 'Bearer',
    });
    return new Future.value(new Response(body, 200));
  }

  group('jwt-flow', () {
    var clientEmail = 'a@b.com';
    var scopes = ['s1', 's2'];

    test('successfull', () async {
      var flow = new JwtFlow(clientEmail, TestPrivateKey, null, scopes,
          mockClient(expectAsyncT(successfullSignRequest), expectClose: false));

      var credentials = await flow.run();
      expect(credentials.accessToken.data, equals('atok'));
      expect(credentials.accessToken.type, equals('Bearer'));
      expect(credentials.scopes, equals(['s1', 's2']));
      expectExpiryOneHourFromNow(credentials.accessToken);
    });

    test('successfull-with-user', () async {
      var flow = new JwtFlow(clientEmail, TestPrivateKey, 'x@y.com', scopes,
          mockClient(expectAsyncT(successfullSignRequest), expectClose: false));

      var credentials = await flow.run();
      expect(credentials.accessToken.data, equals('atok'));
      expect(credentials.accessToken.type, equals('Bearer'));
      expect(credentials.scopes, equals(['s1', 's2']));
      expectExpiryOneHourFromNow(credentials.accessToken);
    });

    test('invalid-server-response', () {
      var flow = new JwtFlow(clientEmail, TestPrivateKey, null, scopes,
          mockClient(expectAsyncT(invalidAccessToken), expectClose: false));

      expect(flow.run(), throwsA(isException));
    });

    test('transport-failure', () {
      var flow = new JwtFlow(
          clientEmail, TestPrivateKey, null, scopes, transportFailure);

      expect(flow.run(), throwsA(isTransportException));
    });
  });
}
