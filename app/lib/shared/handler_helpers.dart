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

import '../frontend/request_context.dart';
import '../frontend/service_utils.dart';
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
  handler = _uriValidationRequestWrapper(handler);
  if (sanitize) {
    handler = _sanitizeRequestWrapper(handler);
  }
  handler = _httpsWrapper(handler);
  handler = _logRequestWrapper(logger, handler);
  handler = _userAuthWrapper(handler);
  handler = _cspHeaderWrapper(handler);
  handler = _requestContextWrapper(handler);
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
    final uiCacheEnabled = isPrimaryHost && !hasExperimentalCookie;

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
    uri.pathSegments.forEach(Uri.decodeComponent);
  } catch (_) {
    return false;
  }
  return true;
}

shelf.Handler _sanitizeRequestWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    return await handler(_sanitizeRequestedUri(request));
  };
}

shelf.Handler _userAuthWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    await registerLoggedInUserIfPossible(request);
    return await handler(request);
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
  final resource = uri.path;
  final normalizedResource = path.normalize(resource);

  if (resource == normalizedResource) {
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
