// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/account/testing/fake_auth_provider.dart';
import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/scorecard/scorecard_memcache.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/redis_cache.dart';

import '../../shared/handlers_test_utils.dart';
import '../utils.dart';

import '_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFiles());

  group('ui', () {
    final db = DatastoreDB(MemDatastore());

    setUpAll(() async {
      await db.commit(inserts: [testPackage, testPackageVersion]);
    });

    void _test(String name, Future fn()) {
      tScopedTest(name, () async {
        await withCache(() {
          registerAccountBackend(
              AccountBackend(db, authProvider: FakeAuthProvider()));
          registerAnalyzerClient(AnalyzerClient());
          registerBackend(Backend(db, null));
          registerScoreCardBackend(ScoreCardBackend(db));
          registerScoreCardMemcache(ScoreCardMemcache());
        });
      });
    }

    _test('/packages/foobar_pkg - found', () async {
      await expectHtmlResponse(await issueGet('/packages/foobar_pkg'));
    });

    _test('/packages/foobar_not_found - not found', () async {
      await expectRedirectResponse(await issueGet('/packages/foobar_not_found'),
          '/packages?q=foobar_not_found');
    });

    _test('/packages/foobar_pkg/versions - found', () async {
      await expectHtmlResponse(await issueGet('/packages/foobar_pkg/versions'));
    });

    _test('/packages/foobar_not_found/versions - not found', () async {
      await expectRedirectResponse(
          await issueGet('/packages/foobar_not_found/versions'),
          '/packages?q=foobar_not_found');
    });

    _test('/packages/foobar_pkg/versions/0.1.1 - found', () async {
      await expectHtmlResponse(
          await issueGet('/packages/foobar_pkg/versions/0.1.1+5'));
    });

    _test('/packages/foobar_pkg/versions/0.1.2 - not found', () async {
      await expectRedirectResponse(
          await issueGet('/packages/foobar_pkg/versions/0.1.2'),
          '/packages/foobar_pkg#-versions-tab-');
    });
  });
}
