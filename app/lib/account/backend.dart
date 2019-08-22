// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:neat_cache/neat_cache.dart';
import 'package:retry/retry.dart';
import 'package:uuid/uuid.dart';

import '../shared/configuration.dart';
import '../shared/exceptions.dart';

import 'auth_provider.dart';
import 'google_oauth2.dart' show GoogleOauth2AuthProvider;
import 'models.dart';

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
User get authenticatedUser => ss.lookup(#_authenticated_user) as User;

/// Calls [fn] with the currently authenticated user as an argument.
///
/// If no user is currently authenticated, this will throw an
/// `AuthenticationException` exception.
Future<R> withAuthenticatedUser<R>(Future<R> fn(User user)) async {
  if (authenticatedUser == null) {
    throw AuthenticationException.authenticationRequired();
  }
  return await fn(authenticatedUser);
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

  /// Returns the e-mail address of the [userId].
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

  /// Return the e-mail addresses of the [userIds].
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
      throw Exception('More than one User exists for e-mail: $email');
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
  /// a new one. When the authenticated e-mail of the user changes, the email
  /// field will be updated to the latest one.
  Future<User> authenticateWithBearerToken(String token) async {
    final auth = await _authProvider.tryAuthenticate(token);
    if (auth == null) {
      return null;
    }
    final user = await _lookupOrCreateUserByOauthUserId(auth);
    if (user.isDeleted) {
      // This can only happen if the Google account had been deleted and then
      // later re-enabled. We don't automatically re-enable such User accounts,
      // as the new account might be a new owner on the same e-mail address
      // (e.g. non-Google e-mails on GSuite).
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

      // We've probably found a non-valid User state, it is better to fail the
      // authentication. Let's investigate it before allowing the creation of
      // the new User.
      if (usersWithEmail.isNotEmpty) {
        final userIds = usersWithEmail.map((u) => u.userId).join(', ');
        _logger.severe(
            'Probably User state violation while looking for ${auth.email}: $userIds');
        throw StateError('User state violation: $userIds');
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

    // update user if e-mail has been changed
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
}
