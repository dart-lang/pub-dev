// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/account_info.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../frontend/backend.dart';
import '../../shared/handlers.dart';

/// Handles /api/account/v1/info
Future<shelf.Response> accountInfoHandler(shelf.Request request) async {
  PkgScopeData pkgScopeData;
  final package = request.requestedUri.queryParameters['package'];
  if (package != null) {
    bool isUploader;
    if (authenticatedUser != null) {
      final p = await backend.lookupPackage(package);
      isUploader = p.hasUploader(authenticatedUser.userId);
    } else {
      isUploader = false;
    }
    pkgScopeData = PkgScopeData(package: package, isUploader: isUploader);
  }

  final accountInfo = AccountInfo(
    email: authenticatedUser?.email ?? '-',
    pkgScopeData: pkgScopeData,
  );
  return jsonResponse(accountInfo.toJson());
}
