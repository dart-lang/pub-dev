// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library gcloud.test.db_all_test;

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/src/datastore_impl.dart' as datastore_impl;
import 'package:unittest/unittest.dart';

import 'common_e2e.dart';
import 'datastore/e2e/datastore_test_impl.dart' as datastore_test;
import 'db/e2e/db_test_impl.dart' as db_test;
import 'db/e2e/metamodel_test_impl.dart' as db_metamodel_test;

main() {
  var scopes = datastore_impl.DatastoreImpl.SCOPES;

  var now = new DateTime.now().millisecondsSinceEpoch;
  String namespace = '${Platform.operatingSystem}${now}';

  withAuthClient(scopes, (String project, httpClient) {
    var datastore = new datastore_impl.DatastoreImpl(httpClient, project);
    var datastoreDB = new db.DatastoreDB(datastore);

    return runE2EUnittest(() {
      datastore_test.runTests(datastore, namespace);

      test('sleep-between-test-suites', () {
        expect(new Future.delayed(const Duration(seconds: 10)), completes);
      });

      db_test.runTests(datastoreDB, namespace);

      test('sleep-between-test-suites', () {
        expect(new Future.delayed(const Duration(seconds: 10)), completes);
      });

      db_metamodel_test.runTests(datastore, datastoreDB);
    }).whenComplete(() {
      return datastore_test.cleanupDB(datastore, namespace);
    });
  });
}
