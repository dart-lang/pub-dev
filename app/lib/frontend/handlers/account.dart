// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:client_data/account_api.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../account/consent_backend.dart';
import '../../account/session_cookie.dart' as session_cookie;
import '../../package/backend.dart';
import '../../package/search_adapter.dart';
import '../../publisher/backend.dart';
import '../../publisher/models.dart';
import '../../search/search_form.dart';
import '../../shared/configuration.dart' show activeConfiguration;
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';

import '../templates/admin.dart';
import '../templates/consent.dart';
import '../templates/listing.dart';
import '../templates/misc.dart' show renderUnauthenticatedPage;

/// Handles requests for /authorized
shelf.Response authorizedHandler(_) => htmlResponse(renderAuthorizedPage());

/// Handles POST /api/account/session
Future<shelf.Response> updateSessionHandler(
    shelf.Request request, ClientSessionRequest body) async {
  final user = await requireAuthenticatedUser();

  InvalidInputException.checkNotNull(body.accessToken, 'accessToken');
  await accountBackend.verifyAccessTokenOwnership(body.accessToken!, user);

  // Only allow creation of sessions on the primary site host.
  // Exposing session on other domains is a security concern.
  // Note: staging sites may have a different primary host.
  if (request.requestedUri.host != activeConfiguration.primarySiteUri.host ||
      request.requestedUri.scheme !=
          activeConfiguration.primarySiteUri.scheme) {
    // The resource simply doesn't exist on this host.
    throw NotFoundException.resource('no such url');
  }

  final cookieString = request.headers[HttpHeaders.cookieHeader];
  final sessionData =
      await accountBackend.parseAndLookupSessionCookie(cookieString);
  // check if the session data is the same
  if (sessionData != null &&
      sessionData.userId == user.userId &&
      sessionData.email == user.email) {
    final status = ClientSessionStatus(
      changed: false,
      expires: sessionData.expires,
    );
    return jsonResponse(status.toJson());
  }

  final profile = await authProvider.getAccountProfile(body.accessToken);
  final newSession = await accountBackend.createNewSession(
    name: profile!.name!,
    imageUrl: profile.imageUrl!,
  );

  return jsonResponse(
    ClientSessionStatus(
      changed: true,
      expires: newSession.expires,
    ).toJson(),
    headers: session_cookie.createSessionCookie(
        newSession.sessionId, newSession.expires),
  );
}

