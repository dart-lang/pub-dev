// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import 'models.dart';

/// Creates a new TestProfile with the missing entities (e.g. users or publishers)
/// created.
TestProfile normalize(TestProfile profile) {
  final users = <String, TestUser>{};
  final publishers = <String, TestPublisher>{};
  final packages = <String, TestPackage>{};

  profile.users?.forEach((user) {
    users[user.email] = user;
  });
  if (profile.defaultUser != null) {
    _createUserIfNeeded(users, profile.defaultUser);
  }

  profile.publishers?.forEach((publisher) {
    publishers[publisher.name] = publisher;
    publisher.members?.forEach((member) {
      _createUserIfNeeded(users, member.email);
    });
  });

  profile.packages?.forEach((package) {
    packages[package.name] = package;
    package.uploaders?.forEach((uploader) {
      _createUserIfNeeded(users, uploader);
    });
  });

  final defaultUser = profile.defaultUser ?? users.keys.first;

  profile.packages?.forEach((package) {
    if (package.publisher != null) {
      _createPublisherIfNeeded(
        publishers,
        package.publisher,
        memberEmail: defaultUser,
      );
    } else if (package.uploaders == null || package.uploaders.isEmpty) {
      packages[package.name] = package.change(uploaders: [defaultUser]);
    }
  });

  return TestProfile(
    defaultUser: defaultUser,
    users: users.values.toList(),
    publishers: publishers.values.toList(),
    packages: packages.values.toList(),
  );
}

TestUser _createUserIfNeeded(Map<String, TestUser> users, String email) {
  return users.putIfAbsent(
    email,
    () => TestUser(
      email: email,
      created: DateTime.now().toUtc(),
      isDeleted: false,
      likes: <String>[],
    ),
  );
}

TestPublisher _createPublisherIfNeeded(
  Map<String, TestPublisher> publishers,
  String publisherId, {
  @required String memberEmail,
  DateTime created,
  DateTime updated,
}) {
  return publishers.putIfAbsent(publisherId, () {
    final now = DateTime.now().toUtc();
    final publisherCreated = created ?? now;
    final publisherUpdated = updated ?? publisherCreated;
    return TestPublisher(
      name: publisherId,
      created: publisherCreated,
      updated: publisherUpdated,
      members: <TestMember>[
        TestMember(
          email: memberEmail,
          role: 'admin',
          created: publisherUpdated,
          updated: publisherUpdated,
        ),
      ],
    );
  });
}
