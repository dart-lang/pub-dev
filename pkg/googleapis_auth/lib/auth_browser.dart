// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library googleapis_auth.auth_browser;

import 'dart:async';

import 'package:http/browser_client.dart';
import 'package:http/http.dart';

import 'auth.dart';
import 'src/auth_http_utils.dart';
import 'src/http_client_base.dart';
import 'src/oauth2_flows/implicit.dart';

export 'auth.dart';

/// Obtains a HTTP client which uses the given [apiKey] for making HTTP
/// requests.
///
/// Note that the returned client should *only* be used for making HTTP requests
/// to Google Services. The [apiKey] should not be disclosed to third parties.
///
/// The user is responsible for closing the returned HTTP [Client].
/// Closing the returned [Client] will not close [baseClient].
Client clientViaApiKey(String apiKey, {Client baseClient}) {
  if (baseClient == null) {
    baseClient = new BrowserClient();
  } else {
    baseClient = nonClosingClient(baseClient);
  }
  return new ApiKeyClient(baseClient, apiKey);
}

/// Will create and complete with a [BrowserOAuth2Flow] object.
///
/// This function will perform an implicit browser based oauth2 flow.
///
/// It will load Google's `gapi` library and initialize it. After initialization
/// it will complete with a [BrowserOAuth2Flow] object. The flow object can be
/// used to obtain `AccessCredentials` or an authenticated HTTP client.
///
/// If loading or initializing the `gapi` library results in an error, this
/// future will complete with an error.
///
/// If [baseClient] is not given, one will be automatically created. It will be
/// used for making authenticated HTTP requests. See [BrowserOAuth2Flow].
///
/// The [ClientId] can be obtained in the Google Cloud Console.
///
/// The user is responsible for closing the returned [BrowserOAuth2Flow] object.
/// Closing the returned [BrowserOAuth2Flow] will not close [baseClient]
/// if one was given.
Future<BrowserOAuth2Flow> createImplicitBrowserFlow(
    ClientId clientId, List<String> scopes,
    {Client baseClient}) {
  if (baseClient == null) {
    baseClient = new RefCountedClient(new BrowserClient(), initialRefCount: 1);
  } else {
    baseClient = new RefCountedClient(baseClient, initialRefCount: 2);
  }

  var flow = new ImplicitFlow(clientId.identifier, scopes);
  return flow.initialize().catchError((error, stack) {
    baseClient.close();
    return new Future.error(error, stack);
  }).then((_) => new BrowserOAuth2Flow._(flow, baseClient));
}

/// Used for obtaining oauth2 access credentials.
///
/// Warning:
///
/// The methods `obtainAccessCredentialsViaUserConsent` and
/// `clientViaUserConsent` try to open a popup window for the user authorization
/// dialog.
///
/// In order to prevent browsers from blocking the popup window, these
/// methods should only be called inside an event handler, since most
/// browsers do not block popup windows created in response to a user
/// interaction.
class BrowserOAuth2Flow {
  final ImplicitFlow _flow;
  final RefCountedClient _client;

  bool _wasClosed = false;

  /// The HTTP client passed in will be closed if `close` was called and all
  /// generated HTTP clients via [clientViaUserConsent] were closed.
  BrowserOAuth2Flow._(this._flow, this._client);

  /// Obtain oauth2 [AccessCredentials].
  ///
  /// If [immediate] is `true` there will be no user involvement. If the user
  /// is either not logged in or has not already granted the application access,
  /// a `UserConsentException` will be thrown.
  ///
  /// If [immediate] is `false` the user might be asked to login (if he is not
  /// already logged in) and might get asked to grant the application access
  /// (if the application hasn't been granted access before).
  ///
  /// The returned future will complete with `AccessCredentials` if the user
  /// has given the application access to it's data. Otherwise the future will
  /// complete with a `UserConsentException`.
  ///
  /// In case another error occurs the returned future will complete with an
  /// `Exception`.
  Future<AccessCredentials> obtainAccessCredentialsViaUserConsent(
      {bool immediate: false}) {
    _ensureOpen();
    return _flow.login(force: false, immediate: immediate);
  }

  /// Obtains [AccessCredentials] and returns an authenticated HTTP client.
  ///
  /// After obtaining access credentials, this function will return an HTTP
  /// [Client]. HTTP requests made on the returned client will get an
  /// additional `Authorization` header with the `AccessCredentials` obtained.
  ///
  /// In case the `AccessCredentials` expire, it will try to obtain new ones
  /// without user consent.
  ///
  /// See [obtainAccessCredentialsViaUserConsent] for how credentials will be
  /// obtained. Errors from [obtainAccessCredentialsViaUserConsent] will be let
  /// through to the returned `Future` of this function and to the returned
  /// HTTP client (in case of credential refreshes).
  ///
  /// The returned HTTP client will forward errors from lower levels via it's
  /// `Future<Response>` or it's `Response.read()` stream.
  ///
  /// The user is responsible for closing the returned HTTP client.
  Future<AutoRefreshingAuthClient> clientViaUserConsent(
      {bool immediate: false}) {
    return obtainAccessCredentialsViaUserConsent(immediate: immediate)
        .then(_clientFromCredentials);
  }

