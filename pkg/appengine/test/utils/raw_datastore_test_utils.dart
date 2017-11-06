// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library raw_datastore_test_utils;

import 'package:gcloud/datastore.dart';

const TEST_KIND = 'TestKind';
const TEST_PROPERTY_KEY_PREFIX = 'test_property';
const TEST_LIST_PROPERTY = 'listproperty';
const TEST_LIST_VALUE = 'listvalue';
const TEST_PROPERTY_VALUE_PREFIX = 'test_property';

const TEST_INDEXED_PROPERTY = 'indexedProp';
const TEST_INDEXED_PROPERTY_VALUE_PREFIX = 'indexedValue';
const TEST_UNINDEXED_PROPERTY = 'unindexedProp';
const TEST_BLOB_INDEXED_PROPERTY = 'blobPropertyIndexed';
final TEST_BLOB_INDEXED_VALUE = new BlobValue([0xaa, 0xaa, 0xff, 0xff]);

buildKey(int i, {Function idFunction, String kind : TEST_KIND, Partition p}) {
  var path = [new KeyElement(kind, idFunction == null ? null : idFunction(i))];
  return new Key(path, partition: p);
}

Map<String, Object> buildProperties(int i) {
  var listValues = [
      'foo',
      '$TEST_LIST_VALUE$i',
  ];

  return {
    TEST_PROPERTY_KEY_PREFIX : '$TEST_PROPERTY_VALUE_PREFIX$i',
    TEST_LIST_PROPERTY : listValues,
    TEST_INDEXED_PROPERTY : '$TEST_INDEXED_PROPERTY_VALUE_PREFIX$i',
    TEST_UNINDEXED_PROPERTY : '$TEST_INDEXED_PROPERTY_VALUE_PREFIX$i',
    TEST_BLOB_INDEXED_PROPERTY : TEST_BLOB_INDEXED_VALUE,
  };
}

List<Key> buildKeys(
    int from, int to, {Function idFunction, String kind : TEST_KIND,
    Partition partition}) {
  var keys = [];
  for (var i = from; i < to; i++) {
    keys.add(buildKey(i, idFunction: idFunction, kind: kind, p: partition));
  }
  return keys;
}

List<Entity> buildEntities(
    int from, int to, {Function idFunction, String kind : TEST_KIND,
    Partition partition}) {
  var entities = [];
  var unIndexedProperties = new Set<String>();
  for (var i = from; i < to; i++) {
    var key = buildKey(i, idFunction: idFunction, kind: kind, p: partition);
    var properties = buildProperties(i);
    unIndexedProperties.add(TEST_UNINDEXED_PROPERTY);
    entities.add(
        new Entity(key, properties, unIndexedProperties: unIndexedProperties));
  }
  return entities;
}

List<Entity> buildEntityWithAllProperties(
    int from, int to, {String kind : TEST_KIND, Partition partition}) {
  var us42 = const Duration(microseconds: 42);
  var unIndexed = new Set<String>.from(['blobProperty']);

  Map<String, Object> buildProperties(int i) {
    return {
      'nullValue' : null,
      'boolProperty' : true,
      'intProperty' : 42,
      'doubleProperty' : 4.2,
      'stringProperty' : 'foobar',
      'blobProperty' : new BlobValue([0xff, 0xff, 0xaa, 0xaa]),
      'blobPropertyIndexed' : new BlobValue([0xaa, 0xaa, 0xff, 0xff]),
      'dateProperty' :
          new DateTime.fromMillisecondsSinceEpoch(1, isUtc: true).add(us42),
      'keyProperty' : buildKey(1, idFunction: (i) => 's$i', kind: kind),
      'listProperty' : [
        42,
        4.2,
        'foobar',
        buildKey(1, idFunction: (i) => 's$i', kind: 'TestKind'),
      ],
    };
  }

  var entities = [];
  for (var i = from; i < to; i++) {
    var key = buildKey(
        i, idFunction: (i) => 'allprop$i', kind: kind, p: partition);
    var properties = buildProperties(i);
    entities.add(new Entity(key, properties, unIndexedProperties: unIndexed));
  }
  return entities;
}
