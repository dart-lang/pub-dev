// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:html';
import 'dart:js';

import 'package:http/browser_client.dart';
import 'package:http/http.dart';

import 'google_auth_js.dart';

Element _logoutElem;
Element _accountInfoElem;

GoogleUser _currentUser;
BrowserClient client = BrowserClient();

void _updateUser(GoogleUser user) {
  final isSignedIn = getAuthInstance().isSignedIn.get();
  _currentUser = !isSignedIn || user?.getId() == null ? null : user;
  client.close();
  if (_currentUser == null) {
    print('No active user');
    client = BrowserClient();
    _accountInfoElem.text = '-';
  } else {
    print('user: ${_currentUser.getBasicProfile().getEmail()}');
    client =
        AuthenticatedClient(_currentUser.getAuthResponse(true)?.access_token);
    _updateOnCredChange();
  }
  _updateVisibility();
  print('updated user.');
}

Future<void> setupAccount() async {
  context['pubAuthInit'] = () {
    if (getAuthInstance().isSignedIn.get()) {
      _updateUser(getAuthInstance().currentUser.get());
    } else {
      _updateUser(null);
    }
    getAuthInstance().currentUser.listen(allowInterop(_updateUser));
  };
  final accountHeaderElem = document.body.querySelector('.account-header');
  if (accountHeaderElem == null) {
    return;
  }

  _logoutElem = document.createElement('a')
    ..text = 'Logout'
    ..onClick.listen((_) {
      // TODO: await Promise
      getAuthInstance().signOut();
      _updateUser(null);
    });
  accountHeaderElem.append(_logoutElem);

  _accountInfoElem = document.createElement('div')..text = 'loading...';
  accountHeaderElem.append(_accountInfoElem);

  _updateVisibility();
}

void _updateVisibility() {
  if (_currentUser != null) {
    _logoutElem.style.display = 'block';
  } else {
    _logoutElem.style.display = 'none';
  }
}

Future _updateOnCredChange() async {
  if (client != null) {
    try {
      final rs = await client.get('/api/account/v1/info');
      final map = json.decode(rs.body) as Map<String, dynamic>;
      _accountInfoElem.text = map['email'] as String;
    } catch (e) {
      print(e);
      client = null;
    }
  }
  _updateVisibility();
}

class AuthenticatedClient extends BrowserClient {
  final String _token;
  final _client = BrowserClient();
  AuthenticatedClient(this._token);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    // Make new request object and perform the authenticated request.
    final modifiedRequest =
        RequestImpl(request.method, request.url, request.finalize());
    modifiedRequest.headers.addAll(request.headers);
    modifiedRequest.headers['Authorization'] = 'Bearer $_token';
    final response = await _client.send(modifiedRequest);
    final wwwAuthenticate = response.headers['www-authenticate'];
    if (wwwAuthenticate != null) {
      await response.stream.drain();
      throw Exception(
          'Access was denied (www-authenticate header was: $wwwAuthenticate).');
    }
    return response;
  }

  @override
  void close() {
    _client.close();
  }
}

class RequestImpl extends BaseRequest {
  final Stream<List<int>> _stream;

  RequestImpl(String method, Uri url, [Stream<List<int>> stream])
      : _stream = stream == null ? Stream.fromIterable([]) : stream,
        super(method, url);

  @override
  ByteStream finalize() {
    super.finalize();
    if (_stream == null) {
      return null;
    }
    return ByteStream(_stream);
  }
}
