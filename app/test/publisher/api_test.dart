// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/data/account_api.dart' as account_api;
import 'package:_pub_shared/data/publisher_api.dart';
import 'package:gcloud/db.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Publisher API', () {
    group('Get publisher info', () {
      _testNoPublisher((client) => client.publisherInfo('no-domain.net'));

      testWithProfile('OK', fn: () async {
        final client = createPubApiClient();
        final rs = await client.publisherInfo('example.com');
        expect(rs.toJson(), {
          'description': '',
          'websiteUrl': 'https://example.com/',
          'contactEmail': 'admin@pub.dev',
        });
      });
    });

    group('Create publisher', () {
      testWithProfile('verified.com', fn: () async {
        final api = createPubApiClient(authToken: adminAtPubDevAuthToken);

        // Check that we can create the publisher
        final r1 = await api.createPublisher(
          'verified.com',
          CreatePublisherRequest(accessToken: adminAtPubDevAuthToken),
        );
        expect(r1.contactEmail, 'admin@pub.dev');

        // Check that creating again idempotently works too
        final r2 = await api.createPublisher(
          'verified.com',
          CreatePublisherRequest(accessToken: adminAtPubDevAuthToken),
        );
        expect(r2.contactEmail, 'admin@pub.dev');

        // Check that we can update the description
        final r3 = await api.updatePublisher(
          'verified.com',
          UpdatePublisherRequest(description: 'hello-world'),
        );
        expect(r3.description, 'hello-world');

        // Check that we get a sane result from publisherInfo
        final r4 = await api.publisherInfo('verified.com');
        expect(r4.toJson(), {
          'description': 'hello-world',
          'websiteUrl': 'https://verified.com/',
          'contactEmail': 'admin@pub.dev',
        });

        // check audit log record
        final page = await auditBackend.listRecordsForPublisher('verified.com');
        final r = page.records
            .firstWhere((r) => r.kind == AuditLogRecordKind.publisherCreated);
        expect(r.summary, '`admin@pub.dev` created publisher `verified.com`.');
      });

      testWithProfile('notverified.com', fn: () async {
        final api = createPubApiClient(authToken: adminAtPubDevAuthToken);

        // Check that we can create the publisher
        final rs = api.createPublisher(
          'notverified.com',
          CreatePublisherRequest(accessToken: adminAtPubDevAuthToken),
        );
        await expectApiException(
          rs,
          status: 403,
          code: 'InsufficientPermissions',
        );
      });
    });

    group('Update description', () {
      _testAdminAuthIssues(
        (client) => client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(description: 'new description'),
        ),
      );

      _testNoPublisher(
        (client) => client.updatePublisher(
          'example.net',
          UpdatePublisherRequest(description: 'new description'),
        ),
      );

      testWithProfile('OK', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(description: 'new description'),
        );
        expect(rs.toJson(), {
          'description': 'new description',
          'websiteUrl': 'https://example.com/',
          'contactEmail': 'admin@pub.dev',
        });
        // Info request should return with the same content.
        final info = await client.publisherInfo('example.com');
        expect(info.toJson(), rs.toJson());

        // check audit log record
        final page = await auditBackend.listRecordsForPublisher('example.com');
        final r = page.records
            .firstWhere((r) => r.kind == AuditLogRecordKind.publisherUpdated);
        expect(r.summary, '`admin@pub.dev` updated publisher `example.com`.');
      });
    });

    group('Update websiteUrl', () {
      _testAdminAuthIssues(
        (client) => client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(websiteUrl: 'https://example.com/about'),
        ),
      );

      _testNoPublisher(
        (client) => client.updatePublisher(
          'example.net',
          UpdatePublisherRequest(websiteUrl: 'https://example.net/about'),
        ),
      );

      testWithProfile('bad URL: relative link', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(websiteUrl: 'example.com/'),
        );
        await expectApiException(rs, status: 400, message: 'Not a valid URL.');
      });

      testWithProfile('bad URL with escapes', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(websiteUrl: 'https://example.com/  /%%%%'),
        );
        await expectApiException(rs,
            status: 400,
            message: 'The parsed URL does not match its original form.');
      });

      testWithProfile('bad URL scheme', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(websiteUrl: 'http://example.com/'),
        );
        await expectApiException(rs, status: 400, message: 'must be `https`');
      });

      testWithProfile('OK: normal URL', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(websiteUrl: 'https://example.com/about'),
        );
        expect(rs.toJson(), {
          'description': '',
          'websiteUrl': 'https://example.com/about',
          'contactEmail': 'admin@pub.dev',
        });
        // Info request should return with the same content.
        final info = await client.publisherInfo('example.com');
        expect(info.toJson(), rs.toJson());
      });

      testWithProfile('OK: unusual URL', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(
              websiteUrl: 'http://other-domain.com:2222/about'),
        );
        expect(rs.toJson(), {
          'description': '',
          'websiteUrl': 'http://other-domain.com:2222/about',
          'contactEmail': 'admin@pub.dev',
        });
        // Info request should return with the same content.
        final info = await client.publisherInfo('example.com');
        expect(info.toJson(), rs.toJson());
      });
    });

    group('Update contactEmail', () {
      _testAdminAuthIssues(
        (client) => client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(contactEmail: 'user@pub.dev'),
        ),
      );

      _testNoPublisher(
        (client) => client.updatePublisher(
          'example.net',
          UpdatePublisherRequest(contactEmail: 'user@pub.dev'),
        ),
      );

      Future<void> _updateWithInvite(String? newContactEmail) async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final orig = await client.publisherInfo('example.com');
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(contactEmail: newContactEmail),
        );
        expect(rs.contactEmail, orig.contactEmail);

        // contact is not changed yet
        final info = await client.publisherInfo('example.com');
        expect(info.contactEmail, orig.contactEmail);

        // email is sent
        expect(fakeEmailSender.sentMessages.length, 1);
        final email = fakeEmailSender.sentMessages.first;
        expect(email.recipients.single.email, newContactEmail);
        final consentId = email.bodyText
            .split('\n')
            .firstWhere((s) => s.contains('https://pub.dev/consent'))
            .split('?id=')
            .last
            .trim();
        expect(consentId, hasLength(26));

        // accept consent
        await client.resolveConsent(
            consentId, account_api.ConsentResult(granted: true));

        // check updated value
        final updated = await client.publisherInfo('example.com');
        expect(updated.contactEmail, newContactEmail);
      }

      testWithProfile('Not registered user e-mail', fn: () async {
        final newContactEmail = 'not-registered@example.com';
        await _updateWithInvite(newContactEmail);
        // no User entity created
        final users = await accountBackend.lookupUsersByEmail(newContactEmail);
        expect(users, isEmpty);
      });

      testWithProfile('User is not a member', fn: () async {
        await _updateWithInvite('user@pub.dev');
      });

      testWithProfile('User is not admin', fn: () async {
        final user = await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('other@pub.dev'),
          () => requireAuthenticatedWebUser(),
        );
        await dbService.commit(inserts: [
          publisherMember(user.userId, 'example.com', 'not-admin'),
        ]);
        await _updateWithInvite(user.email);
      });

      testWithProfile('OK', fn: () async {
        final user = await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('other@pub.dev'),
          () => requireAuthenticatedWebUser(),
        );
        await dbService.commit(inserts: [
          publisherMember(user.userId, 'example.com', 'admin'),
        ]);
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(contactEmail: user.email),
        );
        expect(rs.toJson(), {
          'description': '',
          'websiteUrl': 'https://example.com/',
          'contactEmail': 'other@pub.dev',
        });
        // Info request should return with the same content.
        final info = await client.publisherInfo('example.com');
        expect(info.toJson(), rs.toJson());
      });
    });

    group('Update all publisher detail', () {
      testWithProfile('OK', fn: () async {
        final user = await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('other@pub.dev'),
          () => requireAuthenticatedWebUser(),
        );
        await dbService.commit(inserts: [
          publisherMember(user.userId, 'example.com', 'admin'),
        ]);
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(
              description: 'new description',
              websiteUrl: 'https://www.example.com/about',
              contactEmail: user.email),
        );
        expect(rs.toJson(), {
          'description': 'new description',
          'websiteUrl': 'https://www.example.com/about',
          'contactEmail': user.email,
        });
        // Info request should return with the same content.
        final info = await client.publisherInfo('example.com');
        expect(info.toJson(), rs.toJson());
      });
    });

    group('Invite a new member', () {
      Future<List<Map>> queryConstents({String? email}) async {
        final query = dbService.query<Consent>();
        return await query
            .run()
            .where((c) => c.email == email || email == null)
            .map((c) => {
                  'id': c.consentId,
                  'fromUserId': c.fromUserId,
                  'email': c.email,
                  'kind': c.kind,
                  'args': c.args,
                  'notificationCount': c.notificationCount,
                })
            .toList();
      }

      _testAdminAuthIssues(
        (client) => client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: 'other@pub.dev')),
      );

      _testNoPublisher((client) => client.invitePublisherMember(
          'no-domain.net', InviteMemberRequest(email: 'other@pub.dev')));

      testWithProfile('Invalid e-mail', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: 'not an e-mail'));
        await expectApiException(rs, status: 400, code: 'InvalidInput');
      });

      testWithProfile('User is already a member', fn: () async {
        final user = await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('other@pub.dev'),
          () => requireAuthenticatedWebUser(),
        );
        await dbService.commit(inserts: [
          publisherMember(
              user.userId, 'example.com', PublisherMemberRole.admin),
        ]);
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: user.email!));
        await expectApiException(rs,
            status: 400,
            code: 'InvalidInput',
            message: 'User is already a member.');
      });

      testWithProfile('Pending with Consent, sending new e-mail', fn: () async {
        final adminUser =
            await accountBackend.lookupUserByEmail('admin@pub.dev');
        final otherUser = await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('other@pub.dev'),
          () => requireAuthenticatedWebUser(),
        );
        final consent = Consent.init(
          fromUserId: adminUser.userId,
          email: 'other@pub.dev',
          kind: 'PublisherMember',
          args: ['example.com'],
        );
        consent.created = consent.created!.subtract(Duration(hours: 1));
        consent.notificationCount++;
        await dbService.commit(inserts: [consent]);
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: 'other@pub.dev'));
        expect(rs.emailSent, isTrue);
        expect(await queryConstents(email: 'other@pub.dev'), [
          {
            'id': isNotNull,
            'fromUserId': adminUser.userId,
            'email': 'other@pub.dev',
            'kind': 'PublisherMember',
            'args': ['example.com'],
            'notificationCount': 2,
          }
        ]);

        await expectApiException(
          client.publisherMemberInfo('example.com', otherUser.userId),
          status: 404,
          code: 'NotFound',
        );
      });

      testWithProfile('Invite new account', fn: () async {
        final user = await accountBackend.lookupUserByEmail('admin@pub.dev');
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: 'newuser@example.com'));
        expect(rs.emailSent, isTrue);
        final list = await client.listPublisherMembers('example.com');
        expect(list.members, hasLength(1));
        expect(list.members.where((m) => m.email == 'newuser@example.com'),
            isEmpty);
        expect(await queryConstents(email: 'newuser@example.com'), [
          {
            'id': isNotNull,
            'fromUserId': user.userId,
            'email': 'newuser@example.com',
            'kind': 'PublisherMember',
            'args': ['example.com'],
            'notificationCount': 1,
          }
        ]);
      });

      testWithProfile('Invite existing account', fn: () async {
        final user = await accountBackend.lookupUserByEmail('admin@pub.dev');
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: 'user@pub.dev'));
        expect(rs.emailSent, isTrue);
        expect(await queryConstents(email: 'user@pub.dev'), [
          {
            'id': isNotNull,
            'fromUserId': user.userId,
            'email': 'user@pub.dev',
            'kind': 'PublisherMember',
            'args': ['example.com'],
            'notificationCount': 1,
          }
        ]);
      });

      testWithProfile('Don not send e-mail twice in a row', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs1 = await client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: 'other@pub.dev'));
        expect(rs1.emailSent, isTrue);
        final rs2 = await client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: 'other@pub.dev'));
        expect(rs2.emailSent, isFalse);
      });

      testWithProfile('Accept invite with existing user', fn: () async {
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');
        final client1 = createPubApiClient(authToken: adminAtPubDevAuthToken);
        await client1.invitePublisherMember(
            'example.com', InviteMemberRequest(email: 'user@pub.dev'));
        final consents = await dbService
            .query<Consent>()
            .run()
            .where((c) => c.email == 'user@pub.dev')
            .toList();
        final consentId = consents.single.consentId;
        final client2 = createPubApiClient(authToken: userAtPubDevAuthToken);
        final rs2 = await client2.resolveConsent(
            consentId, account_api.ConsentResult(granted: true));
        expect(rs2.granted, isTrue);
        final m = await client1.publisherMemberInfo('example.com', user.userId);
        expect(m.toJson(), {
          'userId': user.userId,
          'role': 'admin',
          'email': 'user@pub.dev',
        });
      });

      testWithProfile('Accept invite with new account', fn: () async {
        final client1 = createPubApiClient(authToken: adminAtPubDevAuthToken);
        await client1.invitePublisherMember(
            'example.com', InviteMemberRequest(email: 'newaccount@pub.dev'));
        final consents = await dbService
            .query<Consent>()
            .run()
            .where((c) => c.email == 'newaccount@pub.dev')
            .toList();
        final consentId = consents.single.consentId;
        final client2 = createPubApiClient(
            authToken: createFakeAuthTokenForEmail('newaccount@pub.dev'));
        final rs2 = await client2.resolveConsent(
            consentId, account_api.ConsentResult(granted: true));
        expect(rs2.granted, isTrue);
        final list = await client1.listPublisherMembers('example.com');
        final m = list.members.firstWhere((m) => m.email.startsWith('new'));
        expect(m.toJson(), {
          'userId': isNotNull,
          'role': 'admin',
          'email': 'newaccount@pub.dev',
        });
      });

      testWithProfile('Decline invite', fn: () async {
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');
        final client1 = createPubApiClient(authToken: adminAtPubDevAuthToken);
        await client1.invitePublisherMember(
            'example.com', InviteMemberRequest(email: 'user@pub.dev'));
        final consents = await dbService
            .query<Consent>()
            .run()
            .where((c) => c.email == 'user@pub.dev')
            .toList();
        final consentId = consents.single.consentId;
        final client2 = createPubApiClient(authToken: userAtPubDevAuthToken);
        final rs2 = await client2.resolveConsent(
            consentId, account_api.ConsentResult(granted: false));
        expect(rs2.granted, isFalse);
        // repeated request throws exception
        await expectApiException(
          client2.resolveConsent(
              consentId, account_api.ConsentResult(granted: false)),
          status: 404,
          code: 'NotFound',
        );
        final rs4 = client1.publisherMemberInfo('example.com', user.userId);
        await expectApiException(rs4, status: 404, code: 'NotFound');
      });
    });

    group('List members', () {
      _testAdminAuthIssues(
        (client) => client.listPublisherMembers('example.com'),
      );

      _testNoPublisher(
        (client) => client.listPublisherMembers('no-domain.net'),
      );

      testWithProfile('OK', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.listPublisherMembers('example.com');
        expect(_json(rs.toJson()), {
          'members': [
            {
              'userId': isNotEmpty,
              'email': 'admin@pub.dev',
              'role': 'admin',
            },
          ],
        });
      });
    });

    group('Get member detail', () {
      _testAdminAuthIssues(
        (client) async {
          final user = await accountBackend.lookupUserByEmail('admin@pub.dev');
          return await client.publisherMemberInfo('example.com', user.userId);
        },
      );

      _testNoPublisher(
        (client) async {
          final user = await accountBackend.lookupUserByEmail('admin@pub.dev');
          return await client.publisherMemberInfo('no-domain.net', user.userId);
        },
      );

      testWithProfile('User is not a member', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = client.publisherMemberInfo('example.com', 'not-a-user-id');
        await expectApiException(rs, status: 404, code: 'NotFound');
      });

      testWithProfile('OK', fn: () async {
        final user = await accountBackend.lookupUserByEmail('admin@pub.dev');
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.publisherMemberInfo('example.com', user.userId);
        expect(rs.toJson(), {
          'userId': user.userId,
          'email': user.email,
          'role': 'admin',
        });
      });
    });

    group('Update member detail', () {
      _testAdminAuthIssues(
        (client) async {
          final user = await accountBackend.lookupUserByEmail('user@pub.dev');
          return await client.updatePublisherMember(
            'example.com',
            user.userId,
            UpdatePublisherMemberRequest(role: 'admin'),
          );
        },
      );

      _testNoPublisher(
        (client) async {
          final user = await accountBackend.lookupUserByEmail('user@pub.dev');
          return await client.updatePublisherMember(
            'no-domain.net',
            user.userId,
            UpdatePublisherMemberRequest(role: 'admin'),
          );
        },
      );

      testWithProfile('Modification of self is blocked', fn: () async {
        final user = await accountBackend.lookupUserByEmail('admin@pub.dev');
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = client.updatePublisherMember(
            'example.com',
            user.userId,
            UpdatePublisherMemberRequest(
              role: 'x',
            ));
        await expectApiException(rs, status: 409, code: 'RequestConflict');
      });

      testWithProfile('Modification of unrelated user is blocked',
          fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');
        final rs = client.updatePublisherMember(
            'example.com', user.userId, UpdatePublisherMemberRequest());
        await expectApiException(rs, status: 404, code: 'NotFound');
      });

      testWithProfile('Role value is not allowed', fn: () async {
        final user = await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('other@pub.dev'),
          () => requireAuthenticatedWebUser(),
        );
        await dbService.commit(inserts: [
          publisherMember(
              user.userId, 'example.com', PublisherMemberRole.admin),
        ]);
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = client.updatePublisherMember(
            'example.com',
            user.userId,
            UpdatePublisherMemberRequest(
              role: 'not-allowed-role',
            ));
        await expectApiException(rs, status: 400, code: 'InvalidInput');
      });

      testWithProfile('OK', fn: () async {
        final user = await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('other@pub.dev'),
          () => requireAuthenticatedWebUser(),
        );
        await dbService.commit(inserts: [
          publisherMember(user.userId, 'example.com', 'someotherrole'),
        ]);
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.updatePublisherMember(
            'example.com',
            user.userId,
            UpdatePublisherMemberRequest(
              role: PublisherMemberRole.admin,
            ));
        expect(rs.toJson(), {
          'userId': isNotEmpty,
          'role': 'admin',
          'email': 'other@pub.dev',
        });
        // Info request should return with the same content.
        final updated =
            await client.publisherMemberInfo('example.com', user.userId);
        expect(updated.toJson(), rs.toJson());
      });
    });

    group('Delete member', () {
      _testAdminAuthIssues(
        (client) async {
          final user = await accountBackend.lookupUserByEmail('user@pub.dev');
          return await client.removePublisherMember('example.com', user.userId);
        },
      );

      _testNoPublisher(
        (client) async {
          final user = await accountBackend.lookupUserByEmail('user@pub.dev');
          return await client.removePublisherMember(
              'no-domain.net', user.userId);
        },
      );

      testWithProfile('Modification of self is blocked', fn: () async {
        final user = await accountBackend.lookupUserByEmail('admin@pub.dev');
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = client.removePublisherMember('example.com', user.userId);
        await expectApiException(rs, status: 409, code: 'RequestConflict');
      });

      testWithProfile('Remove of non-member is idempotent', fn: () async {
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs =
            await client.removePublisherMember('example.com', user.userId);
        expect(json.fuse(utf8).decode(rs), {'status': 'OK'});
      });

      testWithProfile('OK', fn: () async {
        final user = await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('other@pub.dev'),
          () => requireAuthenticatedWebUser(),
        );
        await dbService.commit(inserts: [
          publisherMember(
              user.userId, 'example.com', PublisherMemberRole.admin),
        ]);
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs =
            await client.removePublisherMember('example.com', user.userId);
        expect(json.fuse(utf8).decode(rs), {'status': 'OK'});
        // Info request should return with NotFound exception.
        final updated = client.publisherMemberInfo('example.com', user.userId);
        await expectApiException(updated, status: 404, code: 'NotFound');
        // check audit log
        final page = await auditBackend.listRecordsForPublisher('example.com');
        final r = page.records.firstWhere(
            (r) => r.kind == AuditLogRecordKind.publisherMemberRemoved);
        expect(r.summary,
            '`admin@pub.dev` removed `other@pub.dev` from publisher `example.com`.');
      });
    });
  });
}

