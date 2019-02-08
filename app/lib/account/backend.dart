// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/oauth2/v2.dart' as oauth2_v2;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pub_server/repository.dart' show UnauthorizedAccessException;
import 'package:retry/retry.dart';
import 'package:uuid/uuid.dart';

import '../frontend/models.dart' show PackageVersion;

import 'models.dart';

final _logger = new Logger('pub.account.backend');
final _uuid = Uuid();

/// The pub client's OAuth2 identifier.
final _pubAudience = '818368855108-8grd2eg9tj9f38os6f1urbcvsq399u8n.apps.'
    'googleusercontent.com';

/// Sets the account backend service.
void registerAccountBackend(AccountBackend backend) =>
    ss.register(#_accountBackend, backend);

/// The active account backend service.
AccountBackend get accountBackend =>
    ss.lookup(#_accountBackend) as AccountBackend;

/// Sets the active authenticated user.
void registerAuthenticatedUser(AuthenticatedUser user) =>
    ss.register(#_authenticated_user, user);

/// The active authenticated user.
AuthenticatedUser get authenticatedUser =>
    ss.lookup(#_authenticated_user) as AuthenticatedUser;

/// Calls [fn] with the currently authenticated user as an argument.
///
/// If no user is currently authenticated, this will throw an
/// `UnauthorizedAccess` exception.
Future<R> withAuthenticatedUser<R>(Future<R> fn(AuthenticatedUser user)) async {
  if (authenticatedUser == null) {
    throw UnauthorizedAccessException('No active user.');
  }
  return await fn(authenticatedUser);
}

/// Represents the backend for the account handling and authentication.
class AccountBackend {
  final DatastoreDB _db;
  final _defaultAuthProvider = GoogleOauth2AuthProvider(_pubAudience);

  AccountBackend(this._db);

  Future close() async {
    await _defaultAuthProvider.close();
  }

  /// Returns the `User` entry for the [userId] or null if it does not exists.
  Future<User> lookupUserById(String userId) async {
    final key = _db.emptyKey.append(User, id: userId);
    return (await _db.lookup<User>([key])).single;
  }

  /// Authenticates [accessToken] and returns an `AuthenticatedUser` object.
  ///
  /// The method returns null if the access token is invalid.
  ///
  /// When no associated User entry exists in Datastore, this method will create
  /// a new one. When the authenticated e-mail of the user changes, the email
  /// field will be updated to the latest one.
  Future<AuthenticatedUser> authenticateWithAccessToken(
      String accessToken) async {
    final auth = await _defaultAuthProvider.tryAuthenticate(accessToken);
    if (auth == null) {
      return null;
    }
    final user = await _lookupOrCreateUserByOauthUserId(auth);
    return AuthenticatedUser(user.userId, user.email);
  }

  Future<User> _lookupOrCreateUserByOauthUserId(AuthResult auth) async {
    final mappingKey = _db.emptyKey.append(User, id: auth.oauthUserId);

    final user = await retry(() async {
      // Check existing mapping.
      final mapping = (await _db.lookup<OAuthUserID>([mappingKey])).single;
      if (mapping != null) {
        final user = (await _db.lookup<User>([mapping.userIdKey])).single;
        // TODO: we should probably have some kind of consistency mitigation
        if (user == null) {
          throw AssertionError('Incomplete OAuth userId mapping: '
              'missing User (`${mapping.userId}`) referenced by `${mapping.id}`.');
        }
        return user;
      }

      // Check pre-migrated User with existing email.
      final usersWithEmail = await (_db.query<User>()
            ..filter('email =', auth.email))
          .run()
          .toList();
      // TODO: trigger consistency mitigation if more than one email exists
      if (usersWithEmail.length == 1 &&
          usersWithEmail.single.oauthUserId == null) {
        // We've found a single pre-migrated User with empty oauthUserId: need
        // to create OAuthUserID for it.
        return await _db.withTransaction((tx) async {
          final user =
              (await tx.lookup<User>([usersWithEmail.single.key])).single;
          final newMapping = OAuthUserID()
            ..parentKey = _db.emptyKey
            ..id = auth.oauthUserId
            ..userIdKey = user.key;
          user.oauthUserId = auth.oauthUserId;
          tx.queueMutations(inserts: [user, newMapping]);
          await tx.commit();
        }) as User;
      }

      // Sanity check: query the first use of the e-mail address.
      // Existing uploaders should be pre-migrated, and should be handled by the
      // code above. A new user should not have a previously existing package
      // uploaded.
      DateTime created = DateTime.now().toUtc();
      final uploadedVersions = _db.query<PackageVersion>()
        ..filter('uploaderEmail =', auth.email);
      int uploadedCount = 0;
      await for (var version in uploadedVersions.run()) {
        uploadedCount++;
        if (created.isAfter(version.created)) {
          created = version.created;
        }
      }
      if (uploadedCount != null) {
        _logger.warning(
            'Pre-migration inconsistent for ${auth.email}, creating new User.');
      }

      final newUser = User()
        ..parentKey = _db.emptyKey
        ..id = _uuid.v4().toString()
        ..oauthUserId = auth.oauthUserId
        ..email = auth.email
        ..created = created;

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

class AuthenticatedUser {
  final String userId;
  final String email;

  AuthenticatedUser(this.userId, this.email);
}

class AuthResult {
  final String oauthUserId;
  final String email;

  AuthResult(this.oauthUserId, this.email);
}

/// Authenticates access tokens.
abstract class AuthProvider {
  /// Checks the [accessToken] and returns a verified user information.
  ///
  /// Returns null on any error, or if the token is expired, or the user is not
  /// verified.
  Future<AuthResult> tryAuthenticate(String accessToken);

  /// Close resources.
  Future close();
}

class GoogleOauth2AuthProvider extends AuthProvider {
  final String _audience;
  http.Client _httpClient;
  oauth2_v2.Oauth2Api _oauthApi;

  GoogleOauth2AuthProvider(this._audience) {
    _httpClient = http.Client();
    _oauthApi = oauth2_v2.Oauth2Api(_httpClient);
  }

  @override
  Future<AuthResult> tryAuthenticate(String accessToken) async {
    if (accessToken == null) {
      return null;
    }
    oauth2_v2.Tokeninfo info;
    try {
      info = await _oauthApi.tokeninfo(accessToken: accessToken);
      if (info == null) {
        return null;
      }

      if (info.audience != _audience) {
        _logger.warning('OAuth2 access attempted with invalid audience, '
            'for email: "${info.email}", audience: "${info.audience}"');
        return null;
      }

      if (info.expiresIn == null ||
          info.expiresIn <= 0 ||
          info.verifiedEmail != true ||
          info.email == null ||
          info.email.isEmpty) {
        _logger.warning('OAuth2 token info invalid: ${info.toJson()}');
        return null;
      }

      return AuthResult(info.userId, info.email);
    } on oauth2_v2.ApiRequestError catch (e) {
      _logger.info('Access denied for OAuth2 access token.', e);
    } catch (e, st) {
      _logger.warning('OAuth2 access token lookup failed.', e, st);
    }
    return null;
  }

  @override
  Future close() async {
    _httpClient.close();
  }
}
