// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/browser_client.dart';
import 'package:http/http.dart';

/// Returns a HTTP Client that if a [token] is present, will send it as a `Bearer`
/// token in the `Authorization` header for each request. If [token] is null,
/// it returns a regular Client.
Client getAuthenticatedClient(String token) {
  return token == null ? BrowserClient() : _AuthenticatedClient(token);
}

/// An [http.Client] which sends a `Bearer` token as `Authorization` header
/// for each request.
class _AuthenticatedClient extends BrowserClient {
  final String _token;
  final _client = BrowserClient();
  _AuthenticatedClient(this._token);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    // Make new request object and perform the authenticated request.
    final modifiedRequest =
    _RequestImpl(request.method, request.url, request.finalize());
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

class _RequestImpl extends BaseRequest {
  final Stream<List<int>> _stream;

  _RequestImpl(String method, Uri url, [Stream<List<int>> stream])
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
