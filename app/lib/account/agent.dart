// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/shared/exceptions.dart';

final _uuidRegExp =
    RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$');

abstract class KnownAgents {
  static const githubActions = 'service:github-actions';
  static const googleCloudServiceAccount =
      'service:gcp-service-account';

  static const _values = <String>{
    githubActions,
    googleCloudServiceAccount,
  };
}

/// Whether the [userId] is valid-looking,
/// without namespace or other special value.
bool isValidUserId(String userId) {
  return _uuidRegExp.matchAsPrefix(userId) != null;
}

/// Whether the [agent] is a valid-looking identifier.
bool isKnownServiceAgent(String agent) {
  return KnownAgents._values.contains(agent);
}

/// Whether the [agent] is a valid-looking actor.
bool isValidUserIdOrServiceAgent(String agent) =>
    isValidUserId(agent) || isKnownServiceAgent(agent);

void checkUserIdParam(String value) {
  InvalidInputException.check(isValidUserId(value), 'Invalid "userId".');
}

void checkAgentParam(String value) {
  InvalidInputException.check(
      isValidUserIdOrServiceAgent(value), 'Invalid "agent".');
}
