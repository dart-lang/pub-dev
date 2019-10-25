// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/account/models.dart';
import 'package:pub_dartlang_org/package/models.dart';
import 'package:pub_dartlang_org/publisher/models.dart';
import 'package:pub_dartlang_org/shared/user_merger.dart';

import 'test_models.dart';
import 'test_services.dart';

void main() {
  Future updateUsers() async {
    await dbService.withTransaction((tx) async {
      final users = await tx.lookup<User>([hansUser.key, joeUser.key]);
      users.forEach((u) => u.oauthUserId = 'oauth-1');
      tx.queueMutations(inserts: users);
      tx.queueMutations(inserts: [
        OAuthUserID()
          ..id = 'oauth-1'
          ..userIdKey =
              Key.emptyKey(Partition(null)).append(User, id: joeUser.userId)
      ]);
      await tx.commit();
    });
  }

  testWithServices('packages and versions', () async {
    final control = generateBundle(
      'control',
      ['1.0.0'],
      uploaders: [adminUser],
    );
    await dbService.commit(inserts: [
      control.package,
      ...control.versions,
      ...pvModels(control.versions.single),
    ]);

    await updateUsers();
    final merger = UserMerger(db: dbService, concurrency: 2, deleteUsers: true);
    await merger.fixAll();

    final pkgList = await dbService.lookup<Package>([
      foobarPackage.key,
      control.package.key,
    ]);
    expect(pkgList[0].uploaders, [joeUser.userId]);
    expect(pkgList[1].uploaders, [adminUser.userId]);

    final pvList = await dbService.lookup<PackageVersion>([
      foobarStablePV.key,
      control.versions.single.key,
    ]);
    expect(pvList[0].uploader, joeUser.userId);
    expect(pvList[1].uploader, adminUser.userId);
  });

  testWithServices('session', () async {
    await dbService.commit(inserts: [
      UserSession()
        ..id = 'target'
        ..userIdKey = hansUser.key
        ..email = 'target@domain.com'
        ..created = DateTime.now()
        ..expires = DateTime.now(),
      UserSession()
        ..id = 'control'
        ..userIdKey = adminUser.key
        ..email = 'control@domain.com'
        ..created = DateTime.now()
        ..expires = DateTime.now(),
    ]);

    await updateUsers();
    final merger = UserMerger(db: dbService, concurrency: 2, deleteUsers: true);
    await merger.fixAll();

    final list = await dbService.lookup<UserSession>([
      dbService.emptyKey.append(UserSession, id: 'target'),
      dbService.emptyKey.append(UserSession, id: 'control'),
    ]);
    expect(list[0].userId, joeUser.userId);
    expect(list[1].userId, adminUser.userId);
  });

  testWithServices('consent', () async {
    final target1 = Consent.init(
        parentKey: hansUser.key,
        kind: 'k1',
        args: ['1'],
        fromUserId: adminUser.userId);
    final target2 = Consent.init(
        parentKey: adminUser.key,
        kind: 'k2',
        args: ['2'],
        fromUserId: hansUser.userId);
    final control = Consent.init(
        parentKey: adminUser.key,
        kind: 'k3',
        args: ['3'],
        fromUserId: adminUser.userId);
    await dbService.commit(inserts: [target1, target2, control]);

    await updateUsers();
    final merger = UserMerger(db: dbService, concurrency: 2, deleteUsers: true);
    await merger.fixAll();

    final list = await dbService.query<Consent>().run().toList();
    final updated1 = list.firstWhere((c) => c.id == target1.id);
    final updated2 = list.firstWhere((c) => c.id == target2.id);
    final updated3 = list.firstWhere((c) => c.id == control.id);

    expect(updated1.parentKey.id, joeUser.userId);
    expect(updated1.fromUserId, adminUser.userId);
    expect(updated2.parentKey.id, adminUser.userId);
    expect(updated2.fromUserId, joeUser.userId);
    expect(updated3.parentKey.id, adminUser.userId);
    expect(updated3.fromUserId, adminUser.userId);
  });

  testWithServices('publisher membership', () async {
    final control = publisherMember(adminUser.userId, 'admin');
    await dbService.commit(inserts: [control]);
    final before = await dbService.query<PublisherMember>().run().toList();
    expect(before.map((m) => m.userId).toList()..sort(), [
      adminUser.userId,
      hansUser.userId,
    ]);

    await updateUsers();
    final merger = UserMerger(db: dbService, concurrency: 2, deleteUsers: true);
    await merger.fixAll();

    final after = await dbService.query<PublisherMember>().run().toList();
    expect(after.map((m) => m.userId).toList()..sort(), [
      adminUser.userId,
      joeUser.userId,
    ]);
  });
}
