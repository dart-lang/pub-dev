// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../auth_provider.dart';

/// A fake auth provider where user resolution is done via the provided access
/// token.
///
/// Access tokens are in the format of user-name-at-example-dot-com and resolve
/// to user-name@example.com as email and user-name-example-com as userId.
///
/// Access tokens without '-at-' are not resolving to any user.
class FakeAuthProvider implements AuthProvider {
  final int httpPort;
  FakeAuthProvider([this.httpPort = 8080]);

  @override
  Future<void> close() async {}

  @override
  Future<AuthResult> tryAuthenticate(String accessToken) async {
    if (accessToken == null || !accessToken.contains('-at-')) return null;
    final email = accessToken.replaceAll('-at-', '@').replaceAll('-dot-', '.');
    final id = email.replaceAll('@', '-').replaceAll('.', '-');
    return AuthResult(id, email);
  }

  @override
  Future<AccountProfile> getAccountProfile(String accessToken) async {
    if (accessToken == null || !accessToken.contains('-at-')) return null;
    final imageUrl = '/images/user/$accessToken.jpg';
    return AccountProfile(
      name: accessToken
          .split('-at-')
          .first
          .replaceAll('-', ' ')
          .replaceAll('.', ' '),
      imageUrl: imageUrl,
    );
  }
}
