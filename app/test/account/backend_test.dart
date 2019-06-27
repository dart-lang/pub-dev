// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/account/models.dart';
import 'package:pub_dartlang_org/account/testing/fake_auth_provider.dart';

void main() {
  group('AccountBackend', () {
    final memDb = MemDatastore();
    final datastore = DatastoreDB(memDb);
    final backend = AccountBackend(datastore, authProvider: FakeAuthProvider());

    setUpAll(() async {
      datastore.commit(inserts: [
        User()
          ..parentKey = datastore.emptyKey
          ..id = 'a-example-com'
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
      final email = await backend.getEmailOfUserId('a-example-com');
      expect(email, 'a@example.com');
      final u1 = await backend.lookupUserById('a-example-com');
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
      expect(ids.contains('a-example-com'), isTrue);
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

      final u1 =
          await backend.authenticateWithAccessToken('a-at-example-dot-com');
      expect(u1.userId, 'a-example-com');
      expect(u1.email, 'a@example.com');

      final u2 = await backend.lookupUserById('a-example-com');
      expect(u2.email, 'a@example.com');
      expect(u2.oauthUserId, 'a-example-com');

      final ids2 = await datastore
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toList();
      expect(ids2, ['a-example-com']);
    });

    test('Authenticate: new user', () async {
      final ids1 = await datastore
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toList();
      expect(ids1, ['a-example-com']);

      final u1 =
          await backend.authenticateWithAccessToken('c-at-example-dot-com');
      expect(u1.userId, hasLength(36));
      expect(u1.email, 'c@example.com');

      final u2 = await backend.lookupUserById(u1.userId);
      expect(u2.email, 'c@example.com');
      expect(u2.oauthUserId, 'c-example-com');

      final ids2 = await datastore
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toList();
      ids2.sort();
      expect(ids2, ['a-example-com', 'c-example-com']);
    });
  });
}
