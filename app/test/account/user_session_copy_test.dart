// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../shared/test_services.dart';

void main() {
  testWithProfile(
    'Datastore -> SQL',
    fn: () async {
      final session = await accountBackend.createOrUpdateClientSession();

      // remove the SQL row
      expect(
        await primaryDatabase.withRetry(
          (db) => db.userSessions.byKey(session.sessionId).fetch(),
        ),
        isNotNull,
      );
      await primaryDatabase.withRetry(
        (db) => db.userSessions.delete(session.sessionId).execute(),
      );
      expect(
        await primaryDatabase.withRetry(
          (db) => db.userSessions.byKey(session.sessionId).fetch(),
        ),
        isNull,
      );

      final r = await accountBackend.copyUserSessionsFromDatastoreToSql();
      expect(r.updated, 1);
      expect(
        await primaryDatabase.withRetry(
          (db) => db.userSessions.byKey(session.sessionId).fetch(),
        ),
        isNotNull,
      );
    },
  );

  testWithProfile(
    'SQL -> Datastore',
    fn: () async {
      final session = await accountBackend.createOrUpdateClientSession();

      // Remove the Datastore entity
      expect(
        await dbService.lookupOrNull<UserSession>(
          dbService.emptyKey.append(UserSession, id: session.sessionId),
        ),
        isNotNull,
      );
      await dbService.commit(
        deletes: [
          dbService.emptyKey.append(UserSession, id: session.sessionId),
        ],
      );
      expect(
        await dbService.lookupOrNull<UserSession>(
          dbService.emptyKey.append(UserSession, id: session.sessionId),
        ),
        isNull,
      );

      final r = await accountBackend.copyUserSessionsFromSqlToDatastore();
      expect(r.updated, 1);
      expect(
        await dbService.lookupOrNull<UserSession>(
          dbService.emptyKey.append(UserSession, id: session.sessionId),
        ),
        isNotNull,
      );
    },
  );

  testWithProfile(
    'newer expires (Datastore -> SQL)',
    fn: () async {
      final session = await accountBackend.createOrUpdateClientSession();
      final older = session.expires!.subtract(Duration(days: 5));

      final ds = await dbService.lookupValue<UserSession>(
        dbService.emptyKey.append(UserSession, id: session.sessionId),
      );
      ds.expires = older;
      await dbService.commit(inserts: [ds]);

      await accountBackend.copyUserSessionsFromDatastoreToSql();
      final row = await primaryDatabase.withRetry(
        (db) => db.userSessions.byKey(session.sessionId).fetch(),
      );
      expect(row!.expires, session.expires);
    },
  );
}
