// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers;

import 'dart:math';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart' show dbService;
import 'package:pub_semver/pub_semver.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'handlers_redirects.dart';
import 'search_service.dart';
import 'models.dart';
import 'templates.dart';

/// Handler for the whole URL space of pub.dartlang.org
///
/// The passed in [shelfPubApi] handler will be used for handling requests to
///   - /api/*
appHandler(shelf.Request request, shelf.Handler shelfPubApi) {
  var path = request.url.path;

  var handler = {
      '/' : indexHandler,
      '/authorized' : authorizedHandler,
      '/doc' : docHandler,
      '/site-map' : sitemapHandler,
      '/admin' : adminHandler,
      '/search' : searchHandler,
      '/packages' : packagesHandler,
  }[path];

  if (handler != null) {
    return handler(request);
  } else if (path.startsWith('/api') ||
             path.startsWith('/packages') && path.endsWith('.tar.gz')) {
    return shelfPubApi(request);
  } else if (path.startsWith('/packages/')) {
    return packageHandler(request);
  } else {
    return _notFoundHandler(request);
  }
}

/// Handles requests for /
indexHandler(_) async {
  var query = dbService.query(Package)
      ..order('-updated')
      ..limit(5);
  var packages = await query.run().toList();
  var versionKeys = packages.map((p) => p.latestVersion).toList();
  var versions = await dbService.lookup(versionKeys);
  assert(!versions.any((version) => version == null));
  return _htmlResponse(renderIndexPage(versions));
}

/// Handles requests for /authorized
authorizedHandler(_) => _htmlResponse(renderAuthorizedPage());

/// Handles requests for /doc
docHandler(shelf.Request request) {
  var pubDocUrl = 'https://www.dartlang.org/tools/pub/';
  var dartlangDotOrgPath = REDIRECT_PATHS[request.url.path];
  if (dartlangDotOrgPath != null) {
    return _redirectResponse('$pubDocUrl$dartlangDotOrgPath');
  }
  return _redirectResponse(pubDocUrl);
}

/// Handles requests for /site-map
sitemapHandler(_) => _htmlResponse(renderSitemapPage());

/// Handles requests for /admin
adminHandler(shelf.Request request) async {
  var users = userService;
  var db = dbService;

  if (users.currentUser == null) {
    return _redirectResponse(await users.createLoginUrl('${request.url}'));
  } else {
    var email = users.currentUser.email;
    var isNonGoogleUser = !email.endsWith('@google.com');
    if (isNonGoogleUser) {
      var status = 'Unauthorized';
      var message = 'You do not have access to this page.';
      return _htmlResponse(renderErrorPage(status, message, null), status: 403);
    } else {
      var privateKeyKey = db.emptyKey.append(PrivateKey, id: 'singleton');
      PrivateKey key = (await db.lookup([privateKeyKey])).first;
      assert(key != null);
      // TODO: Pass `reloadStatus` to renderAdminPage.
      return _htmlResponse(renderAdminPage(key != null, true));
    }
  }
}

/// Handles requests for /search
searchHandler(shelf.Request request) async {
  var query = request.url.queryParameters['q'];
  if (query == null) {
    return _htmlResponse(
        renderSearchPage(query, [], new SearchLinks.empty(query)));
  }

  int page = _pageFromUrl(
      request.url, maxPages: SEARCH_MAX_RESULTS ~/ PageLinks.RESULTS_PER_PAGE);

  int offset = PageLinks.RESULTS_PER_PAGE * (page - 1);
  int resultCount = PageLinks.RESULTS_PER_PAGE;
  var searchPage = await searchService.search(query, offset, resultCount);
  var links = new SearchLinks(query, searchPage.offset, searchPage.totalCount);
  return
      _htmlResponse(renderSearchPage(query, searchPage.packageVersions, links));
}

