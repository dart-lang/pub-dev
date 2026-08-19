// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:appengine/src/grpc_api_impl/datastore_impl.dart';
import 'package:gcloud/db.dart' as db;
import 'package:grpc/grpc.dart' as grpc;
import 'package:test/test.dart' as test;
import 'db/db_tests.dart' as db_tests;
import 'db/metamodel_tests.dart' as metamodel_tests;

import 'common_e2e.dart' show onBot, withAuthenticator, PROJECT_ENV;
import 'raw_datastore_test_impl.dart' as datastore_tests;

String? shouldSkip() {
  if (onBot()) {
    return 'Skipping e2e tests on bot';
  }

  if (!Platform.environment.containsKey(PROJECT_ENV)) {
    return '$PROJECT_ENV not set';
  }

  return null;
}

void main() async {
  final endpoint = 'datastore.googleapis.com';

  final String nsPrefix = Platform.operatingSystem;

  test.group('grpc', () {
    test.test('datastore', () async {
      await withAuthenticator(OAuth2Scopes,
          (String project, grpc.HttpBasedAuthenticator authenticator) async {
        final clientChannel = grpc.ClientChannel(endpoint);
        final datastore =
            GrpcDatastoreImpl(clientChannel, authenticator, project);
        // ignore: unused_local_variable
        final dbService = db.DatastoreDB(datastore);

        // Once all tests are done we'll close the resources.
        test.tearDownAll(() async {
          await clientChannel.shutdown();
        });

        // Run low-level datastore tests.
        datastore_tests.runTests(
            datastore, '$nsPrefix${DateTime.now().millisecondsSinceEpoch}');

        // Run high-level db tests.
        db_tests.runTests(
            dbService, '$nsPrefix${DateTime.now().millisecondsSinceEpoch}');

        // Run metamodel tests.
        metamodel_tests.runTests(datastore, dbService,
            '$nsPrefix${DateTime.now().millisecondsSinceEpoch}');
      });
    });
  }, skip: shouldSkip());
}
