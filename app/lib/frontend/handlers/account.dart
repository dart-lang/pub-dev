// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/account_api.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../account/session_cookie.dart' as session_cookie;
import '../../package/backend.dart';
import '../../package/search_service.dart';
import '../../publisher/backend.dart';
import '../../publisher/models.dart';
import '../../search/search_service.dart';
import '../../shared/configuration.dart' show activeConfiguration;
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';

import '../templates/admin.dart';
import '../templates/listing.dart';
import '../templates/misc.dart' show renderUnauthenticatedPage;

/// Handles POST /api/account/session
Future<shelf.Response> updateSessionHandler(
  shelf.Request request, {
  ClientSessionData clientSessionData,
}) async {
  final user = await requireAuthenticatedUser();

  // Only allow creation of sessions on the primary site host.
  // Exposing session on other domains is a security concern.
  // Note: staging sites may have a different primary host.
  if (request.requestedUri.host != activeConfiguration.primarySiteUri.host ||
      request.requestedUri.scheme !=
          activeConfiguration.primarySiteUri.scheme) {
    // The resource simply doesn't exist on this host.
    throw NotFoundException.resource('no such url');
  }

  // check if the session data is the same
  if (userSessionData != null &&
      userSessionData.userId == user.userId &&
      userSessionData.email == user.email &&
      userSessionData.imageUrl == clientSessionData.imageUrl) {
    final status = ClientSessionStatus(
      changed: false,
      expires: userSessionData.expires,
    );
    return jsonResponse(status.toJson());
  }

  final newSession = await accountBackend.createNewSession(
      imageUrl: clientSessionData.imageUrl);

  return jsonResponse(
    ClientSessionStatus(
      changed: true,
      expires: newSession.expires,
    ).toJson(),
    headers: session_cookie.createSessionCookie(newSession),
  );
}

/// Handles DELETE /api/account/session
Future<shelf.Response> invalidateSessionHandler(shelf.Request request) async {
  final hasUserSession = userSessionData != null;
  // Invalidate the server-side sessionId, in case the user signed out because
  // the local cookie store was compromised.
  if (hasUserSession) {
    await accountBackend.invalidateSession(userSessionData.sessionId);
  }
  return jsonResponse(
    ClientSessionStatus(
      changed: hasUserSession,
      expires: null,
    ).toJson(),
    // Clear cookie, so we don't have to lookup an invalid sessionId.
    headers: session_cookie.clearSessionCookie(),
  );
}

/// Handles GET /consent?id=<consentId>
Future<shelf.Response> consentPageHandler(
    shelf.Request request, String consentId) async {
  if (userSessionData == null) {
    return htmlResponse(renderUnauthenticatedPage());
  }
  // TODO: if no consentId is given, render the listing of user consents page
  return htmlResponse(renderConsentPage(consentId));
}

/// Handles /api/account/options/packages/<package>
Future<AccountPkgOptions> accountPkgOptionsHandler(
    shelf.Request request, String package) async {
  final user = await requireAuthenticatedUser();
  final p = await packageBackend.lookupPackage(package);
  if (p == null) {
    throw NotFoundException.resource(package);
  }
  return AccountPkgOptions(
      isAdmin: await packageBackend.isPackageAdmin(p, user.userId));
}

/// Handles /api/account/options/publishers/<publisherId>
Future<AccountPublisherOptions> accountPublisherOptionsHandler(
    shelf.Request request, String publisherId) async {
  final user = await requireAuthenticatedUser();
  final member =
      await publisherBackend.getPublisherMember(publisherId, user.userId);
  final isAdmin = member != null && member.role == PublisherMemberRole.admin;
  return AccountPublisherOptions(isAdmin: isAdmin);
}

/// Handles requests for GET /account/packages [?q=...]
Future<shelf.Response> accountPackagesPageHandler(shelf.Request request) async {
  if (userSessionData == null) {
    return htmlResponse(renderUnauthenticatedPage());
  }

  // Redirect in case of empty search query.
  if (request.requestedUri.query == 'q=') {
    return redirectResponse(request.requestedUri.path);
  }

  final publishers =
      await publisherBackend.listPublishersForUser(userSessionData.userId);
  final searchQuery = parseFrontendSearchQuery(
    request.requestedUri.queryParameters,
    uploaderOrPublishers: [
      userSessionData.email,
      ...publishers.map((p) => p.publisherId),
    ],
  );

  final searchResult = await searchService.search(searchQuery);
  final int totalCount = searchResult.totalCount;
  final links =
      PageLinks(searchQuery.offset, totalCount, searchQuery: searchQuery);

  final html = renderAccountPackagesPage(
    packages: searchResult.packages,
    pageLinks: links,
    searchQuery: searchQuery,
    totalCount: totalCount,
  );
  return htmlResponse(html);
}
