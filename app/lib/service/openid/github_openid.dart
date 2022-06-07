// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/tool/utils/http.dart';

import 'openid_models.dart';

/// Fetches the OpenID configuration and then the JSON Web Key list from GitHub.
Future<OpenIdData> fetchGithubOpenIdData() async {
  final githubUrl =
      'https://token.actions.githubusercontent.com/.well-known/openid-configuration';
  final list = await cache
      .openIdData(configurationUrl: githubUrl)
      .get(() => _fetchOpenIdData(configurationUrl: githubUrl));
  return list!;
}

/// Fetches the OpenID configuration and then the JSON Web Key list from the given endpoint.
Future<OpenIdData> _fetchOpenIdData({
  required String configurationUrl,
}) async {
  final client = httpRetryClient();
  try {
    final configUri = Uri.parse(configurationUrl);
    final providerRs = await client.get(configUri);
    if (providerRs.statusCode != 200) {
      throw Exception(
          'Unexpected status code ${providerRs.statusCode} while fetching $configUri');
    }
    final providerData = json.decode(providerRs.body) as Map<String, dynamic>;
    final provider = OpenIdProvider.fromJson(providerData);
    final jwksUri = Uri.parse(provider.jwksUri);
    final jwksRs = await client.get(jwksUri);
    if (jwksRs.statusCode != 200) {
      throw Exception(
          'Unexpected status code ${jwksRs.statusCode} while fetching $jwksUri');
    }
    final jwksData = json.decode(jwksRs.body) as Map<String, dynamic>;
    return OpenIdData(
      provider: provider,
      jwks: JsonWebKeyList.fromJson(jwksData),
    );
  } finally {
    client.close();
  }
}
