// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/account_api.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../package/backend.dart';
import '../../publisher/backend.dart';
import '../../publisher/models.dart';
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';

import '../templates/admin.dart';

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
