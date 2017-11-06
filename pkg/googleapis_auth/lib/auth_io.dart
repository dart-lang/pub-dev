// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library googleapis_auth.auth_io;

import 'dart:async';

import 'package:http/http.dart';

import 'auth.dart';
import 'src/auth_http_utils.dart';
import 'src/http_client_base.dart';
import 'src/oauth2_flows/auth_code.dart';
import 'src/oauth2_flows/jwt.dart';
import 'src/oauth2_flows/metadata_server.dart';
import 'src/typedefs.dart';

export 'auth.dart';
export 'src/typedefs.dart';

/// Obtains oauth2 credentials and returns an authenticated HTTP client.
///
/// See [obtainAccessCredentialsViaUserConsent] for specifics about the
/// arguments used for obtaining access credentials.
///
/// Once access credentials have been obtained, this function will complete
/// with an auto-refreshing HTTP client. Once the `AccessCredentials` expire
/// it will use it's refresh token (if available) to obtain new credentials.
/// See [autoRefreshingClient] for more information.
///
/// If [baseClient] is not given, one will be automatically created. It will be
/// used for making authenticated HTTP requests.
///
/// The user is responsible for closing the returned HTTP [Client].
/// Closing the returned [Client] will not close [baseClient].
Future<AutoRefreshingAuthClient> clientViaUserConsent(
    ClientId clientId, List<String> scopes, PromptUserForConsent userPrompt,
    {Client baseClient}) {
  bool closeUnderlyingClient = false;
  if (baseClient == null) {
    baseClient = new Client();
    closeUnderlyingClient = true;
  }

  var flow = new AuthorizationCodeGrantServerFlow(
      clientId, scopes, baseClient, userPrompt);
  return flow.run().catchError((error, stack) {
    if (closeUnderlyingClient) {
      baseClient.close();
    }
    return new Future.error(error, stack);
  }).then((credentials) => new AutoRefreshingClient(
      baseClient, clientId, credentials,
      closeUnderlyingClient: closeUnderlyingClient));
}

/// Obtains oauth2 credentials and returns an authenticated HTTP client.
///
/// See [obtainAccessCredentialsViaUserConsentManual] for specifics about the
/// arguments used for obtaining access credentials.
///
/// Once access credentials have been obtained, this function will complete
/// with an auto-refreshing HTTP client. Once the `AccessCredentials` expire
/// it will use it's refresh token (if available) to obtain new credentials.
/// See [autoRefreshingClient] for more information.
///
/// If [baseClient] is not given, one will be automatically created. It will be
/// used for making authenticated HTTP requests.
///
/// The user is responsible for closing the returned HTTP [Client].
/// Closing the returned [Client] will not close [baseClient].
Future<AutoRefreshingAuthClient> clientViaUserConsentManual(ClientId clientId,
    List<String> scopes, PromptUserForConsentManual userPrompt,
    {Client baseClient}) {
  bool closeUnderlyingClient = false;
  if (baseClient == null) {
    baseClient = new Client();
    closeUnderlyingClient = true;
  }

  var flow = new AuthorizationCodeGrantManualFlow(
      clientId, scopes, baseClient, userPrompt);
  return flow.run().catchError((error, stack) {
    if (closeUnderlyingClient) {
      baseClient.close();
    }
    return new Future.error(error, stack);
  }).then((credentials) => new AutoRefreshingClient(
      baseClient, clientId, credentials,
      closeUnderlyingClient: closeUnderlyingClient));
}

