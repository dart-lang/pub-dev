// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/shared/redis_cache.dart';

import 'jwt.dart';
import 'openid_models.dart';
import 'openid_utils.dart';

final _logger = Logger('github_openid');

/// Fetches the OpenID configuration and then the JSON Web Key list from GitHub.
Future<OpenIdData> fetchGithubOpenIdData() async {
  final githubUrl =
      'https://token.actions.githubusercontent.com/.well-known/openid-configuration';
  final list = await cache
      .openIdData(configurationUrl: githubUrl)
      .get(() => fetchOpenIdData(configurationUrl: githubUrl));
  return list!;
}

/// Parsed payload values GitHub sends with the token.
class GitHubJwtPayload {
  /// repository for which the action is running
  final String repository;

  /// the unique identifier of [repository]
  final String repositoryId;

  /// owner of the repository
  final String repositoryOwner;

  /// the unique identifier of [repositoryOwner]
  final String repositoryOwnerId;

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

  /// RunId of the Github Action that this token comes from.
  final String? runId;

  /// The URL used as the `iss` property of JWT payloads.
  static const issuerUrl = 'https://token.actions.githubusercontent.com';

  @visibleForTesting
  static const requiredClaims = <String>{
    // generic claims
    'iat',
    'nbf',
    'exp',
    'iss',
    'aud',
    // github-specific claims
    'repository',
    'repository_id',
    'repository_owner',
    'repository_owner_id',
    'event_name',
    'ref',
    'ref_type',
    'run_id',
  };

  GitHubJwtPayload._(Map<String, dynamic> map)
      : repository = parseAsString(map, 'repository'),
        repositoryOwner = parseAsString(map, 'repository_owner'),
        repositoryId = parseAsString(map, 'repository_id'),
        repositoryOwnerId = parseAsString(map, 'repository_owner_id'),
        eventName = parseAsString(map, 'event_name'),
        ref = parseAsString(map, 'ref'),
        refType = parseAsString(map, 'ref_type'),
        actor = parseAsStringOrNull(map, 'actor'),
        environment = parseAsStringOrNull(map, 'environment'),
        sha = parseAsStringOrNull(map, 'sha'),
        runId = parseAsStringOrNull(map, 'run_id');

  factory GitHubJwtPayload(JwtPayload payload) {
    final missing = requiredClaims.difference(payload.keys.toSet()).sorted();
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