/// Handles requests for /packages
///   TODO: handle ...?format=json URIs
packagesHandler(shelf.Request request) async {
  int page = _pageFromUrl(request.url);

  var db = dbService;
  var offset = PackageLinks.RESULTS_PER_PAGE * (page - 1);
  var limit = PackageLinks.MAX_PAGES * PackageLinks.RESULTS_PER_PAGE + 1;

  var query = db.query(Package)
      ..offset(offset)
      ..limit(limit)
      ..order('-updated');

  var packages = await query.run().toList();
  var links = new PackageLinks(offset, offset + packages.length);
  var pagePackages = packages.take(PackageLinks.RESULTS_PER_PAGE).toList();
  var versionKeys = pagePackages.map((p) => p.latestVersion).toList();
  var versions = await db.lookup(versionKeys);
  return _htmlResponse(renderPkgIndexPage(pagePackages, versions, links));
}

/// Handles requests for /packages/...
///
/// Handles the following URLs:
///   - /packages/<package>
///   - /packages/<package>/versions
packageHandler(shelf.Request request) {
  var path = request.url.path.substring('/packages/'.length);

  int slash = path.indexOf('/');
  if (slash == -1) {
    return packageShowHandler(request, path);
  }

  var package = path.substring(0, slash);
  if (path.substring(slash) == '/versions') {
    return packageVersionsHandler(request, package);
  }
  return _notFoundHandler(request);
}

/// Handles requests for /packages/<package>
///   TODO: handle ...?format=json URIs
packageShowHandler(shelf.Request request, String packageName) async {
  var db = dbService;
  var packageKey = db.emptyKey.append(Package, id: packageName);
  Package package = (await db.lookup([packageKey])).first;
  if (package == null) return _notFoundHandler(request);

  var versions = await
      db.query(PackageVersion, ancestorKey: package.key).run().toList();
  _sortVersionsDesc(versions);
  var first10Versions = versions.take(10).toList();
  return _htmlResponse(renderPkgShowPage(
      package, first10Versions, first10Versions.last, versions.length));
}

/// Handles requests for /packages/<package>/versions/<version>
packageVersionsHandler(shelf.Request request, String packageName) async {
  var db = dbService;
  var packageKey = db.emptyKey.append(Package, id: packageName);
  Package package = (await db.lookup([packageKey])).first;
  if (package == null) return _notFoundHandler(request);

  var versions = await
      db.query(PackageVersion, ancestorKey: package.key).run().toList();
  _sortVersionsDesc(versions);
  return _htmlResponse(renderPkgVersionsPage(package, versions));
}


shelf.Response _notFoundHandler(request) {
  var status = '404 Not Found';
  var message = 'The path \'${request.url.path}\' was not found.';
  return _htmlResponse(renderErrorPage(status, message, null), status: 404);
}

shelf.Response _htmlResponse(String content, {int status: 200}) {
  return new shelf.Response(
      status,
      body: content,
      headers: {'content-type' : 'text/html; charset=utf-8'});
}

shelf.Response _redirectResponse(url) {
  return new shelf.Response.seeOther(url);
}


/// Sorts [versions] according to the semantic versioning specification.
void _sortVersionsDesc(List<PackageVersion> versions) {
  versions.sort((PackageVersion a, PackageVersion b) {
    var av = new Version.parse(a.version);
    var bv = new Version.parse(b.version);
    return bv.compareTo(av);
  });
}


/// Extracts the 'page' query parameter from [url].
///
/// Returns a valid positive integer. If [maxPages] is given, the result is
/// clamped to [maxPages].
int _pageFromUrl(Uri url, {int maxPages}) {
  var pageAsString = url.queryParameters['page'];
  int pageAsInt = 1;
  if (pageAsString != null) {
    try {
      pageAsInt = max(int.parse(pageAsString), 1);
    } catch (error, stack) { }
  }

  if (maxPages != null && pageAsInt > maxPages) pageAsInt = maxPages;
  return pageAsInt;
}
