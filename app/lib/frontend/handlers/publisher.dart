// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../package/search_service.dart';
import '../../publisher/backend.dart';
import '../../search/search_service.dart';
import '../../shared/handlers.dart';
import '../../shared/redis_cache.dart' show cache;
import '../../shared/urls.dart' as urls;
import '../request_context.dart';
import '../templates/listing.dart' show PageLinks;
import '../templates/misc.dart' show renderUnauthenticatedPage;
import '../templates/publisher.dart';

import 'misc.dart' show formattedNotFoundHandler;

/// Handles requests for GET /create-publisher
Future<shelf.Response> createPublisherPageHandler(shelf.Request request) async {
  return htmlResponse(renderCreatePublisherPage());
}

/// Handles requests for GET /publishers
Future<shelf.Response> publisherListHandler(shelf.Request request) async {
  final content = await cache.uiPublisherListPage().get(() async {
    final publishers = await publisherBackend.listPublishers(limit: 1000);
    return renderPublisherListPage(publishers, isGlobal: true);
  });
  return htmlResponse(content);
}

/// Handles requests for GET /account/publishers
Future<shelf.Response> accountPublishersPageHandler(
    shelf.Request request) async {
  if (userSessionData == null) {
    return htmlResponse(renderUnauthenticatedPage());
  } else {
    final publishers =
        await publisherBackend.listPublishersForUser(userSessionData.userId);
    final content = renderPublisherListPage(publishers, isGlobal: false);
    return htmlResponse(content);
  }
}

/// Handles requests for GET /publishers/<publisherId>
Future<shelf.Response> publisherPageHandler(
    shelf.Request request, String publisherId) async {
  return redirectResponse(urls.publisherPackagesUrl(publisherId));
}

/// Handles requests for GET /publishers/<publisherId>/packages [?q=...]
Future<shelf.Response> publisherPackagesPageHandler(
    shelf.Request request, String publisherId) async {
  final searchQuery = parseFrontendSearchQuery(
    request.requestedUri.queryParameters,
    publisherId: publisherId,
  );
  // Redirect in case of empty search query.
  if (request.requestedUri.query == 'q=') {
    return redirectResponse(request.requestedUri.path);
  }

  final isLanding = request.requestedUri.queryParameters.isEmpty;
  if (isLanding && requestContext.uiCacheEnabled) {
    final html = await cache.uiPublisherPackagesPage(publisherId).get();
    if (html != null) {
      return htmlResponse(html);
    }
  }

  final publisher = await publisherBackend.getPublisher(publisherId);
  if (publisher == null) {
    // We may introduce search for publishers (e.g. somebody just mistyped a
    // domain name), but now we just have a formatted error page.
    return formattedNotFoundHandler(request);
  }

  final searchResult = await searchService.search(searchQuery);
  final int totalCount = searchResult.totalCount;
  final links =
      PageLinks(searchQuery.offset, totalCount, searchQuery: searchQuery);

  final html = renderPublisherPackagesPage(
    publisher: publisher,
    packages: searchResult.packages,
    pageLinks: links,
    searchQuery: searchQuery,
    totalCount: totalCount,
  );
  if (isLanding && requestContext.uiCacheEnabled) {
    await cache.uiPublisherPackagesPage(publisherId).set(html);
  }
  return htmlResponse(html);
}

/// Handles requests for GET /publishers/<publisherId>/admin
Future<shelf.Response> publisherAdminPageHandler(
    shelf.Request request, String publisherId) async {
  final publisher = await publisherBackend.getPublisher(publisherId);
  if (publisher == null) {
    // We may introduce search for publishers (e.g. somebody just mistyped a
    // domain name), but now we just have a formatted error page.
    return formattedNotFoundHandler(request);
  }
  return htmlResponse(renderPublisherAdminPage(publisher));
}
