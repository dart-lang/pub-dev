// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart' as test;

import 'package:appengine/src/grpc_api_impl/auth_utils.dart';
import 'package:appengine/src/grpc_api_impl/grpc.dart' as grpc;
import 'package:appengine/src/grpc_api_impl/datastore_impl.dart';
import 'package:gcloud/db.dart' as db;
import 'package:googleapis_auth/auth_io.dart';

import 'common_e2e.dart' show withServiceAccount;
import 'db/db_tests.dart' as db_tests;
import 'db/metamodel_tests.dart' as metamodel_tests;
import 'raw_datastore_test_impl.dart' as datastore_tests;

main() async {
  // Due to package:test issue (see
  // https://github.com/dart-lang/test/issues/578)
  if (Platform.operatingSystem == 'macos') {
    return;
  }

  final endpoint = Uri.parse('https://datastore.googleapis.com');
  final scopes = <String>[
    'https://www.googleapis.com/auth/cloud-platform',
    'https://www.googleapis.com/auth/datastore',
  ];

  final String nsPrefix = Platform.operatingSystem;

  await withServiceAccount(
      (String project, ServiceAccountCredentials serviceAccount) async {
    final accessTokenProvider =
        new ServiceAccountTokenProvider(serviceAccount, scopes);
    final dialer = new grpc.Dialer(endpoint);
    final client = new grpc.Client(dialer, accessTokenProvider, 10);
    final datastore = new GrpcDatastoreImpl(client, project);
    final dbService = new db.DatastoreDB(datastore);

    // Once all tests are done we'll close the resources.
    test.tearDownAll(() async {
      await client.close();
      await accessTokenProvider.close();
    });

    // Run low-level datastore tests.
    datastore_tests.runTests(
        datastore, '${nsPrefix}${new DateTime.now().millisecondsSinceEpoch}');

    // Run high-level db tests.
    db_tests.runTests(
        dbService, '${nsPrefix}${new DateTime.now().millisecondsSinceEpoch}');

    // Run metamodel tests.
    metamodel_tests.runTests(datastore, dbService,
        '${nsPrefix}${new DateTime.now().millisecondsSinceEpoch}');
  });
}
