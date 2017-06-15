// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.utils;

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/model_properties.dart';
import 'package:pub_dartlang_org/frontend/models.dart';

class TestDelayCompletion {
  final int count;
  final Function _complete = expectAsync0(() {});
  int _got = 0;

  TestDelayCompletion({this.count: 1});

  void complete() {
    _got++;
    if (_got == count) _complete();
  }
}

final Key testPackageKey =
    new Key.emptyKey(new Partition(null)).append(Package, id: 'foobar_pkg');

final Key testPackageVersionKey =
    testPackageKey.append(PackageVersion, id: '0.1.1');

final Pubspec testPubspec = new Pubspec.fromYaml(TestPackagePubspec);

final Package testPackage = new Package()
  ..parentKey = testPackageKey.parent
  ..id = testPackageKey.id
  ..name = testPackageKey.id
  ..created = new DateTime.utc(2014)
  ..updated = new DateTime.utc(2015)
  ..uploaderEmails = ['hans@juergen.com']
  ..latestVersionKey = testPackageVersionKey
  ..latestDevVersionKey = testPackageVersionKey;

final PackageVersion testPackageVersion = new PackageVersion()
  ..parentKey = testPackageVersionKey.parent
  ..id = testPackageVersionKey.id
  ..version = testPackageVersionKey.id
  ..packageKey = testPackageKey
  ..created = new DateTime.utc(2014)
  ..libraries = ['foolib.dart']
  ..pubspec = testPubspec
  ..readmeFilename = 'README.md'
  ..readmeContent = TestPackageReadme
  ..changelogFilename = 'CHANGELOG.md'
  ..changelogContent = TestPackageChangelog
  ..sortOrder = -1;

final PackageVersion flutterPackageVersion =
    clonePackageVersion(testPackageVersion)
      ..detectedTypes = [
        BuiltinTypes.flutterPackage,
        BuiltinTypes.flutterPlugin,
      ]
      ..pubspec = new Pubspec.fromYaml(TestPackagePubspec +
          '''
flutter:
  plugin:
    class: SomeClass
  ''');

PackageVersion clonePackageVersion(PackageVersion original) =>
    new PackageVersion()
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
      ..sortOrder = original.sortOrder;

Future scoped(func()) {
  return fork(() async {
    return func();
  });
}

void scopedTest(String name, func(), {Timeout timeout}) {
  test(name, () {
    return fork(() async {
      return func();
    });
  }, timeout: timeout);
}

final String TestPackageReadme = '''
Test Package
============

This is a readme file.

```dart
void main() {
}
```
''';

final String TestPackageChangelog = '''
Changelog
============

0.1.1 - test package

''';

final String TestPackagePubspec = '''
name: foobar_pkg
version: 0.1.1
author: Hans Juergen <hans@juergen.com>
homepage: http://hans.juergen.com
description: 'my package description'

dependencies:
  gcloud: any
''';
