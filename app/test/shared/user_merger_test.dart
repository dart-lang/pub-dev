// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:gcloud/db.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/like_backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/shared/user_merger.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import 'test_services.dart';

void main() {
  Future<void> _corruptAndFix() async {
    final admin = await accountBackend.lookupUserByEmail('admin@pub.dev');
    final user = await accountBackend.lookupUserByEmail('user@pub.dev');
    await dbService.withTransaction((tx) async {
      final oauth = await tx.lookupValue<OAuthUserID>(
          dbService.emptyKey.append(OAuthUserID, id: admin.oauthUserId));
      final u = await tx.lookupValue<User>(admin.key);
      u.oauthUserId = user.oauthUserId;
      tx.queueMutations(inserts: [u], deletes: [oauth.key]);
      await tx.commit();
    });
    final merger = UserMerger(
      db: dbService,
      concurrency: 2,
      omitEmailCheck: true,
    );
    await merger.fixAll();
  }

  testWithProfile('packages and versions', fn: () async {
    final admin = await accountBackend.lookupUserByEmail('admin@pub.dev');
    final user = await accountBackend.lookupUserByEmail('user@pub.dev');
    final pkg1 = (await packageBackend.lookupPackage('oxygen'))!;
    expect(pkg1.uploaders, [admin.userId]);

    await _corruptAndFix();

    final pkg = (await packageBackend.lookupPackage('oxygen'))!;
    expect(pkg.uploaders, [user.userId]);

    final pv = (await packageBackend.lookupPackageVersion(
        pkg.name!, pkg.latestVersion!))!;
    expect(pv.uploader, user.userId);
  });

  testWithProfile('session', fn: () async {
    final admin = await accountBackend.lookupUserByEmail('admin@pub.dev');
    final user = await accountBackend.lookupUserByEmail('user@pub.dev');
    final control = await withFakeAuthRequestContext(
      'control@pub.dev',
      () => requireAuthenticatedWebUser(),
    );
    await dbService.commit(inserts: [
      UserSession()
        ..id = 'target'
        ..userId = admin.userId
        ..email = admin.email
        ..created = clock.now()
        ..expires = clock.now(),
      UserSession()
        ..id = 'control'
        ..userId = control.userId
        ..email = control.userId
        ..created = clock.now()
        ..expires = clock.now(),
    ]);

    await _corruptAndFix();

    final list = await dbService.lookup<UserSession>([
      dbService.emptyKey.append(UserSession, id: 'target'),
      dbService.emptyKey.append(UserSession, id: 'control'),
    ]);
    expect(list[0]!.userId, user.userId);
    expect(list[1]!.userId, control.userId);
  });

  testWithProfile('new consent', fn: () async {
    final admin = await accountBackend.lookupUserByEmail('admin@pub.dev');
    final user = await accountBackend.lookupUserByEmail('user@pub.dev');
    final control = await withFakeAuthRequestContext(
      'control@pub.dev',
      () => requireAuthenticatedWebUser(),
    );

    final target1 = Consent.init(
      email: admin.email,
      kind: 'k1',
      args: ['1'],
      fromAgent: user.userId,
      fromUserId: user.userId,
    );
    final target2 = Consent.init(
      email: user.email,
      kind: 'k2',
      args: ['2'],
      fromAgent: admin.userId,
      fromUserId: admin.userId,
    );
    final controlConsent = Consent.init(
      email: control.email,
      kind: 'k3',
      args: ['3'],
      fromAgent: control.userId,
      fromUserId: control.userId,
    );
    await dbService.commit(inserts: [target1, target2, controlConsent]);

    await _corruptAndFix();

    final list = await dbService.query<Consent>().run().toList();
    final updated1 = list.firstWhere((c) => c.id == target1.id);
    final updated2 = list.firstWhere((c) => c.id == target2.id);
    final updated3 = list.firstWhere((c) => c.id == controlConsent.id);

    expect(updated1.fromUserId, user.userId);
    expect(updated2.fromUserId, user.userId);
    expect(updated3.fromUserId, control.userId);
  });

  testWithProfile('publisher membership',
      testProfile: TestProfile(
        packages: [],
        publishers: [
          TestPublisher(
              name: 'example.com',
              members: [TestMember(email: 'admin@pub.dev', role: 'admin')]),
          TestPublisher(
              name: 'verified.com',
              members: [TestMember(email: 'control@pub.dev', role: 'admin')]),
        ],
        users: [TestUser(email: 'user@pub.dev', likes: [])],
      ), fn: () async {
    await _corruptAndFix();

    expect(await publisherBackend.getAdminMemberEmails('example.com'),
        ['user@pub.dev']);
    expect(await publisherBackend.getAdminMemberEmails('verified.com'),
        ['control@pub.dev']);
  });

  testWithProfile('like', fn: () async {
    final user = await accountBackend.lookupUserByEmail('user@pub.dev');
    final admin = await accountBackend.lookupUserByEmail('admin@pub.dev');
    await likeBackend.likePackage(admin, 'oxygen');
    expect(
        (await likeBackend.listPackageLikes(admin))
            .map((e) => e.package)
            .toList(),
        ['oxygen']);
    expect(await likeBackend.listPackageLikes(user), isEmpty);

    await _corruptAndFix();

    expect(await likeBackend.listPackageLikes(admin), isEmpty);
    expect(
        (await likeBackend.listPackageLikes(user))
            .map((e) => e.package)
            .toList(),
        ['oxygen']);
  });

  testWithProfile('audit log record', fn: () async {
    final user = await accountBackend.lookupUserByEmail('user@pub.dev');
    final admin = await accountBackend.lookupUserByEmail('admin@pub.dev');
    await _corruptAndFix();
    final adminRecords = await auditBackend.listRecordsForUserId(admin.userId);
    expect(adminRecords.records, isEmpty);
    final userRecords = await auditBackend.listRecordsForUserId(user.userId);
    expect(userRecords.records, isNotEmpty);
  });
}
