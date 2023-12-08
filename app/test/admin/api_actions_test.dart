// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/data/admin_api.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:test/test.dart';

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
      'create-publisher',
      AdminInvokeActionArguments(arguments: {
        'publisher': 'other.com',
        'member-email': 'user@pub.dev'
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
    // TODO(sigurdm): Migrate delete-publisher to be an Action.
    final rs2 = await client.adminExecuteTool(
      'delete-publisher',
      Uri(pathSegments: [
        '--publisher',
        'other.com',
      ]).toString(),
    );
    expect(utf8.decode(rs2), 'Publisher and 1 member(s) deleted.');
    final p2 = await publisherBackend.getPublisher('other.com');
    expect(p2, isNull);
  });

  testWithProfile('remove package from publisher', fn: () async {
    final api = createPubApiClient(authToken: siteAdminToken);
    final result = await api.adminInvokeAction(
      'remove-package-from-publisher',
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
}
