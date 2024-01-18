// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../service/openid/gcp_openid.dart';
import '../service/openid/github_openid.dart';
import '../service/openid/jwt.dart';
import '../shared/exceptions.dart';

import 'models.dart';

final _uuidRegExp =
    RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$');

/// Agents identify authenticated users or automated system accounts.
///
/// The format and/or the content prefix identifies the type of the agent.
/// Newer agent identifiers must contain a unique (but maybe opaque)
/// part that corresponds with an internal or external authentication
/// identifier (like email address or repository URL).
///
/// Older identifiers may only describe the type of the agent.
abstract class KnownAgents {
  /// Non-specific agent - only specifies it is from GitHub Actions.
  ///  
  /// Deprecated and should not be used for new audit-log entries.
  /// This value is still present in some older audit-log entries.
  static const genericGithubActions = 'service:github-actions';

  /// Non-specific agent - only specifies it is from GCP Service Account.
  ///
  /// Deprecated and should not be used for new audit-log entries.
  /// This value is still present in some older audit-log entries.
  static const genericGcpServiceAccount = 'service:gcp-service-account';

  // Agent for pub admin actions.
  static const pubSupport = 'support@pub.dev';

  /// Returns an agentId in the format of `service:github-actions:<repositoryOwnerId>/<repositoryId>`
  static String githubActionsAgentId({
    required String repositoryOwnerId,
    required String repositoryId,
  }) {
    return [genericGithubActions, '$repositoryOwnerId/$repositoryId'].join(':');
  }

  /// Returns an agentId in the format of `service:gcp-service-account:<oauthUserId>`
  static String gcpServiceAccountAgentId({
    required String oauthUserId,
  }) {
    return [genericGcpServiceAccount, oauthUserId].join(':');
  }

  static const _agentIdPrefixes = [
    '$genericGithubActions:',
    '$genericGcpServiceAccount:',
  ];

  static const _nonSpecificAgentIds = <String>{
    genericGithubActions,
    genericGcpServiceAccount,
    pubSupport,
  };
}

/// Whether the [userId] is valid-looking,
/// without namespace or other special value.
bool looksLikeUserId(String userId) {
  return _uuidRegExp.matchAsPrefix(userId) != null;
}

/// Whether the [agent] is a valid-looking identifier.
bool looksLikeServiceAgent(String agent) {
  return KnownAgents._nonSpecificAgentIds.contains(agent) ||
      KnownAgents._agentIdPrefixes.any((prefix) => agent.startsWith(prefix));
}

/// Whether the [agent] is a valid-looking actor.
bool looksLikeUserIdOrServiceAgent(String agent) =>
    looksLikeUserId(agent) || looksLikeServiceAgent(agent);

void checkUserIdParam(String value) {
  InvalidInputException.check(looksLikeUserId(value), 'Invalid "userId".');
}

void checkAgentParam(String value) {
  InvalidInputException.check(
      looksLikeUserIdOrServiceAgent(value), 'Invalid "agent".');
}

/// An [AuthenticatedAgent] represents an _agent_ (a user or automated service)
/// that has been authenticated and which may be allowed to operate on specific
/// resources on pub.dev
///
/// Examples:
///  * A user using the `pub` client.
///  * A user using the `pub.dev` UI.
///  * A GCP service account may authenticate using an OIDC `id_token`,
///  * A Github Action may authenticate using an OIDC `id_token`.
abstract class AuthenticatedAgent {
  /// The unique identifier of the agent.
  /// Must pass the [looksLikeUserIdOrServiceAgent] check.
  ///
  /// Examples:
  ///  * For a regular user we use `User.userId`.
  ///  * For automated publishing we use [KnownAgents] identifiers.
  String get agentId;

  /// The formatted identfier of the agent, which may be publicly visible
  /// in logs and audit records.
  ///
  /// Examples:
  ///  * For a regular user we display their `email`.
  ///  * For a service account we display a description.
  ///  * For automated publishing we display the service and the origin trigger.
  String get displayId;

  /// The email address of the agent (if there is any).
  String? get email;
}

/// Holds the authenticated Github Action information.
///
/// The [agentId] has the following format: `service:github-actions:<repositoryOwnerId>/<repositoryId>`
class AuthenticatedGithubAction implements AuthenticatedAgent {
  @override
  late final agentId = KnownAgents.githubActionsAgentId(
    repositoryOwnerId: payload.repositoryOwnerId,
    repositoryId: payload.repositoryId,
  );

  @override
  String get displayId => KnownAgents.genericGithubActions;

  /// OIDC `id_token` the request was authenticated with.
  ///
  /// The [agentId] of an [AuthenticatedAgent] have always been authenticated using the [idToken].
  /// Hence, claims on the [idToken] may be used to determine authorization of a request.
  ///
  /// The audience, expiration and signature must be verified by the
  /// auth flow, but backend code can use the content to verify the
  /// pub-specific scope of the token.
  final JsonWebToken idToken;

  /// The parsed, GitHub-specific JWT payload.
  final GitHubJwtPayload payload;

  AuthenticatedGithubAction({
    required this.idToken,
    required this.payload,
  }) {
    _checkRepository(payload.repository);
  }

  @override
  String? get email => null;
}

void _checkRepository(String repository) {
  InvalidInputException.check(repository.trim().isNotEmpty,
      'The JWT from GitHub must have a non-empty `repository`.');
  final parts = repository.split('/');
  InvalidInputException.check(
      parts.length == 2, 'The JWT from GitHub must have a valid `repository`.');
  InvalidInputException.check(parts.every((e) => e.isNotEmpty),
      'The JWT from GitHub must have a valid `repository`.');
}

/// Holds the authenticated Google Cloud Service account information.
///
/// The [agentId] has the following format: `service:gcp-service-account:<oauthUserId>`
class AuthenticatedGcpServiceAccount implements AuthenticatedAgent {
  @override
  late final agentId =
      KnownAgents.gcpServiceAccountAgentId(oauthUserId: oauthUserId);

  @override
  String get displayId => email;

  /// OIDC `id_token` the request was authenticated with.
  ///
  /// The [agentId] of an [AuthenticatedAgent] have always been authenticated using the [idToken].
  /// Hence, claims on the [idToken] may be used to determine authorization of a request.
  ///
  /// The audience, expiration and signature must be verified by the
  /// auth flow, but backend code can use the content to verify the
  /// pub-specific scope of the token.
  final JsonWebToken idToken;

  /// The parsed, Google Cloud-specific JWT payload.
  final GcpServiceAccountJwtPayload payload;

  AuthenticatedGcpServiceAccount({
    required this.idToken,
    required this.payload,
  });

  @override
  String get email => payload.email;
  String get oauthUserId => payload.sub;
  String get audience => idToken.payload.aud.single;
}

/// Holds the authenticated user information.
class AuthenticatedUser implements AuthenticatedAgent {
  final User user;
  final String audience;

  AuthenticatedUser(
    this.user, {
    required this.audience,
  });

  @override
  String get agentId => user.userId;

  @override
  String get displayId => user.email!;

  String get userId => user.userId;
  @override
  String? get email => user.email;
  String? get oauthUserId => user.oauthUserId;
}
