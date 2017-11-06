// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library googleapis_auth.auth;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import 'src/auth_http_utils.dart';
import 'src/crypto/pem.dart';
import 'src/crypto/rsa.dart';
import 'src/http_client_base.dart';
import 'src/utils.dart';

/// An OAuth2 access token.
class AccessToken {
  /// The token type, usually "Bearer"
  final String type;

  /// The access token data.
  final String data;

  /// Time at which the token will be expired (UTC time)
  final DateTime expiry;

  /// [expiry] must be a UTC `DateTime`.
  AccessToken(String this.type, String this.data, DateTime this.expiry) {
    if (type == null || data == null || expiry == null) {
      throw new ArgumentError('Arguments type/data/expiry may not be null.');
    }

    if (!expiry.isUtc) {
      throw new ArgumentError('The expiry date must be a Utc DateTime.');
    }
  }

  bool get hasExpired {
    return new DateTime.now().toUtc().isAfter(expiry);
  }

  String toString() => "AccessToken(type=$type, data=$data, expiry=$expiry)";
}

/// OAuth2 Credentials.
class AccessCredentials {
  /// An access token.
  final AccessToken accessToken;

  /// A refresh token, which can be used to refresh the access credentials.
  ///
  /// This field may be null.
  final String refreshToken;

  /// Scopes these credentials are valid for.
  final List<String> scopes;

  AccessCredentials(this.accessToken, this.refreshToken, this.scopes) {
    if (accessToken == null || scopes == null) {
      throw new ArgumentError('Arguments accessToken/scopes must not be null.');
    }
  }
}

/// Represents the client application's credentials.
class ClientId {
  /// The identifier used to identify this application to the server.
  final String identifier;

  /// The client secret used to identify this application to the server.
  final String secret;

  ClientId(this.identifier, this.secret) {
    if (identifier == null) {
      throw new ArgumentError('Argument identifier may not be null.');
    }
  }

  ClientId.serviceAccount(this.identifier) : secret = null {
    if (identifier == null) {
      throw new ArgumentError('Argument identifier may not be null.');
    }
  }
}

/// Represents credentials for a service account.
class ServiceAccountCredentials {
  /// The email address of this service account.
  final String email;

  /// The clientId.
  final ClientId clientId;

  /// Private key.
  final String privateKey;

  /// Impersonated user, if any. If not impersonating any user this is `null`.
  final String impersonatedUser;

  /// Private key as an [RSAPrivateKey].
  final RSAPrivateKey privateRSAKey;

  /// Creates a new [ServiceAccountCredentials] from JSON.
  ///
  /// [json] can be either a [Map] or a JSON map encoded as a [String].
  ///
  /// The optional named argument [impersonatedUser] is used to set the user
  /// to impersonate if impersonating a user.
  factory ServiceAccountCredentials.fromJson(json, {String impersonatedUser}) {
    if (json is String) {
      json = JSON.decode(json);
    }
    if (json is! Map) {
      throw new ArgumentError('json must be a Map or a String encoding a Map.');
    }
    var identifier = json['client_id'];
    var privateKey = json['private_key'];
    var email = json['client_email'];
    var type = json['type'];

    if (type != 'service_account') {
      throw new ArgumentError('The given credentials are not of type '
          'service_account (was: $type).');
    }

    if (identifier == null || privateKey == null || email == null) {
      throw new ArgumentError('The given credentials do not contain all the '
          'fields: client_id, private_key and client_email.');
    }

    var clientId = new ClientId(identifier, null);
    return new ServiceAccountCredentials(email, clientId, privateKey,
        impersonatedUser: impersonatedUser);
  }

  /// Creates a new [ServiceAccountCredentials].
  ///
  /// [email] is the e-mail address of the service account.
  ///
  /// [clientId] is the client ID for the service account.
  ///
  /// [privateKey] is the base 64 encoded, unencrypted private key, including
  /// the '-----BEGIN PRIVATE KEY-----' and '-----END PRIVATE KEY-----'
  /// boundaries.
  ///
  /// The optional named argument [impersonatedUser] is used to set the user
  /// to impersonate if impersonating a user is needed.
  ServiceAccountCredentials(this.email, this.clientId, String privateKey,
      {String this.impersonatedUser})
      : privateKey = privateKey,
        privateRSAKey = keyFromString(privateKey) {
    if (email == null || clientId == null || privateKey == null) {
      throw new ArgumentError(
          'Arguments email/clientId/privateKey must not be null.');
    }
  }
}

