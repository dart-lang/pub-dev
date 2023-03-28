// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../frontend/handlers.dart';
import '../../shared/handler_helpers.dart';
import '../../tool/utils/http.dart';

/// Returns a HTTP client that bridges HTTP requests and shelf handlers without
/// the actual HTTP transport layer.
///
/// If [handler] is not specified, it will use the default frontend handler.
http.Client httpClientToShelfHandler({
  shelf.Handler? handler,
  String? authToken,
  String? sessionId,
  String? csrfToken,
}) {
  handler ??= createAppHandler();
  handler = wrapHandler(
    Logger.detached('test'),
    handler,
    sanitize: true,
  );
  return httpClientWithAuthorization(
    tokenProvider: () async => authToken,
    sessionIdProvider: () async => sessionId,
    csrfTokenProvider: () async => csrfToken,
    client: http_testing.MockClient(_wrapShelfHandler(handler)),
  );
}

String _removeLeadingSlashes(String path) {
  while (path.startsWith('/')) {
    path = path.substring(1);
  }
  return path;
}

http_testing.MockClientHandler _wrapShelfHandler(shelf.Handler handler) {
  return (rq) async {
    final shelfRq = shelf.Request(
      rq.method,
      rq.url.replace(path: _removeLeadingSlashes(rq.url.path)),
      body: rq.body,
      headers: rq.headers,
      url: Uri(path: _removeLeadingSlashes(rq.url.path), query: rq.url.query),
      handlerPath: '',
    );
    late shelf.Response rs;
    // Need to fork a service scope to create a separate RequestContext in the
    // search service handler.
    await fork(() async {
      rs = await handler(shelfRq);
    });
    return http.Response(
      await rs.readAsString(),
      rs.statusCode,
      headers: rs.headers,
    );
  };
}
