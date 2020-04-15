// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:stack_trace/stack_trace.dart';

import '../account/backend.dart';
import '../account/search_preference_cookie.dart' as search_preference_cookie;
import '../account/session_cookie.dart' as session_cookie;
import '../frontend/request_context.dart';
import '../frontend/templates/layout.dart';

import 'configuration.dart';
import 'exceptions.dart';
import 'handlers.dart';
import 'markdown.dart';
import 'urls.dart' as urls;
import 'utils.dart' show fileAnIssueContent, parseCookieHeader;

// The .dev top-level domain is included on the HSTS preload list, making HTTPS
// required on all connections to .dev websites and pages without needing
// individual HSTS registration or configuration.
// https://get.dev/#benefits
// However, we should still emit it on other domains e.g. on pub.dartlang.org.
const _hstsDuration = Duration(days: 365);

Future<void> runHandler(
  Logger logger,
  shelf.Handler handler, {
  bool sanitize = false,
  shelf.Handler cronHandler,
  int port = 8080,
}) async {
  handler = wrapHandler(logger, handler, sanitize: sanitize);
  await runAppEngine((HttpRequest request) {
    // If request origins from the appengine cron scheduler, and we have a
    // cron handler we call that.
    if (request?.headers['X-Appengine-Cron']?.contains('true') == true &&
        cronHandler != null) {
      // The load-balancer ensures that X-Appengine-Cron: true, is only present
      // on requests from the AppEngine Cron scheduler. So we do not need all
      // the validating wrappers `handler` is wrapped with. Indeed, this request
      // arrives over HTTP, so if we were to redirect to HTTPS it would fail.
      shelf_io.handleRequest(request, cronHandler);
      return;
    }
    shelf_io.handleRequest(request, handler);
  }, shared: true, port: port);
}

/// Wraps the app handler with useful wrappers.
shelf.Handler wrapHandler(
  Logger logger,
  shelf.Handler handler, {
  bool sanitize = false,
}) {
  // Handlers wrap other handlers, and they are called in the revers order of
  // their wrapping. Read this list from the bottom and go up to get the real
  // execution order.
  handler = _cspHeaderWrapper(handler);
  handler = _userAuthWrapper(handler);
  handler =
      _requestContextWrapper(handler); // need to run after session wrapper
  handler = _searchPreferenceWrapper(handler);
  handler = _userSessionWrapper(handler);
  handler = _httpsWrapper(handler);
  if (sanitize) {
    handler = _sanitizeRequestWrapper(handler);
  }
  handler = _uriValidationRequestWrapper(handler);
  handler = _logRequestWrapper(logger, handler);
  return handler;
}

/// Populates [requestContext] with the extracted request attributes.
shelf.Handler _requestContextWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    final indentJson =
        request.requestedUri.queryParameters.containsKey('pretty');

    final host = request.requestedUri.host;
    final isPrimaryHost = host == urls.primaryHost;
    final isProductionHost = activeConfiguration.productionHosts.contains(host);

    final cookies =
        parseCookieHeader(request.headers[HttpHeaders.cookieHeader]);
    final hasExperimentalCookie = cookies['experimental'] == '1';
    final isExperimental = hasExperimentalCookie;

    final enableRobots = hasExperimentalCookie ||
        (!activeConfiguration.blockRobots && isProductionHost);
    final uiCacheEnabled = //
        isPrimaryHost && // don't cache on non-primary domains
            !hasExperimentalCookie && // don't cache if experimental cookie is enabled
            userSessionData == null; // don't cache if a user session is active

    registerRequestContext(RequestContext(
      indentJson: indentJson,
      isExperimental: isExperimental,
      blockRobots: !enableRobots,
      uiCacheEnabled: uiCacheEnabled,
    ));
    return await handler(request);
  };
}

// Extends response with content security policy headers when the response's
// content type is HTML.
shelf.Handler _cspHeaderWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    final rs = await handler(request);
    final contentType = rs.headers['content-type'];
    final isHtml = contentType != null && contentType.startsWith('text/html');
    if (isHtml) {
      return rs.change(headers: {
        'x-content-type-options': 'nosniff',
        'x-frame-options': 'deny',
        'content-security-policy': contentSecurityPolicy,
      });
    } else {
      return rs;
    }
  };
}

shelf.Handler _logRequestWrapper(Logger logger, shelf.Handler handler) {
  return (shelf.Request request) async {
    final isLiveness = request.requestedUri.path == '/liveness_check';
    final isReadiness = request.requestedUri.path == '/readiness_check';
    final shouldLog = !(isLiveness || isReadiness);
    if (shouldLog) {
      logger.info('Handling request: ${request.requestedUri}');
    }
    try {
      return await handler(request);
    } on ResponseException catch (e) {
      if (shouldLog) {
        logger.info('Caught response exception: $e');
      }
      final content =
          markdownToHtml('# Error `${e.code}`\n\n${e.message}\n', null);
      return htmlResponse(
        renderLayoutPage(PageType.package, content, title: 'Error ${e.code}'),
        status: e.status,
      );
    } catch (error, st) {
      logger.severe('Request handler failed', error, Trace.from(st));

      final title = 'Pub is not feeling well';
      Map<String, String> debugHeaders;
      if (context.traceId != null) {
        debugHeaders = {'package-site-request-id': context.traceId};
      }
      final markdownText = '''# $title

**Fatal package site error.**

$fileAnIssueContent

Add these details to help us fix the issue:
````
Requested URL: ${request.requestedUri}
Request ID: ${context.traceId}
````
      ''';

      final content = renderLayoutPage(
          PageType.package, markdownToHtml(markdownText, null),
          title: title);
      return htmlResponse(content, status: 500, headers: debugHeaders);
    } finally {
      if (shouldLog) {
        logger.info('Request handler done.');
      }
    }
  };
}

