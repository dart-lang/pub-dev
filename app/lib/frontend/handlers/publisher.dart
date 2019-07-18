// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;
import 'package:client_data/publisher_api.dart';
import 'package:api_builder/api_builder.dart';

import '../../shared/handlers.dart';

part 'publisher.g.dart';

class PublisherApi {
  // NOTE: This has a body and returns a JSON structure
  @EndPoint.put('/api/publisher/<publisherId>')
  Future<PublisherInfo> updatePublisher(
    shelf.Request request,
    String publisherId,
    UpdatePublisherRequest body,
  ) async {
    return null;
  }

  // NOTE: This has no body and returns no JSON structure
  @EndPoint.delete('/api/publisher/<publisherId>')
  Future<shelf.Response> deletePublisher(
    shelf.Request request,
    String publisherId,
  ) async {
    return null;
  }

  // NOTE: The above variants can be combined as desired.

  Router get router => _$PublisherApiRouter(this);
}

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
Future<shelf.Response> updatePublisherApiHandler(
    shelf.Request request, String publisherId) async {
  // TODO: implement
  return notFoundHandler(request);
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
