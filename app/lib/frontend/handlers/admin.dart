// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers;

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import '../../shared/handlers.dart';

import '../backend.dart';
import '../models.dart';
import '../templates.dart';

/// Handles requests for /authorized
shelf.Response authorizedHandler(_) =>
    htmlResponse(templateService.renderAuthorizedPage());

/// Handles requests for /admin/confirm
Future<shelf.Response> adminConfirmHandler(shelf.Request request) async {
  final segments = request.requestedUri.pathSegments;
  if (segments.length <= 2) {
    return notFoundHandler(request);
  }
  final type = segments[2];
  if (type == PackageInviteType.newUploader) {
    if (segments.length != 6) {
      return _formattedInviteExpiredHandler(request);
    }
    final packageName = segments[3];
    final recipientEmail = segments[4];
    final urlNonce = segments[5];
    if (packageName.isEmpty || urlNonce.isEmpty) {
      return _formattedInviteExpiredHandler(request);
    }
    final invite = await backend.confirmPackageInvite(
      packageName: packageName,
      type: type,
      recipientEmail: recipientEmail,
      urlNonce: urlNonce,
    );
    if (invite == null) {
      return _formattedInviteExpiredHandler(request);
    }
    try {
      await backend.repository.confirmUploader(
          invite.fromEmail, invite.packageName, invite.recipientEmail);
    } catch (e) {
      _formattedInviteExpiredHandler(request, 'Error message:\n\n```\n$e\n```');
    }
    return htmlResponse(templateService.renderUploaderConfirmedPage(
        invite.packageName, invite.recipientEmail));
  } else {
    return _formattedInviteExpiredHandler(request);
  }
}

Future<shelf.Response> _formattedInviteExpiredHandler(shelf.Request request,
    [String message = '']) async {
  return htmlResponse(
    templateService.renderErrorPage(
        'Invite expired',
        'The URL you have clicked expired or became invalid.\n\n$message\n',
        null),
    status: 404,
  );
}
