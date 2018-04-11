// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart' as shelf;

import 'scheduler_stats.dart';
import 'urls.dart';
import 'versions.dart';

const String default404NotFound = '404 Not Found';

/// The default age a browser would take hold of the static files before
/// checking with the server for a newer version.
const staticShortCache = const Duration(minutes: 5);

/// The age the browser should cache the static file if there is a hash provided
/// and it matches the etag.
const staticLongCache = const Duration(hours: 24);

shelf.Response redirectResponse(String url) => new shelf.Response.seeOther(url);

shelf.Response redirectToSearch(String query) {
  final uri = new Uri(path: '/packages', queryParameters: {'q': query});
  return redirectResponse(uri.toString());
}

shelf.Response atomXmlResponse(String content, {int status: 200}) =>
    new shelf.Response(
      status,
      body: content,
      headers: {'content-type': 'application/atom+xml; charset="utf-8"'},
    );

shelf.Response yamlResponse(String yamlString, {int status: 200}) =>
    new shelf.Response(status,
        body: yamlString,
        headers: {'content-type': 'text/yaml; charset="utf-8"'});

shelf.Response jsonResponse(Map map, {int status: 200, bool indent: false}) {
  final String body =
      indent ? new JsonEncoder.withIndent('  ').convert(map) : json.encode(map);
  return new shelf.Response(
    status,
    body: body,
    headers: {'content-type': 'application/json; charset="utf-8"'},
  );
}

shelf.Response htmlResponse(String content,
    {int status: 200, Map<String, String> headers}) {
  headers ??= <String, String>{};
  headers['content-type'] = 'text/html; charset="utf-8"';
  return new shelf.Response(status, body: content, headers: headers);
}

shelf.Response notFoundHandler(shelf.Request request,
        {String body: default404NotFound}) =>
    htmlResponse(body, status: 404);

shelf.Response rejectRobotsHandler(shelf.Request request) =>
    new shelf.Response.ok('User-agent: *\nDisallow: /\n');

/// Combines a response for /debug requests
shelf.Response debugResponse([Map data]) {
  final map = {
    'vm': {
      'currentRss': ProcessInfo.currentRss,
      'maxRss': ProcessInfo.maxRss,
    },
    'scheduler': latestSchedulerStats,
    'versions': {
      'runtime': runtimeVersion,
      'sdk': sdkVersion,
      'pana': panaVersion,
      'flutter': flutterVersion,
      'dartdoc': dartdocVersion,
      'customization': customizationVersion,
    },
  };
  if (data != null) {
    map.addAll(data);
  }
  return jsonResponse(map, indent: true);
}

bool isNotModified(shelf.Request request, DateTime lastModified, String etag) {
  final ifModifiedSince = request.ifModifiedSince;
  if (ifModifiedSince != null &&
      lastModified != null &&
      !lastModified.isAfter(ifModifiedSince)) {
    return true;
  }

  final ifNoneMatch = request.headers[HttpHeaders.IF_NONE_MATCH];
  if (ifNoneMatch != null && ifNoneMatch == etag) {
    return true;
  }

  return false;
}

bool isProductionHost(shelf.Request request) {
  final String host = request.requestedUri.host;
  return host == pubHostedDomain;
}
