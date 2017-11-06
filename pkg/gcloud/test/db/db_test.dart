// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library gcloud.db_test;

import 'package:gcloud/db.dart';
import 'package:unittest/unittest.dart';

@Kind()
class Foobar extends Model {}

main() {
  group('db', () {
    test('default-partition', () {
      var db = new DatastoreDB(null);

      // Test defaultPartition
      expect(db.defaultPartition.namespace, isNull);

      // Test emptyKey
      expect(db.emptyKey.partition.namespace, isNull);

      // Test emptyKey.append()
      var key = db.emptyKey.append(Foobar, id: 42);
      expect(key.parent, db.emptyKey);
      expect(key.partition.namespace, isNull);
      expect(key.id, 42);
      expect(key.type, equals(Foobar));
    });

    test('non-default-partition', () {
      var nsDb = new DatastoreDB(null,
          defaultPartition: new Partition('foobar-namespace'));

      // Test defaultPartition
      expect(nsDb.defaultPartition.namespace, 'foobar-namespace');

      // Test emptyKey
      expect(nsDb.emptyKey.partition.namespace, 'foobar-namespace');

      // Test emptyKey.append()
      var key = nsDb.emptyKey.append(Foobar, id: 42);
      expect(key.parent, nsDb.emptyKey);
      expect(key.partition.namespace, 'foobar-namespace');
      expect(key.id, 42);
      expect(key.type, equals(Foobar));
    });
  });
}
