// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:pub_dev/frontend/handlers/cache_control.dart';
import 'package:pub_dev/frontend/templates/misc.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/env_config.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:stack_trace/stack_trace.dart';

import '../account/backend.dart';
import '../frontend/dom/dom.dart' as d;
import '../frontend/request_context.dart';
import '../frontend/templates/layout.dart';
import '../service/csp/default_csp.dart';

import 'exceptions.dart';
import 'handlers.dart';

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
  int port = 8080,
  Future<void> Function()? processTerminationSignal,
}) async {
  handler = wrapHandler(logger, handler, sanitize: sanitize);
  if (envConfig.isRunningInAppengine) {
    await runAppEngine(
      (HttpRequest request) {
        shelf_io.handleRequest(request, handler);
      },
      shared: true,
      port: port,
    );
  } else {
    final server = await shelf_io.serve(
      (request) async {
        final rs = await fork(() async {
          return await handler(request);
        });
        return rs as shelf.Response;
      },
      InternetAddress.anyIPv4,
      port,
      shared: true,
    );
    processTerminationSignal ??= waitForProcessSignalTermination;
    await processTerminationSignal();
    await server.close();
  }
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
  handler = _redirectLoopDetectorWrapper(logger, handler);
  handler = _cspHeaderWrapper(handler);
  handler = _userAuthWrapper(handler);
  handler = _requestContextWrapper(handler);
  handler = _httpsWrapper(handler);
  if (sanitize) {
    handler = _sanitizeRequestWrapper(handler);
  }
  handler = _logRequestWrapper(logger, handler);
  return handler;
}

/// Detects simple redirect loop and emits a log message on it.
shelf.Handler _redirectLoopDetectorWrapper(
  Logger logger,
  shelf.Handler handler,
) {
  return (shelf.Request request) async {
    final rs = await handler(request);
    // 304 Not Modified - doesn't need to have a location header and there is no redirect
    if (rs.statusCode >= 300 && rs.statusCode < 400 && rs.statusCode != 304) {
      final location = rs.headers[HttpHeaders.locationHeader];

      // sanity check for the header being present
      if (location == null) {
        throw ArgumentError(
          'Redirect response without location header (rq: ${request.requestedUri}).',
        );
      }

      // sanity check for the header being valid
      final uri = Uri.tryParse(location);
      if (uri == null) {
        throw FormatException(
          'Redirect response with invalid location header: "$location" (rq: ${request.requestedUri}).',
        );
      }

      // exact match
      if (request.requestedUri == uri) {
        logger.shout(
          'Redirect loop detected.',
          Exception('Redirect loop detected (rq: ${request.requestedUri}).'),
        );
        return rs;
      }

      // path + querystring match
      if (uri.toString().startsWith(uri.path) &&
          request.requestedUri.toString().endsWith(uri.toString())) {
        logger.shout(
          'Redirect loop detected.',
          Exception('Redirect loop detected (rq: ${request.requestedUri}).'),
        );
        return rs;
      }
    }
    return rs;
  };
}

/// Populates [requestContext] with the extracted request attributes.
shelf.Handler _requestContextWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    final context = await buildRequestContext(request: request);
    registerRequestContext(context);
    var rs = await handler(request);
    if (!rs.hasCacheControl) {
      rs = CacheControl.defaultPrivate.apply(rs);
    }
    return rs;
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
      return rs.change(
        headers: {
          'x-content-type-options': 'nosniff',
          'x-frame-options': 'deny',
          'content-security-policy': defaultContentSecurityPolicySerialized,
        },
      );
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
      final content = d.fragment([
        d.h1(text: 'Error: ${e.code}'),
        d.codeSnippet(language: 'text', text: e.message),
      ]);
      return htmlResponse(
        renderLayoutPage(
          PageType.package,
          content,
          title: 'Error ${e.code}',
          noIndex: true,
        ),
        status: e.status,
        headers: e.headers,
      );
    } catch (error, st) {
      logger.severe('Request handler failed', error, Trace.from(st));

      final title = 'Pub is not feeling well';
      Map<String, String>? debugHeaders;
      if (context.traceId != null) {
        debugHeaders = {'package-site-request-id': context.traceId!};
      }

      final content = renderLayoutPage(
        PageType.package,
        renderFatalError(
          title: title,
          requestedUri: request.requestedUri,
          traceId: context.traceId,
        ),
        title: title,
        noIndex: true,
      );
      return htmlResponse(content, status: 500, headers: debugHeaders);
    } finally {
      if (shouldLog) {
        logger.info('Request handler done.');
      }
    }
  };
}

shelf.Handler _sanitizeRequestWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    shelf.Request sanitizedRequest;
    try {
      sanitizedRequest = _sanitizeRequestedUri(request);
    } on FormatException catch (_) {
      return badRequestHandler(request);
    }
    return await handler(sanitizedRequest);
  };
}

/// Looks at request and if the 'Authorization' header was set tries to get
/// the user email address and registers it.
shelf.Handler _userAuthWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    final authorization = request.headers['authorization'];
    String? accessToken;
    if (authorization != null) {
      final parts = authorization.split(' ');
      if (parts.length == 2 && parts.first.trim().toLowerCase() == 'bearer') {
        accessToken = parts.last.trim();
      }
    }
    return await accountBackend.withBearerToken(
      accessToken,
      () async => await handler(request),
    );
  };
}

/// In production environment (as defined by appengine's [context] variable):
/// - redirects non-https requests to https
/// - adds Strict-Transport-Security response header (HSTS)
shelf.Handler _httpsWrapper(shelf.Handler handler) {
  return (shelf.Request request) async {
    if (context.isProductionEnvironment &&
        request.requestedUri.scheme != 'https') {
      final secureUri = request.requestedUri.replace(scheme: 'https');
      return shelf.Response.seeOther(secureUri);
    }

    shelf.Response rs = await handler(request);
    if (context.isProductionEnvironment) {
      rs = rs.change(
        headers: {
          'strict-transport-security':
              'max-age=${_hstsDuration.inSeconds}; preload',
        },
      );
    }
    return rs;
  };
}

shelf.Request _sanitizeRequestedUri(shelf.Request request) {
  // These methods may throw FormatException.
  void triggerUriParsingMethods(Uri uri) {
    uri.pathSegments;
    uri.queryParametersAll;
  }

  final uri = request.requestedUri;
  triggerUriParsingMethods(uri);
  final resource = Uri.decodeFull(uri.path);
  final normalizedPath = path.normalize(resource);
  // path.normalize removes trailing `/`, but in URLs we need to keep them
  final normalizedResource =
      (resource.length > 1 &&
          resource.endsWith('/') &&
          !normalizedPath.endsWith('/'))
      ? '$normalizedPath/'
      : normalizedPath;

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
    triggerUriParsingMethods(changedUri);
    final sanitized = shelf.Request(
      request.method,
      changedUri,
      protocolVersion: request.protocolVersion,
      headers: request.headers,
      body: request.read(),
      encoding: request.encoding,
      context: request.context,
    );
    return sanitized;
  }
}
