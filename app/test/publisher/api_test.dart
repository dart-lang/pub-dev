// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:client_data/account_api.dart' as account_api;
import 'package:client_data/publisher_api.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';
import 'package:pub_dev/publisher/models.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Publisher API', () {
    group('Get publisher info', () {
      _testNoPublisher((client) => client.publisherInfo('no-domain.net'));

      testWithServices('OK', () async {
        final client = createPubApiClient();
        final rs = await client.publisherInfo('example.com');
        expect(rs.toJson(), {
          'description': 'This is us!',
          'websiteUrl': 'https://example.com/',
          'contactEmail': 'contact@example.com',
        });
      });
    });

    group('Create publisher', () {
      testWithServices('verified.com', () async {
        final api = createPubApiClient(authToken: hansUser.userId);

        // Check that we can create the publisher
        final r1 = await api.createPublisher(
          'verified.com',
          CreatePublisherRequest(accessToken: hansUser.userId),
        );
        expect(r1.contactEmail, hansUser.email);

        // Check that creating again idempotently works too
        final r2 = await api.createPublisher(
          'verified.com',
          CreatePublisherRequest(accessToken: hansUser.userId),
        );
        expect(r2.contactEmail, hansUser.email);

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
          'contactEmail': hansUser.email,
        });
      });

      testWithServices('notverified.com', () async {
        final api = createPubApiClient(authToken: hansUser.userId);

        // Check that we can create the publisher
        final rs = api.createPublisher(
          'notverified.com',
          CreatePublisherRequest(accessToken: hansUser.userId),
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

      testWithServices('OK', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(description: 'new description'),
        );
        expect(rs.toJson(), {
          'description': 'new description',
          'websiteUrl': 'https://example.com/',
          'contactEmail': 'contact@example.com',
        });
        // Info request should return with the same content.
        final info = await client.publisherInfo('example.com');
        expect(info.toJson(), rs.toJson());
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

      testWithServices('bad URL: relative link', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(websiteUrl: 'example.com/'),
        );
        await expectApiException(rs, status: 400, message: 'Not a valid URL.');
      });

      testWithServices('bad URL with escapes', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(websiteUrl: 'https://example.com/  /%%%%'),
        );
        await expectApiException(rs,
            status: 400,
            message: 'The parsed URL does not match its original form.');
      });

      testWithServices('bad URL scheme', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(websiteUrl: 'ftp://example.com/'),
        );
        await expectApiException(rs,
            status: 400, message: 'must be any of http, https');
      });

      testWithServices('OK: normal URL', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(websiteUrl: 'https://example.com/about'),
        );
        expect(rs.toJson(), {
          'description': 'This is us!',
          'websiteUrl': 'https://example.com/about',
          'contactEmail': 'contact@example.com',
        });
        // Info request should return with the same content.
        final info = await client.publisherInfo('example.com');
        expect(info.toJson(), rs.toJson());
      });

      testWithServices('OK: unusual URL', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(
              websiteUrl: 'http://other-domain.com:2222/about'),
        );
        expect(rs.toJson(), {
          'description': 'This is us!',
          'websiteUrl': 'http://other-domain.com:2222/about',
          'contactEmail': 'contact@example.com',
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
          UpdatePublisherRequest(contactEmail: hansUser.email),
        ),
      );

      _testNoPublisher(
        (client) => client.updatePublisher(
          'example.net',
          UpdatePublisherRequest(contactEmail: hansUser.email),
        ),
      );

      testWithServices('Not registered user e-mail', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final orig = await client.publisherInfo('example.com');
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(contactEmail: 'not-registered@example.com'),
        );
        expect(rs.contactEmail, orig.contactEmail);

        // contact is not changed yet
        final info = await client.publisherInfo('example.com');
        expect(info.contactEmail, orig.contactEmail);

        // email is sent
        expect(fakeEmailSender.sentMessages.length, 1);
        final email = fakeEmailSender.sentMessages.first;
        expect(email.recipients.single.email, 'not-registered@example.com');
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
        expect(updated.contactEmail, 'not-registered@example.com');

        // no User entity created
        final user = await accountBackend
            .lookupUserByEmail('not-registered@example.com');
        expect(user, isNull);
      });

      testWithServices('User is not a member', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(contactEmail: testUserA.userId),
        );
        await expectApiException(rs, status: 400, code: 'InvalidInput');
      });

      testWithServices('User is not admin', () async {
        await dbService.commit(inserts: [
          publisherMember(testUserA.userId, 'not-admin'),
        ]);
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(contactEmail: testUserA.userId),
        );
        await expectApiException(rs, status: 400, code: 'InvalidInput');
      });

      testWithServices('OK', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(contactEmail: hansUser.email),
        );
        expect(rs.toJson(), {
          'description': 'This is us!',
          'websiteUrl': 'https://example.com/',
          'contactEmail': 'hans@juergen.com',
        });
        // Info request should return with the same content.
        final info = await client.publisherInfo('example.com');
        expect(info.toJson(), rs.toJson());
      });
    });

    group('Update all publisher detail', () {
      testWithServices('OK', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(
              description: 'new description',
              websiteUrl: 'https://www.example.com/about',
              contactEmail: hansUser.email),
        );
        expect(rs.toJson(), {
          'description': 'new description',
          'websiteUrl': 'https://www.example.com/about',
          'contactEmail': 'hans@juergen.com',
        });
        // Info request should return with the same content.
        final info = await client.publisherInfo('example.com');
        expect(info.toJson(), rs.toJson());
      });
    });

    group('Invite a new member', () {
      Future<List<Map>> queryConstents({String userId, String email}) async {
        final query = dbService.query<Consent>();
        return await query
            .run()
            .where((c) => c.userId == userId || userId == null)
            .where((c) => c.email == email || email == null)
            .map((c) => {
                  'id': c.consentId,
                  'fromUserId': c.fromUserId,
                  'userId': c.userId,
                  'email': c.email,
                  'kind': c.kind,
                  'args': c.args,
                  'notificationCount': c.notificationCount,
                })
            .toList();
      }

      _testAdminAuthIssues(
        (client) => client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: testUserA.email)),
      );

      _testNoPublisher((client) => client.invitePublisherMember(
          'no-domain.net', InviteMemberRequest(email: testUserA.email)));

      testWithServices('Invalid e-mail', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: 'not an e-mail'));
        await expectApiException(rs, status: 400, code: 'InvalidInput');
      });

      testWithServices('User is already a member', () async {
        await dbService.commit(inserts: [
          publisherMember(testUserA.userId, PublisherMemberRole.admin),
        ]);
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: testUserA.email));
        await expectApiException(rs, status: 400, code: 'InvalidInput');
      });

      testWithServices('Pending with Consent, sending new e-mail', () async {
        final consent = Consent.init(
          fromUserId: hansUser.userId,
          userId: testUserA.userId,
          email: testUserA.email,
          kind: 'PublisherMember',
          args: ['example.com'],
        );
        consent.created = consent.created.subtract(Duration(hours: 1));
        consent.notificationCount++;
        await dbService.commit(inserts: [consent]);
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = await client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: testUserA.email));
        expect(rs.emailSent, isTrue);
        expect(await queryConstents(email: testUserA.email), [
          {
            'id': isNotNull,
            'fromUserId': hansUser.userId,
            'userId': testUserA.userId,
            'email': testUserA.email,
            'kind': 'PublisherMember',
            'args': ['example.com'],
            'notificationCount': 2,
          }
        ]);

        await expectApiException(
          client.publisherMemberInfo('example.com', testUserA.userId),
          status: 404,
          code: 'NotFound',
        );
      });

      testWithServices('Invite new account', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
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
            'fromUserId': hansUser.userId,
            'userId': isNull, // no user has been created
            'email': 'newuser@example.com',
            'kind': 'PublisherMember',
            'args': ['example.com'],
            'notificationCount': 1,
          }
        ]);
      });

      testWithServices('Invite existing account', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = await client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: testUserA.email));
        expect(rs.emailSent, isTrue);
        expect(await queryConstents(email: testUserA.email), [
          {
            'id': isNotNull,
            'fromUserId': hansUser.userId,
            'userId': testUserA.userId,
            'email': testUserA.email,
            'kind': 'PublisherMember',
            'args': ['example.com'],
            'notificationCount': 1,
          }
        ]);
      });

      testWithServices('Don not send e-mail twice in a row', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs1 = await client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: testUserA.email));
        expect(rs1.emailSent, isTrue);
        final rs2 = await client.invitePublisherMember(
            'example.com', InviteMemberRequest(email: testUserA.email));
        expect(rs2.emailSent, isFalse);
      });

      testWithServices('Accept invite', () async {
        final client1 = createPubApiClient(authToken: hansUser.userId);
        await client1.invitePublisherMember(
            'example.com', InviteMemberRequest(email: joeUser.email));
        final consents = await dbService
            .query<Consent>()
            .run()
            .where((c) => c.email == joeUser.email)
            .toList();
        final consentId = consents.single.consentId;
        final client2 = createPubApiClient(authToken: joeUser.userId);
        final rs2 = await client2.resolveConsent(
            consentId, account_api.ConsentResult(granted: true));
        expect(rs2.granted, isTrue);
        final m =
            await client1.publisherMemberInfo('example.com', joeUser.userId);
        expect(m.toJson(), {
          'userId': 'joe-at-example-dot-com',
          'role': 'admin',
          'email': 'joe@example.com',
        });
      });

      testWithServices('Decline invite', () async {
        final client1 = createPubApiClient(authToken: hansUser.userId);
        await client1.invitePublisherMember(
            'example.com', InviteMemberRequest(email: joeUser.email));
        final consents = await dbService
            .query<Consent>()
            .run()
            .where((c) => c.email == joeUser.email)
            .toList();
        final consentId = consents.single.consentId;
        final client2 = createPubApiClient(authToken: joeUser.userId);
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
        final rs4 = client1.publisherMemberInfo('example.com', joeUser.userId);
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

      testWithServices('OK', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = await client.listPublisherMembers('example.com');
        expect(_json(rs.toJson()), {
          'members': [
            {
              'userId': 'hans-at-juergen-dot-com',
              'email': 'hans@juergen.com',
              'role': 'admin',
            },
          ],
        });
      });
    });

    group('Get member detail', () {
      _testAdminAuthIssues(
        (client) => client.publisherMemberInfo('example.com', hansUser.userId),
      );

      _testNoPublisher(
        (client) =>
            client.publisherMemberInfo('no-domain.net', hansUser.userId),
      );

      testWithServices('User is not a member', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.publisherMemberInfo('example.com', 'not-a-user-id');
        await expectApiException(rs, status: 404, code: 'NotFound');
      });

      testWithServices('OK', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs =
            await client.publisherMemberInfo('example.com', hansUser.userId);
        expect(rs.toJson(), {
          'userId': 'hans-at-juergen-dot-com',
          'email': 'hans@juergen.com',
          'role': 'admin',
        });
      });
    });

    group('Update member detail', () {
      _testAdminAuthIssues(
        (client) => client.updatePublisherMember(
          'example.com',
          testUserA.userId,
          UpdatePublisherMemberRequest(role: 'admin'),
        ),
      );

      _testNoPublisher(
        (client) => client.updatePublisherMember(
          'no-domain.net',
          testUserA.userId,
          UpdatePublisherMemberRequest(role: 'admin'),
        ),
      );

      testWithServices('Modification of self is blocked', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.updatePublisherMember(
            'example.com',
            hansUser.userId,
            UpdatePublisherMemberRequest(
              role: 'x',
            ));
        await expectApiException(rs, status: 409, code: 'RequestConflict');
      });

      testWithServices('Modification of unrelated user is blocked', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.updatePublisherMember(
            'example.com', testUserA.userId, UpdatePublisherMemberRequest());
        await expectApiException(rs, status: 404, code: 'NotFound');
      });

      testWithServices('Role value is not allowed', () async {
        await dbService.commit(inserts: [
          publisherMember(testUserA.userId, PublisherMemberRole.admin),
        ]);
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.updatePublisherMember(
            'example.com',
            testUserA.userId,
            UpdatePublisherMemberRequest(
              role: 'not-allowed-role',
            ));
        await expectApiException(rs, status: 400, code: 'InvalidInput');
      });

      testWithServices('OK', () async {
        await dbService.commit(inserts: [
          publisherMember(testUserA.userId, 'someotherrole'),
        ]);
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = await client.updatePublisherMember(
            'example.com',
            testUserA.userId,
            UpdatePublisherMemberRequest(
              role: PublisherMemberRole.admin,
            ));
        expect(rs.toJson(), {
          'userId': 'a-example-com',
          'role': 'admin',
          'email': 'a@example.com',
        });
        // Info request should return with the same content.
        final updated =
            await client.publisherMemberInfo('example.com', testUserA.userId);
        expect(updated.toJson(), rs.toJson());
      });
    });

    group('Delete member', () {
      _testAdminAuthIssues(
        (client) =>
            client.removePublisherMember('example.com', testUserA.userId),
      );

      _testNoPublisher(
        (client) =>
            client.removePublisherMember('no-domain.net', testUserA.userId),
      );

      testWithServices('Modification of self is blocked', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.removePublisherMember('example.com', hansUser.userId);
        await expectApiException(rs, status: 409, code: 'RequestConflict');
      });

      testWithServices('Remove of non-member is idempotent', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs =
            await client.removePublisherMember('example.com', testUserA.userId);
        expect(json.fuse(utf8).decode(rs), {'status': 'OK'});
      });

      testWithServices('OK', () async {
        await dbService.commit(inserts: [
          publisherMember(testUserA.userId, PublisherMemberRole.admin),
        ]);
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs =
            await client.removePublisherMember('example.com', testUserA.userId);
        expect(json.fuse(utf8).decode(rs), {'status': 'OK'});
        // Info request should return with NotFound exception.
        final updated =
            client.publisherMemberInfo('example.com', testUserA.userId);
        await expectApiException(updated, status: 404, code: 'NotFound');
      });
    });
  });
}

