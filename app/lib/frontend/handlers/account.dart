// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/account_api.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../frontend/backend.dart';
import '../../shared/handlers.dart';

/// Handles GET /consent
Future<shelf.Response> consentPageHandler(shelf.Request request) async {
  // TODO: implement
  return notFoundHandler(request);
}

/// Handles PUT /api/account/consent/<consentId>
Future<shelf.Response> putAccountConsentHandler(
    shelf.Request request, String consentId) async {
  // TODO: implement
  return notFoundHandler(request);
}

/// Handles /api/account/options/packages/<package>
Future<shelf.Response> accountPkgOptionsHandler(
    shelf.Request request, String package) async {
  final p = await backend.lookupPackage(package);
  if (p == null) {
    return notFoundHandler(request);
  }
  final options =
      AccountPkgOptions(isAdmin: await backend.isPackageAdmin(p));
  return jsonResponse(options.toJson());
}
