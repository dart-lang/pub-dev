// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:neat_cache/neat_cache.dart';
import 'package:pub_dev/account/agent.dart';
import 'package:pub_dev/service/openid/jwt.dart';

import '../package/models.dart';
import '../shared/datastore.dart';
import '../shared/exceptions.dart';
import '../shared/redis_cache.dart' show cache, EntryPurgeExt;
import '../shared/utils.dart';

import 'auth_provider.dart';
import 'models.dart';
import 'session_cookie.dart' as session_cookie;

export 'auth_provider.dart' show AuthSource;

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
Future<User> requireAuthenticatedUser({AuthSource? source}) async {
  final token = _getBearerToken();
  if (token == null || token.isEmpty) {
    throw AuthenticationException.authenticationRequired();
  }
  final auth =
      await authProvider.tryAuthenticate(source ?? AuthSource.website, token);
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
  return user;
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
  /// Must pass the [isValidUserIdOrServiceAgent] check.
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
}

/// Holds the authenticated Github Action information.
class AuthenticatedGithubAction implements AuthenticatedAgent {
  @override
  String get agentId => KnownAgents.githubActions;

  @override
  final String displayId;

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
    required this.displayId,
    required this.idToken,
    required this.payload,
  });
}

/// Holds the authenticated user information.
class AuthenticatedUser implements AuthenticatedAgent {
  final User user;

  AuthenticatedUser(this.user);

  @override
  String get agentId => user.userId;

  @override
  String get displayId => user.email!;
}

/// Verifies the current bearer token in the request scope and returns the
/// current authenticated user or a service agent with the available data.
Future<AuthenticatedAgent> requireAuthenticatedAgent(
    {AuthSource? source}) async {
  final token = _getBearerToken();
  if (token == null || token.isEmpty) {
    throw AuthenticationException.authenticationRequired();
  }
  final authenticatedService = _tryAuthenticateGithubAction(token);
  if (authenticatedService != null) {
    return authenticatedService;
  } else {
    return AuthenticatedUser(await requireAuthenticatedUser(source: source));
  }
}

AuthenticatedGithubAction? _tryAuthenticateGithubAction(String token) {
  if (!JsonWebToken.looksLikeJWT(token)) {
    return null;
  }
  final idToken = JsonWebToken.tryParse(token);
  if (idToken == null) {
    return null;
  }
  if (!idToken.payload.verifyTimestamps()) {
    return null;
  }
  final payload = GitHubJwtPayload.tryParse(idToken.payload);
  if (payload == null) {
    return null;
  }
  // TODO: check the audience
  // TODO: check signature from JWKS
  // TODO: when everything is verified, return the JWT token.
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

  /// Returns [Like] if [userId] likes [package], otherwise returns `null`.
  Future<Like?> getPackageLikeStatus(String userId, String package) async {
    final key = _db.emptyKey.append(User, id: userId).append(Like, id: package);

    return await _db.lookupOrNull<Like>(key);
  }

  /// Returns a list with [LikeData] of all the packages that the given
  ///  [user] likes.
  Future<List<LikeData>> listPackageLikes(User user) async {
    return (await cache.userPackageLikes(user.userId).get(() async {
      // TODO(zarah): Introduce pagination and/or migrate this to search.
      final query = _db.query<Like>(ancestorKey: user.key)
        ..order('-created')
        ..limit(1000);
      final likes = await query.run().toList();
      return likes.map((Like l) => LikeData.fromModel(l)).toList();
    }))!;
  }

  /// Creates and returns a package like entry for the given [user] and
  /// [package], and increments the 'likes' property on [package].
  Future<Like> likePackage(User user, String package) async {
    final res = await withRetryTransaction<Like>(_db, (tx) async {
      final packageKey = _db.emptyKey.append(Package, id: package);
      final p = await tx.lookupOrNull<Package>(packageKey);
      if (p == null) {
        throw NotFoundException.resource(package);
      }

      final key =
          _db.emptyKey.append(User, id: user.id).append(Like, id: package);
      final oldLike = await tx.lookupOrNull<Like>(key);

      if (oldLike != null) {
        return oldLike;
      }

      p.likes++;
      final newLike = Like()
        ..parentKey = user.key
        ..id = p.id
        ..created = clock.now().toUtc()
        ..packageName = p.name;

      tx.queueMutations(inserts: [p, newLike]);
      return newLike;
    });
    await purgeAccountCache(userId: user.userId);
    return res;
  }

  /// Delete a package like entry for the given [user] and [package] if it
  /// exists, and decrements the 'likes' property on [package].
  Future<void> unlikePackage(User user, String package) async {
    await withRetryTransaction<void>(_db, (tx) async {
      final packageKey = _db.emptyKey.append(Package, id: package);
      final p = await tx.lookupOrNull<Package>(packageKey);
      if (p == null) {
        throw NotFoundException.resource(package);
      }

      final likeKey =
          _db.emptyKey.append(User, id: user.id).append(Like, id: package);
      final like = await tx.lookupOrNull<Like>(likeKey);

      if (like == null) {
        return;
      }

      p.likes--;
      tx.queueMutations(inserts: [p], deletes: [likeKey]);
    });
    await cache.userPackageLikes(user.userId).purge();
  }

  /// Verifies that the access token belongs to the [owner].
  ///
  /// Throws [AuthenticationException] if token cannot be authenticated or the
  /// OAuth userId differs from [owner].
  Future<void> verifyAccessTokenOwnership(
      AuthSource source, String accessToken, User owner) async {
    final auth = await authProvider.tryAuthenticate(source, accessToken);
    if (auth == null) {
      throw AuthenticationException.accessTokenInvalid();
    }
    if (owner.oauthUserId != auth.oauthUserId) {
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
    final user = await requireAuthenticatedUser();
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
