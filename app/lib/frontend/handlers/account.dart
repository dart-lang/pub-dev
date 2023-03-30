// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart';
import 'package:clock/clock.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../account/consent_backend.dart';
import '../../account/default_auth_provider.dart';
import '../../account/like_backend.dart';
import '../../account/session_cookie.dart' as session_cookie;
import '../../audit/backend.dart';
import '../../frontend/request_context.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../publisher/backend.dart';
import '../../publisher/models.dart';
import '../../scorecard/backend.dart';
import '../../shared/env_config.dart';
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';
import '../../shared/urls.dart' as urls;

import '../templates/admin.dart';
import '../templates/consent.dart';
import '../templates/misc.dart' show renderUnauthenticatedPage;

/// Handles requests for /authorized
shelf.Response authorizedHandler(_) => htmlResponse(renderAuthorizedPage());

/// Handles GET /sign-in
Future<shelf.Response> startSignInHandler(shelf.Request request) async {
  final session = await accountBackend.createOrUpdateClientSession(
    sessionId: requestContext.clientSessionCookieStatus.sessionId,
  );
  final params = request.requestedUri.queryParameters;
  // Automated authentication handling for local fake server.
  final fakeEmail = envConfig.isRunningLocally ? params['fake-email'] : null;
  final go = params['go'] ?? '/';
  if (!urls.isValidLocalRedirectUrl(go)) {
    return notFoundHandler(request, body: 'Invalid `go` URL.');
  }
  final state = <String, String>{
    if (fakeEmail != null) 'fake-email': fakeEmail,
    'go': go,
  };
  final oauth2Url = await authProvider.getOauthAuthenticationUrl(
    state: state,
    nonce: session.openidNonce!,
    promptSelect: params['select'] == '1',
    includeScopes: params['scope']?.split(' '),
    loginHint: requestContext.sessionData?.email,
  );
  return redirectResponse(
    oauth2Url.toString(),
    headers: session_cookie.createClientSessionCookie(
      sessionId: session.sessionId,
      maxAge: session.maxAge,
    ),
  );
}

/// Handles GET /sign-in/complete
Future<shelf.Response> signInCompleteHandler(shelf.Request request) async {
  final params = request.requestedUri.queryParameters;
  final error = params['error'];
  if (error != null && error.isNotEmpty) {
    return htmlResponse('There was an error: $error', status: 401);
  }

  final code = params['code'];
  if (code == null || code.isEmpty) {
    return notFoundHandler(request, body: 'Missing `code`.');
  }
  final state = decodeState(params['state']);
  final go = state['go'];
  if (go == null || !urls.isValidLocalRedirectUrl(go)) {
    return notFoundHandler(request, body: 'Missing or invalid `go`.');
  }

  if (!requestContext.clientSessionCookieStatus.isPresent) {
    return notFoundHandler(request, body: 'Missing session cookie.');
  }
  final session = await accountBackend.lookupValidUserSession(
      requestContext.clientSessionCookieStatus.sessionId!);
  if (session == null) {
    return notFoundHandler(
      request,
      body: 'Expired session.',
      headers: session_cookie.clearSessionCookies(),
    );
  }
  final expectedNonce = session.openidNonce;
  if (expectedNonce == null) {
    return notFoundHandler(request, body: 'Missing `nonce` in session.');
  }
  final profile = await authProvider.tryAuthenticateOauthCode(
    code: code,
    expectedNonce: expectedNonce,
  );
  if (profile == null) {
    throw AuthenticationException.failed();
  }
  final newSession = await accountBackend.updateClientSessionWithProfile(
    sessionId: session.sessionId,
    profile: profile,
  );
  return redirectResponse(
    go,
    headers: session_cookie.createClientSessionCookie(
      sessionId: newSession.sessionId,
      maxAge: newSession.maxAge,
    ),
  );
}

/// Handles GET /api/account/session
Future<ClientSessionStatus> getAccountSessionHandler(
    shelf.Request request) async {
  final sessionData = requestContext.sessionData;
  return ClientSessionStatus(
    expires: sessionData?.expires,
    authenticatedAt: sessionData?.authenticatedAt,
  );
}

