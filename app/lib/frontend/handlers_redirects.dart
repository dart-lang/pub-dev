// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_redirects;

import 'package:shelf/shelf.dart' as shelf;

import '../shared/handlers.dart';
import '../shared/urls.dart' as urls;

/// Checks [request] whether it can handle it via redirect.
/// Returns null when there is no redirect.
shelf.Response tryHandleRedirects(shelf.Request request) {
  final host = request.requestedUri.host;
  if (host == 'www.dartdocs.org' || host == 'dartdocs.org') {
    return redirectResponse(
        request.requestedUri.replace(host: 'pub.dartlang.org').toString());
  }

  final path = request.requestedUri.path;
  if (path == '/search') {
    return redirectResponse(
        request.requestedUri.replace(path: urls.searchUrl()).toString());
  }
  if (path.startsWith('/doc')) {
    return _docRedirectHandler(request);
  }
  return null;
}

/// Handles requests for /doc
shelf.Response _docRedirectHandler(shelf.Request request) {
  final pubDocUrl = 'https://www.dartlang.org/tools/pub/';
  final dartlangDotOrgPath = redirectPaths[request.requestedUri.path];
  if (dartlangDotOrgPath != null) {
    return redirectResponse('$pubDocUrl$dartlangDotOrgPath');
  }
  return redirectResponse(pubDocUrl);
}

const Map<String, String> redirectPaths = const <String, String>{
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
