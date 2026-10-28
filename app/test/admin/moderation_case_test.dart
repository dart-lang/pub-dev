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
    testWithProfile(
      'success with defaults',
      fn: () async {
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = await api.adminInvokeAction(
          'moderation-case-create',
          AdminInvokeActionArguments(arguments: {'subject': 'package:oxygen'}),
        );
        expect(rs.output, {
          'caseId': isNotEmpty,
          'reporterEmail': 'support@pub.dev',
          'kind': 'notification',
          'opened': isNotEmpty,
          'resolved': null,
          'source': 'trusted-flagger',
          'subject': 'package:oxygen',
          'isSubjectOwner': false,
          'url': null,
          'status': 'pending',
          'grounds': null,
          'violation': null,
          'reason': null,
          'appealedCaseId': null,
          'actionLog': {'entries': []},
        });
      },
    );

    testWithProfile(
      'success with non-defaults',
      fn: () async {
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = await api.adminInvokeAction(
          'moderation-case-create',
          AdminInvokeActionArguments(
            arguments: {
              'reporter-email': 'user@pub.dev',
              'subject': 'package:oxygen',
              'kind': 'notification',
              'source': 'external-notification',
            },
          ),
        );
        expect(rs.output, {
          'caseId': isNotEmpty,
          'reporterEmail': 'user@pub.dev',
          'kind': 'notification',
          'opened': isNotEmpty,
          'resolved': null,
          'source': 'external-notification',
          'subject': 'package:oxygen',
          'isSubjectOwner': false,
          'url': null,
          'status': 'pending',
          'grounds': null,
          'violation': null,
          'reason': null,
          'appealedCaseId': null,
          'actionLog': {'entries': []},
        });
      },
    );

    testWithProfile(
      'invalid subjects',
      fn: () async {
        final values = [null, '', 'oxygen', 'packag:oxygen'];

        for (final v in values) {
          final api = createPubApiClient(authToken: siteAdminToken);
          final rs = api.adminInvokeAction(
            'moderation-case-create',
            AdminInvokeActionArguments(
              arguments: {if (v != null) 'subject': v},
            ),
          );
          await expectApiException(
            rs,
            status: 400,
            code: 'InvalidInput',
            message: 'invalid subject',
          );
        }
      },
    );

    testWithProfile(
      'subject does not exists',
      fn: () async {
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = api.adminInvokeAction(
          'moderation-case-create',
          AdminInvokeActionArguments(arguments: {'subject': 'package:ox'}),
        );
        await expectApiException(
          rs,
          status: 404,
          code: 'NotFound',
          message: 'does not exist',
        );
      },
    );

    testWithProfile(
      'invalid values',
      fn: () async {
        final values = {
          'kind': 'kind',
          'source': 'source',
          'reporter-email': 'non-email',
        };

        for (final v in values.entries) {
          final api = createPubApiClient(authToken: siteAdminToken);
          final rs = api.adminInvokeAction(
            'moderation-case-create',
            AdminInvokeActionArguments(
              arguments: {'subject': 'package:oxygen', v.key: v.value},
            ),
          );
          await expectApiException(
            rs,
            status: 400,
            code: 'InvalidInput',
            message: 'invalid',
          );
        }
      },
    );
  });

  group('Update moderation case', () {
    Future<String> _create() async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'moderation-case-create',
        AdminInvokeActionArguments(arguments: {'subject': 'package:oxygen'}),
      );
      return rs.output['caseId'] as String;
    }

    testWithProfile(
      'success',
      fn: () async {
        final caseId = await _create();
        final api = createPubApiClient(authToken: siteAdminToken);
        // close case first to change status
        await api.adminInvokeAction(
          'moderation-case-resolve',
          AdminInvokeActionArguments(arguments: {'case': caseId}),
        );

        final rs = await api.adminInvokeAction(
          'moderation-case-update',
          AdminInvokeActionArguments(
            arguments: {
              'case': caseId,
              'reporter-email': 'user@pub.dev',
              'kind': 'notification',
              'source': 'external-notification',
              'status': 'no-action',
            },
          ),
        );
        expect(rs.output, {
          'caseId': isNotEmpty,
          'reporterEmail': 'user@pub.dev',
          'kind': 'notification',
          'opened': isNotEmpty,
          'resolved': isNotEmpty,
          'source': 'external-notification',
          'subject': 'package:oxygen',
          'isSubjectOwner': false,
          'url': null,
          'status': 'no-action',
          'grounds': 'none',
          'violation': 'none',
          'reason': null,
          'appealedCaseId': null,
          'actionLog': {'entries': []},
        });

        final list = await api.adminInvokeAction(
          'moderation-case-list',
          AdminInvokeActionArguments(arguments: {'density': 'expanded'}),
        );
        expect(list.output, {
          'cases': [rs.output],
        });
      },
    );

    testWithProfile(
      'no case parameter',
      fn: () async {
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = api.adminInvokeAction(
          'moderation-case-update',
          AdminInvokeActionArguments(arguments: {}),
        );
        await expectApiException(
          rs,
          status: 400,
          code: 'InvalidInput',
          message: 'case must be given',
        );
      },
    );

    testWithProfile(
      'case does not exists',
      fn: () async {
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = api.adminInvokeAction(
          'moderation-case-update',
          AdminInvokeActionArguments(arguments: {'case': 'x'}),
        );
        await expectApiException(
          rs,
          status: 404,
          code: 'NotFound',
          message: 'Could not find',
        );
      },
    );

    testWithProfile(
      'invalid values',
      fn: () async {
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
            'moderation-case-update',
            AdminInvokeActionArguments(
              arguments: {'case': caseId, v.key: v.value},
            ),
          );
          await expectApiException(
            rs,
            status: 400,
            code: 'InvalidInput',
            message: 'invalid',
          );
        }
      },
    );
  });

  group('List and info moderation cases', () {
    Future<String> _create(String subject, {String? kind}) async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'moderation-case-create',
        AdminInvokeActionArguments(
          arguments: {'subject': subject, if (kind != null) 'kind': kind},
        ),
      );
      return rs.output['caseId'] as String;
    }

    Future<Map<String, dynamic>> _list(Map<String, String> arguments) async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'moderation-case-list',
        AdminInvokeActionArguments(arguments: arguments),
      );
      return rs.output;
    }

    Future<void> _expectInvalid(String name, Map<String, String> arguments) {
      final api = createPubApiClient(authToken: siteAdminToken);
      return expectApiException(
        api.adminInvokeAction(
          name,
          AdminInvokeActionArguments(arguments: arguments),
        ),
        status: 400,
        code: 'InvalidInput',
      );
    }

    testWithProfile(
      'sort, filter and density',
      fn: () async {
        final first = await _create('package:oxygen');
        final second = await _create('package:neon');
        final api = createPubApiClient(authToken: siteAdminToken);
        // only the first one is resolved
        await api.adminInvokeAction(
          'moderation-case-resolve',
          AdminInvokeActionArguments(arguments: {'case': first}),
        );

        // empty list when nothing matches
        expect(await _list({'subject': 'nothing'}), {'caseIds': isEmpty});

        // sorted by opened, most recent first
        final byOpened = await _list({'density': 'compact'});
        expect((byOpened['cases'] as List).map((c) => c['caseId']), [
          second,
          first,
        ]);

        // sorted by resolved: the unresolved case is listed last
        final byResolved = await _list({
          'sort': 'resolved',
          'density': 'compact',
        });
        expect((byResolved['cases'] as List).map((c) => c['caseId']), [
          first,
          second,
        ]);

        // filters
        Future<List<Object?>> ids(Map<String, String> args) async {
          final rs = await _list({'density': 'compact', ...args});
          return (rs['cases'] as List).map((c) => c['caseId']).toList();
        }

        expect(await ids({'status': 'pending'}), [second]);
        expect(await ids({'status': 'resolved'}), [first]);
        expect(await ids({'subject': 'neon'}), [second]);
        expect(await ids({'kind': 'appeal'}), isEmpty);
        expect(await ids({'kind': 'notification'}), [second, first]);
        expect(await ids({'past': '1d'}), [second, first]);
        expect(await ids({'past': '1d', 'sort': 'resolved'}), [first]);

        // expanded density has the action log
        final expanded = await _list({'density': 'expanded'});
        expect(expanded['cases'], hasLength(2));
        for (final c in expanded['cases'] as List) {
          expect(c['actionLog'], {'entries': []});
        }
      },
    );

    testWithProfile(
      'expanded density joins the action logs to the right case',
      expectedLogMessages: [
        RegExp(
          r'SHOUT Deleting object from public bucket: ".*/api/archives/.*.tar.gz".',
        ),
      ],
      fn: () async {
        final withLogs = await _create('package:oxygen');
        final withoutLogs = await _create('package:neon');
        final api = createPubApiClient(authToken: siteAdminToken);
        for (final state in ['true', 'false']) {
          await api.adminInvokeAction(
            'moderate-package',
            AdminInvokeActionArguments(
              arguments: {
                'case': withLogs,
                'package': 'oxygen',
                'state': state,
                'note': 'state $state',
              },
            ),
          );
        }

        final expanded = await _list({'density': 'expanded'});
        final byId = {
          for (final c in expanded['cases'] as List) c['caseId'] as String: c,
        };
        expect(byId.keys, unorderedEquals([withLogs, withoutLogs]));
        expect(byId[withoutLogs]['actionLog'], {'entries': []});
        final entries = byId[withLogs]['actionLog']['entries'] as List;
        expect(entries.map((e) => e['note']), ['state true', 'state false']);
        expect(entries.map((e) => e['subject']).toSet(), {'package:oxygen'});
      },
    );

    testWithProfile(
      'invalid list parameters',
      fn: () async {
        await _expectInvalid('moderation-case-list', {'sort': 'x'});
        await _expectInvalid('moderation-case-list', {'density': 'x'});
      },
    );

    testWithProfile(
      'info',
      fn: () async {
        final caseId = await _create('package:oxygen');
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = await api.adminInvokeAction(
          'moderation-case-info',
          AdminInvokeActionArguments(arguments: {'case': caseId}),
        );
        expect(rs.output, {
          'caseId': caseId,
          'reporterEmail': 'support@pub.dev',
          'kind': 'notification',
          'opened': isNotEmpty,
          'resolved': null,
          'source': 'trusted-flagger',
          'subject': 'package:oxygen',
          'isSubjectOwner': false,
          'url': null,
          'status': 'pending',
          'grounds': null,
          'violation': null,
          'reason': null,
          'appealedCaseId': null,
          'actionLog': {'entries': []},
        });

        // the SQL-based output is the same as the Datastore-based one
        final mc = await adminBackend.lookupModerationCase(caseId);
        expect(rs.output, mc!.toDebugInfo());
      },
    );

    testWithProfile(
      'info: not found and missing parameter',
      fn: () async {
        final api = createPubApiClient(authToken: siteAdminToken);
        await expectApiException(
          api.adminInvokeAction(
            'moderation-case-info',
            AdminInvokeActionArguments(arguments: {'case': 'x'}),
          ),
          status: 404,
          code: 'NotFound',
        );
        await _expectInvalid('moderation-case-info', {});
      },
    );
  });

  group('Delete moderation case', () {
    Future<String> _create() async {
      final api = createPubApiClient(authToken: siteAdminToken);
      final rs = await api.adminInvokeAction(
        'moderation-case-create',
        AdminInvokeActionArguments(arguments: {'subject': 'package:oxygen'}),
      );
      return rs.output['caseId'] as String;
    }

    testWithProfile(
      'success',
      fn: () async {
        final caseId = await _create();
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = await api.adminInvokeAction(
          'moderation-case-delete',
          AdminInvokeActionArguments(arguments: {'case': caseId}),
        );
        expect(rs.output, {'deleted': true});

        expect(await adminBackend.lookupModerationCase(caseId), isNull);
      },
    );

    testWithProfile(
      'does not exists',
      fn: () async {
        final api = createPubApiClient(authToken: siteAdminToken);
        final rs = api.adminInvokeAction(
          'moderation-case-delete',
          AdminInvokeActionArguments(arguments: {'case': 'x'}),
        );
        await expectApiException(rs, status: 404);
      },
    );
  });
}
