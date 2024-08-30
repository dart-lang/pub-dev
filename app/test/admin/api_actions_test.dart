// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import '../package/backend_test_utils.dart';
import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('list actions', () {
    setupTestsWithAdminTokenIssues((api) async {
      await api.adminListActions();
    });
  });

  group('invoke action', () {
    setupTestsWithAdminTokenIssues((api) async {
      await api.adminInvokeAction(
        'tool-list',
        AdminInvokeActionArguments(arguments: {}),
      );
    });

    testWithProfile('tool-list', fn: () async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final result = await api.adminInvokeAction(
        'tool-list',
        AdminInvokeActionArguments(arguments: {}),
      );
      expect(result.output.containsKey('tools'), isTrue);
    });
  });

  testWithProfile('user-info', fn: () async {
    final api = createPubApiClient(authToken: siteAdminToken);
    final result = await api.adminInvokeAction(
      'user-info',
      AdminInvokeActionArguments(arguments: {'user': 'admin@pub.dev'}),
    );

    final oxygen = await packageBackend.lookupPackage('oxygen');

    expect(result.output, {
      'users': [
        {
          'userId': oxygen!.uploaders!.first,
          'email': 'admin@pub.dev',
          'packages': ['flutter_titanium', 'oxygen'],
          'publishers': ['example.com'],
          'moderated': false,
          'created': isA<String>(),
          'deleted': false
        }
      ]
    });
  });

  testWithProfile('merge existing moderated package into existing',
      fn: () async {
    final originalVersionList = await packageBackend.listVersions('oxygen');

    // inject "bad" ModeratedPackage tombstone
    await dbService.commit(inserts: [
      ModeratedPackage()
        ..parentKey = dbService.emptyKey
        ..id = 'oxygen'
        ..name = 'oxygen'
        ..moderated = clock.now().toUtc()
        ..versions = [
          originalVersionList.versions.first.version, // existing
          '8.99.100', // non-existing
        ]
        ..uploaders = [],
    ]);

    // verify that new upload is blocked
    final pubspecContent = generatePubspecYaml('oxygen', '9.0.0');
    final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
    final rs1 = createPubApiClient(authToken: adminClientToken)
        .uploadPackageBytes(bytes);
    await expectApiException(
      rs1,
      status: 400,
      code: 'PackageRejected',
      message: 'Package name oxygen is reserved',
    );

    // merge tombstone
    final api = createPubApiClient(authToken: siteAdminToken);
    final result = await api.adminInvokeAction(
      'merge-moderated-package-into-existing',
      AdminInvokeActionArguments(arguments: {'package': 'oxygen'}),
    );
    expect(result.output, {
      'package': 'oxygen',
      'merged': true,
    });

    // verify that upload is unblocked
    final rs2 = await createPubApiClient(authToken: adminClientToken)
        .uploadPackageBytes(bytes);
    expect(rs2.success.message, contains('Successfully uploaded'));
  });
}
