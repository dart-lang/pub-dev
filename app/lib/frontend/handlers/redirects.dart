// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_redirects;

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../shared/handlers.dart';
import '../../shared/urls.dart';

part 'redirects.g.dart';

/// Routes that are only processed by the old pub domain.
class PubDartlangOrgService {
  Router get router => _$PubDartlangOrgServiceRouter(this);

  /// (Old) pub client doc redirect
  @Route.get('/doc')
  @Route.get('/doc/<path|[^]*>')
  Future<Response> doc(Request request) async => _docRedirectHandler(request);

  /// (Old) server index redirect
  @Route.get('/server')
  Future<Response> server(Request request) async =>
      redirectResponse('$siteRoot/');

  /// (Old) Flutter plugins redirect
  @Route.get('/flutter/plugins')
  Future<Response> flutterPlugins(Request request) async =>
      redirectResponse('$siteRoot/flutter/packages');

  /// (Old) Server packages redirect
  @Route.get('/server/packages')
  Future<Response> serverPackages(Request request) async =>
      redirectResponse(request.requestedUri
          .replace(host: primaryHost, path: '/packages')
          .toString());

  /// (Old) Search redirect
  @Route.get('/search')
  Future<Response> search(Request request) async =>
      redirectResponse(request.requestedUri
          .replace(host: primaryHost, path: '/packages')
          .toString());
}

/// Routes that are only processed by the legacy dartdocs.org domain.
class LegacyDartdocService {
  Router get router => _$LegacyDartdocServiceRouter(this);

  /// Landing page of dartdocs.org
  @Route.get('/')
  Future<Response> index(Request request) async =>
      redirectResponse(fullSiteUrl);

  /// Specific documentation page of dartdocs.org
  @Route.get('/documentation')
  @Route.get('/documentation/<path|[^]*>')
  Future<Response> documentation(Request request) async =>
      redirectResponse(Uri.parse(fullSiteUrl)
          .replace(path: request.requestedUri.path)
          .toString());

  @Route.all('/<_|.*>')
  Response catchAll(Request request) => Response.notFound('Not Found.');
}

/// Handles requests for /doc
Response _docRedirectHandler(Request request) {
  final pubDocUrl = '$dartSiteRoot/tools/pub/';
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
