// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:neat_cache/neat_cache.dart';
import 'package:pub_dev/admin/models.dart';

import '../audit/models.dart';
import '../frontend/request_context.dart';
import '../service/openid/gcp_openid.dart';
import '../service/openid/github_openid.dart';
import '../shared/configuration.dart';
import '../shared/datastore.dart';
import '../shared/exceptions.dart';
import '../shared/redis_cache.dart' show cache, EntryPurgeExt;
import '../shared/utils.dart';

import 'agent.dart';
import 'auth_provider.dart';
import 'models.dart';

final _logger = Logger('account.backend');

/// The duration or extension of a client session.
const _sessionDuration = Duration(days: 30);

/// Sets the auth provider service.
void registerAuthProvider(AuthProvider authProvider) =>
    ss.register(#_authProvider, authProvider);

/// The active auth provider service.
AuthProvider get authProvider => ss.lookup(#_authProvider) as AuthProvider;

/// Sets the account backend service.
void registerAccountBackend(AccountBackend backend) =>
    ss.register(#_accountBackend, backend);

/// The active account backend service.
AccountBackend get accountBackend =>
    ss.lookup(#_accountBackend) as AccountBackend;

void _registerBearerToken(String token) => ss.register(#_bearerToken, token);
String? _getBearerToken() => ss.lookup(#_bearerToken) as String?;

/// Verifies the current bearer in the request scope and returns the
/// current authenticated user.
///
/// When the token authentication fails, the method throws
/// [AuthenticationException].
///
/// The token may be an oauth2 `access_token` or an openid-connect
/// `id_token` (signed JWT).
///
/// When no associated User entry exists in Datastore, this method will create
/// a new one. When the authenticated email of the user changes, the email
/// field will be updated to the latest one.
Future<AuthenticatedUser> requireAuthenticatedWebUser() async {
  if (requestContext.clientSessionCookieStatus.isPresent) {
    final sessionUser = await accountBackend.tryAuthenticateWebSessionUser(
      sessionId: requestContext.clientSessionCookieStatus.sessionId,
      hasStrictCookie: requestContext.clientSessionCookieStatus.isStrict,
      csrfTokenInHeader: requestContext.csrfToken,
      requiresStrictCookie: true,
    );
    if (sessionUser != null) {
      return sessionUser;
    } else {
      throw AuthenticationException.failed('Session expired.');
    }
  }
  throw AuthenticationException.failed();
}

/// Require that the incoming request is authorized by an administrator with
/// the given [permission].
///
/// Throws [AuthorizationException] if it doesn't have the permission.
Future<AuthenticatedGcpServiceAccount> requireAuthenticatedAdmin(
    AdminPermission permission) async {
  final agent = await _requireAuthenticatedAgent();
  if (agent is AuthenticatedGcpServiceAccount) {
    final admin = activeConfiguration.admins!.firstWhereOrNull(
        (a) => a.oauthUserId == agent.oauthUserId && a.email == agent.email);
    final isAdmin = admin != null && admin.permissions.contains(permission);
    if (!isAdmin) {
      _logger.warning(
          'Authenticated user (${agent.displayId}) is trying to access unauthorized admin APIs.');
      throw AuthorizationException.userIsNotAdminForPubSite();
    }
    return agent;
  } else {
    throw AuthenticationException.tokenInvalid('not a GCP service account');
  }
}

/// Verifies the current bearer token in the request scope and returns the
/// current authenticated user or a service agent with the available data.
///
/// For users it verifies that the audience is for the pub client.
Future<AuthenticatedAgent> requireAuthenticatedClient() async {
  final agent = await _requireAuthenticatedAgent();
  if (agent is AuthenticatedUser &&
      agent.audience != activeConfiguration.pubClientAudience) {
    throw AuthenticationException.tokenInvalid(
        'token audience "${agent.audience}" does not match expected value');
  }
  return agent;
}

/// Verifies the current bearer token in the request scope and returns the
/// current authenticated user or a service agent with the available data.
Future<AuthenticatedAgent> _requireAuthenticatedAgent() async {
  final token = _getBearerToken();
  if (token == null || token.isEmpty) {
    throw AuthenticationException.authenticationRequired();
  }

  final authenticatedServiceAgent = await _tryAuthenticateServiceAgent(token);
  if (authenticatedServiceAgent != null) {
    return authenticatedServiceAgent;
  }

  final auth = await authProvider.tryAuthenticateAsUser(token);
  if (auth == null) {
    throw AuthenticationException.failed();
  }

  final user = await accountBackend._lookupOrCreateUserByOauthUserId(auth);
  if (user == null) {
    throw AuthenticationException.failed();
  }
  if (user.isBlocked || user.isModerated) {
    throw AuthorizationException.blocked();
  }
  if (user.isDeleted) {
    // This may only happen if we have a data inconsistency in the datastore.
    _logger.severe(
      'Login on deleted account: ${user.userId} / ${user.email}',
      AuthorizationException.blocked(),
      StackTrace.current,
    );
    throw AuthorizationException.blocked();
  }
  return AuthenticatedUser(user, audience: auth.audience);
}

Future<AuthenticatedAgent?> _tryAuthenticateServiceAgent(String token) async {
  final idToken = await authProvider.tryAuthenticateAsServiceToken(token);
  if (idToken == null) {
    return null;
  }
  if (idToken.payload.aud.length != 1 ||
      idToken.payload.aud.single !=
          activeConfiguration.externalServiceAudience) {
    throw AssertionError(
        'authProvider.tryAuthenticateAsServiceToken should not return a parsed token with audience mismatch.');
  }

  if (idToken.payload.iss == GitHubJwtPayload.issuerUrl) {
    final payload = GitHubJwtPayload.tryParse(idToken.payload);
    if (payload == null) {
      throw AuthenticationException.tokenInvalid('unable to parse payload');
    }
    return AuthenticatedGithubAction(
      idToken: idToken,
      payload: payload,
    );
  }

  if (idToken.payload.iss == GcpServiceAccountJwtPayload.issuerUrl) {
    final payload = GcpServiceAccountJwtPayload.tryParse(idToken.payload);
    if (payload == null) {
      throw AuthenticationException.tokenInvalid('unable to parse payload');
    }
    return AuthenticatedGcpServiceAccount(
      idToken: idToken,
      payload: payload,
    );
  }

  return null;
}

/// Represents the backend for the account handling and authentication.
class AccountBackend {
  final DatastoreDB _db;
  final _emailCache = Cache(Cache.inMemoryCacheProvider(1000))
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8);

  AccountBackend(this._db);

  /// Returns the `User` entry for the [userId] or null if it does not exists.
  Future<User?> lookupUserById(String userId) async {
    checkUserIdParam(userId);
    return await _db.lookupOrNull<User>(_db.emptyKey.append(User, id: userId));
  }

  /// Returns the list of `User` entries for the corresponding id in [userIds].
  ///
  /// Returns null in the positions where a [User] entry was missing.
  Future<List<User?>> lookupUsersById(List<String> userIds) async {
    for (final userId in userIds) {
      checkUserIdParam(userId);
    }
    final keys =
        userIds.map((id) => _db.emptyKey.append(User, id: id)).toList();
    return await _db.lookup<User>(keys);
  }

  /// Returns the email address of the [userId].
  ///
  /// Uses in-memory cache to store entries locally for up to 10 minutes.
  Future<String?> getEmailOfUserId(String userId) async {
    checkUserIdParam(userId);
    final entry = _emailCache[userId];
    var email = await entry.get();
    if (email != null) {
      return email;
    }
    final user = await lookupUserById(userId);
    if (user == null) return null;
    email = user.email;
    await entry.set(email);
    return email;
  }

  /// Return the email addresses of the [userIds].
  ///
  /// Returns null in the positions where a [User] entry was missing.
  ///
  /// Uses in-memory cache to store entries locally for up to 10 minutes.
  Future<List<String?>> getEmailsOfUserIds(List<String> userIds) async {
    final result = <String?>[];
    for (String userId in userIds) {
      result.add(await getEmailOfUserId(userId));
    }
    return result;
  }

  /// Returns the list of `User` entries for the [email] or empty list if it
  /// does not exists.
  Future<List<User>> lookupUsersByEmail(String email) async {
    email = email.toLowerCase();
    final query = _db.query<User>()..filter('email =', email);
    return await query.run().toList();
  }

  /// Returns the single `User` entity for the [email].
  @visibleForTesting
  Future<User> lookupUserByEmail(String email) async {
    final users = await lookupUsersByEmail(email);
    return users.single;
  }

  /// Stores the bearer [token] in a new scope.
  ///
  /// The method returns with the response of [fn].
  Future<R> withBearerToken<R>(String? token, Future<R> Function() fn) async {
    if (token == null) {
      return await fn();
    } else {
      return await ss.fork(() async {
        _registerBearerToken(token);
        return await fn();
      }) as R;
    }
  }

  Future<User?> _lookupUserByOauthUserId(String oauthUserId) async {
    // TODO: This should be cached.
    final oauthUserMapping = await _db.lookupOrNull<OAuthUserID>(
        _db.emptyKey.append(OAuthUserID, id: oauthUserId));
    if (oauthUserMapping == null) {
      return null;
    }
    return await _db.lookupValue<User>(
      oauthUserMapping.userIdKey!,
      orElse: () => throw StateError(
        'Incomplete OAuth userId mapping missing '
        'User(`${oauthUserMapping.userId}`) referenced by '
        '`${oauthUserMapping.id}`.',
      ),
    );
  }

  Future<User> _updateUserEmail(User user, String email) async {
    return await withRetryTransaction(_db, (tx) async {
      final u = await tx.lookupValue<User>(user.key);
      if (u.email != email) {
        u.email = email;
        tx.insert(u);
      }
      return u;
    });
  }

  /// Returns an [User] entity for the authenticated service account.
  /// This method should be used only by admin agents.
  Future<User> userForServiceAccount(
      AuthenticatedGcpServiceAccount authenticatedAgent) async {
    final user = await _lookupOrCreateUserByOauthUserId(AuthResult(
      oauthUserId: authenticatedAgent.oauthUserId,
      email: authenticatedAgent.email,
      audience: authenticatedAgent.audience,
    ));
    if (user == null) {
      throw AuthenticationException.failed();
    }
    return user;
  }

  /// Returns a [User] entity that matches the [auth] results:
  /// - If there is an entity with the OauthUserID, it will be returned.
  /// - If there is an entity with the email but not OAuthUserID (old account
  ///   that hasn't been used for a while), we will fill the User.oauthUserId
  ///   field and return the entity.
  /// Otherwise (e.g. multiple entities with the same email, or data inconsistency)
  /// the method will return `null`.
  Future<User?> _lookupOrCreateUserByOauthUserId(AuthResult auth) async {
    final emptyKey = _db.emptyKey;

    // Attempt to lookup the user, the common case is that the user exists.
    // If the user exists, it's always cheaper to lookup the user outside a
    // transaction.
    final user = await _lookupUserByOauthUserId(auth.oauthUserId);
    if (user != null && user.email != auth.email && auth.email.isNotEmpty) {
      return await _updateUserEmail(user, auth.email);
    }
    if (user != null) {
      return user;
    }

    return await withRetryTransaction<User>(_db, (tx) async {
      final oauthUserIdKey = emptyKey.append(
        OAuthUserID,
        id: auth.oauthUserId,
      );

      // Check that the user doesn't exist in this transaction.
      final oauthUserMapping =
          await tx.lookupOrNull<OAuthUserID>(oauthUserIdKey);
      if (oauthUserMapping != null) {
        // If the user does exist we can just return it.
        return await tx.lookupValue<User>(
          oauthUserMapping.userIdKey!,
          orElse: () => throw StateError(
            'Incomplete OAuth userId mapping missing '
            'User(`${oauthUserMapping.userId}`) referenced by '
            '`${oauthUserMapping.id}`.',
          ),
        );
      }

      // Check pre-migrated User with existing email.
      // Notice, that we're doing this outside the transaction, but these are
      // legacy users, we should avoid creation of new users with only emails
      // as this lookup is eventually consistent.
      final usersWithEmail = await (_db.query<User>()
            ..filter('email =', auth.email))
          .run()
          .toList();
      if (usersWithEmail.length == 1 &&
          usersWithEmail.single.oauthUserId == null &&
          !usersWithEmail.single.isDeleted) {
        final user = await tx.lookupValue<User>(usersWithEmail.single.key);
        if (user.oauthUserId == auth.oauthUserId) {
          throw StateError(
            'Incomplete user oauthid mapping OAuthUserId entity is missing '
            'for  User(`${user.userId}`)',
          );
        }
        if (user.oauthUserId == null) {
          // We've found a single pre-migrated, non-deleted User with empty
          // `oauthUserId` field: need to create OAuthUserID for it.
          user.oauthUserId = auth.oauthUserId;
          tx.insert(user);
          tx.insert(
            OAuthUserID()
              ..parentKey = emptyKey
              ..id = auth.oauthUserId
              ..userIdKey = user.key,
          );
          return user;
        }
        _logger.info(
          'Reusing email from User(${user.userId}) as user has a different oauth2 user_id',
        );
      }

      // Create new user with oauth2 user_id mapping
      final user = User.init()
        ..parentKey = emptyKey
        ..id = createUuid()
        ..oauthUserId = auth.oauthUserId
        ..email = auth.email
        ..created = clock.now().toUtc();

      tx.insert(user);
      tx.insert(
        OAuthUserID()
          ..parentKey = emptyKey
          ..id = auth.oauthUserId
          ..userIdKey = user.key,
      );

      return user;
    });
  }

  /// Updates an existing or creates a new client session for pre-authorization
  /// secrets and post-authorization user information.
  Future<UserSession> createOrUpdateClientSession({
    String? sessionId,
  }) async {
    final now = clock.now().toUtc();
    final oldSession =
        sessionId == null ? null : await lookupValidUserSession(sessionId);
    // try to update old session first
    if (oldSession != null) {
      final rs = await withRetryTransaction(_db, (tx) async {
        final session = await tx.lookupOrNull<UserSession>(oldSession.key);
        if (session == null) {
          return null;
        }
        session.expires = now.add(_sessionDuration);
        tx.insert(session);
        return session;
      });
      if (rs != null) return rs;
    }

    // in the absence of a valid existing session, create a new one
    final session = UserSession.init()
      ..created = now
      ..expires = now.add(_sessionDuration);
    await _db.commit(inserts: [session]);
    return session;
  }

  /// Updates the [UserSession] entity with the authenticated profile information.
  ///
  /// Returns the new [SessionData] that is also populated in the cache.
  Future<SessionData> updateClientSessionWithProfile({
    required String sessionId,
    required AuthResult profile,
  }) async {
    final now = clock.now().toUtc();
    final info = await authProvider.callTokenInfoWithAccessToken(
        accessToken: profile.accessToken ?? '');
    final user = await _lookupOrCreateUserByOauthUserId(profile);
    if (user == null || user.isBlocked || user.isModerated || user.isDeleted) {
      throw AuthenticationException.failed();
    }
    final data = await withRetryTransaction(_db, (tx) async {
      final session = await tx.lookupOrNull<UserSession>(
          _db.emptyKey.append(UserSession, id: sessionId));
      if (session == null || session.isExpired()) {
        throw AuthenticationException.failed('Session has been expired.');
      }
      final oldUserId = session.userId;
      if (oldUserId != null &&
          oldUserId.isNotEmpty &&
          oldUserId != user.userId) {
        // expire old session
        tx.delete(session.key);
        await cache.userSessionData(sessionId).purgeAndRepeat();

        // create a new session
        final newSession = UserSession.init()
          ..userId = user.userId
          ..email = user.email
          ..name = profile.name
          ..imageUrl = profile.imageUrl
          ..accessToken = profile.accessToken
          ..grantedScopes = info.scope
          ..created = now
          ..authenticatedAt = now
          ..expires = now.add(_sessionDuration);
        tx.insert(newSession);
        return SessionData.fromModel(newSession);
      } else {
        // only update the current one
        session
          ..userId = user.userId
          ..email = user.email
          ..name = profile.name
          ..imageUrl = profile.imageUrl
          ..accessToken = profile.accessToken
          ..grantedScopes = info.scope
          ..authenticatedAt = now
          ..expires = now.add(_sessionDuration);
        tx.insert(session);
        return SessionData.fromModel(session);
      }
    });
    await cache.userSessionData(data.sessionId).set(data);
    return data;
  }

  /// Tries to authenticate the web user with the session cookies and
  /// - if present and if required - the CSRF token.
  Future<AuthenticatedUser?> tryAuthenticateWebSessionUser({
    required String? sessionId,
    required bool hasStrictCookie,
    required String? csrfTokenInHeader,
    required bool requiresStrictCookie,
  }) async {
    if (sessionId == null) {
      return null;
    }
    if (requiresStrictCookie && !hasStrictCookie) {
      return null;
    }

    final session = await getSessionData(sessionId);
    if (session == null || !session.isAuthenticated) {
      return null;
    }

    // assuming that strict mode is always used with CSRF token verification
    if (requiresStrictCookie) {
      if (csrfTokenInHeader == null || csrfTokenInHeader != session.csrfToken) {
        return null;
      }
    }

    final user = await lookupUserById(session.userId!);
    if (user == null || user.isBlocked || user.isModerated || user.isDeleted) {
      return null;
    }
    return AuthenticatedUser(user,
        audience: activeConfiguration.pubServerAudience!);
  }

  /// Returns the user session associated with the [sessionId] or null if it
  /// does not exists.
  ///
  /// First it tries to load the session from cache, then, if it is not in cache,
  /// it will try to load it from Datastore.
  Future<SessionData?> getSessionData(String sessionId) async {
    final cacheEntry = cache.userSessionData(sessionId);
    final cached = await cacheEntry.get();
    if (cached != null) {
      return cached.isExpired ? null : cached;
    }

    final session = await lookupValidUserSession(sessionId);
    if (session == null) {
      return null;
    }

    final data = SessionData.fromModel(session);
    await cacheEntry.set(data);
    return data;
  }

  /// Returns the [UserSession] associated with the [sessionId] or
  /// `null` if it does not exists.
  ///
  /// Deletes the session entry if it has already expired and
  /// clears the related cache too.
  Future<UserSession?> lookupValidUserSession(String sessionId) async {
    final key = _db.emptyKey.append(UserSession, id: sessionId);
    final session = await _db.lookupOrNull<UserSession>(key);
    if (session == null) {
      return null;
    }
    if (session.isExpired()) {
      await _db.commit(deletes: [key]);
      await cache.userSessionData(sessionId).purge();
      return null;
    }
    return session;
  }

  /// Removes the session data from the Datastore and from cache.
  Future<void> invalidateUserSession(String sessionId) async {
    final key = _db.emptyKey.append(UserSession, id: sessionId);
    try {
      await _db.commit(deletes: [key]);
    } catch (_) {
      // ignore if the entity has been already deleted concurrently
    }
    await cache.userSessionData(sessionId).purge();
  }

  /// Scans Datastore for all sessions the user has, and invalidates
  /// them all (by deleting the Datastore entry and purging the cache).
  Future<void> invalidateAllUserSessions(String userId) async {
    final query = _db.query<UserSession>()..filter('userId =', userId);
    await for (final session in query.run()) {
      await invalidateUserSession(session.sessionId);
    }
  }

  /// Removes the expired sessions from Datastore.
  Future<void> deleteExpiredSessions() async {
    final now = clock.now().toUtc();
    // account for possible clock skew
    final ts = now.subtract(Duration(minutes: 15));
    final query = _db.query<UserSession>()..filter('expires <', ts);
    final count = await _db.deleteWithQuery(query);
    _logger.info('Deleted ${count.deleted} UserSession entries.');
  }

  /// Updates the blocked status of a user.
  Future<void> updateBlockedFlag(String userId, bool isBlocked) async {
    var expireSessions = false;
    await withRetryTransaction(_db, (tx) async {
      final user =
          await tx.lookupOrNull<User>(_db.emptyKey.append(User, id: userId));
      if (user == null) throw NotFoundException.resource('User:$userId');

      if (user.isBlocked == isBlocked) return;
      user.isBlocked = isBlocked;
      tx.insert(user);
      expireSessions = isBlocked;
    });

    if (expireSessions) {
      await _expireAllSessions(userId);
    }
  }

  /// Updates the moderated status of a user.
  ///
  /// Expires all existing user sessions.
  Future<void> updateModeratedFlag(
    String userId,
    bool isModerated, {
    required Key? refCaseKey,
    required String? message,
  }) async {
    await withRetryTransaction(_db, (tx) async {
      final user =
          await tx.lookupOrNull<User>(_db.emptyKey.append(User, id: userId));
      if (user == null) throw NotFoundException.resource('User:$userId');

      user.updateIsModerated(isModerated: isModerated);
      tx.insert(user);

      if (refCaseKey != null) {
        final mc = await tx.lookupValue<ModerationCase>(refCaseKey);
        mc.addActionLogEntry(
          ModerationSubject.user(user.email!).fqn,
          isModerated ? ModerationAction.apply : ModerationAction.revert,
          message,
        );
        tx.insert(mc);
      }
    });
    await _expireAllSessions(userId);
    await purgeAccountCache(userId: userId);
  }

  /// Retrieves a list of all uploader events that happened between [begin] and
  /// [end].
  Stream<AuditLogRecord> getUploadEvents({DateTime? begin, DateTime? end}) {
    final query = _db.query<AuditLogRecord>();
    query.filter('kind =', AuditLogRecordKind.packagePublished);
    if (begin != null) {
      query.filter('created >=', begin);
    }
    if (end != null) {
      query.filter('created <', end);
    }
    return query.run();
  }

  // expire all sessions of a given user from datastore and cache
  Future<void> _expireAllSessions(String userId) async {
    final query = _db.query<UserSession>()..filter('userId =', userId);
    final sessionsToDelete = await query.run().toList();
    for (final session in sessionsToDelete) {
      await _db.commit(deletes: [session.key]);
      await cache.userSessionData(session.sessionId).purge();
    }
  }
}

/// Purge [cache] entries for given [userId].
Future<void> purgeAccountCache({
  required String userId,
}) async {
  await Future.wait([
    cache.userPackageLikes(userId).purgeAndRepeat(),
    cache.publisherPage(userId).purgeAndRepeat(),
  ]);
}
