// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:fake_gcloud/mem_datastore.dart';
import 'package:pub_dev/account/agent.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/service/openid/gcp_openid.dart';
import 'package:pub_dev/service/openid/github_openid.dart';
import 'package:pub_dev/service/openid/jwt.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

void main() {
  group('before parameter parse and format', () {
    final backend = AuditBackend(DatastoreDB(MemDatastore()));

    test('nearby timestamps', () {
      final t1 = clock.now().toUtc();
      final t2 = t1.subtract(Duration(milliseconds: 1));
      final param = backend.nextTimestamp(t1, t2);
      expect(param, t2.toIso8601String());
      expect(backend.parseBeforeQueryParameter(param), t2);
    });

    test('larger difference', () {
      final t1 = clock.now().toUtc();
      final t2 = t1.subtract(Duration(days: 2));
      final param = backend.nextTimestamp(t1, t2);
      expect(param, hasLength(10));
      final parsed = backend.parseBeforeQueryParameter(param);
      expect(t2.isBefore(parsed), true);
      expect(t1.isAfter(parsed), true);
    });
  });

  group('message test', () {
    test('user uploads a package', () {
      final r = AuditLogRecord.packagePublished(
        created: clock.now(),
        package: 'pkg',
        version: '1.0.0',
        uploader: AuthenticatedUser(
          User.init()
            ..id = 'user-id'
            ..email = 'user@pub.dev',
          audience: 'fake-client-audience',
        ),
      );
      expect(r.summary,
          'Package `pkg` version `1.0.0` was published by `user@pub.dev`.');
      expect(r.data, {
        'package': 'pkg',
        'version': '1.0.0',
        'email': 'user@pub.dev',
      });
    });

    test('GitHub Action uploads a package', () {
      final token = JsonWebToken(
        header: {},
        payload: {
          'aud': 'https://pub.dev',
          'event_name': 'push',
          'exp': 0,
          'iat': 0,
          'iss': 'github',
          'nbf': 0,
          'ref': 'tag',
          'ref_type': 'refs/tags/v1.2.0',
          'repository': 'abcd/efgh',
          'repository_id': '11',
          'repository_owner': 'abcd',
          'repository_owner_id': '22',
          'actor': 'abcd',
          'sha': 'some-hash-value',
          'run_id': 'example-run-id',
        },
        signature: [],
      );
      final r = AuditLogRecord.packagePublished(
        created: clock.now(),
        package: 'pkg',
        version: '1.2.0',
        uploader: AuthenticatedGithubAction(
          idToken: token,
          payload: GitHubJwtPayload(token.payload),
        ),
      );
      expect(
        r.summary,
        'Package `pkg` version `1.2.0` was published from GitHub Actions '
        '(`run_id`: [`example-run-id`](https://github.com/abcd/efgh/actions/runs/example-run-id)) '
        'triggered by pushing revision `some-hash-value` to the `abcd/efgh` repository.',
      );
      expect(r.data, {
        'package': 'pkg',
        'version': '1.2.0',
        'repository': 'abcd/efgh',
        'run_id': 'example-run-id',
        'sha': 'some-hash-value',
      });
    });

    test('Google Cloud service account uploads a package', () {
      final token = JsonWebToken(
        header: {},
        payload: {
          'aud': 'https://pub.dev',
          'exp': 0,
          'iat': 0,
          'iss': 'google',
          'sub': 'sub-value',
          'nbf': 0,
          'email': 'account@example.com',
        },
        signature: [],
      );
      final r = AuditLogRecord.packagePublished(
        created: clock.now(),
        package: 'pkg',
        version: '1.2.0',
        uploader: AuthenticatedGcpServiceAccount(
          idToken: token,
          payload: GcpServiceAccountJwtPayload(token.payload),
        ),
      );
      expect(
          r.summary,
          'Package `pkg` version `1.2.0` was published by '
          'Google Cloud service account: `account@example.com`.');
      expect(r.data, {
        'package': 'pkg',
        'version': '1.2.0',
        'email': 'account@example.com',
      });
    });
  });
}