/// Obtains oauth2 credentials and returns an authenticated HTTP client.
///
/// See [obtainAccessCredentialsViaServiceAccount] for specifics about the
/// arguments used for obtaining access credentials.
///
/// Once access credentials have been obtained, this function will complete
/// with an auto-refreshing HTTP client. Once the `AccessCredentials` expire
/// it will obtain new access credentials.
///
/// If [baseClient] is not given, one will be automatically created. It will be
/// used for making authenticated HTTP requests and for obtaining access
/// credentials.
///
/// The user is responsible for closing the returned HTTP [Client].
/// Closing the returned [Client] will not close [baseClient].
Future<AutoRefreshingAuthClient> clientViaServiceAccount(
    ServiceAccountCredentials clientCredentials, List<String> scopes,
    {Client baseClient}) {
  if (baseClient == null) {
    baseClient = new Client();
  } else {
    baseClient = nonClosingClient(baseClient);
  }

  var flow = new JwtFlow(
      clientCredentials.email,
      clientCredentials.privateRSAKey,
      clientCredentials.impersonatedUser,
      scopes,
      baseClient);
  return flow.run().catchError((error, stack) {
    baseClient.close();
    return new Future.error(error, stack);
  }).then((credentials) {
    return new _ServiceAccountClient(baseClient, credentials, flow);
  });
}

/// Obtains oauth2 credentials and returns an authenticated HTTP client.
///
/// See [obtainAccessCredentialsViaMetadataServer] for specifics about the
/// arguments used for obtaining access credentials.
///
/// Once access credentials have been obtained, this function will complete
/// with an auto-refreshing HTTP client. Once the `AccessCredentials` expire
/// it will obtain new access credentials.
///
/// If [baseClient] is not given, one will be automatically created. It will be
/// used for making authenticated HTTP requests and for obtaining access
/// credentials.
///
/// The user is responsible for closing the returned HTTP [Client].
/// Closing the returned [Client] will not close [baseClient].
Future<AutoRefreshingAuthClient> clientViaMetadataServer({Client baseClient}) {
  if (baseClient == null) {
    baseClient = new Client();
  } else {
    baseClient = nonClosingClient(baseClient);
  }

  var flow = new MetadataServerAuthorizationFlow(baseClient);
  return flow.run().catchError((error, stack) {
    baseClient.close();
    return new Future.error(error, stack);
  }).then((credentials) {
    return new _MetadataServerClient(baseClient, credentials, flow);
  });
}

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
    baseClient = new Client();
  } else {
    baseClient = nonClosingClient(baseClient);
  }
  return new ApiKeyClient(baseClient, apiKey);
}

/// Obtain oauth2 [AccessCredentials] using the oauth2 authentication code flow.
///
/// The returned future will complete with `AccessCredentials` if the user
/// has given the application access to it's data. Otherwise the future will
/// complete with a `UserConsentException`.
///
/// In case another error occurs the returned future will complete with an
/// `Exception`.
///
/// [userPrompt] will be used for directing the user/user-agent to a URI. See
/// [PromptUserForConsent] for more information.
///
/// [client] will be used for obtaining `AccessCredentials` from an
/// authorization code.
///
/// The [ClientId] can be obtained in the Google Cloud Console.
Future<AccessCredentials> obtainAccessCredentialsViaUserConsent(
    ClientId clientId,
    List<String> scopes,
    Client client,
    PromptUserForConsent userPrompt) {
  return new AuthorizationCodeGrantServerFlow(
          clientId, scopes, client, userPrompt)
      .run();
}

/// Obtain oauth2 [AccessCredentials] using the oauth2 authentication code flow.
///
/// The returned future will complete with `AccessCredentials` if the user
/// has given the application access to it's data. Otherwise the future will
/// complete with a `UserConsentException`.
///
/// In case another error occurs the returned future will complete with an
/// `Exception`.
///
/// [userPrompt] will be used for directing the user/user-agent to a URI. See
/// [PromptUserForConsentManual] for more information.
///
/// [client] will be used for obtaining `AccessCredentials` from an
/// authorization code.
///
/// The [ClientId] can be obtained in the Google Cloud Console.
Future<AccessCredentials> obtainAccessCredentialsViaUserConsentManual(
    ClientId clientId,
    List<String> scopes,
    Client client,
    PromptUserForConsentManual userPrompt) {
  return new AuthorizationCodeGrantManualFlow(
          clientId, scopes, client, userPrompt)
      .run();
}

