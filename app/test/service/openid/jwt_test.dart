// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pem/pem.dart';
import 'package:pub_dev/service/openid/jwt.dart';
import 'package:pub_dev/service/openid/openssl_commands.dart';
import 'package:test/test.dart';

void main() {
  // token generated on jwt.io
  final jwtIoToken =
      'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIi'
      'wibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyM'
      'n0.NHVaYe26MbtOYhSKkoKYdFVomg4i8ZJd8_-RU8VNbftc4TSMb4bXP3l3YlNW'
      'ACwyXPGffz5aXHc6lty1Y2t4SWRqGteragsVdZufDn5BlnJl9pdR_kdVFUsra2r'
      'WKEofkZeIC4yWytE58sMIihvo9H1ScmmVwBcQP6XETqYd0aSHp1gOa9RdUPDvoX'
      'Q5oqygTqVtxaDr6wUFKrKItgBMzWIdNZ6y7O9E0DhEPTbE9rfBo6KTFsHAZnMg4'
      'k68CDp2woYIaXbmYTWcvbzIuHO7_37GT79XdIwkm95QJ7hYC9RiwrV7mesbY4PA'
      'ahERJawntho0my942XheVLmGwLMBkQ';
  // public key to verify the token
  final jwtIoPublicKeyPem = [
    '-----BEGIN PUBLIC KEY-----',
    'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu1SU1LfVLPHCozMxH2Mo',
    '4lgOEePzNm0tRgeLezV6ffAt0gunVTLw7onLRnrq0/IzW7yWR7QkrmBL7jTKEn5u',
    '+qKhbwKfBstIs+bMY2Zkp18gnTxKLxoS2tFczGkPLPgizskuemMghRniWaoLcyeh',
    'kd3qqGElvW/VDL5AaWTg0nLVkjRo9z+40RQzuVaE8AkAFmxZzow3x+VJYKdjykkJ',
    '0iT9wCS0DRTXu269V264Vf/3jvredZiKRkgwlL9xNAwxXFg0x/XFw005UWVRIkdg',
    'cKWTjpBP2dPwVZ4WWC+9aGVd+Gyn1o0CLelf4rEjGoXbAAEgAqeGUxrcIlbjXfbc',
    'mwIDAQAB',
    '-----END PUBLIC KEY-----',
  ].join('\n');

  group('JWT parse', () {
    test('invalid format', () {
      expect(JsonWebToken.tryParse(''), isNull);
      expect(JsonWebToken.tryParse('.....'), isNull);
      expect(JsonWebToken.tryParse('ab.c1.23'), isNull);
    });

    test('parse successful', () {
      final parsed = JsonWebToken.parse(jwtIoToken);
      expect(parsed.header, {
        'alg': 'RS256',
        'typ': 'JWT',
      });
      expect(parsed.alg, 'RS256');
      expect(parsed.typ, 'JWT');
      expect(parsed.payload, {
        'sub': '1234567890',
        'name': 'John Doe',
        'admin': true,
        'iat': 1516239022,
      });
      expect(parsed.iat!.year, 2018);
      expect(parsed.exp, isNull);
      expect(parsed.signature, hasLength(256));
    });

    test('verify signature', () async {
      final headerAndPayloadEncoded = jwtIoToken.split('.').take(2).join('.');
      final parsed = JsonWebToken.parse(jwtIoToken);
      final isValid = await verifyTextWithRsaSignature(
        input: headerAndPayloadEncoded,
        signature: parsed.signature,
        publicKey:
            decodePemBlocks(PemLabel.publicKey, jwtIoPublicKeyPem).single,
      );
      expect(isValid, isTrue);
    });
  });
}
