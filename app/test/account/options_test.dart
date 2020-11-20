// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('/api/account/options', () {
    testWithProfile('package - no user', fn: () async {
      final client = createPubApiClient();
      final rs = client.accountPackageOptions('oxygen');
      await expectApiException(rs, status: 401);
    });

    testWithProfile('package - no package', fn: () async {
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      final rs = client.accountPackageOptions('no_package');
      await expectApiException(rs, status: 404);
    });

    testWithProfile('package - not admin', fn: () async {
      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
      final rs = await client.accountPackageOptions('oxygen');
      expect(rs.isAdmin, isFalse);
    });

    testWithProfile('package - admin', fn: () async {
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      final rs = await client.accountPackageOptions('oxygen');
      expect(rs.isAdmin, isTrue);
    });

    testWithProfile('publisher - no user', fn: () async {
      final client = createPubApiClient();
      final rs = client.accountPublisherOptions('example.com');
      await expectApiException(rs, status: 401);
    });

    testWithProfile('publisher - no publisher', fn: () async {
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      final rs = await client.accountPublisherOptions('no-domain.com');
      expect(rs.isAdmin, isFalse);
    });

    testWithProfile('publisher - not admin', fn: () async {
      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
      final rs = await client.accountPublisherOptions('example.com');
      expect(rs.isAdmin, isFalse);
    });

    testWithProfile('publisher - admin', fn: () async {
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      final rs = await client.accountPublisherOptions('example.com');
      expect(rs.isAdmin, isTrue);
    });
  });
}
