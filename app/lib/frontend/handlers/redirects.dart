// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_redirects;

import 'package:shelf/shelf.dart' as shelf;

import '../../shared/handlers.dart';
import '../../shared/urls.dart' as urls;

typedef SyncHandler = shelf.Response Function(shelf.Request request);

/// Checks [request] whether it can handle it via redirect.
/// Returns null when there is no redirect.
shelf.Response tryHandleRedirects(shelf.Request request) {
  final host = request.requestedUri.host;
  final path = request.requestedUri.path;
  if (host == 'www.dartdocs.org' ||
      host == 'dartdocs.org' ||
      host == 'www.pub.dev') {
    return redirectResponse(
        request.requestedUri.replace(host: urls.primaryHost).toString());
  }

  // Redirect from legacy host (pub.dartlang.org) to primary host (pub.dev).
  if (host == urls.legacyHost &&
      host != urls.primaryHost &&
      _shouldRedirectToPubDev(path)) {
    return redirectResponse(
        request.requestedUri.replace(host: urls.primaryHost).toString());
  }

  return null;
}

bool _shouldRedirectToPubDev(String path) {
  if (path.startsWith('/api/')) return false;
  if (path.endsWith('.tar.gz')) return false;
  if (path.endsWith('.json')) return false;
  if (path == '/debug') return false;
  return true;
}

/// Handles requests for /doc
shelf.Response docRedirectHandler(shelf.Request request) {
  final pubDocUrl = '${urls.dartSiteRoot}/tools/pub/';
  final dartlangDotOrgPath = redirectPaths[request.requestedUri.path];
  if (dartlangDotOrgPath != null) {
    return redirectResponse('$pubDocUrl$dartlangDotOrgPath');
  }
  return redirectResponse(pubDocUrl);
}

const Map<String, String> redirectPaths = <String, String>{
  // /doc/ goes to "Getting started".
  '/doc': 'get-started.html',
  '/doc/': 'get-started.html',

  // Redirect from the old names for the commands.
  '/doc/pub-install.html': 'cmd/pub-get.html',
  '/doc/pub-update.html': 'cmd/pub-upgrade.html',

  // Most of the moved docs have the same name.
  '/doc/get-started.html': 'get-started.html',
  '/doc/dependencies.html': 'dependencies.html',
  '/doc/pubspec.html': 'pubspec.html',
  '/doc/package-layout.html': 'package-layout.html',
  '/doc/assets-and-transformers.html': 'assets-and-transformers.html',
  '/doc/faq.html': 'faq.html',
  '/doc/glossary.html': 'glossary.html',
  '/doc/versioning.html': 'versioning.html',

  // The command references were moved under "cmd".
  '/doc/pub-build.html': 'cmd/pub-build.html',
  '/doc/pub-cache.html': 'cmd/pub-cache.html',
  '/doc/pub-get.html': 'cmd/pub-get.html',
  '/doc/pub-lish.html': 'cmd/pub-lish.html',
  '/doc/pub-upgrade.html': 'cmd/pub-upgrade.html',
  '/doc/pub-serve.html': 'cmd/pub-serve.html'
};