/// Handles DELETE /api/account/session
Future<shelf.Response> invalidateSessionHandler(shelf.Request request) async {
  final cookieString = request.headers[HttpHeaders.cookieHeader];
  final sessionData =
      await accountBackend.parseAndLookupSessionCookie(cookieString);
  final hasUserSession = sessionData != null;
  // Invalidate the server-side sessionId, in case the user signed out because
  // the local cookie store was compromised.
  if (hasUserSession) {
    await accountBackend.invalidateSession(sessionData!.sessionId);
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
    shelf.Request request, String? consentId) async {
  if (userSessionData == null) {
    return htmlResponse(renderUnauthenticatedPage());
  }

  if (consentId == null || consentId.isEmpty) {
    // TODO: if no consentId is given, render the listing of user consents page
    throw NotFoundException('Missing consent id.');
  }

  final user = await accountBackend.lookupUserById(userSessionData!.userId!);
  final consent = await consentBackend.getConsent(consentId, user!);
  // If consent does not exists (or does not belong to the user), the `getConsent`
  // call above will throw, and the generic error page will be shown.
  // TODO: handle missing/expired consent gracefully

  return htmlResponse(
    renderConsentPage(
      consentId: consentId,
      title: consent.titleText,
      descriptionHtml: consent.descriptionHtml,
    ),
    // Consent pages have the consent ID in the URL. Browsers should not pass on
    // this ID to the pages that are linked from the consent page.
    noReferrer: true,
  );
}

/// Handles GET /api/account/options/packages/<package>
Future<AccountPkgOptions> accountPkgOptionsHandler(
    shelf.Request request, String package) async {
  checkPackageVersionParams(package);
  final user = await requireAuthenticatedUser();
  final p = await packageBackend.lookupPackage(package);
  if (p == null) {
    throw NotFoundException.resource(package);
  }
  return AccountPkgOptions(
      isAdmin: await packageBackend.isPackageAdmin(p, user.userId));
}

/// Handles GET /api/account/likes
Future<LikedPackagesRepsonse> listPackageLikesHandler(
    shelf.Request request) async {
  final user = await requireAuthenticatedUser();
  final packages = await accountBackend.listPackageLikes(user);
  final List<PackageLikeResponse> packageLikes = List.from(packages.map(
      (like) => PackageLikeResponse(
          liked: true, package: like.package, created: like.created)));
  return LikedPackagesRepsonse(likedPackages: packageLikes);
}

/// Handles GET /api/account/likes/<package>
Future<PackageLikeResponse> getLikePackageHandler(
    shelf.Request request, String package) async {
  checkPackageVersionParams(package);
  final user = await requireAuthenticatedUser();
  final p = await packageBackend.lookupPackage(package);
  if (p == null) {
    throw NotFoundException.resource(package);
  }

  final like = await accountBackend.getPackageLikeStatus(user.userId, package);
  return PackageLikeResponse(
    liked: like != null,
    package: package,
    created: like?.created,
  );
}

/// Handles PUT /api/account/likes/<package>
Future<PackageLikeResponse> likePackageHandler(
    shelf.Request request, String package) async {
  final user = await requireAuthenticatedUser();
  final l = await accountBackend.likePackage(user, package);
  return PackageLikeResponse(liked: true, package: package, created: l.created);
}

/// Handles DELETE /api/account/likes/<package>
Future<shelf.Response> unlikePackageHandler(
    shelf.Request request, String package) async {
  final user = await requireAuthenticatedUser();

  await accountBackend.unlikePackage(user, package);
  return shelf.Response(204);
}

/// Handles /api/account/options/publishers/<publisherId>
Future<AccountPublisherOptions> accountPublisherOptionsHandler(
    shelf.Request request, String publisherId) async {
  checkPublisherIdParam(publisherId);
  final user = await requireAuthenticatedUser();
  final member =
      await publisherBackend.getPublisherMember(publisherId, user.userId);
  final isAdmin = member != null && member.role == PublisherMemberRole.admin;
  return AccountPublisherOptions(isAdmin: isAdmin);
}

/// Handles requests for GET /my-packages [?q=...]
Future<shelf.Response> accountPackagesPageHandler(shelf.Request request) async {
  if (userSessionData == null) {
    return htmlResponse(renderUnauthenticatedPage());
  }

  // Redirect in case of empty search query.
  if (request.requestedUri.query == 'q=') {
    return redirectResponse(request.requestedUri.path);
  }

  final page =
      await publisherBackend.listPublishersForUser(userSessionData!.userId!);
  final searchForm = parseFrontendSearchForm(
    request.requestedUri.queryParameters,
    uploaderOrPublishers: [
      // TODO: remove email after userId is populated in the search index
      userSessionData!.email!,
      userSessionData!.userId!,
      ...page.publishers!.map((p) => p.publisherId),
    ],
    includeAll: true,
  );

  final searchResult = await searchAdapter.search(searchForm);
  final int totalCount = searchResult.totalCount;
  final links = PageLinks(searchForm, totalCount);

  final html = renderAccountPackagesPage(
    user: (await accountBackend.lookupUserById(userSessionData!.userId!))!,
    userSessionData: userSessionData!,
    searchResultPage: searchResult,
    pageLinks: links,
    searchForm: searchForm,
    totalCount: totalCount,
    messageFromBackend: searchResult.message,
  );
  return htmlResponse(html);
}

/// Handles requests for GET my-liked-packages
Future<shelf.Response> accountMyLikedPackagesPageHandler(
    shelf.Request request) async {
  if (userSessionData == null) {
    return htmlResponse(renderUnauthenticatedPage());
  }

  final user = (await accountBackend.lookupUserById(userSessionData!.userId!))!;
  final likes = await accountBackend.listPackageLikes(user);
  final html = renderMyLikedPackagesPage(
    user: user,
    userSessionData: userSessionData!,
    likes: likes,
  );
  return htmlResponse(html);
}

/// Handles requests for GET /my-publishers
Future<shelf.Response> accountPublishersPageHandler(
    shelf.Request request) async {
  if (userSessionData == null) {
    return htmlResponse(renderUnauthenticatedPage());
  }

  final page =
      await publisherBackend.listPublishersForUser(userSessionData!.userId!);
  final content = renderAccountPublishersPage(
    user: (await accountBackend.lookupUserById(userSessionData!.userId!))!,
    userSessionData: userSessionData!,
    publishers: page.publishers!,
  );
  return htmlResponse(content);
}

/// Handles requests for GET /my-activity-log
Future<shelf.Response> accountMyActivityLogPageHandler(
    shelf.Request request) async {
  if (userSessionData == null) {
    return htmlResponse(renderUnauthenticatedPage());
  }
  final before = auditBackend.parseBeforeQueryParameter(
      request.requestedUri.queryParameters['before']);
  final activities = await auditBackend.listRecordsForUserId(
    userSessionData!.userId!,
    before: before,
  );
  final content = renderAccountMyActivityPage(
    user: (await accountBackend.lookupUserById(userSessionData!.userId!))!,
    userSessionData: userSessionData!,
    activities: activities,
  );
  return htmlResponse(content);
}
