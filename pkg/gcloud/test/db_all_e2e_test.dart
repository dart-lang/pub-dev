// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library gcloud.test.db_all_test;

import 'dart:async';

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/src/datastore_impl.dart' as datastore_impl;
import 'package:unittest/unittest.dart';

import 'db/e2e/db_test_impl.dart' as db_test;
import 'db/e2e/metamodel_test_impl.dart' as db_metamodel_test;
import 'datastore/e2e/datastore_test_impl.dart' as datastore_test;


import 'common_e2e.dart';

main() {
  var scopes = datastore_impl.DatastoreImpl.SCOPES;

  withAuthClient(scopes, (String project, httpClient) {
    var datastore = new datastore_impl.DatastoreImpl(httpClient, 's~$project');
    var datastoreDB = new db.DatastoreDB(datastore);

    return datastore_test.cleanupDB(datastore).then((_) {
      return runE2EUnittest(() {
        datastore_test.runTests(datastore);

        test('sleep-between-test-suites', () {
          expect(new Future.delayed(const Duration(seconds: 10)), completes);
        });

        db_test.runTests(datastoreDB);

        test('sleep-between-test-suites', () {
          expect(new Future.delayed(const Duration(seconds: 10)), completes);
        });

        db_metamodel_test.runTests(datastore, datastoreDB);
      });
    });
  });
}
