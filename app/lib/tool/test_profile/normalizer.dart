// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'models.dart';

/// Creates a new TestProfile with the missing entities (e.g. users or publishers)
/// created.
TestProfile normalize(
  TestProfile profile, {
  List<ResolvedVersion>? resolvedVersions,
}) {
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

  final defaultUser = profile.defaultUser ?? users.keys.first;

  // add missing packages from resolved versions
  if (resolvedVersions != null) {
    resolvedVersions.forEach((rv) {
      if (generatedPackages.containsKey(rv.package)) {
        return;
      }
      importedPackages.putIfAbsent(
          rv.package,
          () => TestPackage(
                name: rv.package,
                versions: [
                  TestVersion(version: rv.version, created: rv.created),
                ],
                uploaders: [defaultUser],
              ));
    });
    // update versions from resolved versions
    List<TestVersion> getUpdateVersions(TestPackage p) {
      return resolvedVersions
          .where((rv) => rv.package == p.name)
          .map((rv) => rv.version)
          .toSet()
          .map((v) => TestVersion(
              version: v,
              created:
                  resolvedVersions.firstWhere((x) => x.version == v).created))
          .toList();
    }

    importedPackages.values.toList().forEach((p) {
      importedPackages[p.name] = p.change(versions: getUpdateVersions(p));
    });
    generatedPackages.values.toList().forEach((p) {
      generatedPackages[p.name] = p.change(versions: getUpdateVersions(p));
    });
  }

  final publishersToCreate = {
    ...importedPackages.values.map((p) => p.publisher).nonNulls,
    ...generatedPackages.values.map((p) => p.publisher).nonNulls,
  };
  for (final publisher in publishersToCreate) {
    _createPublisherIfNeeded(
      publishers,
      publisher,
      memberEmail: defaultUser,
    );
  }

  for (final package in importedPackages.values.toList()) {
    if (package.publisher == null &&
        (package.uploaders == null || package.uploaders!.isEmpty)) {
      importedPackages[package.name] = package.change(uploaders: [defaultUser]);
    }
  }

  for (final package in generatedPackages.values.toList()) {
    if (package.publisher == null &&
        (package.uploaders == null || package.uploaders!.isEmpty)) {
      generatedPackages[package.name] =
          package.change(uploaders: [defaultUser]);
    }
  }

  return TestProfile(
    defaultUser: defaultUser,
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