/// Obtain oauth2 [AccessCredentials] using service account credentials.
///
/// In case the service account has no access to the requested scopes or another
/// error occurs the returned future will complete with an `Exception`.
///
/// [client] will be used for obtaining `AccessCredentials`.
///
/// The [ServiceAccountCredentials] can be obtained in the Google Cloud Console.
Future<AccessCredentials> obtainAccessCredentialsViaServiceAccount(
    ServiceAccountCredentials clientCredentials,
    List<String> scopes,
    Client baseClient) {
  return new JwtFlow(clientCredentials.email, clientCredentials.privateRSAKey,
          clientCredentials.impersonatedUser, scopes, baseClient)
      .run();
}

/// Obtain oauth2 [AccessCredentials] using the metadata API on ComputeEngine.
///
/// In case the VM was not configured with access to the requested scopes or an
/// error occurs the returned future will complete with an `Exception`.
///
/// [client] will be used for obtaining `AccessCredentials`.
///
/// No credentials are needed. But this function is only intended to work on a
/// Google Compute Engine VM with configured access to Google APIs.
Future<AccessCredentials> obtainAccessCredentialsViaMetadataServer(
    Client baseClient) {
  return new MetadataServerAuthorizationFlow(baseClient).run();
}

/// Obtain oauth2 [AccessCredentials] by exchanging an authorization code.
///
/// Running a hybrid oauth2 flow as described in the
/// `googleapis_auth.auth_browser` library results in a `HybridFlowResult` which
/// contains short-lived [AccessCredentials] for the client and an authorization
/// code. This authorization code needs to be transferred to the server, which
/// can exchange it against long-lived [AccessCredentials].
///
/// If the authorization code was obtained using the mentioned hybrid flow, the
/// [redirectUrl] must be `"postmessage"` (default).
///
/// If you obtained the authorization code using a different mechanism, the
/// [redirectUrl] must be the same that was used to obtain the code.
///
/// NOTE: Only the server application will know the `client secret` - which is
/// necessary to exchange an authorization code against access tokens.
///
/// NOTE: It is important to transmit the authorization code in a secure manner
/// to the server. You should use "anti-request forgery state tokens" to guard
/// against "cross site request forgery" attacks.
/// An example on how to do this can be found here:
///   https://developers.google.com/+/web/signin/server-side-flow
Future<AccessCredentials> obtainAccessCredentialsViaCodeExchange(
    Client baseClient, ClientId clientId, String code,
    {String redirectUrl: 'postmessage'}) {
  return obtainAccessCredentialsUsingCode(
      clientId, code, redirectUrl, baseClient);
}

/// Will close the underlying `http.Client`.
class _ServiceAccountClient extends AutoRefreshDelegatingClient {
  final JwtFlow flow;
  AccessCredentials credentials;
  Client authClient;

  _ServiceAccountClient(Client client, this.credentials, this.flow)
      : super(client) {
    authClient = authenticatedClient(baseClient, credentials);
  }

  Future<StreamedResponse> send(BaseRequest request) async {
    if (!credentials.accessToken.hasExpired) {
      return authClient.send(request);
    } else {
      var newCredentials = await flow.run();
      notifyAboutNewCredentials(newCredentials);
      credentials = newCredentials;
      authClient = authenticatedClient(baseClient, credentials);
      return authClient.send(request);
    }
  }
}

/// Will close the underlying `http.Client`.
class _MetadataServerClient extends AutoRefreshDelegatingClient {
  final MetadataServerAuthorizationFlow flow;
  AccessCredentials credentials;
  Client authClient;

  _MetadataServerClient(Client client, this.credentials, this.flow)
      : super(client) {
    authClient = authenticatedClient(baseClient, credentials);
  }

  Future<StreamedResponse> send(BaseRequest request) async {
    if (!credentials.accessToken.hasExpired) {
      return authClient.send(request);
    } else {
      var newCredentials = await flow.run();
      notifyAboutNewCredentials(newCredentials);
      credentials = newCredentials;
      authClient = authenticatedClient(baseClient, credentials);
      return authClient.send(request);
    }
  }
}
