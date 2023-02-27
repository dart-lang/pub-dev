// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:http/browser_client.dart';
import 'package:http/http.dart';

export 'package:http/http.dart' show Client;

/// Creates an authenticated [Client] that calls [getToken] to obtain an
/// bearer-token to use in the `Authorization: Bearer <token>` header.
Client createAuthenticatedClient(Future<String?> Function() getToken) {
  return _AuthenticatedClient(getToken);
}

String? _getCsrfMetaContent() {
  final values = document.head
      ?.querySelectorAll('meta')
      .where((e) => e.attributes['name'] == 'csrf-token')
      .map((e) => e.attributes['content'])
      .where((e) => e != null)
      .cast<String>()
      .toList();
  if (values == null || values.isEmpty) {
    return null;
  }
  return values.first.trim();
}

/// An HTTP [Client] which sends custom headers alongside each request:
///
///  - `Authorization` header with `Bearer` token, when `getAuthTokenFn` is
///    provided and returns a non-null value.
///
///  - `x-pub-csrf-token` header when the HTML document's `<head>` contains the
///    `<meta name="csrf-token" content="<token>">` element.
class _AuthenticatedClient extends _BrowserClient {
  _AuthenticatedClient(Future<String?> Function()? getAuthTokenFn)
      : super(
          getHeadersFn: () async {
            final bearerToken =
                getAuthTokenFn == null ? null : await getAuthTokenFn();
            final csrfToken = _getCsrfMetaContent();
            return {
              if (bearerToken != null && bearerToken.isNotEmpty)
                'Authorization': 'Bearer $bearerToken',
              if (csrfToken != null && csrfToken.isNotEmpty)
                'x-pub-csrf-token': csrfToken,
            };
          },
        );
}

/// An [Client] which updates the headers for each request.
class _BrowserClient extends BrowserClient {
  final Future<Map<String, String>> Function() getHeadersFn;
  final _client = BrowserClient();
  _BrowserClient({
    required this.getHeadersFn,
  });

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final headers = await getHeadersFn();

    final modifiedRequest = _RequestImpl.fromRequest(
      request,
      updateHeaders: headers,
    );

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
  final ByteStream _stream;

  _RequestImpl.fromRequest(
    BaseRequest request, {
    required Map<String, String> updateHeaders,
  })  : _stream = request.finalize(),
        super(request.method, request.url) {
    final newKeys = <String>{
      ...request.headers.keys,
      ...updateHeaders.keys,
    };
    for (final key in newKeys) {
      final newValue = updateHeaders[key] ?? request.headers[key];
      if (newValue != null) {
        headers[key] = newValue;
      }
    }
    headers.addAll(request.headers);
  }

  @override
  ByteStream finalize() {
    super.finalize();
    return ByteStream(_stream);
  }
}
