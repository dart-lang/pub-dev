// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/package_api.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Update value through API', () {
    setupTestsWithCallerAuthorizationIssues(
      (client) => client.setCredentiallessPublishing(
          'oxygen', CredentiallessPublishing()),
    );

    testWithProfile('no package', fn: () async {
      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
      await expectApiException(
        client.setCredentiallessPublishing(
            'no_such_package', CredentiallessPublishing()),
        status: 404,
        code: 'NotFound',
      );
    });

    testWithProfile('not admin', fn: () async {
      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
      await expectApiException(
        client.setCredentiallessPublishing(
            'oxygen', CredentiallessPublishing()),
        status: 403,
        code: 'InsufficientPermissions',
        message:
            'Insufficient permissions to perform administrative actions on package `oxygen`.',
      );
    });

    testWithProfile('successful update', fn: () async {
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      final rs = await client.setCredentiallessPublishing(
          'oxygen',
          CredentiallessPublishing(
            github: GithubPublishing(
              isEnabled: true,
              projectPath: 'dart-lang/pub-dev',
            ),
          ));
      expect(rs.toJson(), {
        'github': {
          'isEnabled': true,
          'projectPath': 'dart-lang/pub-dev',
        },
      });
      final p = await packageBackend.lookupPackage('oxygen');
      expect(p!.credentiallessPublishing.toJson(), rs.toJson());
    });

    testWithProfile('bad project path', fn: () async {
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      final badPaths = [
        '/',
        'a/',
        '/b',
        '//',
        'a/b/c',
        'a /b',
        '(/b',
      ];
      for (final projectPath in badPaths) {
        final rs = client.setCredentiallessPublishing(
            'oxygen',
            CredentiallessPublishing(
              github: GithubPublishing(
                isEnabled: false,
                projectPath: projectPath,
              ),
            ));
        await expectApiException(
          rs,
          status: 400,
          code: 'InvalidInput',
        );
      }
    });
  });
}
