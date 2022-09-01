// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Tags(['presubmit-only'])
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
            'audience': 'https://pub.dev',
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
      final githubData = await fetchGithubOpenIdData();
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
      expect(token.payload.verifyTimestamps(), isTrue);
      final payload = GitHubJwtPayload(token.payload);
      expect(payload.aud, 'https://pub.dev');
      expect(payload.repository, 'dart-lang/pub-dev');
      expect(payload.eventName, anyOf(['pull_request']));
      expect(payload.refType, anyOf(['branch']));
      // example `ref`: `refs/pull/38/merge`
      expect(payload.ref, startsWith('refs/'));
      expect(payload.ref, anyOf(contains('/pull/')));

      // TODO: decide if we need to run checks on these values
      // example `sub`: `repo:dart-lang/pub-dev:pull_request`
      expect(token.payload['sub'], startsWith('repo:dart-lang/pub-dev:'));
      expect(token.payload['repository_visibility'], 'public');
      expect(token.payload['actor'], isNotEmpty);
    },
  );
}
