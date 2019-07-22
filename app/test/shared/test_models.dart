// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/account/models.dart';
import 'package:pub_dartlang_org/publisher/models.dart';
import 'package:pub_dartlang_org/frontend/model_properties.dart';
import 'package:pub_dartlang_org/frontend/models.dart';

final Key foobarPkgKey =
    Key.emptyKey(Partition(null)).append(Package, id: 'foobar_pkg');

final Key foobarStablePVKey =
    foobarPkgKey.append(PackageVersion, id: '0.1.1+5');
final Key foobarDevPVKey = foobarPkgKey.append(PackageVersion, id: '0.2.0-dev');

final hansUser = User()
  ..id = 'hans-at-juergen-dot-com'
  ..email = 'hans@juergen.com'
  ..created = DateTime.utc(2014);
final testUserA = User()
  ..id = 'a-example-com'
  ..email = 'a@example.com'
  ..created = DateTime(2019, 01, 01);

final hansAuthenticated =
    AuthenticatedUser('hans-at-juergen-dot-com', 'hans@juergen.com');

Package createFoobarPackage({String name, List<AuthenticatedUser> uploaders}) {
  name ??= foobarPkgKey.id as String;
  uploaders ??= [hansAuthenticated];
  return Package()
    ..parentKey = foobarPkgKey.parent
    ..id = name
    ..name = name
    ..created = DateTime.utc(2014)
    ..updated = DateTime.utc(2015)
    ..uploaders = uploaders.map((user) => user.userId).toList()
    ..latestVersionKey = foobarStablePVKey
    ..latestDevVersionKey = foobarStablePVKey
    ..downloads = 0;
}

final Package foobarPackage = createFoobarPackage()
  ..latestDevVersionKey = foobarDevPVKey;
final foobarUploaderEmails = [hansAuthenticated.email];

final Package discontinuedPackage = createFoobarPackage()
  ..isDiscontinued = true;

final PackageVersion foobarStablePV = PackageVersion()
  ..parentKey = foobarStablePVKey.parent
  ..id = foobarStablePVKey.id
  ..version = foobarStablePVKey.id as String
  ..packageKey = foobarPkgKey
  ..created = DateTime.utc(2014)
  ..libraries = ['foolib.dart']
  ..pubspec = Pubspec.fromYaml(foobarStablePubspec)
  ..readmeFilename = 'README.md'
  ..readmeContent = foobarReadmeContent
  ..changelogFilename = 'CHANGELOG.md'
  ..changelogContent = foobarChangelogContent
  ..exampleFilename = 'example/lib/main.dart'
  ..exampleContent = foobarExampleContent
  ..sortOrder = -1
  ..downloads = 0;

final PackageVersion flutterPackageVersion = clonePackageVersion(foobarStablePV)
  ..created = DateTime.utc(2015)
  ..pubspec = Pubspec.fromYaml(foobarStablePubspec +
      '''
flutter:
  plugin:
    class: SomeClass
  ''');

final PackageVersion foobarDevPV = clonePackageVersion(foobarStablePV)
  ..id = foobarDevPVKey.id
  ..version = foobarDevPVKey.id as String;

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

final String foobarReadmeContent = '''
Test Package
============

This is a readme file.

```dart
void main() {
}
```
''';

final String foobarChangelogContent = '''
Changelog
============

0.1.1 - test package

''';

final String foobarExampleContent = '''
main() {
  print('Hello world!');
}
''';

final String foobarStablePubspec = '''
name: foobar_pkg
version: 0.1.1+5
author: Hans Juergen <hans@juergen.com>
homepage: http://hans.juergen.com
description: 'my package description'

dependencies:
  gcloud: any
''';

final exampleComPublisher = Publisher()
  ..id = 'example.com'
  ..description = 'This is us!'
  ..created = DateTime(2019, 07, 15)
  ..updated = DateTime(2019, 07, 16);

PublisherMember publisherMember(String userId, String role, {Key parentKey}) =>
    PublisherMember()
      ..parentKey = parentKey ?? exampleComPublisher.key
      ..id = userId
      ..role = role;
