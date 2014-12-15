// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.api.users;

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;

class User {
  final String email;
  final String id;
  final String authDomain;
  final bool isAdmin;

  User({this.email, this.authDomain, this.id, this.isAdmin});

  String toString() => email;
}

abstract class UserService {
  User get currentUser;

  Future<String> createLoginUrl(String destination);

  Future<String> createLogoutUrl(String destination);
}

/**
 * Register a new [UserService] object.
 *
 * Calling this outside of a service scope or calling it more than once inside
 * the same service scope will result in an error.
 *
 * See the `package:gcloud/service_scope.dart` library for more information.
 */
void registerUserService(UserService service) {
  ss.register(#_appengine.users, service);
}

/**
 * The user service.
 *
 * Request handlers will be run inside a service scope which contains the
 * users service.
 */
UserService get userService => ss.lookup(#_appengine.users);
