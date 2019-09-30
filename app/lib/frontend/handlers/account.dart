// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io' show Cookie, HttpHeaders;

import 'package:client_data/account_api.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../package/backend.dart';
import '../../publisher/backend.dart';
import '../../publisher/models.dart';
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';

import '../templates/admin.dart';

/// Handles POST /api/account/session
Future<shelf.Response> updateSessionHandler(shelf.Request request,
    {ClientSessionData clientSessionData}) async {
  final user = await requireAuthenticatedUser();

  if (clientSessionData == null) {
    final body = await request.readAsString();
    final map = json.decode(body) as Map<String, dynamic>;
    clientSessionData = ClientSessionData.fromJson(map);
  }

  // check if the session data is the same
  if (userSessionData != null &&
      userSessionData.userId == user.userId &&
      userSessionData.email == user.email &&
      userSessionData.imageUrl == clientSessionData.imageUrl) {
    final status = ClientSessionStatus(
      changed: false,
      expires: userSessionData.expires,
    );
    return jsonResponse(status.toJson());
  }

  final newSession = await accountBackend.createNewSession(
      imageUrl: clientSessionData.imageUrl);
  final cookie = Cookie(pubSessionCookieName, newSession.sessionId)
    ..expires = newSession.expires
    ..httpOnly = true
    ..path = '/';
  final headers = <String, String>{
    HttpHeaders.setCookieHeader: cookie.toString(),
  };
  final status = ClientSessionStatus(
    changed: true,
    expires: newSession.expires,
  );
  return jsonResponse(status.toJson(), headers: headers);
}

/// Handles DELETE /api/account/session
Future<shelf.Response> invalidateSessionHandler(shelf.Request request) async {
  final changed = userSessionData != null;
  final headers = <String, String>{};
  if (userSessionData != null) {
    final cookie = Cookie(pubSessionCookieName, '')
      ..maxAge = 0
      ..path = '/';
    headers[HttpHeaders.setCookieHeader] = cookie.toString();
  }
  final status = ClientSessionStatus(
    changed: changed,
    expires: null,
  );
  return jsonResponse(status.toJson(), headers: headers);
}

/// Handles GET /consent?id=<consentId>
Future<shelf.Response> consentPageHandler(
    shelf.Request request, String consentId) async {
  // TODO: if no consentId is given, render the listing of user consents page
  return htmlResponse(renderConsentPage(consentId));
}

/// Handles /api/account/options/packages/<package>
Future<AccountPkgOptions> accountPkgOptionsHandler(
    shelf.Request request, String package) async {
  final user = await requireAuthenticatedUser();
  final p = await packageBackend.lookupPackage(package);
  if (p == null) {
    throw NotFoundException.resource(package);
  }
  return AccountPkgOptions(
      isAdmin: await packageBackend.isPackageAdmin(p, user.userId));
}

/// Handles /api/account/options/publishers/<publisherId>
Future<AccountPublisherOptions> accountPublisherOptionsHandler(
    shelf.Request request, String publisherId) async {
  final user = await requireAuthenticatedUser();
  final member =
      await publisherBackend.getPublisherMember(publisherId, user.userId);
  final isAdmin = member != null && member.role == PublisherMemberRole.admin;
  return AccountPublisherOptions(isAdmin: isAdmin);
}
