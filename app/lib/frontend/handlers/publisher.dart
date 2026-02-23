// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:pub_dev/frontend/templates/views/publisher/publisher_list.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/auth_provider.dart';
import '../../audit/backend.dart';
import '../../package/search_adapter.dart';
import '../../publisher/backend.dart';
import '../../publisher/models.dart';
import '../../shared/handlers.dart';
import '../../shared/redis_cache.dart' show cache;
import '../../shared/urls.dart' as urls;
import '../dom/dom.dart' as d;
import '../request_context.dart';
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
  final content = await cache.uiPublisherListPageContent().get(() async {
    final page = await publisherBackend.listPublishers();
    return publisherListNode(
      publishers: page.publishers ?? <PublisherSummary>[],
      isGlobal: true,
    );
  });
  return htmlResponse(renderPublisherListPage(content!));
}

/// Handles requests for `GET /publishers/<publisherId>`.
Future<shelf.Response> publisherPageHandler(
  shelf.Request request,
  String publisherId,
) async {
  checkPublisherIdParam(publisherId);
  return redirectResponse(urls.publisherPackagesUrl(publisherId));
}

/// Handles requests for `GET /publishers/<publisherId>/packages [?q=...]`.
Future<shelf.Response> publisherPackagesPageHandler(
  shelf.Request request,
  String publisherId, {
  required PublisherPackagesPageKind kind,
}) async {
  checkPublisherIdParam(publisherId);

  // Redirect in case of empty search query.
  if (request.requestedUri.query == 'q=') {
    return redirectResponse(request.requestedUri.path);
  }

  final status = await publisherBackend.getPublisherStatus(publisherId);
  switch (status) {
    case .missing:
      // We may introduce search for publishers (e.g. somebody just mistyped a
      // domain name), but now we just have a formatted error page.
      return formattedNotFoundHandler(request);
    case .moderated:
      final message = 'The publisher `$publisherId` has been moderated.';
      return htmlResponse(
        renderErrorPage(default404NotFound, message),
        status: 404,
      );
    case .abandoned:
    case .active:
      // continue rendering
      break;
  }

  final searchForm = SearchForm.parse(request.requestedUri.queryParameters);
  // redirect to the search page when any search or pagination is present
  if (searchForm.isNotEmpty) {
    final redirectForm = searchForm.addRequiredTagIfAbsent(
      PackageTags.publisherTag(publisherId),
    );
    return redirectResponse(
      redirectForm.toSearchLink(page: searchForm.currentPage),
    );
  }

  SearchForm appliedSearchForm;
  switch (kind) {
    case PublisherPackagesPageKind.listed:
      appliedSearchForm = SearchForm().toggleRequiredTag(
        PackageTags.publisherTag(publisherId),
      );
      break;
    case PublisherPackagesPageKind.unlisted:
      appliedSearchForm = SearchForm()
          .toggleRequiredTag(PackageTags.publisherTag(publisherId))
          .toggleRequiredTag(PackageTags.isUnlisted);
      break;
  }

  final publisher = await publisherBackend.lookupPublisher(publisherId);
  final (tabContent, totalCount) =
      await cache.publisherPackagesTabContent(publisherId, kind).get(() async {
            final searchResult = await searchAdapter.search(
              appliedSearchForm,
              // Do not apply rate limit here.
              rateLimitKey: null,
            );
            final tabContent = publisherPackagesListTabContentNode(
              publisherId: publisherId,
              kind: kind,
              searchResultPage: searchResult,
            );
            return (tabContent, searchResult.totalCount);
          })
          as (d.Node, int);

  final html = renderPublisherPackagesPage(
    publisher: publisher!,
    kind: kind,
    searchForm: appliedSearchForm,
    tabContent: tabContent,
    totalCount: totalCount,
    isAdmin: await publisherBackend.isMemberAdmin(
      publisher,
      requestContext.authenticatedUserId,
    ),
  );
  return htmlResponse(html);
}

/// Handles requests for `GET /publishers/<publisherId>/admin`.
Future<shelf.Response> publisherAdminPageHandler(
  shelf.Request request,
  String publisherId,
) async {
  final publisher = await publisherBackend.getListedPublisher(publisherId);
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
    return htmlResponse(renderUnauthorizedPage(), status: 403);
  }

  return htmlResponse(
    renderPublisherAdminPage(
      publisher: publisher,
      members: await publisherBackend.listPublisherMembers(publisherId),
    ),
  );
}

/// Handles requests for `GET /publishers/<publisherId>/activity-log`.
Future<shelf.Response> publisherActivityLogPageHandler(
  shelf.Request request,
  String publisherId,
) async {
  final publisher = await publisherBackend.getListedPublisher(publisherId);
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
    return htmlResponse(renderUnauthorizedPage(), status: 403);
  }

  final before = auditBackend.parseBeforeQueryParameter(
    request.requestedUri.queryParameters['before'],
  );
  final activities = await auditBackend.listRecordsForPublisher(
    publisherId,
    before: before,
  );
  return htmlResponse(
    renderPublisherActivityLogPage(
      publisher: publisher,
      activities: activities,
    ),
  );
}
