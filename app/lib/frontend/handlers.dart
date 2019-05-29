// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers;

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'handlers/misc.dart';
import 'handlers/redirects.dart';
import 'handlers/routes.dart';

final _pubHeaderLogger = Logger('pub.header_logger');

void _logPubHeaders(shelf.Request request) {
  request.headers.forEach((String key, String value) {
    final lowerCaseKey = key.toLowerCase();
    if (lowerCaseKey.startsWith('x-pub')) {
      _pubHeaderLogger.info('$key: $value');
    }
  });
}

/// Handler for the whole URL space of the pub site.
///
/// The passed in [shelfPubApi] handler will be used for handling requests to
///   - /api/*
Future<shelf.Response> appHandler(
  shelf.Request request,
  shelf.Handler shelfPubApi,
) async {
  _logPubHeaders(request);

  final redirected = tryHandleRedirects(request);
  if (redirected != null) return redirected;

  final pubSiteHandler = PubSiteService(shelfPubApi).router.handler;

  final res = await pubSiteHandler(request);
  if (res != null) {
    return res;
  }

  return formattedNotFoundHandler(request);
}