shelf.Handler _uriValidationRequestWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    if (_isValidUri(request)) {
      return await handler(request);
    } else {
      return htmlResponse('URL is invalid', status: 400);
    }
  };
}

bool _isValidUri(shelf.Request request) {
  final uri = request.requestedUri;
  try {
    // should be able to parse path segments
    uri.pathSegments.forEach((_) => null);
    // should be able to parse query parameters
    uri.queryParameters.forEach((_, __) => null);
  } on FormatException catch (_) {
    return false;
  }
  return true;
}

shelf.Handler _sanitizeRequestWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    shelf.Request sanitizedRequest;
    try {
      sanitizedRequest = _sanitizeRequestedUri(request);
    } on FormatException catch (_) {
      return invalidRequestHandler(request);
    }
    return await handler(sanitizedRequest);
  };
}

/// Looks at request and if the 'Authorization' header was set tries to get
/// the user email address and registers it.
shelf.Handler _userAuthWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    final authorization = request.headers['authorization'];
    if (authorization != null) {
      final parts = authorization.split(' ');
      if (parts.length == 2 && parts.first.trim().toLowerCase() == 'bearer') {
        final accessToken = parts.last.trim();

        final user =
            await accountBackend.authenticateWithBearerToken(accessToken);
        if (user != null) {
          registerAuthenticatedUser(user);
        }
      }
    }
    return await handler(request);
  };
}

/// Processes the search preference cookie, and on successful decoding it will
/// set the SearchPreference object.
shelf.Handler _searchPreferenceWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    if (request.headers.containsKey(HttpHeaders.cookieHeader)) {
      final sp = search_preference_cookie.parseSearchPreferenceCookie(
        request.headers[HttpHeaders.cookieHeader],
      );
      if (sp != null) {
        registerSearchPreference(sp);
      }
    }
    return await handler(request);
  };
}

/// Processes the session cookie, and on successful verification it will set the
/// user session data.
shelf.Handler _userSessionWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    // Never read or look for the session cookie on hosts other than the
    // primary site. Who knows how it got there or what it means.
    if (request.requestedUri.host == activeConfiguration.primarySiteUri.host &&
        request.headers.containsKey(HttpHeaders.cookieHeader)) {
      final sessionId = session_cookie.parseSessionCookie(
        request.headers[HttpHeaders.cookieHeader],
      );
      if (sessionId != null && sessionId.isNotEmpty) {
        final sessionData = await accountBackend.lookupSession(sessionId);
        if (sessionData != null) {
          registerUserSessionData(sessionData);
        }
      }
    }
    shelf.Response rs = await handler(request);
    if (userSessionData != null) {
      // Indicates that the response is intended for a single user and must not
      // be stored by a shared cache. A private cache may store the response.
      rs = rs.change(headers: {HttpHeaders.cacheControlHeader: 'private'});
    }
    return rs;
  };
}

/// In production environment (as defined by appengine's [context] variable):
/// - redirects non-https requests to https
/// - adds Strict-Transport-Security response header (HSTS)
shelf.Handler _httpsWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    if (context != null &&
        context.isProductionEnvironment &&
        request.requestedUri.scheme != 'https') {
      final secureUri = request.requestedUri.replace(scheme: 'https');
      return shelf.Response.seeOther(secureUri);
    }

    shelf.Response rs = await handler(request);
    if (context != null && context.isProductionEnvironment) {
      rs = rs.change(headers: {
        'strict-transport-security':
            'max-age=${_hstsDuration.inSeconds}; preload',
      });
    }
    return rs;
  };
}

shelf.Request _sanitizeRequestedUri(shelf.Request request) {
  final uri = request.requestedUri;
  final resource = Uri.decodeFull(uri.path);
  final normalizedResource = path.normalize(resource);

  if (uri.path == normalizedResource) {
    return request;
  } else {
    // With the new flex VMs we can get requests from the load balancer which
    // can contain [Uri]s with e.g. double slashes
    //
    //    -> e.g. https://pub.dev//api/packages/foo
    //
    // Setting PUB_HOSTED_URL to a URL with a slash at the end can cause this.
    // (The pub client will not remove it and instead directly try to request
    //  "GET //api/..." :-/ )
    final changedUri = uri.replace(path: normalizedResource);
    final sanitized = shelf.Request(
      request.method,
      changedUri,
      protocolVersion: request.protocolVersion,
      headers: request.headers,
      body: request.read(),
      encoding: request.encoding,
      context: request.context,
    );
    if (!sanitized.context.containsKey('_originalRequest')) {
      return sanitized.change(context: {'_originalRequest': request});
    } else {
      return sanitized;
    }
  }
}
