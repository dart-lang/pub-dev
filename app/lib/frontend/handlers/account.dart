// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:_pub_shared/data/account_api.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/account/default_auth_provider.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../account/consent_backend.dart';
import '../../account/like_backend.dart';
import '../../account/session_cookie.dart' as session_cookie;
import '../../audit/backend.dart';
import '../../frontend/request_context.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../publisher/backend.dart';
import '../../publisher/models.dart';
import '../../scorecard/backend.dart';
import '../../shared/configuration.dart' show activeConfiguration;
import '../../shared/cookie_utils.dart';
import '../../shared/env_config.dart';
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';

import '../templates/admin.dart';
import '../templates/consent.dart';
import '../templates/misc.dart' show renderUnauthenticatedPage;

final _logger = Logger('account_handler');

/// Handles requests for /authorized
shelf.Response authorizedHandler(_) => htmlResponse(renderAuthorizedPage());

/// Handles GET /sign-in
Future<shelf.Response> startSignInHandler(shelf.Request request) async {
  if (!requestContext.experimentalFlags.useNewSignIn) {
    return notFoundHandler(request);
  }
  final session = await accountBackend.createOrUpdateClientSession(
    sessionId: requestContext.clientSessionCookieStatus.sessionId,
  );
  final params = request.requestedUri.queryParameters;
  // Automated authentication handling for local fake server.
  final fakeEmail = envConfig.isRunningLocally ? params['fake-email'] : null;
  final go = params['go'];
  // TODO: verify go
  final state = <String, String>{
    if (fakeEmail != null) 'fake-email': fakeEmail,
    if (go != null) 'go': go,
  };
  final oauth2Url = await authProvider.getOauthAuthenticationUrl(
    state: state,
    nonce: session.openidNonce!,
    promptConsent: false,
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

/// Handles GET /sign-in/callback
Future<shelf.Response> signInCallbackHandler(shelf.Request request) async {
  if (!requestContext.experimentalFlags.useNewSignIn) {
    return notFoundHandler(request);
  }
  final params = request.requestedUri.queryParameters;
  final error = params['error'];
  if (error != null && error.isNotEmpty) {
    return htmlResponse('There was an error: $error', status: 401);
  }

  final code = params['code'];
  if (code == null || code.isEmpty) {
    return notFoundHandler(request, body: 'Missing `code`.');
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
  final state = decodeState(params['state']);
  // TODO: verify state in the response
  // TODO: verify prompt (=none or =consent)
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

  // TODO: implement proper action on successful authentication
  final go = state['go'];
  if (go != null) {
    // TODO: verify go
    return redirectResponse(
      go,
      headers: session_cookie.createClientSessionCookie(
        sessionId: newSession.sessionId,
        maxAge: newSession.maxAge,
      ),
    );
  }
  return jsonResponse(
    {
      'oauthUserId': '*' * profile.oauthUserId.length,
      'email': profile.email,
      'name': profile.name,
      'imageUrl': profile.imageUrl,
    },
    indentJson: true,
    headers: session_cookie.createClientSessionCookie(
      sessionId: newSession.sessionId,
      maxAge: newSession.maxAge,
    ),
  );
}

/// Handles POST /api/account/session
Future<shelf.Response> updateSessionHandler(
    shelf.Request request, ClientSessionRequest body) async {
  final sw = Stopwatch()..start();
  final authenticatedUser = await requireAuthenticatedWebUser();
  final user = authenticatedUser.user;

  InvalidInputException.checkNotNull(body.accessToken, 'accessToken');
  await accountBackend.verifyAccessTokenOwnership(body.accessToken!, user);
  final t1 = sw.elapsed;

  // Only allow creation of sessions on the primary site host.
  // Exposing session on other domains is a security concern.
  // Note: staging sites may have a different primary host.
  if (request.requestedUri.host != activeConfiguration.primarySiteUri.host ||
      request.requestedUri.scheme !=
          activeConfiguration.primarySiteUri.scheme) {
    // The resource simply doesn't exist on this host.
    throw NotFoundException.resource('no such url');
  }

  final cookies = parseCookieHeader(request.headers[HttpHeaders.cookieHeader]);
  final sessionData =
      await accountBackend.parseAndLookupUserSessionCookie(cookies);
  final t2 = sw.elapsed;
  // check if the session data is the same
  if (sessionData != null &&
      sessionData.userId == user.userId &&
      sessionData.email == user.email) {
    final status = ClientSessionStatus(
      changed: false,
      expires: sessionData.expires,
    );
    _logger.info(
        '[pub-session-handler-debug] Session was alive: $t1 / ${t2 - t1}.');
    return jsonResponse(status.toJson());
  }

  final profile = await authProvider.getAccountProfile(body.accessToken);
  final t3 = sw.elapsed;
  final newSession = await accountBackend.createNewUserSession(
    name: profile!.name!,
    imageUrl: profile.imageUrl!,
  );
  final t4 = sw.elapsed;
  _logger.info(
      '[pub-session-handler-debug] Session was created: $t1 / ${t2 - t1} / ${t3 - t2} / ${t4 - t3}.');

  return jsonResponse(
    ClientSessionStatus(
      changed: true,
      expires: newSession.expires,
    ).toJson(),
    headers: session_cookie.createUserSessionCookie(
        newSession.sessionId, newSession.expires),
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
  if (requestContext.experimentalFlags.useNewSignIn && userId != null) {
    await accountBackend.invalidateAllUserSessions(userId);
  }
  return jsonResponse(
    ClientSessionStatus(
      changed: sessionId != null,
      expires: null,
    ).toJson(),
    // Clear cookie, so we don't have to lookup an invalid sessionId.
    headers: session_cookie.clearSessionCookies(),
  );
}

/// Handles GET /consent?id=<consentId>
Future<shelf.Response> consentPageHandler(
    shelf.Request request, String? consentId) async {
  if (requestContext.isNotAuthenticated) {
    return htmlResponse(renderUnauthenticatedPage());
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
  if (requestContext.isNotAuthenticated) {
    return htmlResponse(renderUnauthenticatedPage());
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
  if (requestContext.isNotAuthenticated) {
    return htmlResponse(renderUnauthenticatedPage());
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
  if (requestContext.isNotAuthenticated) {
    return htmlResponse(renderUnauthenticatedPage());
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
  if (requestContext.isNotAuthenticated) {
    return htmlResponse(renderUnauthenticatedPage());
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