dynamic _json(value) => json.decode(json.encode(value));

void _testAdminAuthIssues(Future Function(PubApiClient client) fn) {
  testWithServices('No active user', () async {
    final client = createPubApiClient();
    final rs = fn(client);
    await expectApiException(rs,
        status: 401,
        code: 'MissingAuthentication',
        message: 'please add `authorization` header');
  });

  testWithServices('Active user is not a member', () async {
    await dbService.commit(
        inserts: [publisherMember(joeUser.userId, 'admin')],
        deletes: [exampleComHansAdmin.key]);
    final client = createPubApiClient(authToken: hansUser.userId);
    final rs = fn(client);
    await expectApiException(rs, status: 403, code: 'InsufficientPermissions');
  });

  testWithServices('Active user is not an admin yet', () async {
    await dbService.commit(inserts: [
      publisherMember(hansUser.userId, 'non-admin'),
    ]);
    final client = createPubApiClient(authToken: hansUser.userId);
    final rs = fn(client);
    await expectApiException(rs, status: 403, code: 'InsufficientPermissions');
  });
}

void _testNoPublisher(Future Function(PubApiClient client) fn) {
  testWithServices('No publisher with given id', () async {
    final client = createPubApiClient(authToken: hansUser.userId);
    final rs = fn(client);
    await expectApiException(rs, status: 404, code: 'NotFound');
  });
}
