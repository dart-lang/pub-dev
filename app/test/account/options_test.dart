// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('/api/account/options', () {
    testWithServices('package - no user', () async {
      final client = createPubApiClient();
      final rs = client.accountPackageOptions('hydrogen');
      await expectApiException(rs, status: 401);
    });

    testWithServices('package - no package', () async {
      final client = createPubApiClient(authToken: joeUser.userId);
      final rs = client.accountPackageOptions('no_package');
      await expectApiException(rs, status: 404);
    });

    testWithServices('package - not admin', () async {
      final client = createPubApiClient(authToken: joeUser.userId);
      final rs = await client.accountPackageOptions('hydrogen');
      expect(rs.isAdmin, isFalse);
    });

    testWithServices('package - admin', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = await client.accountPackageOptions('hydrogen');
      expect(rs.isAdmin, isTrue);
    });

    testWithServices('publisher - no user', () async {
      final client = createPubApiClient();
      final rs = client.accountPublisherOptions('hydrogen');
      await expectApiException(rs, status: 401);
    });

    testWithServices('publisher - no publisher', () async {
      final client = createPubApiClient(authToken: joeUser.userId);
      final rs = await client.accountPublisherOptions('no-domain.com');
      expect(rs.isAdmin, isFalse);
    });

    testWithServices('publisher - not admin', () async {
      final client = createPubApiClient(authToken: joeUser.userId);
      final rs = await client.accountPublisherOptions('example.com');
      expect(rs.isAdmin, isFalse);
    });

    testWithServices('publisher - admin', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = await client.accountPublisherOptions('example.com');
      expect(rs.isAdmin, isTrue);
    });
  });
}
