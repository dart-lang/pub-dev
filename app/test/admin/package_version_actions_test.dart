// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('package version admin actions', () {
    testWithProfile('info request', fn: () async {
      final client = createPubApiClient(authToken: siteAdminToken);
      final rs = await client.adminInvokeAction(
        'package-version-info',
        AdminInvokeActionArguments(arguments: {
          'package': 'oxygen',
          'version': '1.2.0',
        }),
      );
      expect(rs.output, {
        'package-version': {
          'package': 'oxygen',
          'version': '1.2.0',
          'created': isNotEmpty,
          'isModerated': false,
        }
      });
    });

    testWithProfile('package-version-retraction', fn: () async {
      final latest = await packageBackend.getLatestVersion('oxygen');

      final api = createPubApiClient(authToken: siteAdminToken);
      final result = await api.adminInvokeAction(
        'package-version-retraction',
        AdminInvokeActionArguments(arguments: {
          'package': 'oxygen',
          'version': latest!,
          'set-retracted': 'true',
        }),
      );

      expect(result.output, {
        'before': {
          'package': 'oxygen',
          'version': latest,
          'isRetracted': false,
        },
        'after': {
          'package': 'oxygen',
          'version': latest,
          'isRetracted': true,
        },
      });

      final newLatest = await packageBackend.getLatestVersion('oxygen');
      expect(newLatest != latest, isTrue);
    });
  });
}
