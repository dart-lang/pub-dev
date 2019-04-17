// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'popularity_storage.dart';
import 'scheduler_stats.dart';
import 'urls.dart';
import 'utils.dart' show eventLoopLatencyTracker;
import 'versions.dart';

const String default404NotFound = '404 Not Found';

/// The default age a browser would take hold of the static files before
/// checking with the server for a newer version.
const staticShortCache = Duration(minutes: 5);

/// The age the browser should cache the static file if there is a hash provided
/// and it matches the etag.
const staticLongCache = Duration(days: 7);

final _logger = Logger('pub.shared.handler');
final _prettyJson = JsonEncoder.withIndent('  ');

shelf.Response redirectResponse(String url) => shelf.Response.seeOther(url);

shelf.Response redirectToSearch(String query) {
  return redirectResponse(searchUrl(q: query));
}

bool isPrettyJson(shelf.Request request) {
  return request.url.queryParameters.containsKey('pretty');
}

shelf.Response jsonResponse(
  Map map, {
  @required bool pretty,
  int status = 200,
}) {
  final String body = pretty ? _prettyJson.convert(map) : json.encode(map);
  return shelf.Response(
    status,
    body: body,
    headers: {
      'content-type': 'application/json; charset="utf-8"',
      'x-content-type-options': 'nosniff',
    },
  );
}

final _none = <String>["'none'"];
final _self = <String>["'self'"];

final _contentSecurityPolicyMap = <String, List<String>>{
  'child-src': _none,
  'connect-src': _self,
  'default-src': _none,
  'frame-src': _self,
  'font-src': <String>[
    "'self'",
    'https://fonts.googleapis.com/',
    'https://fonts.gstatic.com/',
  ],
  'img-src': <String>[
    "'self'",
    'https:',
    'data:',
  ],
  'manifest-src': _none,
  'media-src': _none,
  'object-src': _none,
  'script-src': <String>[
    "'self'",
    'https://www.googletagmanager.com/',
    'https://www.google.com/',
    'https://www.google-analytics.com/',
    'https://adservice.google.com/',
    'https://ajax.googleapis.com/',
  ],
  'style-src': <String>[
    "'self'",
    'https://pub.dartlang.org/static/', // older dartdoc content requires it
    "'unsafe-inline'", // package page (esp. analysis tab) required is
    'https://fonts.googleapis.com/',
  ],
  'worker-src': _none,
};

/// The serialized string of the CSP header.
final contentSecurityPolicy = _contentSecurityPolicyMap.keys.map<String>((key) {
  final list = _contentSecurityPolicyMap[key];
  return '$key ${list.join(' ')}';
}).join(';');

shelf.Response htmlResponse(String content,
    {int status = 200, Map<String, String> headers}) {
  headers ??= <String, String>{};
  headers['content-type'] = 'text/html; charset="utf-8"';
  return shelf.Response(status, body: content, headers: headers);
}

shelf.Response notFoundHandler(shelf.Request request,
        {String body = default404NotFound}) =>
    htmlResponse(body, status: 404);

shelf.Response rejectRobotsHandler(shelf.Request request) =>
    shelf.Response.ok('User-agent: *\nDisallow: /\n');

/// Combines a response for /debug requests
shelf.Response debugResponse([Map<String, dynamic> data]) {
  final map = <String, dynamic>{
    'env': {
      'GAE_VERSION': Platform.environment['GAE_VERSION'],
      'GAE_MEMORY_MB': Platform.environment['GAE_MEMORY_MB'],
    },
    'vm': {
      'currentRss': ProcessInfo.currentRss,
      'maxRss': ProcessInfo.maxRss,
      'eventLoopLatencyMillis': {
        'median': eventLoopLatencyTracker.median?.inMilliseconds,
        'p90': eventLoopLatencyTracker.p90?.inMilliseconds,
        'p99': eventLoopLatencyTracker.p99?.inMilliseconds,
      },
    },
    'versions': {
      'runtime': runtimeVersion,
      'runtime-sdk': runtimeSdkVersion,
      'tool-env-sdk': toolEnvSdkVersion,
      'pana': panaVersion,
      'flutter': flutterVersion,
      'dartdoc': dartdocVersion,
    },
    'scheduler': latestSchedulerStats,
  };
  if (data != null) {
    map.addAll(data);
  }
  if (popularityStorage != null) {
    map['popularity'] = {
      'fetched': popularityStorage.lastFetched?.toIso8601String(),
      'count': popularityStorage.count,
      'dateRange': popularityStorage.dateRange,
    };
  }
  return jsonResponse(map, pretty: true);
}

bool isNotModified(shelf.Request request, DateTime lastModified, String etag) {
  try {
    final ifModifiedSince = request.ifModifiedSince;
    if (ifModifiedSince != null &&
        lastModified != null &&
        !lastModified.isAfter(ifModifiedSince)) {
      return true;
    }

    final ifNoneMatch = request.headers[HttpHeaders.ifNoneMatchHeader];
    if (ifNoneMatch != null && ifNoneMatch == etag) {
      return true;
    }
  } catch (e, st) {
    // TODO: remove after https://github.com/dart-lang/http_parser/issues/24 gets fixed
    _logger.info('HTTP Header parsing issue detected.', e, st);
  }

  return false;
}

bool isProductionHost(shelf.Request request) {
  final String host = request.requestedUri.host;
  return host == pubHostedDomain;
}