/// A authenticated HTTP client.
abstract class AuthClient implements Client {
  /// The credentials currently used for making HTTP requests.
  AccessCredentials get credentials;
}

/// A autorefreshing, authenticated HTTP client.
abstract class AutoRefreshingAuthClient implements AuthClient {
  /// A broadcast stream of [AccessCredentials].
  ///
  /// A listener will get notified when new [AccessCredentials] were obtained.
  Stream<AccessCredentials> get credentialUpdates;
}

/// Thrown if an attempt to refresh a token failed.
class RefreshFailedException implements Exception {
  final String message;
  RefreshFailedException(this.message);
  String toString() => message;
}

/// Thrown if an attempt to make an authorized request failed.
class AccessDeniedException implements Exception {
  final String message;
  AccessDeniedException(this.message);
  String toString() => message;
}

/// Thrown if user did not give his consent.
class UserConsentException implements Exception {
  final String message;
  UserConsentException(this.message);
  String toString() => message;
}

/// Obtain an `http.Client` which automatically authenticates
/// requests using [credentials].
///
/// Note that the returned `RequestHandler` will not auto-refresh the given
/// [credentials].
///
/// The user is responsible for closing the returned HTTP [Client].
/// Closing the returned [Client] will not close [baseClient].
AuthClient authenticatedClient(
    Client baseClient, AccessCredentials credentials) {
  if (credentials.accessToken.type != 'Bearer') {
    throw new ArgumentError('Only Bearer access tokens are accepted.');
  }
  return new AuthenticatedClient(baseClient, credentials);
}

/// Obtain an `http.Client` which automatically refreshes [credentials]
/// before they expire. Uses [baseClient] as a base for making authenticated
/// http requests and for refreshing [credentials].
///
/// The user is responsible for closing the returned HTTP [Client].
/// Closing the returned [Client] will not close [baseClient].
AutoRefreshingAuthClient autoRefreshingClient(
    ClientId clientId, AccessCredentials credentials, Client baseClient) {
  if (credentials.refreshToken == null) {
    throw new ArgumentError('Refresh token in AccessCredentials was `null`.');
  }
  return new AutoRefreshingClient(baseClient, clientId, credentials);
}

/// Tries to obtain refreshed [AccessCredentials] based on [credentials] using
/// [client].
Future<AccessCredentials> refreshCredentials(
    ClientId clientId, AccessCredentials credentials, Client client) async {
  var formValues = [
    'client_id=${Uri.encodeComponent(clientId.identifier)}',
    'client_secret=${Uri.encodeComponent(clientId.secret)}',
    'refresh_token=${Uri.encodeComponent(credentials.refreshToken)}',
    'grant_type=refresh_token',
  ];

  var body = new Stream<List<int>>.fromIterable(
      [(ASCII.encode(formValues.join('&')))]);
  var request = new RequestImpl('POST', _GoogleTokenUri, body);
  request.headers['content-type'] = 'application/x-www-form-urlencoded';

  var response = await client.send(request);
  var contentType = response.headers['content-type'];
  contentType = contentType == null ? null : contentType.toLowerCase();

  if (contentType == null ||
      (!contentType.contains('json') && !contentType.contains('javascript'))) {
    await response.stream.drain().catchError((_) {});
    throw new Exception(
        'Server responded with invalid content type: $contentType. '
        'Expected json response.');
  }

  return response.stream
      .transform(ASCII.decoder)
      .transform(JSON.decoder)
      .first
      .then((object) {
    Map json = object as Map;

    var token = json['access_token'];
    var seconds = json['expires_in'];
    var tokenType = json['token_type'];
    var error = json['error'];

    if (response.statusCode != 200 && error != null) {
      throw new RefreshFailedException('Refreshing attempt failed. '
          'Response was ${response.statusCode}. Error message was $error.');
    }

    if (token == null || seconds is! int || tokenType != 'Bearer') {
      throw new Exception('Refresing attempt failed. '
          'Invalid server response.');
    }

    return new AccessCredentials(
        new AccessToken(tokenType, token, expiryDate(seconds)),
        credentials.refreshToken,
        credentials.scopes);
  });
}

final _GoogleTokenUri = Uri.parse('https://accounts.google.com/o/oauth2/token');
