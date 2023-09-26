// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/package/backend.dart';
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
