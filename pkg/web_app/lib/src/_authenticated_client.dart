// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/browser_client.dart';
import 'package:http/http.dart';

/// Creates an authenticated [Client] that calls [getToken] to obtain an
/// bearer-token to use in the `Authorization: Bearer <token>` header.
Client createAuthenticatedClient(Future<String> Function() getToken) {
  return _AuthenticatedClient(getToken);
}

/// An [Client] which sends a `Bearer` token as `Authorization` header for each request.
class _AuthenticatedClient extends BrowserClient {
  final Future<String> Function() _getToken;
  final _client = BrowserClient();
  _AuthenticatedClient(this._getToken);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final token = await _getToken();
    // Make new request object and perform the authenticated request.
    final modifiedRequest =
        _RequestImpl(request.method, request.url, request.finalize());
    modifiedRequest.headers.addAll(request.headers);
    modifiedRequest.headers['Authorization'] = 'Bearer $token';
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

class _RequestImpl extends BaseRequest {
  final Stream<List<int>> _stream;

  _RequestImpl(String method, Uri url, [Stream<List<int>> stream])
      : _stream = stream ?? Stream.fromIterable([]),
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
