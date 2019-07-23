// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:client_data/publisher_api.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../publisher/backend.dart';
import '../../shared/handlers.dart';

/// Handles requests for GET /create-publisher
Future<shelf.Response> createPublisherPageHandler(shelf.Request request) async {
  // TODO: implement
  return notFoundHandler(request);
}

/// Handles requests for POST /api/publisher/<publisherId>
Future<shelf.Response> createPublisherApiHandler(
    shelf.Request request, String publisherId) async {
  // TODO: implement
  return notFoundHandler(request);
}

/// Handles requests for GET /api/publisher/<publisherId>
Future<shelf.Response> getPublisherApiHandler(
    shelf.Request request, String publisherId) async {
  // TODO: implement
  return notFoundHandler(request);
}

/// Handles requests for PUT /api/publisher/<publisherId>
Future<PublisherInfo> updatePublisherApiHandler(shelf.Request request,
    String publisherId, UpdatePublisherRequest update) async {
  final p = await publisherBackend.updatePublisherData(
      publisherId, update.description);
  return PublisherInfo(
    description: p.description,
    contact: p.contactEmail,
  );
}

/// Handles requests for POST /api/publisher/<publisherId>/invite-member
Future<shelf.Response> invitePublisherMemberHandler(
    shelf.Request request, String publisherId) async {
  // TODO: implement
  return notFoundHandler(request);
}

/// Handles requests for GET /api/publisher/<publisherId>/members
Future<shelf.Response> getPublisherMembersApiHandler(
    shelf.Request request, String publisherId) async {
  // TODO: implement
  return notFoundHandler(request);
}

/// Handles requests for GET /api/publisher/<publisherId>/members/<userId>
Future<shelf.Response> getPublisherMemberDataApiHandler(
    shelf.Request request, String publisherId, String userId) async {
  // TODO: implement
  return notFoundHandler(request);
}

/// Handles requests for PUT /api/publisher/<publisherId>/members/<userId>
Future<shelf.Response> putPublisherMemberDataApiHandler(
    shelf.Request request, String publisherId, String userId) async {
  // TODO: implement
  return notFoundHandler(request);
}

/// Handles requests for DELETE /api/publisher/<publisherId>/members/<userId>
Future<shelf.Response> deletePublisherMemberDataApiHandler(
    shelf.Request request, String publisherId, String userId) async {
  // TODO: implement
  return notFoundHandler(request);
}
