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
          'oxygen', CredentiallessPublishing.empty()),
    );

    testWithProfile('no package', fn: () async {
      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
      await expectApiException(
        client.setCredentiallessPublishing(
            'no_such_package', CredentiallessPublishing.empty()),
        status: 404,
        code: 'NotFound',
      );
    });

    testWithProfile('not admin', fn: () async {
      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
      await expectApiException(
        client.setCredentiallessPublishing(
            'oxygen', CredentiallessPublishing.empty()),
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
            repository: 'https://github.com/dart-lang/pub-dev',
          ));
      expect(rs.toJson(), {
        'repository': 'https://github.com/dart-lang/pub-dev',
      });
      final p = await packageBackend.lookupPackage('oxygen');
      expect(p!.credentiallessPublishing.toJson(), rs.toJson());
    });

    testWithProfile('bad repository URL', fn: () async {
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      final rs = client.setCredentiallessPublishing(
          'oxygen',
          CredentiallessPublishing(
            repository: 'https://github.com/',
          ));
      await expectApiException(
        rs,
        status: 400,
        code: 'InvalidInput',
        message: 'Unable to parse repository URL.',
      );
    });

    testWithProfile('GitLab is not yet supported', fn: () async {
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      final rs = client.setCredentiallessPublishing(
          'oxygen',
          CredentiallessPublishing(
            repository: 'https://gitlab.com/user/repo',
          ));
      await expectApiException(
        rs,
        status: 400,
        code: 'InvalidInput',
        message: 'Only GitHub is supported at this time.',
      );
    });
  });
}
