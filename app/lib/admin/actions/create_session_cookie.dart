// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/session_cookie.dart' as session_cookie;
import 'package:pub_dev/admin/actions/actions.dart';

final createSessionCookie = AdminAction(
  name: 'create-session-cookie',
  summary: 'Create a session cookie for a given oauth access token.',
  description: '''
Validates the given oauth access token and creates a session cookie for the user.
Returns the cookie headers that can be used to authenticate the user in the browser.
''',
  options: {
    'access-token': 'The oauth access token to validate.',
  },
  invoke: (options) async {
    final accessToken = options['access-token'];
    InvalidInputException.check(
      accessToken != null && accessToken.isNotEmpty,
      'access-token must be given',
    );

    final authResult = await authProvider.tryAuthenticateAsUser(accessToken!);
    if (authResult == null) {
      throw InvalidInputException('Invalid access-token');
    }

    final session = await accountBackend.createOrUpdateClientSession();
    await accountBackend.updateClientSessionWithProfile(
      sessionId: session.sessionId,
      profile: authResult.withToken(accessToken: accessToken),
    );

    final cookieHeaders = session_cookie.createClientSessionCookie(
      sessionId: session.sessionId,
      maxAge: session.maxAge,
    );

    return {
      'cookie': cookieHeaders,
    };
  },
);
