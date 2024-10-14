// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_router/shelf_router.dart';

import '../shared/handlers.dart';
import '../shared/urls.dart';

import 'handlers/misc.dart';
import 'handlers/pubapi.dart';
import 'handlers/redirects.dart';
import 'handlers/routes.dart';
import 'request_context.dart';

final _pubHeaderLogger = Logger('pub.header_logger');

void _logPubHeaders(shelf.Request request) {
  request.headers.forEach((String key, String value) {
    final lowerCaseKey = key.toLowerCase();
    if (lowerCaseKey.startsWith('x-pub') &&
        lowerCaseKey != csrfTokenHeaderName) {
      _pubHeaderLogger.info('$key: $value');
    }
  });
}

/// Handler for the whole URL space of the pub site.
shelf.Handler createAppHandler() {
  final legacyDartdocHandler = LegacyDartdocService().router;
  final pubDartlangOrgHandler = PubDartlangOrgService().router;
  final apiPubDevHandler = ApiPubDevService().router;
  final pubApiHandler = PubApi().router;
  final pubSiteHandler = PubSiteService().router;
  return (shelf.Request request) async {
    _logPubHeaders(request);

    // legacy dartdocs.org URLs
    final host = request.requestedUri.host;
    if (host == 'www.dartdocs.org' || host == 'dartdocs.org') {
      return legacyDartdocHandler(request);
    }

    // keeping for future use
    if (host == 'api.pub.dev') {
      return await apiPubDevHandler(request);
    }

    // do pub.dartlang.org-only routes
    if (host == legacyHost) {
      final rs = await pubDartlangOrgHandler(request);
      if (rs != Router.routeNotFound) {
        return rs;
      }
      if (_shouldRedirectToPubDev(request.requestedUri.path)) {
        return redirectResponse(
            request.requestedUri.replace(host: primaryHost).toString());
      }
    }

    // do www.pub.dev redirect
    if (host == 'www.$primaryHost') {
      return redirectResponse(
          request.requestedUri.replace(host: primaryHost).toString());
    }

    final rs = await pubApiHandler(request);
    if (rs != Router.routeNotFound) {
      return rs;
    }

    final res = await pubSiteHandler(request);
    if (res != Router.routeNotFound) {
      return res;
    }

    // Some clients add an extra `/` at the end of the request. When the above
    // handlers were not able to respond to the request, we redirect it to a
    // a path without the `/`.
    final path = request.requestedUri.path;
    if (path.endsWith('/') && path.length > 1) {
      final newPath = path.substring(0, path.length - 1);
      return redirectResponse(request.requestedUri.resolve(newPath).toString());
    }

    return formattedNotFoundHandler(request);
  };
}

bool _shouldRedirectToPubDev(String path) {
  // pub client uses API calls with pub.dartlang.org
  if (path.startsWith('/api/')) return false;
  // pub client downloads package archives with pub.dartlang.org
  if (path.endsWith('.tar.gz')) return false;
  // pub client uses API calls with .json endpoint on pub.dartlang.org
  if (path.endsWith('.json')) return false;
  // everything else should be redirected
  return true;
}
