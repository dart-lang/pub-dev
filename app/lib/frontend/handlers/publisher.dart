// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/auth_provider.dart';
import '../../audit/backend.dart';
import '../../package/search_adapter.dart';
import '../../publisher/backend.dart';
import '../../publisher/models.dart';
import '../../shared/handlers.dart';
import '../../shared/redis_cache.dart' show cache;
import '../../shared/urls.dart' as urls;
import '../request_context.dart';
import '../templates/listing.dart' show PageLinks;
import '../templates/misc.dart';
import '../templates/publisher.dart';

import 'account.dart' show checkAuthenticatedPageRequest;
import 'misc.dart' show formattedNotFoundHandler;

/// Handles requests for GET /create-publisher
Future<shelf.Response> createPublisherPageHandler(shelf.Request request) async {
  final domain = request.requestedUri.queryParameters['domain'];
  final includeWebmasterScope = domain != null && domain.isNotEmpty;
  final unauthenticatedRs = await checkAuthenticatedPageRequest(
    request,
    requiredScopes: [if (includeWebmasterScope) webmasterScope],
  );
  if (unauthenticatedRs != null) {
    return unauthenticatedRs;
  }
  return htmlResponse(renderCreatePublisherPage(domain: domain));
}

/// Handles requests for GET /publishers
Future<shelf.Response> publisherListHandler(shelf.Request request) async {
  if (requestContext.uiCacheEnabled) {
    final content = await cache.uiPublisherListPage().get(() async {
      final page = await publisherBackend.listPublishers();
      return renderPublisherListPage(page.publishers!);
    });
    return htmlResponse(content!);
  }

  // no caching for logged-in user
  final page = await publisherBackend.listPublishers();
  final content = renderPublisherListPage(page.publishers!);
  return htmlResponse(content);
}

/// Handles requests for GET /publishers/<publisherId>
Future<shelf.Response> publisherPageHandler(
    shelf.Request request, String publisherId) async {
  checkPublisherIdParam(publisherId);
  return redirectResponse(urls.publisherPackagesUrl(publisherId));
}

/// Handles requests for GET /publishers/<publisherId>/packages [?q=...]
Future<shelf.Response> publisherPackagesPageHandler(
  shelf.Request request,
  String publisherId, {
  required PublisherPackagesPageKind kind,
}) async {
  // Redirect in case of empty search query.
  if (request.requestedUri.query == 'q=') {
    return redirectResponse(request.requestedUri.path);
  }

  // Reply with cached page if available.
  final isLanding = kind == PublisherPackagesPageKind.listed &&
      request.requestedUri.queryParameters.isEmpty;
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

  final searchForm = SearchForm.parse(request.requestedUri.queryParameters);
  // redirect to the search page when any search or pagination is present
  if (searchForm.isNotEmpty) {
    final redirectForm = searchForm
        .addRequiredTagIfAbsent(PackageTags.publisherTag(publisherId));
    return redirectResponse(
        redirectForm.toSearchLink(page: searchForm.currentPage));
  }

  SearchForm appliedSearchForm;
  switch (kind) {
    case PublisherPackagesPageKind.listed:
      appliedSearchForm =
          SearchForm().toggleRequiredTag(PackageTags.publisherTag(publisherId));
      break;
    case PublisherPackagesPageKind.unlisted:
      appliedSearchForm = SearchForm()
          .toggleRequiredTag(PackageTags.publisherTag(publisherId))
          .toggleRequiredTag(PackageTags.isUnlisted);
      break;
  }

  final searchResult = await searchAdapter.search(appliedSearchForm);
  final int totalCount = searchResult.totalCount;
  final links = PageLinks(appliedSearchForm, totalCount);

  final html = renderPublisherPackagesPage(
    publisher: publisher,
    kind: kind,
    searchResultPage: searchResult,
    pageLinks: links,
    searchForm: appliedSearchForm,
    totalCount: totalCount,
    isAdmin: await publisherBackend.isMemberAdmin(
        publisher, requestContext.authenticatedUserId),
    messageFromBackend: searchResult.message,
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

  final unauthenticatedRs = await checkAuthenticatedPageRequest(request);
  if (unauthenticatedRs != null) {
    return unauthenticatedRs;
  }
  final isAdmin = await publisherBackend.isMemberAdmin(
    publisher,
    requestContext.authenticatedUserId,
  );
  if (!isAdmin) {
    return htmlResponse(renderUnauthorizedPage());
  }

  return htmlResponse(renderPublisherAdminPage(
    publisher: publisher,
    members: await publisherBackend.listPublisherMembers(publisherId),
  ));
}

/// Handles requests for GET /publishers/<publisherId>/activity-log
Future<shelf.Response> publisherActivityLogPageHandler(
    shelf.Request request, String publisherId) async {
  final publisher = await publisherBackend.getPublisher(publisherId);
  if (publisher == null) {
    // We may introduce search for publishers (e.g. somebody just mistyped a
    // domain name), but now we just have a formatted error page.
    return formattedNotFoundHandler(request);
  }

  final unauthenticatedRs = await checkAuthenticatedPageRequest(request);
  if (unauthenticatedRs != null) {
    return unauthenticatedRs;
  }
  final isAdmin = await publisherBackend.isMemberAdmin(
    publisher,
    requestContext.authenticatedUserId,
  );
  if (!isAdmin) {
    return htmlResponse(renderUnauthorizedPage());
  }

  final before = auditBackend.parseBeforeQueryParameter(
      request.requestedUri.queryParameters['before']);
  final activities = await auditBackend.listRecordsForPublisher(
    publisherId,
    before: before,
  );
  return htmlResponse(renderPublisherActivityLogPage(
    publisher: publisher,
    activities: activities,
  ));
}