  /// Obtains [AccessCredentials] and an authorization code which can be
  /// exchanged for permanent access credentials.
  ///
  /// Use case:
  /// A web application might want to get consent for accessing data on behalf
  /// of a user. The client part is a dynamic webapp which wants to open a
  /// popup which asks the user for consent. The webapp might want to use the
  /// credentials to make API calls, but the server may want to have offline
  /// access to user data as well.
  ///
  /// If [force] is `true` this will create a popup window and ask the user to
  /// grant the application offline access. In case the user is not already
  /// logged in, he will be presented with an login dialog first.
  ///
  /// If [force] is `false` this will only create a popup window if the user
  /// has not already granted the application access. Please note that the
  /// authorization code can only be exchanged for a refresh token if the user
  /// had to grant access via the popup window. Otherwise the code exchange
  /// will only give an access token.
  ///
  /// If [immediate] is `true` there will be no user involvement. If the user
  /// is either not logged in or has not already granted the application access,
  /// a `UserConsentException` will be thrown.
  Future<HybridFlowResult> runHybridFlow(
      {bool force: true, bool immediate: false}) {
    _ensureOpen();
    return _flow
        .loginHybrid(force: force, immediate: immediate)
        .then((List tuple) {
      assert(tuple.length == 2);
      return new HybridFlowResult(this, tuple[0], tuple[1]);
    });
  }

  /// Will close this [BrowserOAuth2Flow] object and the HTTP [Client] it is
  /// using.
  ///
  /// The clients obtained via [clientViaUserConsent] will continue to work.
  /// The client obtained via `newClient` of obtained [HybridFlowResult] objects
  /// will continue to work.
  ///
  /// After this flow object and all obtained clients were closed the underlying
  /// HTTP client will be closed as well.
  ///
  /// After calling this `close` method, calls to [clientViaUserConsent],
  /// [obtainAccessCredentialsViaUserConsent] and to `newClient` on returned
  /// [HybridFlowResult] objects will fail.
  void close() {
    _ensureOpen();
    _wasClosed = true;
    _client.close();
  }

  void _ensureOpen() {
    if (_wasClosed) {
      throw new StateError('BrowserOAuth2Flow has already been closed.');
    }
  }

  AutoRefreshingAuthClient _clientFromCredentials(AccessCredentials cred) {
    _ensureOpen();
    _client.acquire();
    return new _AutoRefreshingBrowserClient(_client, cred, _flow);
  }
}

/// Represents the result of running a browser based hybrid flow.
///
/// The `credentials` field holds credentials which can be used on the client
/// side. The `newClient` function can be used to make a new authenticated HTTP
/// client using these credentials.
///
/// The `authorizationCode` can be sent to the server, which knows the
/// "client secret" and can exchange it with long-lived access credentials.
///
/// See the `obtainAccessCredentialsViaCodeExchange` function in the
/// `googleapis_auth.auth_io` library for more details on how to use the
/// authorization code.
class HybridFlowResult {
  final BrowserOAuth2Flow _flow;

  /// Access credentials for making authenticated HTTP requests.
  final AccessCredentials credentials;

  /// The authorization code received from the authorization endpoint.
  ///
  /// The auth code can be used to receive permanent access credentials.
  /// This requires a confidential client which can keep a secret.
  final String authorizationCode;

  HybridFlowResult(this._flow, this.credentials, this.authorizationCode);

  AutoRefreshingAuthClient newClient() {
    _flow._ensureOpen();
    return _flow._clientFromCredentials(credentials);
  }
}

class _AutoRefreshingBrowserClient extends AutoRefreshDelegatingClient {
  AccessCredentials credentials;
  ImplicitFlow _flow;
  Client _authClient;

  _AutoRefreshingBrowserClient(Client client, this.credentials, this._flow)
      : super(client) {
    _authClient = authenticatedClient(baseClient, credentials);
  }

  Future<StreamedResponse> send(BaseRequest request) {
    if (!credentials.accessToken.hasExpired) {
      return _authClient.send(request);
    } else {
      return _flow.login(immediate: true).then((newCredentials) {
        credentials = newCredentials;
        notifyAboutNewCredentials(credentials);
        _authClient = authenticatedClient(baseClient, credentials);
        return _authClient.send(request);
      });
    }
  }
}
