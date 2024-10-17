// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:http/browser_client.dart';
import 'package:http/http.dart';

export 'package:http/http.dart';

/// Creates an authenticated [Client] that extends request with the CSRF header.
Client createClientWithCsrf() => _AuthenticatedClient();

String? get _csrfMetaContent => document.head
    ?.querySelectorAll('meta[name="csrf-token"]')
    .map((e) => e.getAttribute('content'))
    .firstWhereOrNull((tokenContent) => tokenContent != null)
    ?.trim();

/// An HTTP [Client] which sends custom headers alongside each request:
///
///  - `x-pub-csrf-token` header when the HTML document's `<head>` contains the
///    `<meta name="csrf-token" content="<token>">` element.
class _AuthenticatedClient extends _BrowserClient {
  @override
  Future<Map<String, String>> get _sendHeaders async => {
        if (_csrfMetaContent case final csrfToken? when csrfToken.isNotEmpty)
          'x-pub-csrf-token': csrfToken,
      };
}

/// An [Client] which updates the headers for each request.
abstract class _BrowserClient extends BrowserClient {
  final BrowserClient _client = BrowserClient();

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final modifiedRequest = _RequestImpl.fromRequest(
      request,
      updateHeaders: await _sendHeaders,
    );

    return await _client.send(modifiedRequest);
  }

  @override
  void close() {
    _client.close();
  }

  Future<Map<String, String>> get _sendHeaders;
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
