// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/shared/env_config.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../frontend/handlers/cache_control.dart';
import '../frontend/request_context.dart';

import 'urls.dart' as urls;
import 'utils.dart' show jsonUtf8Encoder;
import 'versions.dart';

const String default400BadRequest = '400 Bad Request';
const String default404NotFound = '404 Not Found';

/// The default header values for JSON responses.
const jsonResponseHeaders = <String, String>{
  'content-type': 'application/json; charset="utf-8"',
  'x-content-type-options': 'nosniff',
};

Map<String, Object> _htmlResponseHeaders(
  Map<String, Object>? headers,
  bool noReferrer,
) {
  headers ??= <String, Object>{};
  headers['content-type'] = 'text/html; charset="utf-8"';
  headers['referrer-policy'] = noReferrer
      ? 'no-referrer'
      : 'strict-origin-when-cross-origin';
  return headers;
}

final _logger = Logger('pub.shared.handler');
final _prettyJson = JsonUtf8Encoder('  ');

shelf.Response redirectResponse(String url, {Map<String, Object>? headers}) {
  return shelf.Response.seeOther(url, headers: headers);
}

shelf.Response redirectToSearch(String query) {
  return redirectResponse(urls.searchUrl(q: query));
}

shelf.Response jsonResponse(
  Map map, {
  int status = 200,
  bool indentJson = false,
  Map<String, Object>? headers,
}) {
  final body = (indentJson || requestContext.indentJson)
      ? _prettyJson.convert(map)
      : jsonUtf8Encoder.convert(map);
  return shelf.Response(
    status,
    body: body,
    headers: {...jsonResponseHeaders, ...?headers},
  );
}

shelf.Response htmlResponse(
  String content, {
  int status = 200,
  Map<String, Object>? headers,
  bool noReferrer = false,
}) {
  return shelf.Response(
    status,
    body: content,
    headers: _htmlResponseHeaders(headers, noReferrer),
  );
}

shelf.Response htmlBytesResponse(
  List<int> content, {
  int status = 200,
  Map<String, Object>? headers,
  bool noReferrer = false,
}) {
  return shelf.Response(
    status,
    body: content,
    headers: _htmlResponseHeaders(headers, noReferrer),
  );
}

/// Response give to HTTP HEAD requests (contains metadata headers).
shelf.Response headHtmlResponse({Map<String, String>? headers}) {
  return htmlResponse('', headers: headers);
}

final _healthCheckHeaders = {
  ...CacheControl.explicitlyPrivate.headers,
  HttpHeaders.contentTypeHeader: 'text/plain; charset="utf-8"',
};

shelf.Response healthCheckOkResponse() =>
    shelf.Response.ok('OK', headers: _healthCheckHeaders);

shelf.Response healthCheckNotReadyResponse() => shelf.Response(
  503,
  body: 'Service Unavailable',
  headers: _healthCheckHeaders,
);

shelf.Response badRequestHandler(shelf.Request request) =>
    htmlResponse(default400BadRequest, status: 400);

shelf.Response notFoundHandler(
  shelf.Request request, {
  String body = default404NotFound,
  Map<String, Object>? headers,
}) {
  return htmlResponse(body, status: 404, headers: headers);
}

shelf.Response methodNotAllowedHandler(
  shelf.Request request, {
  Map<String, Object>? headers,
}) {
  return shelf.Response(405, body: 'Method Not Allowed', headers: headers);
}

shelf.Response rejectRobotsHandler(shelf.Request request) =>
    shelf.Response.ok('User-agent: *\nDisallow: /\n');

/// Combines a response for /debug requests
shelf.Response debugResponse([Map<String, dynamic>? data]) {
  final map = <String, dynamic>{
    'env': envConfig.debugMap(),
    'vm': {
      'x': 1,
      'numberOfProcessors': Platform.numberOfProcessors,
      'currentRss': ProcessInfo.currentRss,
      'maxRss': ProcessInfo.maxRss,
    },
    'versions': {
      'runtime': runtimeVersion,
      'runtime-sdk': runtimeSdkVersion,
      'pana': panaVersion,
      'dartdoc': dartdocVersion,
      'stable': {
        'dart': toolStableDartSdkVersion,
        'flutter': toolStableFlutterSdkVersion,
      },
    },
    ...?data,
  };
  return jsonResponse(map, indentJson: true);
}

bool isNotModified(shelf.Request request, DateTime lastModified, String etag) {
  DateTime? ifModifiedSince;
  try {
    // accessing the header may throw
    ifModifiedSince = request.ifModifiedSince;
  } on FormatException {
    _logger.info('invalid If-Modified-Since header');
    return false;
  }
  if (ifModifiedSince != null && !lastModified.isAfter(ifModifiedSince)) {
    return true;
  }

  final ifNoneMatch = request.headers[HttpHeaders.ifNoneMatchHeader];
  if (ifNoneMatch != null && ifNoneMatch == etag) {
    return true;
  }

  return false;
}

extension RequestExt on shelf.Request {
  /// Returns true if the current request declares that it accepts the [encoding].
  ///
  /// NOTE: the method does not parses the header, only checks whether the [encoding]
  ///       String is present (or everything is accepted).
  @visibleForTesting
  bool acceptsEncoding(String encoding) {
    final set = _parseAcceptHeader(HttpHeaders.acceptEncodingHeader);
    return set?.contains(encoding) ?? false;
  }

  Set<String>? _parseAcceptHeader(String headerKey) {
    final accepting = headers[headerKey];
    if (accepting == null || accepting.isEmpty) {
      return null;
    }
    return accepting.split(',').map((p) => p.split(';').first.trim()).toSet();
  }

  /// Returns true if the current request declares that it accepts the `gzip` encoding.
  ///
  /// NOTE: the method does not parses the header, only checks whether the `gzip`
  ///       String is present (or everything is accepted).
  bool acceptsGzipEncoding() => acceptsEncoding('gzip');

  /// Returns true if the current request declared that it accepts the `application/json`
  /// content type or the accepting everything content type (`*/*`)
  bool acceptsJsonContent() {
    final set = _parseAcceptHeader(HttpHeaders.acceptHeader);
    if (set == null) return false;
    return set.contains('application/json') || set.contains('*/*');
  }

  /// The IP address of the original client starting the request.
  ///
  /// Returns `null` if there is no source IP associated with the request.
  String? get sourceIp {
    final xForwardedFor = headers['x-forwarded-for']?.split(',').first.trim();
    if (xForwardedFor != null && xForwardedFor.isNotEmpty) {
      return xForwardedFor;
    }
    return null;
  }
}
