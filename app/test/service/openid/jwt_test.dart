// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:convert/convert.dart';
import 'package:pub_dev/service/openid/jwt.dart';
import 'package:pub_dev/service/openid/openid_models.dart';
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
      expect(parsed.header.alg, 'RS256');
      expect(parsed.header.typ, 'JWT');
      expect(parsed.payload, {
        'sub': '1234567890',
        'name': 'John Doe',
        'admin': true,
        'iat': 1516239022,
      });
      expect(parsed.payload.iat!.year, 2018);
      expect(parsed.payload.exp, isNull);
      expect(parsed.payload.verifyTimestamps(clock.now()), isTrue);
      expect(parsed.payload.verifyTimestamps(DateTime(2017)), isFalse);
      expect(parsed.signature, hasLength(256));
    });

    test('verify signature', () async {
      final headerAndPayloadEncoded = jwtIoToken.split('.').take(2).join('.');
      final parsed = JsonWebToken.parse(jwtIoToken);
      final isValid = await verifyTextWithRsaSignature(
        input: headerAndPayloadEncoded,
        signature: parsed.signature,
        publicKey: Asn1RsaPublicKey.parsePemString(jwtIoPublicKeyPem),
      );
      expect(isValid, isTrue);
    });
  });

  group('ASN encoding', () {
    test('known PEM encoding', () {
      final reference = Asn1RsaPublicKey.parsePemString(jwtIoPublicKeyPem);
      final n = hex.decode(
          'bb5494d4b7d52cf1c2a333311f6328e2580e11e3f3366d2d46078b7b357a7df0'
          '2dd20ba75532f0ee89cb467aead3f2335bbc9647b424ae604bee34ca127e6efa'
          'a2a16f029f06cb48b3e6cc636664a75f209d3c4a2f1a12dad15ccc690f2cf822'
          'cec92e7a63208519e259aa0b7327a191ddeaa86125bd6fd50cbe406964e0d272'
          'd5923468f73fb8d11433b95684f00900166c59ce8c37c7e54960a763ca4909d2'
          '24fdc024b40d14d7bb6ebd576eb855fff78efade75988a46483094bf71340c31'
          '5c5834c7f5c5c34d3951655122476070a5938e904fd9d3f0559e16582fbd6865'
          '5df86ca7d68d022de95fe2b1231a85db00012002a786531adc2256e35df6dc9b');
      final e = hex.decode('010001');
      final publicKey = Asn1RsaPublicKey(modulus: n, exponent: e);
      expect(hex.encode(publicKey.asDerEncodedBytes),
          hex.encode(reference.asDerEncodedBytes));
    });
  });

  group('JWK + JWT verification test', () {
    // JWKS and JWT data is coming form the following article:
    // https://medium.com/trabe/validate-jwt-tokens-using-jwks-in-java-214f7014b5cf
    final jwksData = {
      'keys': [
        {
          'use': 'sig',
          'kty': 'RSA',
          'kid': 'public:c424b67b-fe28-45d7-b015-f79da50b5b21',
          'alg': 'RS256',
          'n': 'sttddbg-_yjXzcFpbMJB1fIFam9lQBeXWbTqzJwbuFbspHMsRowa8FaPw44l2C'
              '9Q42J3AdQD8CcNj2z7byCTSC5gaDAY30xvZoi5WDWkSjHblMPBUT2cDtw9bIZ6F'
              'ocRp46KaKzeoVDv3a0EBg5cdAdrefawfZoruPZCLmyLqXZmBM8RbpYLChb-UFO2'
              '5i7e4AoRJ2hNFYg0qM-hRZNwLliDfkafjnOgSu7_w0WDInNzbUuy26rb_yDNGEI'
              'ylXHlt0BKcMoeO3sJEwS5EDAkXkvz_7zQ6lgDQ4OLihC4QDwkp7dV2iQxvd7D-X'
              'EaSIahiqdHlqR8cUYOJANDVRIufAzzkyK8Shu_MXhVUW7hH3hNjlEh198bCWANH'
              'csZWF2_V78Rl-UzCjsAFWtttf6FYpR9Kt-8ILM3aAYTAk3OwsvzSeqTtWLHp96Q'
              'E8Bcm1AmZfPWzsd3PpLuSM_wfx4oxDWhdaKQ-HK1hCYLNv2Vity2uNC_tbGxOD9'
              'syRujWKS6wFf2b3jFEudV0NUXQ_1Beu8Ir0jHzuA_0D22wgiaSJ9svfpJ7XyoD6'
              'fxyHSyhpMsXIDLmnwOPKmD67MFQ7Bv_9H91KZmr34oeh6PVWEwb4wUAkDaCebo6'
              'h0gdMoDfZTq9Gn5S-Aq0-_-fIfyN9qrrQ0E1Q_QDhvqXx8eQ1r9smM',
          'e': 'AQAB',
        },
        {
          'use': 'sig',
          'kty': 'RSA',
          'kid': 'public:9b9d0b47-b9ed-4ba6-9180-52fc5b161a3a',
          'alg': 'RS256',
          'n': '6f4qEUPMmYAyAQnGQOIx1UkIEVPPt1BnhDH70w3Gq6uYpm4hUyRFiM1oZ4_xB2'
              '8gTmpR_SJZL31E_yZTLKPwKKsCDyF6YGhFtcyifhsLJc45GW4G4poX8Y34EIYlT'
              '63G9vutwNwzistWZZqBm52e-bdUQ7zjmWUGpgkq1GQJZyPz2lvA2bThRqqj94w1'
              'hqHSCXuAc90cN-Th0Ss1QhKesud7dIgaJQngjWWXdlPBqNYe1oCI04E3gcWdYRF'
              'hKey1lkO0WG4VtQxcMADgCrhFVgicpdYyNVqim7Tf31Is_bcQcbFdmumwxWewT-'
              'dC6ur3UAv1A97L567QCwlGDP5DAvH35NmL3w291tUd4q5Vlwz6gsRKqDhUSonIS'
              'boWvvY2x_ndH1oE2hXYin4WL3SyCyp-De8d59C5UhC8KPTvA-3h_UfcPvz6DRDd'
              'NrKyRdKmn9vQQpTP9jMtK7Tks8qKxK4D4pesUmjiNMsVCo8AwJ-9hMd7TXamE9C'
              'ErfDR7jCQONUMetLnitiM7nazCPXkO5tAhJKzQm1o0HvCVptwaa7MksfViK5YPM'
              'cCYc9bD1Uujo-782MXqAzdncu0nGKaJXnIsYB0-tFNiNXjuYFQ8KV5k5-Wnn0kg'
              'a4CkCHlMU2umR19zFsFwFBdVngOYkCEG46KAgdGDqtj8t4d0GY8tcM',
          'e': 'AQAB',
        },
      ],
    };
    final tokenData = 'eyJhbGciOiJSUzI1NiIsImtpZCI6InB1YmxpYzpjNDI0YjY3Yi1mZTI'
        '4LTQ1ZDctYjAxNS1mNzlkYTUwYjViMjEiLCJ0eXAiOiJKV1QifQ.eyJhdWQiOltdLCJjb'
        'GllbnRfaWQiOiJteS1jbGllbnQiLCJleHAiOjE1Nzg1MTU3MzYsImV4dCI6e30sImlhdC'
        'I6MTU3ODUxMjEzNiwiaXNzIjoiaHR0cDovLzEyNy4wLjAuMTo0NDQ0LyIsImp0aSI6IjQ'
        '1NzM4MmQyLTg0NGMtNDM4OS05YWI4LWRmOWRmMjM4ZTdmOSIsIm5iZiI6MTU3ODUxMjEz'
        'Niwic2NwIjpbXSwic3ViIjoibXktY2xpZW50In0.pOkdoCm0dVRg6UECdzpaeTdFyia_n'
        'mJVT1dTNcwVZx0FOFGBQK4EwUV7Ho-UJY3X-UZANSVYtqtjdBxj10AQfqNl3fGD7c4Zo6'
        'A5g0ah0YsWXocLZ7EWgXP2yzgsqT1KhLpffVSFOBfSqRRSov5jjIBor4vMZQqcL00bFbK'
        'VNqnaiWRA5_8vM-pbzBBkB8Ajkzec6Gvexc78CFVCvINlybKakM9GdMtQbI-ejz1PkE2J'
        'H7PYEWdkOhkzjFgFnDLBMi0_Nqwm25qMT6ugGSix7gg4dYIaVsAzD2fgGrAvLRMhM2L7j'
        'q8UN8vmUOd18s8X-cKRQSjgcVBDjPtQyregr_DpW_4LADORN7xGg6LGhnu2jK8CdTOC2Q'
        '_QbDtrABRADSt_qpSRQrCjqWCS8NKx_QMJHMv33jDlLhG-gMJ_lsjOIQJks0zD6xuAbzk'
        'yvr01UhhJ-iiL9kO1nk84-TSIV4PEQItBqDhZYigHeP3J_mnWlWCVj-kcPxQsa3OA8BQV'
        'AZYMA6z-XEdUo1heOrYQJNzQlEo0Je3umDPfiKJdyfCIEwfHRS83XXp-827qYii3rBg1Q'
        'fWEaJfdeHWKYbQ5QT1QGBNlFPfXNStXbr7ikRzYE3zfleuyTPcuG7jMkbai6DcAHdO1ya'
        'Lpwe_UTY-wWF5Z-N9EXcisOVjUf8jqRuI';

    test('verification success with good signature', () async {
      final jwks = JsonWebKeyList.fromJson(jwksData);
      final token = JsonWebToken.parse(tokenData);

      // sanity checks
      expect(token.header, {
        'alg': 'RS256',
        'kid': 'public:c424b67b-fe28-45d7-b015-f79da50b5b21',
        'typ': 'JWT'
      });
      expect(jwks.keys.first.kid, token.header['kid']);
      // actual verification
      expect(await token.verifySignature(jwks), isTrue);
    });

    test('verification fail with bad signature', () async {
      final jwks = JsonWebKeyList.fromJson(jwksData);
      final token = JsonWebToken.parse(tokenData);
      token.signature[0] = 1;
      expect(await token.verifySignature(jwks), isFalse);
    });

    test('verification fail with bad key', () async {
      final jwks = JsonWebKeyList(keys: []);
      final token = JsonWebToken.parse(tokenData);
      expect(await token.verifySignature(jwks), isFalse);
    });
  });

  group('GitHub payload', () {
    test('not a GitHub payload', () {
      final token = JsonWebToken.parse(jwtIoToken);
      expect(() => GitHubJwtPayload(token.payload),
          throwsA(isA<FormatException>()));
    });

    test('parses GitHub example token', () {
      final token = JsonWebToken.parse(_buildToken(
        header: {
          'typ': 'JWT',
          'alg': 'RS256',
          'x5t': 'example-thumbprint',
          'kid': 'example-key-id'
        },
        payload: {
          'jti': 'example-id',
          'sub': 'repo:octo-org/octo-repo:environment:prod',
          'environment': 'prod',
          'aud': 'https://github.com/octo-org',
          'ref': 'refs/heads/main',
          'sha': 'example-sha',
          'repository': 'octo-org/octo-repo',
          'repository_owner': 'octo-org',
          'actor_id': '12',
          'repository_id': '74',
          'repository_owner_id': '65',
          'run_id': 'example-run-id',
          'run_number': '10',
          'run_attempt': '2',
          'actor': 'octocat',
          'workflow': 'example-workflow',
          'head_ref': '',
          'base_ref': '',
          'event_name': 'workflow_dispatch',
          'ref_type': 'branch',
          'job_workflow_ref':
              'octo-org/octo-automation/.github/workflows/oidc.yml@refs/heads/main',
          'iss': 'https://token.actions.githubusercontent.com',
          'nbf': 1632492967, // Friday, September 24, 2021 2:16:07 PM
          'exp': 1632493867, // Friday, September 24, 2021 2:31:07 PM
          'iat': 1632493567, // Friday, September 24, 2021 2:26:07 PM
        },
        signature: [1, 2, 3, 4], // fake signature
      ));

      final p = GitHubJwtPayload(token.payload);
      expect(p.eventName, 'workflow_dispatch');
      expect(p.verifyTimestamps(clock.now()), isFalse);
      expect(p.verifyTimestamps(DateTime.utc(2021, 9, 24, 14, 16, 00)), false);
      expect(p.verifyTimestamps(DateTime.utc(2021, 9, 24, 14, 16, 08)), false);
      expect(p.verifyTimestamps(DateTime.utc(2021, 9, 24, 14, 26, 00)), false);
      expect(p.verifyTimestamps(DateTime.utc(2021, 9, 24, 14, 26, 08)), true);
      expect(p.verifyTimestamps(DateTime.utc(2021, 9, 24, 14, 31, 00)), true);
      expect(p.verifyTimestamps(DateTime.utc(2021, 9, 24, 14, 31, 08)), false);
    });
  });
}

String _buildToken({
  required Map<String, dynamic> header,
  required Map<String, dynamic> payload,
  required List<int> signature,
}) {
  return [
    base64Url.encode(utf8.encode(json.encode(header))).replaceAll('=', ''),
    base64Url.encode(utf8.encode(json.encode(payload))).replaceAll('=', ''),
    base64Url.encode(signature).replaceAll('=', ''),
  ].join('.');
}
