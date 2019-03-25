// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/account/models.dart';

void main() {
  group('AccountBackend', () {
    final memDb = MemDatastore();
    final datastore = DatastoreDB(memDb);
    final backend = AccountBackend(datastore,
        authProvider: AuthProviderMock(tokens: {
          'token-a': AuthResult('oauth-id-a', 'a@example.com'),
          'token-c': AuthResult('oauth-id-c', 'c@example.com'),
        }));

    setUpAll(() async {
      datastore.commit(inserts: [
        User()
          ..parentKey = datastore.emptyKey
          ..id = 'user-a'
          ..oauthUserId = null
          ..email = 'a@example.com'
          ..created = DateTime(2019, 01, 01)
      ]);
    });

    test('No user', () async {
      final email = await backend.getEmailOfUserId('no-user-id');
      expect(email, isNull);
    });

    test('Successful lookup', () async {
      final email = await backend.getEmailOfUserId('user-a');
      expect(email, 'a@example.com');
      final u1 = await backend.lookupUserById('user-a');
      expect(u1.email, 'a@example.com');
      expect(u1.oauthUserId, isNull);
      final u2 = await backend.lookupOrCreateUserByEmail('a@example.com');
      expect(u2.id, u1.id);
    });

    test('Create missing user', () async {
      final u = await backend.lookupOrCreateUserByEmail('b@example.com');
      expect(u.userId, hasLength(36));
      expect(u.oauthUserId, isNull);
      expect(u.email, 'b@example.com');

      final ids =
          await datastore.query<User>().run().map((u) => u.userId).toList();
      expect(ids.length, 2);
      expect(ids.contains('user-a'), isTrue);
      expect(ids.contains(u.userId), isTrue);
    });

    test('Authenticate: token failure', () async {
      final u = await backend.authenticateWithAccessToken('x');
      expect(u, isNull);
    });

    test('Authenticate: pre-created', () async {
      final ids1 = await datastore
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toList();
      expect(ids1, isEmpty);

      final u1 = await backend.authenticateWithAccessToken('token-a');
      expect(u1.userId, 'user-a');
      expect(u1.email, 'a@example.com');

      final u2 = await backend.lookupUserById('user-a');
      expect(u2.email, 'a@example.com');
      expect(u2.oauthUserId, 'oauth-id-a');

      final ids2 = await datastore
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toList();
      expect(ids2, ['oauth-id-a']);
    });

    test('Authenticate: new user', () async {
      final ids1 = await datastore
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toList();
      expect(ids1, ['oauth-id-a']);

      final u1 = await backend.authenticateWithAccessToken('token-c');
      expect(u1.userId, hasLength(36));
      expect(u1.email, 'c@example.com');

      final u2 = await backend.lookupUserById(u1.userId);
      expect(u2.email, 'c@example.com');
      expect(u2.oauthUserId, 'oauth-id-c');

      final ids2 = await datastore
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toList();
      ids2.sort();
      expect(ids2, ['oauth-id-a', 'oauth-id-c']);
    });
  });
}

class AuthProviderMock implements AuthProvider {
  final Map<String, String> codes;
  final Map<String, AuthResult> tokens;

  AuthProviderMock({
    this.codes = const <String, String>{},
    this.tokens = const <String, AuthResult>{},
  });

  @override
  String authorizationUrl(String state) {
    return 'https://auth.provider.com/url?state=${Uri.encodeQueryComponent(state)}';
  }

  @override
  Future<String> authCodeToAccessToken(String code) async {
    return codes[code];
  }

  @override
  Future<AuthResult> tryAuthenticate(String accessToken) async {
    return tokens[accessToken];
  }

  @override
  Future close() async {}
}
