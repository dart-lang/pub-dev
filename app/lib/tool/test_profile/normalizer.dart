// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'models.dart';

/// Creates a new TestProfile with the missing entities (e.g. users or publishers)
/// created.
TestProfile normalize(TestProfile profile) {
  final users = <String, TestUser>{};
  final publishers = <String, TestPublisher>{};
  final importedPackages = <String, TestPackage>{};
  final generatedPackages = <String, TestPackage>{};

  profile.users.forEach((user) {
    users[user.email] = user;
  });
  if (profile.defaultUser != null) {
    _createUserIfNeeded(users, profile.defaultUser!);
  }

  profile.publishers.forEach((publisher) {
    publishers[publisher.name] = publisher;
    publisher.members.forEach((member) {
      _createUserIfNeeded(users, member.email);
    });
  });

  profile.importedPackages.forEach((package) {
    importedPackages[package.name] = package;
    package.uploaders?.forEach((uploader) {
      _createUserIfNeeded(users, uploader);
    });
  });
  profile.generatedPackages.forEach((package) {
    generatedPackages[package.name] = package;
    package.uploaders?.forEach((uploader) {
      _createUserIfNeeded(users, uploader);
    });
  });

  final publishersToCreate = {
    ...importedPackages.values.map((p) => p.publisher).nonNulls,
    ...generatedPackages.values.map((p) => p.publisher).nonNulls,
  };
  for (final publisher in publishersToCreate) {
    _createPublisherIfNeeded(
      publishers,
      publisher,
      memberEmail: profile.resolvedDefaultUser,
    );
  }

  return TestProfile(
    defaultUser: profile.resolvedDefaultUser,
    users: users.values.toList(),
    publishers: publishers.values.toList(),
    importedPackages: importedPackages.values.toList(),
    generatedPackages: generatedPackages.values.toList(),
  );
}

TestUser _createUserIfNeeded(Map<String, TestUser> users, String email) {
  return users.putIfAbsent(
    email,
    () => TestUser(
      email: email,
      likes: <String>[],
    ),
  );
}

TestPublisher _createPublisherIfNeeded(
  Map<String, TestPublisher> publishers,
  String publisherId, {
  required String memberEmail,
}) {
  return publishers.putIfAbsent(publisherId, () {
    return TestPublisher(
      name: publisherId,
      members: <TestMember>[
        TestMember(
          email: memberEmail,
          role: 'admin',
        ),
      ],
    );
  });
}
