// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';
import 'package:meta/meta.dart';

final _transientStatusCodes = {
  // See: https://cloud.google.com/storage/docs/xml-api/reference-status
  429,
  500,
  503,
};

/// Creates a HTTP client that retries transient status codes.
http.Client httpRetryClient({
  http.Client innerClient,
  int retries,
}) {
  return RetryClient(
    innerClient ?? http.Client(),
    when: (r) => _transientStatusCodes.contains(r.statusCode),
    // TOOD: Consider implementing whenError and handle DNS + handshake errors.
    //       These are safe, retrying after partially sending data is more
    //       sketchy, but probably safe in our application.
    retries: retries ?? 5,
  );
}

/// Returns an [http.Client] which sends a `Bearer` token as `Authorization`
/// header for each request.
http.Client httpClientWithAuthorization({
  @required String bearerToken,
  http.Client client,
}) {
  return _AuthenticatedClient(
    bearerToken,
    client ?? http.Client(),
    client == null,
  );
}

/// An [http.Client] which sends a `Bearer` token as `Authorization` header for
/// each request.
class _AuthenticatedClient extends http.BaseClient {
  final String _bearerToken;
  final http.Client _client;
  final bool _closeInnerClient;

  _AuthenticatedClient(this._bearerToken, this._client, this._closeInnerClient);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['Authorization'] = 'Bearer $_bearerToken';
    return await _client.send(request);
  }

  @override
  void close() {
    if (_closeInnerClient) {
      _client.close();
    }
    super.close();
  }
}
