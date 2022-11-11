// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_dev/service/openid/github_openid.dart';
import 'package:pub_dev/service/openid/jwt.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';
import 'jwt_test.dart';

void main() {
  testWithProfile('GitHub key list', fn: () async {
    final data = await fetchGithubOpenIdData();
    expect(data.provider.issuer, 'https://token.actions.githubusercontent.com');
    expect(data.provider.claimsSupported,
        containsAll(GitHubJwtPayload.requiredClaims));
    expect(data.provider.idTokenSigningAlgValuesSupported, [
      'RS256',
    ]);
    expect(data.jwks.keys, isNotEmpty);
    final rsaKeys = data.jwks.keys.where((key) => key.kty == 'RSA').toList();
    expect(rsaKeys, isNotEmpty);
    final firstRsaKey = rsaKeys.first;
    expect(firstRsaKey.alg, 'RS256');
    expect(firstRsaKey.n, isNotEmpty);
    expect(firstRsaKey.e, isNotEmpty);
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

      final pl = token.payload;
      expect(pl.isTimely(), isFalse);

      // before and after the nbf, exp, and iat timestamps
      expect(pl.isTimely(now: DateTime.utc(2021, 9, 24, 14, 16, 00)), false);
      expect(pl.isTimely(now: DateTime.utc(2021, 9, 24, 14, 16, 08)), false);
      expect(pl.isTimely(now: DateTime.utc(2021, 9, 24, 14, 26, 00)), false);
      expect(pl.isTimely(now: DateTime.utc(2021, 9, 24, 14, 26, 08)), true);
      expect(pl.isTimely(now: DateTime.utc(2021, 9, 24, 14, 31, 00)), true);
      expect(pl.isTimely(now: DateTime.utc(2021, 9, 24, 14, 31, 08)), false);

      // slightly off of the nbf-exp range, but accepted with the threshold
      expect(
          pl.isTimely(
              now: DateTime.utc(2021, 9, 24, 14, 26, 00),
              threshold: Duration(seconds: 10)),
          true);
      expect(
          pl.isTimely(
              now: DateTime.utc(2021, 9, 24, 14, 31, 08),
              threshold: Duration(seconds: 10)),
          true);

      final p = GitHubJwtPayload(token.payload);
      expect(p.eventName, 'workflow_dispatch');
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
