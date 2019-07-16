// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/account/testing/fake_auth_provider.dart';
import 'package:pub_dartlang_org/dartdoc/backend.dart';
import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/publisher/backend.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/redis_cache.dart';

import '../frontend/utils.dart';
import '../shared/utils.dart';

/// Setup scoped services (including fake datastore with pre-populated base data
/// and fake storage) for tests.
void testWithServices(String name, Future fn()) {
  scopedTest(name, () async {
    await withCache(() async {
      final db = DatastoreDB(MemDatastore());
      await db.commit(inserts: [
        testPackage,
        testPackageVersion,
        devPackageVersion,
        testUserA,
        testUserHans,
      ]);
      registerDbService(db);

      final storage = MemStorage(buckets: ['dartdoc', 'tarball']);
      final tarballBucket = storage.bucket('tarball');
      registerStorageService(storage);

      // registering config with bad ports, as we won't access them via network
      registerActiveConfiguration(Configuration.fakePubServer(
        port: 0,
        storageBaseUrl: 'http://localhost:0',
      ));

      registerAccountBackend(
          AccountBackend(db, authProvider: FakeAuthProvider()));
      registerAnalyzerClient(AnalyzerClient());
      registerBackend(
          Backend(db, TarballStorage(storage, tarballBucket, null)));
      registerDartdocBackend(DartdocBackend(db, storage.bucket('dartdoc')));
      registerPublisherBackend(PublisherBackend(db));
      registerScoreCardBackend(ScoreCardBackend(db));

      await fn();
    });
  });
}
