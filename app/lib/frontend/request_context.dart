// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:shelf/shelf.dart' as shelf;

import '../account/backend.dart';
import '../account/models.dart';
import '../account/session_cookie.dart';
import '../shared/configuration.dart';
import '../shared/cookie_utils.dart';
import '../shared/env_config.dart';

import 'handlers/experimental.dart';

/// Sets the active [RequestContext].
void registerRequestContext(RequestContext value) =>
    ss.register(#_request_context, value);

/// The active [RequestContext].
RequestContext get requestContext =>
    ss.lookup(#_request_context) as RequestContext? ?? RequestContext();

/// Holds flags for request context.
class RequestContext {
  /// Whether the JSON responses should be indented.
  final bool indentJson;

  /// Whether indexing of the content by robots should be blocked.
  final bool blockRobots;

  /// Whether the use of UI cache is enabled (when there is a risk of cache
  /// pollution by visually changing the site).
  final bool uiCacheEnabled;

  /// The parsed experimental flags.
  final ExperimentalFlags experimentalFlags;

  /// The CSRF token recieved via the header of the request.
  final String? csrfToken;

  final SessionData? sessionData;

  /// The status of the client session cookie.
  final ClientSessionCookieStatus clientSessionCookieStatus;

  /// Whether to check rate limits for this request.
  final bool checkRateLimits;

  RequestContext({
    this.indentJson = false,
    this.blockRobots = true,
    this.uiCacheEnabled = false,
    ExperimentalFlags? experimentalFlags,
    this.csrfToken,
    this.sessionData,
    ClientSessionCookieStatus? clientSessionCookieStatus,
    bool? checkRateLimits,
  })  : experimentalFlags = experimentalFlags ?? ExperimentalFlags.empty,
        checkRateLimits = checkRateLimits ?? envConfig.isRunningInAppengine,
        clientSessionCookieStatus =
            clientSessionCookieStatus ?? ClientSessionCookieStatus.missing();

  late final _isAuthenticated = sessionData?.isAuthenticated ?? false;
  late final isNotAuthenticated = !_isAuthenticated;
  late final authenticatedUserId =
      _isAuthenticated ? sessionData?.userId : null;
}

Future<RequestContext> buildRequestContext({
  required shelf.Request request,
}) async {
  final cookies = parseCookieHeader(request.headers[HttpHeaders.cookieHeader]);
  final experimentalFlags =
      ExperimentalFlags.parseFromCookie(cookies[experimentalCookieName]);

  // Never read or look for the session cookie on hosts other than the
  // primary site. Who knows how it got there or what it means.
  // Also never cache HTML pages or URLs that are not on the primary host.
  final isPrimaryHost =
      request.requestedUri.host == activeConfiguration.primarySiteUri.host;

  // Parse client session cookie status, which can be present at any kind of request.
  SessionData? sessionData;
  final clientSessionCookieStatus = parseClientSessionCookies(cookies);
  if (isPrimaryHost && clientSessionCookieStatus.isPresent) {
    sessionData = await accountBackend
        .getSessionData(clientSessionCookieStatus.sessionId!);
  }

  final csrfToken = request.headers['x-pub-csrf-token']?.trim();

  final indentJson = request.requestedUri.queryParameters.containsKey('pretty');

  final enableRobots = !experimentalFlags.isEmpty ||
      (!activeConfiguration.blockRobots && isPrimaryHost);
  final uiCacheEnabled =
      // don't cache on non-primary domains
      isPrimaryHost &&
          // don't cache if experimental cookie is enabled
          experimentalFlags.isEmpty &&
          // don't cache if client session is active
          !clientSessionCookieStatus.isPresent &&
          // sanity check, this should be covered by client session cookie
          (csrfToken?.isNotEmpty ?? false);
  return RequestContext(
    indentJson: indentJson,
    blockRobots: !enableRobots,
    uiCacheEnabled: uiCacheEnabled,
    experimentalFlags: experimentalFlags,
    csrfToken: csrfToken,
    sessionData: sessionData,
    clientSessionCookieStatus: clientSessionCookieStatus,
  );
}
