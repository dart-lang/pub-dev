// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';

import 'package:gcloud/datastore.dart';
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/db/metamodel.dart';

List<Entity> buildEntitiesWithDifferentNamespaces(String uniquePostfix) {
  newKey(String? namespace, String kind, int id) {
    final partition = Partition(namespace);
    return Key([KeyElement(kind, id)], partition: partition);
  }

  newEntity(String? namespace, String kind, {int id = 1}) {
    return Entity(newKey(namespace, kind, id), {'ping': 'pong'});
  }

  return [
    newEntity(null, 'NullKind$uniquePostfix', id: 1),
    newEntity(null, 'NullKind$uniquePostfix', id: 2),
    newEntity(null, 'NullKind2$uniquePostfix', id: 1),
    newEntity(null, 'NullKind2$uniquePostfix', id: 2),
    newEntity('FooNamespace', 'FooKind$uniquePostfix', id: 1),
    newEntity('FooNamespace', 'FooKind$uniquePostfix', id: 2),
    newEntity('FooNamespace', 'FooKind2$uniquePostfix', id: 1),
    newEntity('FooNamespace', 'FooKind2$uniquePostfix', id: 2),
    newEntity('BarNamespace', 'BarKind$uniquePostfix', id: 1),
    newEntity('BarNamespace', 'BarKind$uniquePostfix', id: 2),
    newEntity('BarNamespace', 'BarKind2$uniquePostfix', id: 1),
    newEntity('BarNamespace', 'BarKind2$uniquePostfix', id: 2),
  ];
}

runTests(datastore, db.DatastoreDB store, String uniquePostfix) {
  final cond = predicate;

  group('e2e_db_metamodel', () {
    test('namespaces__insert_lookup_delete', () async {
      final entities = buildEntitiesWithDifferentNamespaces(uniquePostfix);
      final keys = entities.map((e) => e.key).toList();

      await datastore.commit(inserts: entities);
      await Future.delayed(const Duration(seconds: 10));

      final namespaceQuery = store.query<Namespace>();
      final List<Namespace> namespaces =
          await namespaceQuery.run().cast<Namespace>().toList();

      expect(namespaces.length, greaterThanOrEqualTo(3));
      expect(namespaces, contains(cond((dynamic ns) => ns.name == null)));
      expect(namespaces,
          contains(cond((dynamic ns) => ns.name == 'FooNamespace')));
      expect(namespaces,
          contains(cond((dynamic ns) => ns.name == 'BarNamespace')));

      try {
        for (final namespace in [null, 'FooNamespace', 'BarNamespace']) {
          // TODO: Partition.newPartition should be updated to accept null.
          final partition = db.Partition(namespace);
          final kindQuery = store.query<Kind>(partition: partition);
          final List<Kind> kinds = await kindQuery.run().cast<Kind>().toList();

          expect(kinds.length, greaterThanOrEqualTo(2));
          if (namespace == null) {
            expect(
                kinds,
                contains(
                    cond((dynamic k) => k.name == 'NullKind$uniquePostfix')));
            expect(
                kinds,
                contains(
                    cond((dynamic k) => k.name == 'NullKind2$uniquePostfix')));
          } else if (namespace == 'FooNamespace') {
            expect(
                kinds,
                contains(
                    cond((dynamic k) => k.name == 'FooKind$uniquePostfix')));
            expect(
                kinds,
                contains(
                    cond((dynamic k) => k.name == 'FooKind2$uniquePostfix')));
          } else if (namespace == 'BarNamespace') {
            expect(
                kinds,
                contains(
                    cond((dynamic k) => k.name == 'BarKind$uniquePostfix')));
            expect(
                kinds,
                contains(
                    cond((dynamic k) => k.name == 'BarKind2$uniquePostfix')));
          }
        }
      } finally {
        await datastore.commit(deletes: keys);
      }
    });
  });
}
