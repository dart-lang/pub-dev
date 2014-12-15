// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:convert';

import 'package:unittest/unittest.dart';

import 'package:appengine/src/protobuf_api/rpc/rpc_service_remote_api.dart';
import 'package:appengine/src/appengine_context.dart';
import 'package:appengine/src/api_impl/raw_datastore_v3_impl.dart';

import 'package:gcloud/db.dart';
import 'package:gcloud/db.dart' as db;


class AllDataTypesModelMixin {
  @BoolProperty()
  bool boolProp;

  @IntProperty()
  int intProp;

  @StringProperty()
  String stringProp;

  @ModelKeyProperty()
  Key keyProp;

  @BlobProperty()
  List<int> blobProp;

  @DateTimeProperty()
  DateTime dateProp;

  @StringListProperty()
  List<String> stringListProp;
}

@Kind()
class NormalModel extends Model with AllDataTypesModelMixin { }

@Kind()
class ExpandoModel extends db.ExpandoModel with AllDataTypesModelMixin { }


final DateTime EndOfYear = new DateTime.utc(2014, 12, 31);
customDate(int i) => EndOfYear.add(new Duration(hours: i));

void fillData(DatastoreDB db, AllDataTypesModelMixin model, int i) {
  model.boolProp = i % 2 == 0;
  model.intProp = i + 42;
  model.stringProp = 'foobar $i';
  model.keyProp = db.emptyKey.append(NormalModel, id: 10 + i);
  model.blobProp = [1, 2, 3, 4]..addAll(UTF8.encode('$i'));
  model.dateProp = customDate(i);
  model.stringListProp = ['a$i', 'b$i', 'c$i'];
}

void verifyData(DatastoreDB db, AllDataTypesModelMixin model, int i) {
  expect(model.boolProp, equals(i % 2 == 0));
  expect(model.intProp, equals(i + 42));
  expect(model.stringProp, equals('foobar $i'));
  expect(model.keyProp, equals(db.emptyKey.append(NormalModel, id: 10 + i)));
  expect(model.blobProp, equals(
      [1, 2, 3, 4]..addAll(UTF8.encode('$i'))));
  expect(model.dateProp, equals(customDate(i)));
  expect(model.stringListProp, equals(['a$i', 'b$i', 'c$i']));
}

runTests(bool writingMode, DatastoreDB db) {
  var key = db.emptyKey.append(NormalModel, id: 99);
  var ekey = key.append(ExpandoModel, id: 102);

  if (writingMode) {
    test('writing-test', () {
      var normalObj = new NormalModel();
      var em = new ExpandoModel();

      em.parentKey = key;

      normalObj.id = 99;
      em.id = 102;

      fillData(db, normalObj, 1);
      fillData(db, em, 5);

      db.commit(inserts: [normalObj, em]).then(expectAsync((_) {
        print('done');
      }));
    });
  }

  if (!writingMode) {
    test('reading-test', () {
      db.lookup([key, ekey])
          .then(expectAsync((List<Model> models) {
        expect(models, hasLength(2));

        NormalModel model = models[0];
        ExpandoModel emodel = models[1];

        expect(model, isNotNull);
        expect(emodel, isNotNull);

        expect(model.id, equals(99));
        expect(emodel.id, equals(102));

        expect(model.parentKey, equals(db.emptyKey));
        expect(emodel.parentKey, equals(key));

        verifyData(db, model, 1);
        verifyData(db, emodel, 5);
      }));
    });
  }
}

void main(List<String> arguments) {
  if (arguments.length != 1 || !['read', 'write'].contains(arguments[0])) {
    print("Usage: main.dart <read|write>");
    exit(1);
  }
  var writingMode = arguments[0] == 'write';

  var rpcService = new RPCServiceRemoteApi('localhost', 4444);
  var appengineContext = new AppengineContext(
      'dev', 'test-application', 'test-version', null, null, null);
  var datastore =
      new DatastoreV3RpcImpl(rpcService, appengineContext, '<invalid-ticket>');

  runTests(writingMode, new DatastoreDB(datastore));
}