/// Handles DELETE /api/account/session
Future<shelf.Response> invalidateSessionHandler(shelf.Request request) async {
  final sessionId = requestContext.sessionData?.sessionId;
  final userId = requestContext.authenticatedUserId;
  // Invalidate the server-side session object, in case the user signed out because
  // the local cookie store was compromised.
  if (sessionId != null) {
    await accountBackend.invalidateUserSession(sessionId);
  }
  if (userId != null) {
    await accountBackend.invalidateAllUserSessions(userId);
  }
  return jsonResponse(
    {},
    // Clear cookie, so we don't have to lookup an invalid sessionId.
    headers: session_cookie.clearSessionCookies(),
  );
}

/// Handles GET /consent?id=<consentId>
Future<shelf.Response> consentPageHandler(
    shelf.Request request, String? consentId) async {
  final unauthenticatedRs = await checkAuthenticatedPageRequest(request);
  if (unauthenticatedRs != null) {
    return unauthenticatedRs;
  }

  if (consentId == null || consentId.isEmpty) {
    // TODO: if no consentId is given, render the listing of user consents page
    throw NotFoundException('Missing consent id.');
  }

  final user =
      await accountBackend.lookupUserById(requestContext.authenticatedUserId!);
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
  final user = await requireAuthenticatedWebUser();
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
  final authenticatedUser = await requireAuthenticatedWebUser();
  final user = authenticatedUser.user;
  final packages = await likeBackend.listPackageLikes(user);
  final List<PackageLikeResponse> packageLikes = List.from(packages.map(
      (like) => PackageLikeResponse(
          liked: true, package: like.package, created: like.created)));
  return LikedPackagesRepsonse(likedPackages: packageLikes);
}

/// Handles GET /api/account/likes/<package>
Future<PackageLikeResponse> getLikePackageHandler(
    shelf.Request request, String package) async {
  checkPackageVersionParams(package);
  final user = await requireAuthenticatedWebUser();
  final p = await packageBackend.lookupPackage(package);
  if (p == null) {
    throw NotFoundException.resource(package);
  }

  final like = await likeBackend.getPackageLikeStatus(user.userId, package);
  return PackageLikeResponse(
    liked: like != null,
    package: package,
    created: like?.created,
  );
}

/// Handles PUT /api/account/likes/<package>
Future<PackageLikeResponse> likePackageHandler(
    shelf.Request request, String package) async {
  final authenticatedUser = await requireAuthenticatedWebUser();
  final user = authenticatedUser.user;
  final l = await likeBackend.likePackage(user, package);
  return PackageLikeResponse(liked: true, package: package, created: l.created);
}

/// Handles DELETE /api/account/likes/<package>
Future<shelf.Response> unlikePackageHandler(
    shelf.Request request, String package) async {
  final authenticatedUser = await requireAuthenticatedWebUser();
  final user = authenticatedUser.user;
  await likeBackend.unlikePackage(user, package);
  return shelf.Response(204);
}

/// Handles /api/account/options/publishers/<publisherId>
Future<AccountPublisherOptions> accountPublisherOptionsHandler(
    shelf.Request request, String publisherId) async {
  checkPublisherIdParam(publisherId);
  final user = await requireAuthenticatedWebUser();
  final publisher = await publisherBackend.getPublisher(publisherId);
  if (publisher == null) {
    throw NotFoundException.resource('publisher "$publisherId"');
  }
  final member =
      await publisherBackend.getPublisherMember(publisher, user.userId);
  final isAdmin = member != null && member.role == PublisherMemberRole.admin;
  return AccountPublisherOptions(isAdmin: isAdmin);
}

