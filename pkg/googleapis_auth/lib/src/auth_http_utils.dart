// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library googleapis_auth;

import 'dart:async';

import 'package:http/http.dart';

import '../auth.dart';
import 'http_client_base.dart';

/// Will close the underlying `http.Client` depending on a constructor argument.
class AuthenticatedClient extends DelegatingClient implements AuthClient {
  final AccessCredentials credentials;

  AuthenticatedClient(Client client, this.credentials)
      : super(client, closeUnderlyingClient: false);

  Future<StreamedResponse> send(BaseRequest request) async {
    // Make new request object and perform the authenticated request.
    var modifiedRequest =
        new RequestImpl(request.method, request.url, request.finalize());
    modifiedRequest.headers.addAll(request.headers);
    modifiedRequest.headers['Authorization'] =
        'Bearer ${credentials.accessToken.data}';
    var response = await baseClient.send(modifiedRequest);
    var wwwAuthenticate = response.headers['www-authenticate'];
    if (wwwAuthenticate != null) {
      await response.stream.drain();
      throw new AccessDeniedException('Access was denied '
          '(www-authenticate header was: $wwwAuthenticate).');
    }
    return response;
  }
}

/// Adds 'key' query parameter when making HTTP requests.
///
/// If 'key' is already present on the URI, it will complete with an exception.
/// This will prevent accedential overrides of a query parameter with the API
/// key.
class ApiKeyClient extends DelegatingClient {
  final String _encodedApiKey;

  ApiKeyClient(Client client, String apiKey)
      : _encodedApiKey = Uri.encodeQueryComponent(apiKey),
        super(client, closeUnderlyingClient: true);

  Future<StreamedResponse> send(BaseRequest request) {
    var url = request.url;
    if (url.queryParameters.containsKey('key')) {
      return new Future.error(new Exception(
          'Tried to make a HTTP request which has already a "key" query '
          'parameter. Adding the API key would override that existing value.'));
    }

    if (url.query == '') {
      url = url.replace(query: 'key=$_encodedApiKey');
    } else {
      url = url.replace(query: '${url.query}&key=$_encodedApiKey');
    }

    var modifiedRequest =
        new RequestImpl(request.method, url, request.finalize());
    modifiedRequest.headers.addAll(request.headers);
    return baseClient.send(modifiedRequest);
  }
}

/// Will close the underlying `http.Client` depending on a constructor argument.
class AutoRefreshingClient extends AutoRefreshDelegatingClient {
  final ClientId clientId;
  AccessCredentials credentials;
  Client authClient;

  AutoRefreshingClient(Client client, this.clientId, this.credentials,
      {bool closeUnderlyingClient: false})
      : super(client, closeUnderlyingClient: closeUnderlyingClient) {
    assert(credentials.refreshToken != null);
    authClient = authenticatedClient(baseClient, credentials);
  }

  Future<StreamedResponse> send(BaseRequest request) async {
    if (!credentials.accessToken.hasExpired) {
      // TODO: Can this return a "access token expired" message?
      // If so, we should handle it.
      return authClient.send(request);
    } else {
      var cred = await refreshCredentials(clientId, credentials, baseClient);
      notifyAboutNewCredentials(cred);
      credentials = cred;
      authClient = authenticatedClient(baseClient, cred);
      return authClient.send(request);
    }
  }
}

abstract class AutoRefreshDelegatingClient extends DelegatingClient
    implements AutoRefreshingAuthClient {
  final StreamController<AccessCredentials> _credentialStreamController =
      new StreamController.broadcast(sync: true);

  AutoRefreshDelegatingClient(Client client, {bool closeUnderlyingClient: true})
      : super(client, closeUnderlyingClient: closeUnderlyingClient);

  Stream<AccessCredentials> get credentialUpdates =>
      _credentialStreamController.stream;

  void notifyAboutNewCredentials(AccessCredentials credentials) {
    _credentialStreamController.add(credentials);
  }

  void close() {
    _credentialStreamController.close();
    super.close();
  }
}
