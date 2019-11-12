// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/history/backend.dart';
import 'package:pub_dev/history/models.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/user_merger.dart';

import 'test_models.dart';
import 'test_services.dart';

void main() {
  Future<void> _updateUsers() async {
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

  Future<void> _corruptAndFix() async {
    await _updateUsers();
    final merger = UserMerger(
      db: dbService,
      concurrency: 2,
      omitEmailCheck: true,
    );
    await merger.fixAll();
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

    await _corruptAndFix();

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

    await _corruptAndFix();

    final list = await dbService.lookup<UserSession>([
      dbService.emptyKey.append(UserSession, id: 'target'),
      dbService.emptyKey.append(UserSession, id: 'control'),
    ]);
    expect(list[0].userId, joeUser.userId);
    expect(list[1].userId, adminUser.userId);
  });

  testWithServices('new consent', () async {
    final target1 = Consent.init(
        userId: hansUser.userId,
        email: null,
        kind: 'k1',
        args: ['1'],
        fromUserId: adminUser.userId);
    final target2 = Consent.init(
        userId: adminUser.userId,
        email: null,
        kind: 'k2',
        args: ['2'],
        fromUserId: hansUser.userId);
    final control = Consent.init(
        userId: adminUser.userId,
        email: null,
        kind: 'k3',
        args: ['3'],
        fromUserId: adminUser.userId);
    await dbService.commit(inserts: [target1, target2, control]);

    await _corruptAndFix();

    final list = await dbService.query<Consent>().run().toList();
    final updated1 = list.firstWhere((c) => c.id == target1.id);
    final updated2 = list.firstWhere((c) => c.id == target2.id);
    final updated3 = list.firstWhere((c) => c.id == control.id);

    expect(updated1.userId, joeUser.userId);
    expect(updated1.fromUserId, adminUser.userId);
    expect(updated2.userId, adminUser.userId);
    expect(updated2.fromUserId, joeUser.userId);
    expect(updated3.userId, adminUser.userId);
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

    await _corruptAndFix();

    final after = await dbService.query<PublisherMember>().run().toList();
    expect(after.map((m) => m.userId).toList()..sort(), [
      adminUser.userId,
      joeUser.userId,
    ]);
  });

  Future<T> updateHistoryEvent<T extends HistoryEvent>(T event) async {
    final id = await historyBackend.storeEvent(event);

    await _corruptAndFix();

    final h = await dbService
        .lookupValue<History>(dbService.emptyKey.append(History, id: id));
    return h.historyEvent as T;
  }

  testWithServices('history: UploaderChanged (current)', () async {
    final updated = await updateHistoryEvent(UploaderChanged(
      packageName: 'foo',
      currentUserId: hansUser.userId,
      currentUserEmail: hansUser.email,
      addedUploaderIds: [adminUser.userId],
      addedUploaderEmails: [adminUser.email],
    ));
    expect(updated.currentUserId, joeUser.userId);
    expect(updated.addedUploaderIds, [adminUser.userId]);
  });

  testWithServices('history: UploaderChanged (added)', () async {
    final updated = await updateHistoryEvent(UploaderChanged(
      packageName: 'foo',
      currentUserId: adminUser.userId,
      currentUserEmail: adminUser.email,
      addedUploaderIds: [hansUser.userId],
      addedUploaderEmails: [hansUser.email],
    ));
    expect(updated.currentUserId, adminUser.userId);
    expect(updated.addedUploaderIds, [joeUser.userId]);
  });

  testWithServices('history: UploaderChanged (removed)', () async {
    final updated = await updateHistoryEvent(UploaderChanged(
      packageName: 'foo',
      currentUserId: adminUser.userId,
      currentUserEmail: adminUser.email,
      removedUploaderIds: [hansUser.userId],
      removedUploaderEmails: [hansUser.email],
    ));
    expect(updated.currentUserId, adminUser.userId);
    expect(updated.removedUploaderIds, [joeUser.userId]);
  });

  testWithServices('history: PackageTransferred', () async {
    final updated = await updateHistoryEvent(PackageTransferred(
      packageName: 'foo',
      fromPublisherId: null,
      toPublisherId: 'example.com',
      userId: hansUser.userId,
      userEmail: hansUser.email,
    ));
    expect(updated.userId, joeUser.userId);
  });

  testWithServices('history: PublisherCreated', () async {
    final updated = await updateHistoryEvent(PublisherCreated(
      publisherId: 'example.com',
      userId: hansUser.userId,
      userEmail: hansUser.email,
    ));
    expect(updated.userId, joeUser.userId);
    expect(updated.userEmail, hansUser.email);
  });

  testWithServices('history: MemberInvited (current)', () async {
    final updated = await updateHistoryEvent(MemberInvited(
      publisherId: 'example.com',
      currentUserId: hansUser.userId,
      currentUserEmail: hansUser.email,
      invitedUserEmail: adminUser.userId,
      invitedUserId: adminUser.userId,
      timestamp: DateTime.now(),
    ));
    expect(updated.currentUserId, joeUser.userId);
    expect(updated.invitedUserId, adminUser.userId);
  });

  testWithServices('history: MemberInvited (invited)', () async {
    final updated = await updateHistoryEvent(MemberInvited(
      publisherId: 'example.com',
      currentUserId: adminUser.userId,
      currentUserEmail: adminUser.email,
      invitedUserEmail: hansUser.userId,
      invitedUserId: hansUser.userId,
      timestamp: DateTime.now(),
    ));
    expect(updated.currentUserId, adminUser.userId);
    expect(updated.invitedUserId, joeUser.userId);
  });

  testWithServices('history: MemberJoined', () async {
    final updated = await updateHistoryEvent(MemberJoined(
      publisherId: 'example.com',
      userId: hansUser.userId,
      userEmail: hansUser.email,
      role: 'admin',
      timestamp: DateTime.now(),
    ));
    expect(updated.userId, joeUser.userId);
    expect(updated.role, 'admin');
  });

  testWithServices('history: MemberRemoved (current)', () async {
    final updated = await updateHistoryEvent(MemberRemoved(
      publisherId: 'example.com',
      currentUserId: hansUser.userId,
      currentUserEmail: hansUser.email,
      removedUserId: adminUser.userId,
      removedUserEmail: adminUser.userId,
      timestamp: DateTime.now(),
    ));
    expect(updated.currentUserId, joeUser.userId);
    expect(updated.removedUserId, adminUser.userId);
  });

  testWithServices('history: MemberRemoved (removed)', () async {
    final updated = await updateHistoryEvent(MemberRemoved(
      publisherId: 'example.com',
      currentUserId: adminUser.userId,
      currentUserEmail: adminUser.email,
      removedUserId: hansUser.userId,
      removedUserEmail: hansUser.userId,
      timestamp: DateTime.now(),
    ));
    expect(updated.currentUserId, adminUser.userId);
    expect(updated.removedUserId, joeUser.userId);
  });
}
