// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.utils;

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/account/models.dart';
import 'package:pub_dartlang_org/frontend/model_properties.dart';
import 'package:pub_dartlang_org/frontend/models.dart';

class TestDelayCompletion {
  final int count;
  final Function _complete = expectAsync0(() {});
  int _got = 0;

  TestDelayCompletion({this.count = 1});

  void complete() {
    _got++;
    if (_got == count) _complete();
  }
}

final Key testPackageKey =
    Key.emptyKey(Partition(null)).append(Package, id: 'foobar_pkg');

final Key testPackageVersionKey =
    testPackageKey.append(PackageVersion, id: '0.1.1+5');
final Key devPackageVersionKey =
    testPackageKey.append(PackageVersion, id: '0.2.0-dev');

final Pubspec testPubspec = Pubspec.fromYaml(testPackagePubspec);

final testUser = User()
  ..id = 'hans-at-juergen-dot-com'
  ..email = 'hans@juergen.com'
  ..created = DateTime.utc(2014);

final testUploaderUser =
    AuthenticatedUser('hans-at-juergen-dot-com', 'hans@juergen.com');

Package createTestPackage({List<AuthenticatedUser> uploaders}) {
  uploaders ??= [testUploaderUser];
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
final testPackageUploaderEmails = [testUploaderUser.email];

final Package discontinuedPackage = createTestPackage()..isDiscontinued = true;
final discontinuedPackageUploaderEmails = [testUploaderUser.email];

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
