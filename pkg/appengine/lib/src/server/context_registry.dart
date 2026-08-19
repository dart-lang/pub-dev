// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/storage.dart' as storage;

import '../appengine_context.dart';
import '../client_context.dart';
import '../logging.dart';
import '../logging_impl.dart';

abstract class LoggerFactory {
  LoggingImpl newRequestSpecificLogger(
      String method,
      String resource,
      String userAgent,
      String host,
      String ip,
      String? traceId,
      String referrer);
  Logging newBackgroundLogger();
}

class ContextRegistry {
  final LoggerFactory _loggingFactory;
  final db.DatastoreDB _db;
  final storage.Storage _storage;
  final AppEngineContext _appengineContext;

  final Map<HttpRequest, ClientContext> _request2context = {};

  ContextRegistry(
      this._loggingFactory, this._db, this._storage, this._appengineContext);

  bool get isDevelopmentEnvironment {
    return _appengineContext.isDevelopmentEnvironment;
  }

  ClientContext add(HttpRequest request) {
    String? traceId;
    // See https://cloud.google.com/trace/docs/support
    final traceHeader = _headerOrEmptyString(
      request.headers,
      'X-Cloud-Trace-Context',
    );
    if (traceHeader != '') {
      traceId = traceHeader.split('/')[0];
    }

    final services = _getServices(request, traceId);
    final context = _ClientContextImpl(services, _appengineContext, traceId);
    _request2context[request] = context;

    request.response.done.whenComplete(() {
      final int responseSize = request.response.headers.contentLength;
      (services.logging as LoggingImpl)
          .finish(request.response.statusCode, responseSize);
    });

    return context;
  }

  ClientContext? lookup(HttpRequest request) {
    return _request2context[request];
  }

  Future remove(HttpRequest request) {
    _request2context.remove(request);
    return Future.value();
  }

  Services newBackgroundServices() => _getServices(null, null);

  Services _getServices(HttpRequest? request, String? traceId) {
    Logging loggingService;
    if (request != null) {
      final uri = request.requestedUri;
      final resource = uri.hasQuery ? '${uri.path}?${uri.query}' : uri.path;
      final List<String>? forwardedFor = request.headers['x-forwarded-for'];

      String ip;
      if (forwardedFor != null && forwardedFor.isNotEmpty) {
        // It seems that, in general, if `x-forwarded-for` has multiple values
        // it is sent as a single header value separated by commas.
        // To ensure only one value for IP is provided, we join all of the
        // `x-forwarded-for` headers into a single string, split on comma,
        // then use the first value.
        ip = forwardedFor.join(',').split(',').first.trim();
      } else {
        ip = request.connectionInfo!.remoteAddress.host;
      }

      loggingService = _loggingFactory.newRequestSpecificLogger(
        request.method,
        resource,
        _headerOrEmptyString(request.headers, HttpHeaders.userAgentHeader),
        uri.host,
        ip,
        traceId,
        _headerOrEmptyString(request.headers, HttpHeaders.refererHeader),
      );
    } else {
      loggingService = _loggingFactory.newBackgroundLogger();
    }

    return Services(_db, _storage, loggingService);
  }
}

class _ClientContextImpl implements ClientContext {
  _ClientContextImpl(this.services, this.applicationContext, this.traceId);

  @override
  final Services services;

  @override
  final AppEngineContext applicationContext;

  @override
  final String? traceId;

  @override
  bool get isDevelopmentEnvironment =>
      applicationContext.isDevelopmentEnvironment;

  @override
  bool get isProductionEnvironment => !isDevelopmentEnvironment;
}

String _headerOrEmptyString(HttpHeaders headers, String headerName) {
  final elements = headers[headerName];
  if (elements != null && elements.isNotEmpty) {
    return elements.first;
  }
  return '';
}
