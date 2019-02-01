// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/oauth2/v2.dart' as oauth2_v2;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pool/pool.dart';
import 'package:retry/retry.dart';

import 'models.dart';

final _logger = new Logger('pub.account.backend');
final _retry = RetryOptions();

/// The pub client's OAuth2 identifier.
final _pubAudience = '818368855108-8grd2eg9tj9f38os6f1urbcvsq399u8n.apps.'
    'googleusercontent.com';

/// Sets the account backend service.
void registerAccountBackend(AccountBackend backend) =>
    ss.register(#_accountBackend, backend);

/// The active account backend service.
AccountBackend get accountBackend =>
    ss.lookup(#_accountBackend) as AccountBackend;

/// Represents the backend for the account handling and authentication.
class AccountBackend {
  final _pool = Pool(1);
  final DatastoreDB _db;
  final _defaultAuthProvider =
      GoogleOauth2AuthProvider('dartlang-pub-1', _pubAudience);

  AccountBackend(this._db);

  Future close() async {
    await _defaultAuthProvider.close();
    await _pool.close();
  }

  /// Returns the `User` entry that is associated with the [accessToken].
  ///
  /// When no entry exists in Datastore, this method will create a new one.
  ///
  /// When the authenticated e-mail of the user changes, the email field will
  /// be updated to the latest one, and the `historicalEmails` field contains
  /// all of the earlier and current values.
  ///
  /// The method returns null if the access token is invalid.
  Future<User> lookupOrCreateUser(String accessToken) async {
    final auth = await _defaultAuthProvider.tryAuthenticate(accessToken);
    if (auth == null) {
      return null;
    }
    final compositeId = auth.compositeId;
    final userKey = _db.emptyKey.append(User, id: compositeId);

    final accessTime = DateTime.now().toUtc();
    final user = await _retry.retry(() async {
      User user = (await _db.lookup<User>([userKey])).single;
      if (user == null) {
        // create user
        user = User()
          ..parentKey = _db.emptyKey
          ..id = compositeId
          ..authProvider = auth.provider
          ..authUserId = auth.userId
          ..email = auth.email
          ..emails = <String>[auth.email]
          ..created = accessTime
          ..updated = accessTime;
        _db.commit(inserts: [user]);
      } else {
        // update user if e-mail has been changed
        if (user.updateEmail(auth.email)) {
          await _db.withTransaction((tx) async {
            user = (await _db.lookup<User>([userKey])).single;
            user.updateEmail(auth.email);
            user.updated = accessTime;
            tx.queueMutations(inserts: [user]);
            await tx.commit();
          });
        }
      }
      return user;
    });

    if (user == null) {
      return null;
    }

    // Future not awaited: updating the last accessed field does not need to
    // block the request serving process.
    _pool.withResource(() async {
      _retry.retry(() async {
        await _db.withTransaction((tx) async {
          final user = (await _db.lookup<User>([userKey])).single;
          if (user.lastAccess == null || user.lastAccess.isBefore(accessTime)) {
            user.lastAccess = accessTime;
            tx.queueMutations(inserts: [user]);
            await tx.commit();
          } else {
            await tx.rollback();
          }
        });
      });
    });

    return user;
  }
}

class AuthResult {
  final String provider;
  final String userId;
  final String email;

  AuthResult(this.provider, this.userId, this.email);

  String get compositeId => '$provider:$userId';
}

/// Authenticates access tokens.
abstract class AuthProvider {
  /// The unique identifier of the provider, which will be part of the Datastore key.
  String get name;

  /// Checks the [accessToken] and returns a verified user information.
  ///
  /// Returns null on any error, or if the token is expired, or the user is not
  /// verified,
  Future<AuthResult> tryAuthenticate(String accessToken);

  /// Close resources.
  Future close();
}

class GoogleOauth2AuthProvider extends AuthProvider {
  @override
  final String name;
  final String _audience;
  http.Client _httpClient;
  oauth2_v2.Oauth2Api _oauthApi;

  GoogleOauth2AuthProvider(this.name, this._audience) {
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

      return AuthResult(name, info.userId, info.email);
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
