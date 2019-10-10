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
import 'package:retry/retry.dart';
import 'package:uuid/uuid.dart';

import '../shared/configuration.dart';
import '../shared/exceptions.dart';
import '../shared/redis_cache.dart' show cache;

import 'auth_provider.dart';
import 'google_oauth2.dart' show GoogleOauth2AuthProvider;
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
final _uuid = Uuid();

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
  final AuthProvider _authProvider;
  final _emailCache = Cache(Cache.inMemoryCacheProvider(1000))
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8);

  AccountBackend(this._db, {AuthProvider authProvider})
      : _authProvider = authProvider ??
            GoogleOauth2AuthProvider(
              activeConfiguration.pubSiteAudience,
              <String>[
                activeConfiguration.pubClientAudience,
                activeConfiguration.pubSiteAudience,
                activeConfiguration.adminAudience,
              ],
            );

  Future close() async {
    await _authProvider.close();
  }

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
    final id = _uuid.v4().toString();
    user = User()
      ..parentKey = _db.emptyKey
      ..id = id
      ..email = email
      ..created = DateTime.now().toUtc()
      ..isDeletedFlag = false;

    await _db.commit(inserts: [user]);
    return user;
  }

  /// Returns the URL of the authorization endpoint used by pub site.
  String siteAuthorizationUrl(String redirectUrl, String state) {
    return _authProvider.authorizationUrl(redirectUrl, state);
  }

  /// Validates the authorization [code] and returns the access token.
  ///
  /// Returns null on any error, or if the token is expired, or the code is not
  /// verified.
  Future<String> siteAuthCodeToAccessToken(String redirectUrl, String code) =>
      _authProvider.authCodeToAccessToken(redirectUrl, code);

  /// Authenticates with bearer [token] and returns an `AuthenticatedUser`
  /// object.
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
    final auth = await _authProvider.tryAuthenticate(token);
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

  Future<User> _lookupOrCreateUserByOauthUserId(AuthResult auth) async {
    if (auth.oauthUserId == null) {
      throw StateError('Authenticated user ${auth.email} without userId.');
    }
    final mappingKey = _db.emptyKey.append(OAuthUserID, id: auth.oauthUserId);

    final user = await retry(() async {
      // Check existing mapping.
      final mapping = (await _db.lookup<OAuthUserID>([mappingKey])).single;
      if (mapping != null) {
        final user = (await _db.lookup<User>([mapping.userIdKey])).single;
        // TODO: we should probably have some kind of consistency mitigation
        if (user == null) {
          throw StateError('Incomplete OAuth userId mapping: '
              'missing User (`${mapping.userId}`) referenced by `${mapping.id}`.');
        }
        return user;
      }

      // Check pre-migrated User with existing email.
      final usersWithEmail = await (_db.query<User>()
            ..filter('email =', auth.email))
          .run()
          .toList();
      if (usersWithEmail.length == 1 &&
          usersWithEmail.single.oauthUserId == null &&
          !usersWithEmail.single.isDeleted) {
        // We've found a single pre-migrated, non-deleted User with empty
        // `oauthUserId` field: need to create OAuthUserID for it.
        final updatedUser = await _db.withTransaction((tx) async {
          final user =
              (await tx.lookup<User>([usersWithEmail.single.key])).single;
          final newMapping = OAuthUserID()
            ..parentKey = _db.emptyKey
            ..id = auth.oauthUserId
            ..userIdKey = user.key;
          user.oauthUserId = auth.oauthUserId;
          tx.queueMutations(inserts: [user, newMapping]);
          await tx.commit();
          return user;
        }) as User;
        return updatedUser;
      }

      // Create new user with oauth2 user_id mapping
      final newUser = User()
        ..parentKey = _db.emptyKey
        ..id = _uuid.v4().toString()
        ..oauthUserId = auth.oauthUserId
        ..email = auth.email
        ..created = DateTime.now().toUtc()
        ..isDeletedFlag = false;

      final newMapping = OAuthUserID()
        ..parentKey = _db.emptyKey
        ..id = auth.oauthUserId
        ..userIdKey = newUser.key;

      await _db.commit(inserts: [newUser, newMapping]);
      return newUser;
    });

    // update user if email has been changed
    if (user.email != auth.email) {
      return await _db.withTransaction((tx) async {
        final u = (await _db.lookup<User>([user.key])).single;
        u.email = auth.email;
        tx.queueMutations(inserts: [u]);
        await tx.commit();
        return u;
      }) as User;
    }

    return user;
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
  Future<UserSessionData> createNewSession({@required String imageUrl}) async {
    final user = await requireAuthenticatedUser();
    final now = DateTime.now().toUtc();
    final sessionId = _uuid.v4().toString();
    final session = UserSession()
      ..id = sessionId
      ..userIdKey = user.key
      ..email = user.email
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
  Future invalidateSession(String sessionId) async {
    final key = _db.emptyKey.append(UserSession, id: sessionId);
    await _db.commit(deletes: [key]);
    await cache.userSessionData(sessionId).purge();
  }

  /// Removes the expired sessions from Datastore and Redis cache.
  Future deleteObsoleteSessions() async {
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
