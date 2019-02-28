// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers;

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../shared/handlers.dart';

import '../backend.dart';
import '../models.dart';
import '../templates/admin.dart';
import '../templates/misc.dart';

/// Handles requests for /oauth/callback
shelf.Response oauthCallbackHandler(shelf.Request request) {
  final code = request.requestedUri.queryParameters['code'];
  final state = request.requestedUri.queryParameters['state'];
  if (code == null || state == null) {
    return notFoundHandler(request);
  }
  final isWhitelisted = state.startsWith('/admin/confirm/');
  if (isWhitelisted) {
    return redirectResponse(request.requestedUri
        .replace(
          path: state,
          queryParameters: request.requestedUri.queryParameters,
        )
        .toString());
  } else {
    return notFoundHandler(request);
  }
}

/// Handles requests for /authorized
shelf.Response authorizedHandler(_) => htmlResponse(renderAuthorizedPage());

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

    bool authorized = false;
    final code = request.requestedUri.queryParameters['code'];
    if (code != null) {
      final redirectUrl = getRedirectUrl(request.requestedUri);
      final accessToken =
          await accountBackend.siteAuthCodeToAccessToken(code, redirectUrl);
      final user = await accountBackend.authenticateWithAccessToken(
        accessToken,
        useSiteProvider: true,
      );
      authorized = user?.email == recipientEmail;
    }

    final invite = await backend.getPackageInvite(
      packageName: packageName,
      type: type,
      recipientEmail: recipientEmail,
      urlNonce: urlNonce,
      confirm: authorized,
    );
    if (invite == null) {
      return _formattedInviteExpiredHandler(request);
    }
    final inviteEmail = invite.fromUserId == null
        ? invite.fromEmail
        : await accountBackend.getEmailOfUserId(invite.fromUserId);

    if (!authorized) {
      // Display only the page that will have a link to authenticate the user.
      final redirectUrl =
          accountBackend.siteAuthorizationUrl(request.requestedUri);
      return htmlResponse(renderUploaderApprovalPage(
          invite.packageName, inviteEmail, invite.recipientEmail, redirectUrl));
    } else {
      // Authentication was successful, display confirmation.
      try {
        await backend.repository.confirmUploader(
            invite.fromEmail, invite.packageName, invite.recipientEmail);
      } catch (e) {
        _formattedInviteExpiredHandler(
            request, 'Error message:\n\n```\n$e\n```');
      }
      return htmlResponse(renderUploaderConfirmedPage(
          invite.packageName, invite.recipientEmail));
    }
  } else {
    return _formattedInviteExpiredHandler(request);
  }
}

Future<shelf.Response> _formattedInviteExpiredHandler(shelf.Request request,
    [String message = '']) async {
  return htmlResponse(
    renderErrorPage(
        'Invite expired',
        'The URL you have clicked expired or became invalid.\n\n$message\n',
        null),
    status: 404,
  );
}
