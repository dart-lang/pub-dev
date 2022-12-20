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
import 'session_cookie.dart' as session_cookie;

/// The name of the session cookie.
///
/// Cookies prefixed '__Host-' must:
///  * be set by a HTTPS response,
///  * not feature a 'Domain' directive, and,
///  * have 'Path=/' directive.
/// Hence, such a cookie cannot have been set by another website or an
/// HTTP proxy for this website.
const pubSessionCookieName = '__Host-pub-sid';
final _logger = Logger('account.backend');

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

/// Sets the active user's session data object.
void registerUserSessionData(UserSessionData value) =>
    ss.register(#_userSessionData, value);

/// The active user's session data.
///
/// **Warning:** the existence of a session MAY ONLY be used for authenticating
/// a user for the purpose of generating HTML output served from a GET request.
///
/// This may **NOT** to authenticate mutations, API interactions, not even GET
/// APIs that return JSON. Whenever possible we require the OpenID-Connect
/// `id_token` be present as `Authentication: Bearer <id_token>` header instead.
/// Such scheme does not work for `GET` requests that serve content to the
/// browser, and hence, we employ session cookies for this purpose.
UserSessionData? get userSessionData =>
    ss.lookup(#_userSessionData) as UserSessionData?;

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
  final agent = await _requireAuthenticatedAgent();
  if (agent is AuthenticatedUser) {
    if (agent.audience != activeConfiguration.pubSiteAudience) {
      throw AuthenticationException.tokenInvalid(
          'token audience "${agent.audience}" does not match expected value');
    }

    return agent;
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
    final isAdmin = await accountBackend.hasAdminPermission(
      oauthUserId: agent.oauthUserId,
      email: agent.email,
      permission: permission,
    );
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
Future<AuthenticatedAgent> requireAuthenticatedClient() async {
  final agent = await _requireAuthenticatedAgent();
  if (agent is AuthenticatedUser &&
      agent.audience != activeConfiguration.pubClientAudience) {
    throw AuthenticationException.tokenInvalid(
        'token audience "${agent.audience}" does not match expected value');
  }
  return agent;
}

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
  if (user.isBlocked) {
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
        'authProvider.tryAuthenticateAsServiceToken should not return a parsed token with audience missmatch.');
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

  /// Returns `true` if the user is authorized by an administrator with the given [permission].
  Future<bool> hasAdminPermission({
    required String? oauthUserId,
    required String? email,
    required AdminPermission permission,
  }) async {
    if (oauthUserId == null || email == null) {
      return false;
    }
    final admin = activeConfiguration.admins!.firstWhereOrNull(
        (a) => a.oauthUserId == oauthUserId && a.email == email);
    return admin != null && admin.permissions.contains(permission);
  }

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

  /// Verifies that the access token belongs to the [owner].
  ///
  /// Throws [AuthenticationException] if token cannot be authenticated or the
  /// OAuth userId differs from [owner].
  Future<void> verifyAccessTokenOwnership(
      String accessToken, User owner) async {
    final auth = await authProvider.tryAuthenticateAsUser(accessToken);
    if (auth == null) {
      throw AuthenticationException.accessTokenInvalid();
    }
    if (owner.oauthUserId != auth.oauthUserId) {
      throw AuthenticationException.accessTokenMissmatch();
    }
    if (auth.audience != activeConfiguration.pubSiteAudience) {
      throw AuthenticationException.accessTokenMissmatch();
    }
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

  // TODO: refactor consent backend to accept non-User agents
  // TODO: remove this after consent backend refactor
  Future<User?> userForServiceAccount(
      AuthenticatedGcpServiceAccount authenticatedAgent) async {
    return await _lookupOrCreateUserByOauthUserId(AuthResult(
      oauthUserId: authenticatedAgent.oauthUserId,
      email: authenticatedAgent.email,
      audience: authenticatedAgent.audience,
    ));
  }

  /// Returns a [User] entity that matches the [auth] results:
  /// - If there is an entity with the OauthUserID, it will be returned.
  /// - If there is an entity with the email but not OAuthUserID (old account
  ///   that hasn't been used for a while), we will fill the User.oauthUserId
  ///   field and return the entity.
  /// Otherwise (e.g. multiple entities with the same email, or data inconsistency)
  /// the method will return `null`.
  Future<User?> _lookupOrCreateUserByOauthUserId(AuthResult auth) async {
    ArgumentError.checkNotNull(auth, 'auth');
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
      final user = User()
        ..parentKey = emptyKey
        ..id = createUuid()
        ..oauthUserId = auth.oauthUserId
        ..email = auth.email
        ..created = clock.now().toUtc()
        ..isBlocked = false
        ..isDeleted = false;

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

  /// Creates a new session for the current authenticated user and returns the
  /// new session data.
  ///
  /// The [UserSessionData.sessionId] is a secret that will be stored in a
  /// secure cookie. Presence of this `sessionId` in a cookie, can only be used
  /// to authorize user specific content to be embedded in HTML pages (such pages
  /// must have `Cache-Control: private`, and may not be cached in server-side).
  /// JSON APIs whether fetching data or updating data cannot be authorized with
  /// a cookie carrying the `sessionId`.
  Future<UserSessionData> createNewSession({
    required String name,
    required String imageUrl,
  }) async {
    final user = await requireAuthenticatedWebUser();
    final now = clock.now().toUtc();
    final session = UserSession()
      ..id = createUuid()
      ..userId = user.userId
      ..email = user.email
      ..name = name
      ..imageUrl = imageUrl
      ..created = now
      ..expires = now.add(Duration(days: 14));
    await _db.commit(inserts: [session]);
    return UserSessionData.fromModel(session);
  }

  /// Parse [cookieString] and lookup session if cookie value is available.
  ///
  /// Returns `null` if the session does not exists or any issue is present
  Future<UserSessionData?> parseAndLookupSessionCookie(
      String? cookieString) async {
    try {
      final sessionId = session_cookie.parseSessionCookie(cookieString);
      if (sessionId != null && sessionId.isNotEmpty) {
        return await _lookupSession(sessionId);
      }
    } catch (e, st) {
      _logger.severe('Unable to process session cookie.', e, st);
    }
    return null;
  }

  /// Returns the user session associated with the [sessionId] or null if it
  /// does not exists.
  Future<UserSessionData?> _lookupSession(String sessionId) async {
    ArgumentError.checkNotNull(sessionId, 'sessionId');

    final cacheEntry = cache.userSessionData(sessionId);
    final cached = await cacheEntry.get();
    if (cached != null) {
      return cached.isExpired ? null : cached;
    }

    final key = _db.emptyKey.append(UserSession, id: sessionId);
    final list = await _db.lookup<UserSession>([key]);
    final session = list.single;
    if (session == null) {
      return null;
    }

    if (session.isExpired()) {
      await _db.commit(deletes: [key]);
      await cacheEntry.purge();
      return null;
    }

    final data = UserSessionData.fromModel(session);
    await cacheEntry.set(data);
    return data;
  }

  /// Removes the session data from the Datastore and from cache.
  Future<void> invalidateSession(String sessionId) async {
    final key = _db.emptyKey.append(UserSession, id: sessionId);
    await _db.commit(deletes: [key]);
    await cache.userSessionData(sessionId).purge();
  }

  /// Removes the expired sessions from Datastore and Redis cache.
  Future<void> deleteObsoleteSessions() async {
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
