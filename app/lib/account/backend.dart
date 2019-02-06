// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/oauth2/v2.dart' as oauth2_v2;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:retry/retry.dart';

import '../frontend/models.dart' show PackageVersion;

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
  final DatastoreDB _db;
  final _defaultAuthProvider = GoogleOauth2AuthProvider(_pubAudience);

  AccountBackend(this._db);

  Future close() async {
    await _defaultAuthProvider.close();
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
    final userKey = _db.emptyKey.append(User, id: auth.userId);

    return await _retry.retry(() async {
      User user = (await _db.lookup<User>([userKey])).single;
      if (user == null) {
        // Query the first use of the e-mail address.
        DateTime created = DateTime.now().toUtc();
        final uploadedVersions = _db.query<PackageVersion>()
          ..filter('uploaderEmail =', auth.email);
        await for (var version in uploadedVersions.run()) {
          if (created.isAfter(version.created)) {
            created = version.created;
          }
        }
        // create user
        user = User()
          ..parentKey = _db.emptyKey
          ..id = auth.userId
          ..email = auth.email
          ..created = created;
        _db.commit(inserts: [user]);
      } else {
        // update user if e-mail has been changed
        if (user.email != auth.email) {
          await _db.withTransaction((tx) async {
            user = (await _db.lookup<User>([userKey])).single;
            user.email = auth.email;
            tx.queueMutations(inserts: [user]);
            await tx.commit();
          });
        }
      }
      return user;
    });
  }
}

class AuthResult {
  final String userId;
  final String email;

  AuthResult(this.userId, this.email);
}

/// Authenticates access tokens.
abstract class AuthProvider {
  /// Checks the [accessToken] and returns a verified user information.
  ///
  /// Returns null on any error, or if the token is expired, or the user is not
  /// verified,
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
