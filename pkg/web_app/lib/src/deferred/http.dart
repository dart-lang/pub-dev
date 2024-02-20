// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:http/browser_client.dart';
import 'package:http/http.dart';

export 'package:http/http.dart';

/// Creates an authenticated [Client] that extends request with the CSRF header.
Client createClientWithCsrf() {
  return _AuthenticatedClient();
}

String? _getCsrfMetaContent() {
  final values = document.head
      ?.querySelectorAll('meta[name="csrf-token"]')
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
///  - `x-pub-csrf-token` header when the HTML document's `<head>` contains the
///    `<meta name="csrf-token" content="<token>">` element.
class _AuthenticatedClient extends _BrowserClient {
  _AuthenticatedClient()
      : super(
          getHeadersFn: () async {
            final csrfToken = _getCsrfMetaContent();
            return {
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

    return await _client.send(modifiedRequest);
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
