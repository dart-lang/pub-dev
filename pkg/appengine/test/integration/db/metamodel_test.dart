// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library metamodel_test;

import 'dart:async';

import 'package:unittest/unittest.dart';

import 'package:appengine/src/appengine_context.dart';
import 'package:appengine/src/api_impl/raw_datastore_v3_impl.dart';
import 'package:appengine/src/protobuf_api/rpc/rpc_service_remote_api.dart';
import 'package:gcloud/datastore.dart';
import 'package:gcloud/datastore.dart' show Key, Query, Partition;
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/db/metamodel.dart';

List<Entity> buildEntitiesWithDifferentNamespaces() {
  newKey(String namespace, String kind, int id) {
    var partition = new Partition(namespace);
    return new Key([new KeyElement(kind, id)], partition: partition);
  }

  newEntity(String namespace, String kind, {int id: 1}) {
    return new Entity(newKey(namespace, kind, id), {'ping': 'pong'});
  }

  return [
    newEntity(null, 'NullKind', id: 1),
    newEntity(null, 'NullKind', id: 2),
    newEntity(null, 'NullKind2', id: 1),
    newEntity(null, 'NullKind2', id: 2),

    newEntity('FooNamespace', 'FooKind', id: 1),
    newEntity('FooNamespace', 'FooKind', id: 2),
    newEntity('FooNamespace', 'FooKind2', id: 1),
    newEntity('FooNamespace', 'FooKind2', id: 2),

    newEntity('BarNamespace', 'BarKind', id: 1),
    newEntity('BarNamespace', 'BarKind', id: 2),
    newEntity('BarNamespace', 'BarKind2', id: 1),
    newEntity('BarNamespace', 'BarKind2', id: 2),
  ];
}

Future sleep(Duration duration) {
  var completer = new Completer();
  new Timer(duration, completer.complete);
  return completer.future;
}

runTests(datastore, db.DatastoreDB store) {
  final cond = predicate;

  group('e2e_db_metamodel', () {
    test('namespaces__insert_lookup_delete', () {
      var entities = buildEntitiesWithDifferentNamespaces();
      var keys = entities.map((e) => e.key).toList();

      return datastore.commit(inserts: entities).then((_) {
        return sleep(const Duration(seconds: 10)).then((_) {
          var namespaceQuery = store.query(Namespace);
          return namespaceQuery.run().toList()
              .then((List<Namespace> namespaces) {
            expect(namespaces.length, 3);
            expect(namespaces, contains(cond((ns) => ns.name == null)));
            expect(namespaces,
                   contains(cond((ns) => ns.name == 'FooNamespace')));
            expect(namespaces,
                   contains(cond((ns) => ns.name == 'BarNamespace')));

            var futures = [];
            for (var namespace in namespaces) {
              var partition = store.newPartition(namespace.name);
              var kindQuery = store.query(Kind, partition: partition);
              futures.add(kindQuery.run().toList().then((List<Kind> kinds) {
                expect(kinds.length, greaterThanOrEqualTo(2));
                if (namespace.name == null) {
                  expect(kinds, contains(cond((k) => k.name == 'NullKind')));
                  expect(kinds, contains(cond((k) => k.name == 'NullKind2')));
                } else if (namespace.name == 'FooNamespace') {
                  expect(kinds, contains(cond((k) => k.name == 'FooKind')));
                  expect(kinds, contains(cond((k) => k.name == 'FooKind2')));
                } else if (namespace.name == 'BarNamespace') {
                  expect(kinds, contains(cond((k) => k.name == 'BarKind')));
                  expect(kinds, contains(cond((k) => k.name == 'BarKind2')));
                }
              }));
            }
            return Future.wait(futures).then((_) {
              expect(datastore.commit(deletes: keys), completes);
            });
          });
        });
      });
    });
  });
}

main() {
  var rpcService = new RPCServiceRemoteApi('127.0.0.1', 4444);
  var appengineContext = new AppengineContext(
      'dev', 'test-application', 'test-version', null, null, null);
  var datastore =
      new DatastoreV3RpcImpl(rpcService, appengineContext, '<invalid-ticket>');

  runTests(datastore, new db.DatastoreDB(datastore));
}
