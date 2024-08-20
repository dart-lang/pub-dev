// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/backend.dart';
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

  testWithProfile(
      'creating, listing members and deleting publisher with no packages',
      fn: () async {
    final client = createPubApiClient(authToken: siteAdminToken);
    final p0 = await publisherBackend.getPublisher('other.com');
    expect(p0, isNull);
    final rs1 = await client.adminInvokeAction(
      'publisher-create',
      AdminInvokeActionArguments(arguments: {
        'publisher': 'other.com',
        'member-email': 'user@pub.dev',
      }),
    );
    expect(rs1.output, {
      'message': 'Publisher created.',
      'publisherId': 'other.com',
      'member-email': 'user@pub.dev',
    });
    final publisherMembersResponse = await client.adminInvokeAction(
      'publisher-members-list',
      AdminInvokeActionArguments(arguments: {
        'publisher': 'other.com',
      }),
    );
    expect(publisherMembersResponse.output, {
      'publisher': 'other.com',
      'description': '',
      'website': 'https://other.com/',
      'contact': 'user@pub.dev',
      'created': isA<String>(),
      'members': [
        {'email': 'user@pub.dev', 'role': 'admin', 'userId': isA<String>()}
      ]
    });
    final p1 = await publisherBackend.getPublisher('other.com');
    expect(p1, isNotNull);
    final rs2 = await client.adminInvokeAction('publisher-delete',
        AdminInvokeActionArguments(arguments: {'publisher': 'other.com'}));
    expect(rs2.output, {
      'message': 'Publisher and all members deleted.',
      'publisherId': 'other.com',
      'members-count': 1,
    });
    final p2 = await publisherBackend.getPublisher('other.com');
    expect(p2, isNull);
  });

  testWithProfile('remove package from publisher', fn: () async {
    final api = createPubApiClient(authToken: siteAdminToken);
    final result = await api.adminInvokeAction(
      'publisher-package-remove',
      AdminInvokeActionArguments(arguments: {'package': 'neon'}),
    );
    final neon = await packageBackend.lookupPackage('neon');

    expect(result.output, {
      'previousPublisher': 'example.com',
      'package': 'neon',
      'uploaders': [
        {'email': 'admin@pub.dev', 'userId': neon!.uploaders!.first}
      ]
    });
    final packagePublisherInfo = await packageBackend.getPublisherInfo('neon');
    expect(packagePublisherInfo.publisherId, isNull);
    final emails = await accountBackend.getEmailsOfUserIds(neon.uploaders!);
    expect(emails, {'admin@pub.dev'});
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
}
