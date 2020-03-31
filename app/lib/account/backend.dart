// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:neat_cache/neat_cache.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/utils.dart';

import '../shared/datastore_helper.dart';
import '../shared/exceptions.dart';
import '../shared/redis_cache.dart' show cache;

import 'auth_provider.dart';
import 'models.dart';

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

/// Sets the active authenticated user.
void registerAuthenticatedUser(User user) =>
    ss.register(#_authenticated_user, user);

/// The active authenticated user.
User get _authenticatedUser => ss.lookup(#_authenticated_user) as User;

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
UserSessionData get userSessionData =>
    ss.lookup(#_userSessionData) as UserSessionData;

/// Sets the active user's search preference object.
void registerSearchPreference(SearchPreference value) =>
    ss.register(#_searchPreference, value);

/// The active search preference object.
SearchPreference get searchPreference =>
    ss.lookup(#_searchPreference) as SearchPreference;

/// Returns the current authenticated user.
///
/// If no user is currently authenticated, this will throw an
/// `AuthenticationException` exception.
Future<User> requireAuthenticatedUser() async {
  if (_authenticatedUser == null) {
    throw AuthenticationException.authenticationRequired();
  }
  return _authenticatedUser;
}

/// Represents the backend for the account handling and authentication.
class AccountBackend {
  final DatastoreDB _db;
  final _emailCache = Cache(Cache.inMemoryCacheProvider(1000))
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8);

  AccountBackend(this._db);

  /// Returns the `User` entry for the [userId] or null if it does not exists.
  Future<User> lookupUserById(String userId) async {
    return (await lookupUsersById(<String>[userId])).single;
  }

  /// Returns the list of `User` entries for the corresponding id in [userIds].
  ///
  /// Returns null in the positions where a [User] entry was missing.
  Future<List<User>> lookupUsersById(List<String> userIds) async {
    final keys =
        userIds.map((id) => _db.emptyKey.append(User, id: id)).toList();
    return await _db.lookup<User>(keys);
  }

  /// Returns the email address of the [userId].
  ///
  /// Uses in-memory cache to store entries locally for up to 10 minutes.
  Future<String> getEmailOfUserId(String userId) async {
    final entry = _emailCache[userId];
    String email = await entry.get();
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
  Future<List<String>> getEmailsOfUserIds(List<String> userIds) async {
    final result = <String>[];
    for (String userId in userIds) {
      result.add(await getEmailOfUserId(userId));
    }
    return result;
  }

  /// Returns the `User` entry for the [email] or null if it does not exists.
  ///
  /// Throws Exception if more then one `User` entry exists.
  Future<User> lookupUserByEmail(String email) async {
    email = email.toLowerCase();
    final query = _db.query<User>()..filter('email =', email);
    final list = await query.run().toList();
    if (list.length > 1) {
      throw Exception('More than one User exists for email: $email');
    }
    if (list.length == 1) {
      return list.single;
    }
    return null;
  }

  /// Returns the `User` entry for the [email] or creates a new one if it does
  /// not exists.
  ///
  /// Throws Exception if more then one `User` entry exists.
  Future<User> lookupOrCreateUserByEmail(String email) async {
    email = email.toLowerCase();
    User user = await lookupUserByEmail(email);
    if (user != null) {
      return user;
    }
    user = User()
      ..parentKey = _db.emptyKey
      ..id = createUuid()
      ..email = email
      ..created = DateTime.now().toUtc()
      ..isDeletedFlag = false;

    await _db.commit(inserts: [user]);
    return user;
  }

  /// Returns [Like] if [userId] likes [package], otherwise returns `null`.
  Future<Like> getPackageLikeStatus(String userId, String package) async {
    final key = _db.emptyKey.append(User, id: userId).append(Like, id: package);

    return await _db.lookupValue<Like>(key, orElse: () => null);
  }

  /// Returns a list with [LikeData] of all the packages that the given
  ///  [user] likes.
  Future<List<LikeData>> listPackageLikes(User user) async {
    return await cache.userPackageLikes(user.userId).get(() async {
      // TODO(zarah): Introduce pagination and/or migrate this to search.
      final query = _db.query<Like>(ancestorKey: user.key)..limit(1000);
      final likes = await query.run().toList();
      return likes.map((Like l) => LikeData.fromModel(l)).toList();
    });
  }

  /// Creates and returns a package like entry for the given [user] and
  /// [package], and increments the 'likes' property on [package].
  Future<Like> likePackage(User user, String package) async {
    final res = await withRetryTransaction<Like>(_db, (tx) async {
      final packageKey = _db.emptyKey.append(Package, id: package);
      final p = await tx.lookupValue<Package>(packageKey, orElse: () => null);
      if (p == null) {
        throw NotFoundException.resource(package);
      }

      final key =
          _db.emptyKey.append(User, id: user.id).append(Like, id: package);
      final oldLike = await tx.lookupValue<Like>(key, orElse: () => null);

      if (oldLike != null) {
        return oldLike;
      }

      p.likes++;
      final newLike = Like()
        ..parentKey = user.key
        ..id = p.id
        ..created = DateTime.now().toUtc()
        ..packageName = p.name;

      tx.queueMutations(inserts: [p, newLike]);
      return newLike;
    });
    await cache.userPackageLikes(user.userId).purge();
    return res;
  }

  /// Delete a package like entry for the given [user] and [package] if it
  /// exists, and decrements the 'likes' property on [package].
  Future<void> unlikePackage(User user, String package) async {
    await withRetryTransaction<void>(_db, (tx) async {
      final packageKey = _db.emptyKey.append(Package, id: package);
      final p = await tx.lookupValue<Package>(packageKey, orElse: () => null);
      if (p == null) {
        throw NotFoundException.resource(package);
      }

      final likeKey =
          _db.emptyKey.append(User, id: user.id).append(Like, id: package);
      final like = await tx.lookupValue<Like>(likeKey, orElse: () => null);

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
      String accessToken, User owner) async {
    final auth = await authProvider.tryAuthenticate(accessToken);
    if (auth == null) {
      throw AuthenticationException.accessTokenInvalid();
    }
    if (owner.oauthUserId != auth.oauthUserId) {
      throw AuthenticationException.accessTokenMissmatch();
    }
  }

  /// Authenticates with bearer [token] and returns an `User` object.
  ///
  /// The method returns null if [token] is invalid.
  ///
  /// The [token] may be an oauth2 `access_token` or an openid-connect
  /// `id_token` (signed JWT).
  ///
  /// When no associated User entry exists in Datastore, this method will create
  /// a new one. When the authenticated email of the user changes, the email
  /// field will be updated to the latest one.
  Future<User> authenticateWithBearerToken(String token) async {
    final auth = await authProvider.tryAuthenticate(token);
    if (auth == null) {
      return null;
    }
    final user = await _lookupOrCreateUserByOauthUserId(auth);
    if (user.isDeleted) {
      // This can only happen if we have a data inconsistency in the datastore.
      _logger
          .severe('Login on deleted account: ${user.userId} / ${user.email}');
      throw StateError('Account had been deleted, login is not allowed.');
    }
    return user;
  }

  Future<User> _lookupUserByOauthUserId(String oauthUserId) async {
    // TODO: This should be cached.
    final oauthUserMapping = await _db.lookupValue<OAuthUserID>(
      _db.emptyKey.append(OAuthUserID, id: oauthUserId),
      orElse: () => null,
    );
    if (oauthUserMapping == null) {
      return null;
    }
    return await _db.lookupValue<User>(
      oauthUserMapping.userIdKey,
      orElse: () => throw StateError(
        'Incomplete OAuth userId mapping missing '
        'User(`${oauthUserMapping.userId}`) referenced by '
        '`${oauthUserMapping.id}`.',
      ),
    );
  }

  Future<User> _lookupOrCreateUserByOauthUserId(AuthResult auth) async {
    ArgumentError.checkNotNull(auth, 'auth');
    if (auth.oauthUserId == null) {
      throw StateError('Authenticated user ${auth.email} without userId.');
    }

    final emptyKey = _db.emptyKey;

    // Attempt to lookup the user, the common case is that the user exists.
    // If the user exists, it's always cheaper to lookup the user outside a
    // transaction.
    final user = await _lookupUserByOauthUserId(auth.oauthUserId);
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
          oauthUserMapping.userIdKey,
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
        ..created = DateTime.now().toUtc()
        ..isDeletedFlag = false;

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
    @required String name,
    @required String imageUrl,
  }) async {
    final user = await requireAuthenticatedUser();
    final now = DateTime.now().toUtc();
    final session = UserSession()
      ..id = createUuid()
      ..userIdKey = user.key
      ..email = user.email
      ..name = name
      ..imageUrl = imageUrl
      ..created = now
      ..expires = now.add(Duration(days: 14));
    await _db.commit(inserts: [session]);
    return UserSessionData.fromModel(session);
  }

  /// Returns the user session associated with the [sessionId] or null if it
  /// does not exists.
  Future<UserSessionData> lookupSession(String sessionId) async {
    ArgumentError.checkNotNull(sessionId, 'sessionId');

    final cacheEntry = cache.userSessionData(sessionId);
    final cached = await cacheEntry.get();
    if (cached != null && DateTime.now().isBefore(cached.expires)) {
      return cached;
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

    // TODO: decide about extending the expiration time (maybe asynchronously)

    final data = UserSessionData.fromModel(session);
    cacheEntry.set(data);
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
    final now = DateTime.now().toUtc();
    // account for possible clock skew
    final ts = now.subtract(Duration(minutes: 15));
    final query = _db.query<UserSession>()..filter('expires <', ts);
    await for (final s in query.run()) {
      await invalidateSession(s.sessionId);
    }
  }

  // TODO: expire all sessions of a given user from datastore and cache
}
