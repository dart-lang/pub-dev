// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('package admin actions', () {
    testWithProfile('info request', fn: () async {
      final client = createPubApiClient(authToken: siteAdminToken);
      final rs = await client.adminInvokeAction(
        'package-info',
        AdminInvokeActionArguments(arguments: {
          'package': 'oxygen',
        }),
      );
      expect(rs.output, {
        'package': {
          'name': 'oxygen',
          'created': isNotEmpty,
          'publisherId': null,
          'latestVersion': '1.2.0',
          'isModerated': false,
        }
      });
    });
  });
}
