// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/tool/utils/http.dart';

import 'jwks.dart';

/// Fetches the OpenID configuration and then the JSON Web Key list from GitHub.
Future<JsonWebKeyList> fetchGithubOpenIdWebKeyList() async {
  final list = await cache.githubOpenIdWebKeyList().get(() async {
    final client = httpRetryClient();
    try {
      final configUri = Uri.parse(
          'https://token.actions.githubusercontent.com/.well-known/openid-configuration');
      final rs1 = await client.get(configUri);
      if (rs1.statusCode != 200) {
        throw Exception(
            'Unexpected status code ${rs1.statusCode} while fetching $configUri');
      }
      final map1 = json.decode(rs1.body) as Map<String, dynamic>;
      final jwksUri = Uri.parse(map1['jwks_uri'] as String);
      final rs2 = await client.get(jwksUri);
      if (rs2.statusCode != 200) {
        throw Exception(
            'Unexpected status code ${rs2.statusCode} while fetching $jwksUri');
      }
      final map2 = json.decode(rs2.body) as Map<String, dynamic>;
      return JsonWebKeyList.fromJson(map2);
    } finally {
      client.close();
    }
  });
  return list!;
}
