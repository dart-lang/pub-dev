// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/cloudcompute/fakecloudcompute.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('package admin actions', () {
    testWithProfile(
      'info request',
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final rs = await client.adminInvokeAction(
          'package-info',
          AdminInvokeActionArguments(arguments: {'package': 'oxygen'}),
        );
        expect(rs.output, {
          'package': {
            'name': 'oxygen',
            'created': isNotEmpty,
            'publisherId': null,
            'uploaders': ['admin@pub.dev'],
            'latestVersion': '1.2.0',
            'isModerated': false,
            'isAdminDeleted': false,
          },
        });
      },
    );

    testWithProfile(
      'discontinue',
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final rs = await client.adminInvokeAction(
          'package-discontinue',
          AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'replaced-by': 'neon'},
          ),
        );
        expect(rs.output, {
          'package': {
            'name': 'oxygen',
            'isDiscontinued': true,
            'replacedBy': 'neon',
          },
        });
      },
    );

    testWithProfile(
      'update latest on a single package',
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final rs = await client.adminInvokeAction(
          'package-latest-update',
          AdminInvokeActionArguments(arguments: {'package': 'oxygen'}),
        );
        expect(rs.output, {'updated': false});
      },
    );

    testWithProfile(
      'update latest on all packages',
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final rs = await client.adminInvokeAction(
          'package-latest-update',
          AdminInvokeActionArguments(arguments: {}),
        );
        expect(rs.output, {'updatedCount': 0});
      },
    );

    testWithProfile(
      'set publisher on a package',
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final rs = await client.adminInvokeAction(
          'package-publisher-set',
          AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'publisher': 'example.com'},
          ),
        );
        expect(rs.output, {
          'before': {'publisherId': null},
          'after': {'publisherId': 'example.com'},
        });
      },
    );

    testWithProfile(
      'task-bump-priority immediate instance creation',
      processJobsWithFakeRunners: true,
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final cloud = taskWorkerCloudCompute as FakeCloudCompute;

        final rs = await client.adminInvokeAction(
          'task-bump-priority',
          AdminInvokeActionArguments(arguments: {'package': 'oxygen'}),
        );
        expect(rs.output, {
          'status': 'started',
          'message': 'Instance created for analysis.',
          'package': 'oxygen',
          'instance': startsWith('instance-'),
          'zone': 'zone-a',
          'versions': ['1.2.0', '2.0.0-dev', '1.0.0'],
        });

        final instances = await cloud.listInstances().toList();
        expect(instances, hasLength(1));
        expect(instances.first.instanceName, rs.output['instance']);
      },
    );

    testWithProfile(
      'task-bump-priority with specific version',
      processJobsWithFakeRunners: true,
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final cloud = taskWorkerCloudCompute as FakeCloudCompute;

        final rs = await client.adminInvokeAction(
          'task-bump-priority',
          AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'version': '1.2.0'},
          ),
        );
        expect(rs.output, {
          'status': 'started',
          'message': 'Instance created for analysis.',
          'package': 'oxygen',
          'instance': startsWith('instance-'),
          'zone': 'zone-a',
          'versions': ['1.2.0'],
        });

        final instances = await cloud.listInstances().toList();
        expect(instances, hasLength(1));
      },
    );

    testWithProfile(
      'task-bump-priority when quota/instance limit is reached',
      processJobsWithFakeRunners: true,
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final cloud = taskWorkerCloudCompute as FakeCloudCompute;

        // Fill instances up to maxTaskInstances (10)
        for (var i = 0; i < activeConfiguration.maxTaskInstances; i++) {
          cloud.fakeCreateRunningInstance(
            zone: 'zone-a',
            instanceName: 'busy-$i',
            ago: Duration(minutes: 5),
          );
        }

        final rs = await client.adminInvokeAction(
          'task-bump-priority',
          AdminInvokeActionArguments(arguments: {'package': 'oxygen'}),
        );
        expect(rs.output, {
          'status': 'enqueued',
          'message':
              'Instance limit reached. Analysis task is enqueued with highest priority.',
          'package': 'oxygen',
        });
      },
    );

    testWithProfile(
      'task-bump-priority with non-existent package',
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final rs = client.adminInvokeAction(
          'task-bump-priority',
          AdminInvokeActionArguments(arguments: {'package': 'non_existing'}),
        );
        await expectApiException(rs, status: 400, code: 'InvalidInput');
      },
    );

    testWithProfile(
      'task-bump-priority with untracked version',
      processJobsWithFakeRunners: true,
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final rs = client.adminInvokeAction(
          'task-bump-priority',
          AdminInvokeActionArguments(
            arguments: {'package': 'oxygen', 'version': '9.9.9'},
          ),
        );
        await expectApiException(rs, status: 400, code: 'InvalidInput');
      },
    );
  });
}
