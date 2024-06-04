// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Create moderation case', () {
    testWithProfile('success with defaults', fn: () async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'create-moderation-case',
        AdminInvokeActionArguments(arguments: {
          'subject': 'package:oxygen',
        }),
      );
      expect(rs.output, {
        'caseId': isNotEmpty,
        'reporterEmail': 'support@pub.dev',
        'kind': 'notification',
        'opened': isNotEmpty,
        'source': 'internal-notification',
        'status': 'pending',
        'subject': 'package:oxygen',
        'url': null,
        'actionLog': {'entries': []}
      });
    });

    testWithProfile('success with non-defaults', fn: () async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'create-moderation-case',
        AdminInvokeActionArguments(arguments: {
          'reporter-email': 'user@pub.dev',
          'subject': 'package:oxygen',
          'kind': 'notification',
          'source': 'external-notification',
          'status': 'no-action',
        }),
      );
      expect(rs.output, {
        'caseId': isNotEmpty,
        'reporterEmail': 'user@pub.dev',
        'kind': 'notification',
        'opened': isNotEmpty,
        'source': 'external-notification',
        'status': 'no-action',
        'subject': 'package:oxygen',
        'url': null,
        'actionLog': {'entries': []}
      });
    });

    testWithProfile('invalid subjects', fn: () async {
      final values = [
        null,
        '',
        'oxygen',
        'packag:oxygen',
      ];

      for (final v in values) {
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = api.adminInvokeAction(
          'create-moderation-case',
          AdminInvokeActionArguments(arguments: {
            if (v != null) 'subject': v,
          }),
        );
        await expectApiException(rs,
            status: 400, code: 'InvalidInput', message: 'invalid subject');
      }
    });

    testWithProfile('subject does not exists', fn: () async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = api.adminInvokeAction(
        'create-moderation-case',
        AdminInvokeActionArguments(arguments: {
          'subject': 'package:ox',
        }),
      );
      await expectApiException(rs,
          status: 404, code: 'NotFound', message: 'does not exist');
    });

    testWithProfile('invalid values', fn: () async {
      final values = {
        'kind': 'kind',
        'source': 'source',
        'status': 'status',
        'reporter-email': 'non-email',
      };

      for (final v in values.entries) {
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = api.adminInvokeAction(
          'create-moderation-case',
          AdminInvokeActionArguments(arguments: {
            'subject': 'package:oxygen',
            v.key: v.value,
          }),
        );
        await expectApiException(rs,
            status: 400, code: 'InvalidInput', message: 'invalid');
      }
    });
  });

  group('Update moderation case', () {
    Future<String> _create() async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'create-moderation-case',
        AdminInvokeActionArguments(arguments: {
          'subject': 'package:oxygen',
        }),
      );
      return rs.output['caseId'] as String;
    }

    testWithProfile('success', fn: () async {
      final caseId = await _create();
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'update-moderation-case',
        AdminInvokeActionArguments(arguments: {
          'case': caseId,
          'reporter-email': 'user@pub.dev',
          'kind': 'notification',
          'source': 'external-notification',
          'status': 'no-action',
        }),
      );
      expect(rs.output, {
        'caseId': isNotEmpty,
        'reporterEmail': 'user@pub.dev',
        'kind': 'notification',
        'opened': isNotEmpty,
        'source': 'external-notification',
        'status': 'no-action',
        'subject': 'package:oxygen',
        'url': null,
        'actionLog': {'entries': []}
      });
    });

    testWithProfile('no case parameter', fn: () async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = api.adminInvokeAction(
        'update-moderation-case',
        AdminInvokeActionArguments(arguments: {}),
      );
      await expectApiException(rs,
          status: 400, code: 'InvalidInput', message: 'case must be given');
    });

    testWithProfile('case does not exists', fn: () async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = api.adminInvokeAction(
        'update-moderation-case',
        AdminInvokeActionArguments(arguments: {'case': 'x'}),
      );
      await expectApiException(rs,
          status: 404, code: 'NotFound', message: 'Could not find');
    });

    testWithProfile('invalid values', fn: () async {
      final caseId = await _create();
      final values = {
        'kind': 'kind',
        'source': 'source',
        'status': 'status',
        'reporter-email': 'non-email',
      };

      for (final v in values.entries) {
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = api.adminInvokeAction(
          'update-moderation-case',
          AdminInvokeActionArguments(arguments: {
            'case': caseId,
            v.key: v.value,
          }),
        );
        await expectApiException(rs,
            status: 400, code: 'InvalidInput', message: 'invalid');
      }
    });
  });

  group('Delete moderation case', () {
    Future<String> _create() async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'create-moderation-case',
        AdminInvokeActionArguments(arguments: {
          'subject': 'package:oxygen',
        }),
      );
      return rs.output['caseId'] as String;
    }

    testWithProfile('success', fn: () async {
      final caseId = await _create();
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'delete-moderation-case',
        AdminInvokeActionArguments(arguments: {
          'case': caseId,
        }),
      );
      expect(rs.output, {'deleted': true});

      expect(await adminBackend.lookupModerationCase(caseId), isNull);
    });

    testWithProfile('does not exists', fn: () async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = api.adminInvokeAction(
        'delete-moderation-case',
        AdminInvokeActionArguments(arguments: {
          'case': 'x',
        }),
      );
      await expectApiException(rs, status: 404);
    });
  });
}
