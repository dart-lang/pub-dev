// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.utils;

import 'dart:async';

import 'package:test/test.dart';

import 'package:gcloud/service_scope.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/models.dart';
import 'package:pub_dartlang_org/model_properties.dart';

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
  ..latestVersionKey = testPackageVersionKey;

final PackageVersion testPackageVersion = new PackageVersion()
  ..parentKey = testPackageVersionKey.parent
  ..id = testPackageVersionKey.id
  ..version = testPackageVersionKey.id
  ..packageKey = testPackageKey
  ..created = new DateTime.utc(2014)
  ..pubspec = testPubspec
  ..readmeFilename = 'README'
  ..readmeContent = 'readme content'
  ..sortOrder = -1;

Future scoped(func()) {
  return fork(() async {
    return func();
  });
}

void scopedTest(String name, func()) {
  test(name, () {
    return fork(() async {
      return func();
    });
  });
}

final String TestPackageReadme = '''
Test Package
============

This is a readme file.
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

dependencies:
  gcloud: any
''';