dynamic _json(value) => json.decode(json.encode(value));

void _testAdminAuthIssues(Future Function(PubApiClient client) fn) {
  setupTestsWithCallerAuthorizationIssues(fn);

  testWithProfile('Active user is not a member', fn: () async {
    final client = createPubApiClient(authToken: userAtPubDevAuthToken);
    final rs = fn(client);
    await expectApiException(rs, status: 403, code: 'InsufficientPermissions');
  });

  testWithProfile('Active user is not an admin yet', fn: () async {
    final user = await accountBackend.lookupUserByEmail('user@pub.dev');
    await dbService.commit(inserts: [
      publisherMember(user.userId, 'example.com', 'non-admin'),
    ]);
    final client = createPubApiClient(authToken: userAtPubDevAuthToken);
    final rs = fn(client);
    await expectApiException(rs, status: 403, code: 'InsufficientPermissions');
  });

  testWithProfile('Publisher is blocked / not visible', fn: () async {
    final p = await dbService.lookupValue<Publisher>(
        dbService.emptyKey.append(Publisher, id: 'example.com'));
    p.isBlocked = true;
    await dbService.commit(inserts: [p]);

    final client = createPubApiClient(authToken: userAtPubDevAuthToken);
    final rs = fn(client);
    await expectApiException(rs, status: 404, code: 'NotFound');
  });
}

void _testNoPublisher(Future Function(PubApiClient client) fn) {
  testWithProfile('No publisher with given id', fn: () async {
    final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
    final rs = fn(client);
    await expectApiException(rs, status: 404, code: 'NotFound');
  });
}
