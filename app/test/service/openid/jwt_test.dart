// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/service/openid/jwt.dart';
import 'package:test/test.dart';

void main() {
  group('JWT parse', () {
    test('invalid format', () {
      expect(JWT.tryParse(''), isNull);
      expect(JWT.tryParse('.....'), isNull);
      expect(JWT.tryParse('ab.c1.23'), isNull);
    });

    test('successful', () {
      // token generated on jwt.io
      final parsed = JWT.parse(
          'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIi'
          'wibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyM'
          'n0.NHVaYe26MbtOYhSKkoKYdFVomg4i8ZJd8_-RU8VNbftc4TSMb4bXP3l3YlNW'
          'ACwyXPGffz5aXHc6lty1Y2t4SWRqGteragsVdZufDn5BlnJl9pdR_kdVFUsra2r'
          'WKEofkZeIC4yWytE58sMIihvo9H1ScmmVwBcQP6XETqYd0aSHp1gOa9RdUPDvoX'
          'Q5oqygTqVtxaDr6wUFKrKItgBMzWIdNZ6y7O9E0DhEPTbE9rfBo6KTFsHAZnMg4'
          'k68CDp2woYIaXbmYTWcvbzIuHO7_37GT79XdIwkm95QJ7hYC9RiwrV7mesbY4PA'
          'ahERJawntho0my942XheVLmGwLMBkQ');
      expect(parsed.header, {
        'alg': 'RS256',
        'typ': 'JWT',
      });
      expect(parsed.algorithm, 'RS256');
      expect(parsed.type, 'JWT');
      expect(parsed.payload, {
        'sub': '1234567890',
        'name': 'John Doe',
        'admin': true,
        'iat': 1516239022,
      });
      expect(parsed.issuedAt!.year, 2018);
      expect(parsed.expires, isNull);
      expect(parsed.signature, hasLength(256));
    });
  });
}