/// Handles requests for GET /my-packages [?q=...]
Future<shelf.Response> accountPackagesPageHandler(shelf.Request request) async {
  final unauthenticatedRs = await checkAuthenticatedPageRequest(request);
  if (unauthenticatedRs != null) {
    return unauthenticatedRs;
  }

  // Redirect in case of empty search query.
  if (request.requestedUri.query == 'q=') {
    return redirectResponse(request.requestedUri.path);
  }

  final next = request.requestedUri.queryParameters['next'];
  final page = await packageBackend
      .listPackagesForUser(requestContext.authenticatedUserId!, next: next);
  final hits = await scoreCardBackend.getPackageViews(page.packages);

  final html = renderAccountPackagesPage(
    user: (await accountBackend
        .lookupUserById(requestContext.authenticatedUserId!))!,
    userSessionData: requestContext.sessionData!,
    startPackage: next,
    packageHits: hits.whereType<PackageView>().toList(),
    nextPackage: page.nextPackage,
  );
  return htmlResponse(html);
}

/// Handles requests for GET my-liked-packages
Future<shelf.Response> accountMyLikedPackagesPageHandler(
    shelf.Request request) async {
  final unauthenticatedRs = await checkAuthenticatedPageRequest(request);
  if (unauthenticatedRs != null) {
    return unauthenticatedRs;
  }

  final user = (await accountBackend
      .lookupUserById(requestContext.authenticatedUserId!))!;
  final likes = await likeBackend.listPackageLikes(user);
  final html = renderMyLikedPackagesPage(
    user: user,
    userSessionData: requestContext.sessionData!,
    likes: likes,
  );
  return htmlResponse(html);
}

/// Handles requests for GET /my-publishers
Future<shelf.Response> accountPublishersPageHandler(
    shelf.Request request) async {
  final unauthenticatedRs = await checkAuthenticatedPageRequest(request);
  if (unauthenticatedRs != null) {
    return unauthenticatedRs;
  }

  final page = await publisherBackend
      .listPublishersForUser(requestContext.authenticatedUserId!);
  final content = renderAccountPublishersPage(
    user: (await accountBackend
        .lookupUserById(requestContext.authenticatedUserId!))!,
    userSessionData: requestContext.sessionData!,
    publishers: page.publishers!,
  );
  return htmlResponse(content);
}

/// Handles requests for GET /my-activity-log
Future<shelf.Response> accountMyActivityLogPageHandler(
    shelf.Request request) async {
  final unauthenticatedRs = await checkAuthenticatedPageRequest(request);
  if (unauthenticatedRs != null) {
    return unauthenticatedRs;
  }
  final before = auditBackend.parseBeforeQueryParameter(
      request.requestedUri.queryParameters['before']);
  final activities = await auditBackend.listRecordsForUserId(
    requestContext.authenticatedUserId!,
    before: before,
  );
  final content = renderAccountMyActivityPage(
    user: (await accountBackend
        .lookupUserById(requestContext.authenticatedUserId!))!,
    userSessionData: requestContext.sessionData!,
    activities: activities,
  );
  return htmlResponse(content);
}

/// Prepares the common responses for unauthenticated users or sessions that
/// need redirect to the authentication service.
///
/// Returns non-null response if the further request processing is blocked.
Future<shelf.Response?> checkAuthenticatedPageRequest(
  shelf.Request request, {
  List<String> requiredScopes = const <String>[],
}) async {
  if (requestContext.isNotAuthenticated) {
    return htmlResponse(renderUnauthenticatedPage());
  }

  final now = clock.now();
  final lastAuthenticated = requestContext.sessionData?.authenticatedAt;
  final isLastAuthenticationOld = lastAuthenticated == null ||
      now.difference(lastAuthenticated) > Duration(minutes: 30);

  final grantedScopes = requestContext.sessionData?.grantedScopes ?? <String>[];
  final hasAllRequiredScopes = requiredScopes.every(grantedScopes.contains);

  final needsReAuthentication =
      isLastAuthenticationOld || !hasAllRequiredScopes;
  if (needsReAuthentication) {
    final requestedUri = request.requestedUri;
    final goUri = Uri(
      path: requestedUri.path,
      query: requestedUri.hasQuery ? requestedUri.query : null,
    );
    final signInUri = Uri(path: '/sign-in', queryParameters: {
      'go': goUri.toString(),
      if (requiredScopes.isNotEmpty) 'scope': requiredScopes.join(' '),
    });
    return redirectResponse(signInUri.toString());
  }

  return null;
}
