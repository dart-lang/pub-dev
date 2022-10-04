// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/tool/utils/http.dart';

import 'jwt.dart';
import 'openid_models.dart';

final _logger = Logger('github_openid');

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

/// Parsed payload with the payload values GitHub sends with the token.
class GitHubJwtPayload {
  /// user controllable URL identifying the intended audience
  final String aud;

  /// repository for which the action is running
  final String repository;

  /// owner of the repository
  final String repositoryOwner;

  /// name of the event that triggered the workflow
  final String eventName;

  /// git reference (e.g. branch name or tag name)
  final String ref;

  /// the kind of git reference given (e.g. "branch")
  final String refType;

  /// actor/initiator of the GitHub action
  final String? actor;

  /// name of the environment used by the job
  final String? environment;

  /// the commit hash
  final String? sha;

  /// The URL used as the `iss` property of JWT payloads.
  static const githubIssuerUrl = 'https://token.actions.githubusercontent.com';

  static const _requiredClaims = <String>{
    // generic claims
    'iat',
    'nbf',
    'exp',
    'iss',
    'aud',
    // github-specific claims
    'repository',
    'repository_owner',
    'event_name',
    'ref',
    'ref_type',
  };

  GitHubJwtPayload._(Map<String, dynamic> map)
      : aud = _parseAsString(map, 'aud'),
        repository = _parseAsString(map, 'repository'),
        repositoryOwner = _parseAsString(map, 'repository_owner'),
        eventName = _parseAsString(map, 'event_name'),
        ref = _parseAsString(map, 'ref'),
        refType = _parseAsString(map, 'ref_type'),
        actor = _parseAsStringOrNull(map, 'actor'),
        environment = _parseAsStringOrNull(map, 'environment'),
        sha = _parseAsStringOrNull(map, 'sha');

  factory GitHubJwtPayload(JwtPayload payload) {
    final missing = _requiredClaims.difference(payload.keys.toSet()).sorted();
    if (missing.isNotEmpty) {
      throw FormatException(
          'JWT from Github is missing following claims: ${missing.map((k) => '`$k`').join(', ')}.');
    }
    return GitHubJwtPayload._(payload);
  }

  static GitHubJwtPayload? tryParse(JwtPayload payload) {
    try {
      return GitHubJwtPayload(payload);
    } on FormatException {
      return null;
    } catch (e, st) {
      _logger.warning('Unexpected JWT parser exception.', e, st);
      return null;
    }
  }
}

String _parseAsString(Map<String, dynamic> map, String key) {
  final value = _parseAsStringOrNull(map, key);
  if (value == null) {
    throw FormatException('Missing value for `$key`.');
  } else {
    return value;
  }
}

String? _parseAsStringOrNull(Map<String, dynamic> map, String key) {
  final value = map[key];
  if (value == null) {
    return null;
  }
  if (value is String) {
    return value;
  }
  throw FormatException('Unexpected value for `$key`: `$value`.');
}
