// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Tags(['presubmit-only'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pub_dev/service/openid/github_openid.dart';
import 'package:pub_dev/service/openid/jwt.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  final actionsIdTokenRequestUrl =
      Platform.environment['ACTIONS_ID_TOKEN_REQUEST_URL'] ?? '';
  final actionsIdTokenRequestToken =
      Platform.environment['ACTIONS_ID_TOKEN_REQUEST_TOKEN'] ?? '';
  final githubRepository = Platform.environment['GITHUB_REPOSITORY'] ?? '';

  // This test only works when running on GitHub Actions with `id-token: write` permissions.
  //
  // This test creates a id-token, not for talking to an external service, but
  // for testing that we are able to verify and validate the token.
  testWithProfile(
    'id-token test',
    skip: actionsIdTokenRequestUrl.isEmpty,
    fn: () async {
      expect(actionsIdTokenRequestUrl, isNotEmpty);
      expect(actionsIdTokenRequestToken, isNotEmpty);

      final uri = Uri.parse(actionsIdTokenRequestUrl);
      final rs = await http.get(
        uri.replace(
          queryParameters: {
            ...uri.queryParameters,
            'audience': 'https://example.com',
          },
        ),
        headers: {
          'User-Agent': 'actions/oidc-client',
          'Authorization': 'Bearer $actionsIdTokenRequestToken',
        },
      );
      if (rs.statusCode != 200) {
        throw StateError('Unexpected response: ${rs.statusCode} ${rs.body}');
      }

      // extract and parse token
      final map = json.decode(rs.body) as Map<String, dynamic>;
      expect(map.keys.toSet(), {'count', 'value'});
      final tokenValue = map['value'] as String;
      final token = JsonWebToken.parse(tokenValue);

      // verify signature
      final githubData = await fetchGitHubOpenIdData();
      expect(await token.verifySignature(githubData.jwks), isTrue);

      // verify headers
      expect(token.header, {
        'typ': 'JWT',
        'alg': 'RS256',
        'x5t': isNotEmpty,
        'kid': isNotEmpty,
      });

      // verify payload
      print(token.payload);
      expect(token.payload.isTimely(threshold: Duration(minutes: 1)), isTrue);
      final payload = GitHubJwtPayload(token.payload);
      expect(token.payload.aud, ['https://example.com']);
      expect(payload.repository, githubRepository);
      expect(payload.eventName, anyOf(['pull_request', 'push', 'schedule']));
      expect(payload.refType, anyOf(['branch']));
      // example `ref`: `refs/pull/38/merge`
      // example `ref`: `refs/head/master`
      expect(payload.ref, startsWith('refs/'));

      // TODO: decide if we need to run checks on these values
      // example `sub`: `repo:dart-lang/pub-dev:pull_request`
      // example `sub`: `repo:isoos/pub-dev:ref:refs/heads/master`
      expect(token.payload['sub'], startsWith('repo:'));
      expect(token.payload['repository_visibility'], 'public');
      expect(token.payload['actor'], isNotEmpty);
    },
  );
}
