// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io' show HttpHeaders;

import 'package:gcloud/service_scope.dart' as ss;
import 'package:shelf/shelf.dart' as shelf;

import 'oauth2_service.dart';

/// Sets the active logged-in user.
void registerLoggedInUser(String user) => ss.register(#_logged_in_user, user);

/// The active logged-in user. This is used for doing authentication checks.
String get loggedInUser => ss.lookup(#_logged_in_user) as String;

/// Looks at [request] and if the 'Authorization' header was set tries to get
/// the user email address and registers it.
Future registerLoggedInUserIfPossible(shelf.Request request) async {
  final authorization = request.headers[HttpHeaders.authorizationHeader];
  if (authorization != null) {
    final parts = authorization.split(' ');
    if (parts.length == 2 && parts.first.trim().toLowerCase() == 'bearer') {
      final accessToken = parts.last.trim();

      final email = await oauth2Service.lookup(accessToken);
      if (email != null) {
        registerLoggedInUser(email);
      }
    }
  }
}
