// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/account_api.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../frontend/backend.dart';
import '../../shared/handlers.dart';

/// Handles /api/account/options/packages/<package>
Future<shelf.Response> accountPkgOptionsHandler(
    shelf.Request request, String package) async {
  if (request.method.toUpperCase() == 'GET') {
    final p = await backend.lookupPackage(package);
    if (p == null) {
      return notFoundHandler(request);
    }
    final options =
        AccountPkgOptions(isUploader: p.hasUploader(authenticatedUser.userId));
    return jsonResponse(options.toJson());
  } else {
    return notFoundHandler(request);
  }
}
