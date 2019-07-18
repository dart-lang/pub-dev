// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/account/models.dart';
import 'package:pub_dartlang_org/publisher/models.dart';
import 'package:pub_dartlang_org/frontend/model_properties.dart';
import 'package:pub_dartlang_org/frontend/models.dart';

final Key testPackageKey =
    Key.emptyKey(Partition(null)).append(Package, id: 'foobar_pkg');

final Key testPackageVersionKey =
    testPackageKey.append(PackageVersion, id: '0.1.1+5');
final Key devPackageVersionKey =
    testPackageKey.append(PackageVersion, id: '0.2.0-dev');

final Pubspec testPubspec = Pubspec.fromYaml(testPackagePubspec);

final testUserHans = User()
  ..id = 'hans-at-juergen-dot-com'
  ..email = 'hans@juergen.com'
  ..created = DateTime.utc(2014);
final testUserA = User()
  ..id = 'a-example-com'
  ..email = 'a@example.com'
  ..created = DateTime(2019, 01, 01);

final testAuthenticatedUserHans =
    AuthenticatedUser('hans-at-juergen-dot-com', 'hans@juergen.com');

Package createTestPackage({List<AuthenticatedUser> uploaders}) {
  uploaders ??= [testAuthenticatedUserHans];
  return Package()
    ..parentKey = testPackageKey.parent
    ..id = testPackageKey.id
    ..name = testPackageKey.id as String
    ..created = DateTime.utc(2014)
    ..updated = DateTime.utc(2015)
    ..uploaders = uploaders.map((user) => user.userId).toList()
    ..latestVersionKey = testPackageVersionKey
    ..latestDevVersionKey = testPackageVersionKey
    ..downloads = 0;
}

final Package testPackage = createTestPackage()
  ..latestDevVersionKey = devPackageVersionKey;
final testPackageUploaderEmails = [testAuthenticatedUserHans.email];

final Package discontinuedPackage = createTestPackage()..isDiscontinued = true;
final discontinuedPackageUploaderEmails = [testAuthenticatedUserHans.email];

final PackageVersion testPackageVersion = PackageVersion()
  ..parentKey = testPackageVersionKey.parent
  ..id = testPackageVersionKey.id
  ..version = testPackageVersionKey.id as String
  ..packageKey = testPackageKey
  ..created = DateTime.utc(2014)
  ..libraries = ['foolib.dart']
  ..pubspec = testPubspec
  ..readmeFilename = 'README.md'
  ..readmeContent = testPackageReadme
  ..changelogFilename = 'CHANGELOG.md'
  ..changelogContent = testPackageChangelog
  ..exampleFilename = 'example/lib/main.dart'
  ..exampleContent = testPackageExample
  ..sortOrder = -1
  ..downloads = 0;

final PackageVersion flutterPackageVersion =
    clonePackageVersion(testPackageVersion)
      ..created = DateTime.utc(2015)
      ..pubspec = Pubspec.fromYaml(testPackagePubspec +
          '''
flutter:
  plugin:
    class: SomeClass
  ''');

final PackageVersion devPackageVersion = clonePackageVersion(testPackageVersion)
  ..id = devPackageVersionKey.id
  ..version = devPackageVersionKey.id as String;

PackageVersion clonePackageVersion(PackageVersion original) => PackageVersion()
  ..packageKey = original.parentKey
  ..id = original.id
  ..version = original.version
  ..packageKey = original.packageKey
  ..created = original.created
  ..libraries = original.libraries
  ..pubspec = original.pubspec
  ..readmeFilename = original.readmeFilename
  ..readmeContent = original.readmeContent
  ..changelogFilename = original.changelogFilename
  ..changelogContent = original.changelogContent
  ..sortOrder = original.sortOrder
  ..downloads = original.downloads;

final String testPackageReadme = '''
Test Package
============

This is a readme file.

```dart
void main() {
}
```
''';

final String testPackageChangelog = '''
Changelog
============

0.1.1 - test package

''';

final String testPackageExample = '''
main() {
  print('Hello world!');
}
''';

final String testPackagePubspec = '''
name: foobar_pkg
version: 0.1.1+5
author: Hans Juergen <hans@juergen.com>
homepage: http://hans.juergen.com
description: 'my package description'

dependencies:
  gcloud: any
''';

final testPublisher = Publisher()
  ..id = 'example.com'
  ..description = 'This is us!'
  ..created = DateTime(2019, 07, 15)
  ..updated = DateTime(2019, 07, 16);

PublisherMember testPublisherMember(String userId, String role) =>
    PublisherMember()
      ..parentKey = testPublisher.key
      ..id = userId
      ..role = role;
