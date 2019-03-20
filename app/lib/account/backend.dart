// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/oauth2/v2.dart' as oauth2_v2;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pub_server/repository.dart' show UnauthorizedAccessException;
import 'package:simple_cache/simple_cache.dart';
import 'package:retry/retry.dart';
import 'package:uuid/uuid.dart';

import '../frontend/models.dart' show Secret, SecretKey;
import '../shared/configuration.dart';
import '../shared/email.dart' show isValidEmail;

import 'models.dart';

final _logger = new Logger('pub.account.backend');
final _uuid = Uuid();

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
  final AuthProvider _authProvider;
  final _emailCache = Cache(Cache.inMemoryCacheProvider(1000))
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8);

  AccountBackend(this._db)
      : _authProvider = GoogleOauth2AuthProvider(
          activeConfiguration.pubSiteAudience,
          <String>[
            activeConfiguration.pubClientAudience,
            activeConfiguration.pubSiteAudience,
          ],
          _db,
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

  /// Returns the `User` entry for the [email] or creates a new one if it does
  /// not exists.
  ///
  /// Throws Exception if more then one `User` entry exists.
  Future<User> lookupOrCreateUserByEmail(String email) async {
    email = email.toLowerCase();
    final query = _db.query<User>()..filter('email =', email);
    final list = await query.run().toList();
    if (list.length > 1) {
      throw Exception('More than one User exists for e-mail: $email');
    }
    if (list.length == 1) {
      return list.single;
    }
    final id = _uuid.v4().toString();
    final user = User()
      ..parentKey = dbService.emptyKey
      ..id = id
      ..email = email
      ..created = DateTime.now().toUtc();

    await _db.commit(inserts: [user]);
    return user;
  }

  /// Returns the URL of the authorization endpoint used by pub site.
  String siteAuthorizationUrl(String state) {
    return _authProvider.authorizationUrl(state);
  }

  /// Validates the authorization [code] and returns the access token.
  ///
  /// Returns null on any error, or if the token is expired, or the code is not
  /// verified.
  Future<String> siteAuthCodeToAccessToken(String code) =>
      _authProvider.authCodeToAccessToken(code);

  /// Authenticates [accessToken] and returns an `AuthenticatedUser` object.
  ///
  /// The method returns null if the access token is invalid.
  ///
  /// When no associated User entry exists in Datastore, this method will create
  /// a new one. When the authenticated e-mail of the user changes, the email
  /// field will be updated to the latest one.
  Future<AuthenticatedUser> authenticateWithAccessToken(
      String accessToken) async {
    final auth = await _authProvider.tryAuthenticate(accessToken);
    if (auth == null) {
      return null;
    }
    final user = await _lookupOrCreateUserByOauthUserId(auth);
    return AuthenticatedUser(user.userId, user.email);
  }

  Future<User> _lookupOrCreateUserByOauthUserId(AuthResult auth) async {
    final mappingKey = _db.emptyKey.append(OAuthUserID, id: auth.oauthUserId);

    final user = await retry(() async {
      // Handle legacy logins that don't have 'openid' scope
      if (auth.oauthUserId != null) {
        // Check existing mapping.
        final mapping = (await _db.lookup<OAuthUserID>([mappingKey])).single;
        if (mapping != null) {
          final user = (await _db.lookup<User>([mapping.userIdKey])).single;
          // TODO: we should probably have some kind of consistency mitigation
          if (user == null) {
            throw Exception('Incomplete OAuth userId mapping: '
                'missing User (`${mapping.userId}`) referenced by `${mapping.id}`.');
          }
          return user;
        }
      }

      // Check pre-migrated User with existing email.
      final usersWithEmail = await (_db.query<User>()
            ..filter('email =', auth.email))
          .run()
          .toList();
      // TODO: trigger consistency mitigation if more than one email exists
      if (usersWithEmail.length == 1 &&
          usersWithEmail.single.oauthUserId == null) {
        // Handle legacy logins that don't have 'openid' scope, and thus, no
        // user_id (oauthUserId), these can't be upgraded yet.
        if (auth.oauthUserId == null) {
          return usersWithEmail.single;
        }

        // We've found a single pre-migrated User with empty oauthUserId: need
        // to create OAuthUserID for it.
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

      // Create new user without oauth2 user_id, to support legacy clients
      // that don't have 'openid' scope, and thus, no user_id.
      if (auth.oauthUserId == null) {
        final newUser = User()
          ..parentKey = _db.emptyKey
          ..id = _uuid.v4().toString()
          ..oauthUserId = null
          ..email = auth.email
          ..created = DateTime.now().toUtc();
        await _db.commit(inserts: [newUser]);
        return newUser;
      }

      // Create new user with oauth2 user_id mapping
      final newUser = User()
        ..parentKey = _db.emptyKey
        ..id = _uuid.v4().toString()
        ..oauthUserId = auth.oauthUserId
        ..email = auth.email
        ..created = DateTime.now().toUtc();

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
  /// Returns the URL of the authorization endpoint.
  String authorizationUrl(String state);

  /// Validates the authorization [code], and returns the access token.
  ///
  /// Returns null on any error, or if the token is expired, or the code is not
  /// verified.
  Future<String> authCodeToAccessToken(String code);

  /// Checks the [accessToken] and returns a verified user information.
  ///
  /// Returns null on any error, or if the token is expired, or the user is not
  /// verified.
  Future<AuthResult> tryAuthenticate(String accessToken);

  /// Close resources.
  Future close();
}

/// Provides OAuth2-based authentication through Google accounts.
class GoogleOauth2AuthProvider extends AuthProvider {
  final String _siteAudience;
  final List<String> _trustedAudiences;
  final DatastoreDB _db;
  http.Client _httpClient;
  oauth2_v2.Oauth2Api _oauthApi;
  bool _secretLoaded = false;
  String _secret;

  GoogleOauth2AuthProvider(
      this._siteAudience, this._trustedAudiences, this._db) {
    _httpClient = http.Client();
    _oauthApi = oauth2_v2.Oauth2Api(_httpClient);
  }

  @override
  String authorizationUrl(String state) {
    return Uri.parse('https://accounts.google.com/o/oauth2/v2/auth').replace(
      queryParameters: {
        'client_id': _siteAudience,
        'redirect_uri': activeConfiguration.oauthRedirectUrl,
        'scope': 'openid profile email',
        'response_type': 'code',
        'access_type': 'online',
        'state': state,
      },
    ).toString();
  }

  @override
  Future<String> authCodeToAccessToken(String code) async {
    final redirectUrl = activeConfiguration.oauthRedirectUrl;
    try {
      await _loadSecret();
      final rs = await _httpClient
          .post('https://www.googleapis.com/oauth2/v4/token', body: {
        'code': code,
        'client_id': _siteAudience,
        'client_secret': _secret,
        'redirect_uri': redirectUrl,
        'grant_type': 'authorization_code',
      });
      if (rs.statusCode >= 400) {
        _logger.info('Bad authorization token: $code for $redirectUrl');
        return null;
      }
      final tokenMap = json.decode(rs.body) as Map<String, dynamic>;
      return tokenMap['access_token'] as String;
    } catch (e) {
      _logger.info('Bad authorization token: $code for $redirectUrl', e);
    }
    return null;
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

      if (!_trustedAudiences.contains(info.audience)) {
        _logger.warning('OAuth2 access attempted with invalid audience, '
            'for email: "${info.email}", audience: "${info.audience}"');
        return null;
      }

      if (info.expiresIn == null ||
          info.expiresIn <= 0 ||
          // TODO: Enable when pub client is requesting the correct scopes.
          // info.userId == null ||
          // info.userId.isEmpty ||
          info.verifiedEmail != true ||
          info.email == null ||
          info.email.isEmpty ||
          !isValidEmail(info.email)) {
        _logger.warning('OAuth2 token info invalid: ${info.toJson()}');
        return null;
      }

      return AuthResult(info.userId, info.email.toLowerCase());
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

  Future _loadSecret() async {
    if (_secretLoaded) return;
    final key = _db.emptyKey
        .append(Secret, id: '${SecretKey.oauthPrefix}$_siteAudience');
    final secret = (await _db.lookup<Secret>([key])).single;
    _secret = secret?.value;
    _secretLoaded = true;
  }
}
