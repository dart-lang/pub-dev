// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/package_api.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Update value through API', () {
    setupTestsWithCallerAuthorizationIssues(
      (client) =>
          client.setAutomatedPublishing('oxygen', AutomatedPublishingConfig()),
    );

    testWithProfile('no package', fn: () async {
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      await expectApiException(
        client.setAutomatedPublishing(
            'no_such_package', AutomatedPublishingConfig()),
        status: 404,
        code: 'NotFound',
      );
    });

    testWithProfile('not admin', fn: () async {
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      await expectApiException(
        client.setAutomatedPublishing('oxygen', AutomatedPublishingConfig()),
        status: 403,
        code: 'InsufficientPermissions',
        message:
            'Insufficient permissions to perform administrative actions on package `oxygen`.',
      );
    });

    testWithProfile('successful update with GitHub', fn: () async {
      final client =
          await createFakeAuthPubApiClient(email: adminAtPubDevEmail);
      final rs = await client.setAutomatedPublishing(
          'oxygen',
          AutomatedPublishingConfig(
            github: GitHubPublishingConfig(
              isEnabled: true,
              repository: 'dart-lang/pub-dev',
              tagPattern: '{{version}}',
            ),
          ));
      expect(rs.toJson(), {
        'github': {
          'isEnabled': true,
          'repository': 'dart-lang/pub-dev',
          'tagPattern': '{{version}}',
          'requireEnvironment': false,
          'isPushEventEnabled': true,
          'isWorkflowDispatchEventEnabled': false,
        },
      });
      final p = await packageBackend.lookupPackage('oxygen');
      expect(
          p!.automatedPublishing!.githubConfig!.toJson(), rs.github!.toJson());
      expect(p.automatedPublishing!.gcpConfig, isNull);
      final audits = await auditBackend.listRecordsForPackage('oxygen');
      // check audit log record exists
      final record = audits.records.firstWhere((e) =>
          e.kind == AuditLogRecordKind.packagePublicationAutomationUpdated);
      expect(record.created, isNotNull);
      expect(record.summary,
          '`admin@pub.dev` updated the publication automation config of package `oxygen`.');
    });

    testWithProfile('successful update with Google Cloud Service account',
        fn: () async {
      final client =
          await createFakeAuthPubApiClient(email: adminAtPubDevEmail);
      final rs = await client.setAutomatedPublishing(
          'oxygen',
          AutomatedPublishingConfig(
            gcp: GcpPublishingConfig(
              isEnabled: true,
              serviceAccountEmail: 'project-id@cloudbuild.gserviceaccount.com',
            ),
          ));
      expect(rs.toJson(), {
        'gcp': {
          'isEnabled': true,
          'serviceAccountEmail': 'project-id@cloudbuild.gserviceaccount.com',
        },
      });
      final p = await packageBackend.lookupPackage('oxygen');
      expect(p!.automatedPublishing!.gcpConfig!.toJson(), rs.gcp!.toJson());
      expect(p.automatedPublishing!.githubConfig, isNull);
      final audits = await auditBackend.listRecordsForPackage('oxygen');
      // check audit log record exists
      final record = audits.records.firstWhere((e) =>
          e.kind == AuditLogRecordKind.packagePublicationAutomationUpdated);
      expect(record.created, isNotNull);
      expect(record.summary,
          '`admin@pub.dev` updated the publication automation config of package `oxygen`.');
    });

    testWithProfile('GitHub Actions: bad project path', fn: () async {
      final client =
          await createFakeAuthPubApiClient(email: adminAtPubDevEmail);
      final badPaths = [
        '',
        '/',
        'a/',
        '/b',
        '//',
        'a/b/c',
        'a /b',
        '(/b',
      ];
      for (final repository in badPaths) {
        final rs = client.setAutomatedPublishing(
            'oxygen',
            AutomatedPublishingConfig(
              github: GitHubPublishingConfig(
                isEnabled: repository.isEmpty,
                repository: repository,
                tagPattern: '{{version}}',
              ),
            ));
        await expectApiException(
          rs,
          status: 400,
          code: 'InvalidInput',
          message: 'repository',
        );
      }
    });

    testWithProfile('GitHub Actions: bad tag pattern', fn: () async {
      final client =
          await createFakeAuthPubApiClient(email: adminAtPubDevEmail);
      final badPatterns = [
        '',
        'v',
        'v {{version}}',
        '{{version}}{{version}}',
      ];
      for (final pattern in badPatterns) {
        final rs = client.setAutomatedPublishing(
            'oxygen',
            AutomatedPublishingConfig(
              github: GitHubPublishingConfig(
                isEnabled: false,
                repository: 'abcd/efgh',
                tagPattern: pattern,
              ),
            ));
        await expectApiException(
          rs,
          status: 400,
          code: 'InvalidInput',
          message: 'tag',
        );
      }
    });

    testWithProfile('GitHub Actions: bad environment pattern', fn: () async {
      final client =
          await createFakeAuthPubApiClient(email: adminAtPubDevEmail);
      final badPatterns = [
        '',
        'e nvironment',
      ];
      for (final pattern in badPatterns) {
        final rs = client.setAutomatedPublishing(
            'oxygen',
            AutomatedPublishingConfig(
              github: GitHubPublishingConfig(
                isEnabled: false,
                repository: 'abcd/efgh',
                tagPattern: '{{version}}',
                requireEnvironment: true,
                environment: pattern,
              ),
            ));
        await expectApiException(
          rs,
          status: 400,
          code: 'InvalidInput',
          message: 'environment',
        );
      }
    });

    testWithProfile('GitHub Actions: no events enabled', fn: () async {
      final client =
          await createFakeAuthPubApiClient(email: adminAtPubDevEmail);
      final rs = client.setAutomatedPublishing(
          'oxygen',
          AutomatedPublishingConfig(
            github: GitHubPublishingConfig(
              isEnabled: false,
              repository: 'abcd/efgh',
              isPushEventEnabled: false,
            ),
          ));
      await expectApiException(
        rs,
        status: 400,
        code: 'InvalidInput',
        message: 'one of the events',
      );
    });

    testWithProfile('Google Cloud: bad service account email', fn: () async {
      final client =
          await createFakeAuthPubApiClient(email: adminAtPubDevEmail);
      final badValues = [
        '',
        'not.an.email',
        'mailto:user@example.com',
        '@example.com',
      ];
      for (final value in badValues) {
        final rs = client.setAutomatedPublishing(
          'oxygen',
          AutomatedPublishingConfig(
            gcp: GcpPublishingConfig(
              isEnabled: value.isEmpty,
              serviceAccountEmail: value,
            ),
          ),
        );
        await expectApiException(
          rs,
          status: 400,
          code: 'InvalidInput',
          message: 'service account email',
          reason: value,
        );
      }
    });

    testWithProfile('Google Cloud: email outside .gserviceaccount.com',
        fn: () async {
      final client =
          await createFakeAuthPubApiClient(email: adminAtPubDevEmail);
      final rs = client.setAutomatedPublishing(
        'oxygen',
        AutomatedPublishingConfig(
          gcp: GcpPublishingConfig(
            isEnabled: true,
            serviceAccountEmail: 'user@pub.dev',
          ),
        ),
      );
      await expectApiException(
        rs,
        status: 400,
        code: 'InvalidInput',
        message: 'email must end with',
      );
    });
  });
}
