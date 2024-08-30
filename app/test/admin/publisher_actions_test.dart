// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  // TODO: move publisher-related tests from api_actions_test.dart
  group('publisher admin actions', () {
    testWithProfile('info request', fn: () async {
      final client = createPubApiClient(authToken: siteAdminToken);
      final rs = await client.adminInvokeAction(
        'publisher-info',
        AdminInvokeActionArguments(arguments: {
          'publisher': 'example.com',
        }),
      );
      expect(rs.output, {
        'publisher': {
          'publisherId': 'example.com',
          'created': isNotEmpty,
          'contactEmail': 'admin@pub.dev',
          'isModerated': false
        },
      });
    });
  });
}
