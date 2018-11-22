// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
const staticShortCache = const Duration(minutes: 5);

/// The age the browser should cache the static file if there is a hash provided
/// and it matches the etag.
const staticLongCache = const Duration(hours: 24);

final _logger = new Logger('pub.shared.handler');
final _prettyJson = new JsonEncoder.withIndent('  ');

shelf.Response redirectResponse(String url) => new shelf.Response.seeOther(url);

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
  return new shelf.Response(
    status,
    body: body,
    headers: {'content-type': 'application/json; charset="utf-8"'},
  );
}

shelf.Response htmlResponse(String content,
    {int status = 200, Map<String, String> headers}) {
  headers ??= <String, String>{};
  headers['content-type'] = 'text/html; charset="utf-8"';
  return new shelf.Response(status, body: content, headers: headers);
}

shelf.Response notFoundHandler(shelf.Request request,
        {String body = default404NotFound}) =>
    htmlResponse(body, status: 404);

shelf.Response rejectRobotsHandler(shelf.Request request) =>
    new shelf.Response.ok('User-agent: *\nDisallow: /\n');

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
      'customization': customizationVersion,
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

/// Extracts the 'page' query parameter from [url].
///
/// Returns a valid positive integer.
int extractPageFromUrlParameters(Uri url) {
  final pageAsString = url.queryParameters['page'];
  int pageAsInt = 1;
  if (pageAsString != null) {
    try {
      pageAsInt = max(int.parse(pageAsString), 1);
    } catch (_, __) {}
  }
  return pageAsInt;
}
