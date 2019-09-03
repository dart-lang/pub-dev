// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import '../../publisher/backend.dart';
import '../../shared/handlers.dart';
import '../templates/publisher.dart';

import 'misc.dart' show formattedNotFoundHandler;

/// Handles requests for GET /create-publisher
Future<shelf.Response> createPublisherPageHandler(shelf.Request request) async {
  return htmlResponse(renderCreatePublisherPage());
}

/// Handles requests for GET /publishers/<publisherId>
Future<shelf.Response> publisherPageHandler(
    shelf.Request request, String publisherId) async {
  final publisher = await publisherBackend.getPublisher(publisherId);
  if (publisher == null) {
    // We may introduce search for publishers (e.g. somebody just mistyped a
    // domain name), but now we just have a formatted error page.
    return formattedNotFoundHandler(request);
  }
  return htmlResponse(renderPublisherPage(publisher));
}

/// Handles requests for GET /publishers/<publisherId>/admin
Future<shelf.Response> publisherAdminPageHandler(
    shelf.Request request, String publisherId) async {
  final publisher = await publisherBackend.getPublisher(publisherId);
  if (publisher == null) {
    // We may introduce search for publishers (e.g. somebody just mistyped a
    // domain name), but now we just have a formatted error page.
    return formattedNotFoundHandler(request);
  }
  return htmlResponse(renderPublisherAdminPage(publisher));
}
