// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:pub_dev/tool/test_profile/models.dart';

import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/package/model_properties.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';

final defaultTestProfile = TestProfile(
  defaultUser: 'admin@pub.dev',
  packages: [
    TestPackage(
      name: 'oxygen',
      versions: [
        '1.0.0',
        '1.2.0',
        '2.0.0-dev',
      ],
    ),
    TestPackage(
      name: 'neon',
      versions: ['1.0.0'],
      publisher: 'example.com',
    ),
    TestPackage(
      name: 'flutter_titanium',
      versions: [
        '1.9.0',
        '1.10.0',
      ],
    ),
  ],
  users: [
    TestUser(
      email: 'admin@pub.dev',
      likes: [],
    ),
    TestUser(
      email: 'user@pub.dev',
      likes: [],
    ),
  ],
);

const adminAtPubDevAuthToken = 'admin-at-pub-dot-dev';
const userAtPubDevAuthToken = 'user-at-pub-dot-dev';
const unauthorizedAtPubDevAuthToken = 'unauthorized-at-pub-dot-dev';

final foobarPkgName = 'foobar_pkg';
final foobarPkgKey =
    Key.emptyKey(Partition(null)).append(Package, id: foobarPkgName);

final foobarStableVersion = '0.1.1+5';
final foobarStablePVKey =
    foobarPkgKey.append(PackageVersion, id: foobarStableVersion);
final foobarDevPVKey = foobarPkgKey.append(PackageVersion, id: '0.2.0-dev');

final _hansUser = User()
  ..id = 'hans-at-juergen-dot-com'
  ..email = 'hans@juergen.com'
  ..created = DateTime.utc(2014)
  ..isBlocked = false
  ..isDeleted = false;

Package _createFoobarPackage() {
  return Package()
    ..parentKey = foobarPkgKey.parent
    ..id = foobarPkgName
    ..name = foobarPkgName
    ..created = DateTime.utc(2014)
    ..updated = DateTime.utc(2015)
    ..uploaders = [_hansUser.userId!]
    ..latestPublished = DateTime.utc(2015)
    ..latestVersionKey = foobarStablePVKey
    ..latestPrereleasePublished = DateTime.utc(2015)
    ..latestPrereleaseVersionKey = foobarDevPVKey
    ..lastVersionPublished = DateTime.utc(2015)
    ..likes = 0
    ..isDiscontinued = false
    ..isUnlisted = false
    ..isWithheld = false
    ..assignedTags = [];
}

final foobarPackage = _createFoobarPackage();
final foobarUploaderEmails = [_hansUser.email];

final Package discontinuedPackage = _createFoobarPackage()
  ..isDiscontinued = true
  ..replacedBy = 'helium';

final foobarStablePV = PackageVersion()
  ..parentKey = foobarStablePVKey.parent
  ..id = foobarStableVersion
  ..version = foobarStableVersion
  ..packageKey = foobarPkgKey
  ..created = DateTime.utc(2014)
  ..uploader = _hansUser.userId
  ..libraries = ['foolib.dart']
  ..pubspec = Pubspec.fromYaml(foobarStablePubspec);

final foobarStablePvInfo = PackageVersionInfo()
  ..parentKey = foobarStablePV.parentKey!.parent
  ..initFromKey(foobarStablePV.qualifiedVersionKey)
  ..versionCreated = foobarStablePV.created
  ..updated = foobarStablePV.created
  ..libraries = foobarStablePV.libraries
  ..libraryCount = foobarStablePV.libraries!.length
  ..assets = [
    AssetKind.readme,
    AssetKind.changelog,
    AssetKind.example,
  ];

final foobarDevPvInfo = PackageVersionInfo()
  ..parentKey = foobarDevPV.parentKey!.parent
  ..initFromKey(foobarDevPV.qualifiedVersionKey)
  ..versionCreated = foobarDevPV.created
  ..updated = foobarDevPV.created
  ..libraries = foobarDevPV.libraries
  ..libraryCount = foobarDevPV.libraries!.length
  ..assets = [];

final foobarAssets = {
  AssetKind.readme: PackageVersionAsset.init(
    package: foobarPkgName,
    version: foobarStableVersion,
    kind: AssetKind.readme,
    versionCreated: foobarStablePV.created,
    path: 'README.md',
    textContent: foobarReadmeContent,
  ),
  AssetKind.changelog: PackageVersionAsset.init(
    package: foobarPkgName,
    version: foobarStableVersion,
    kind: AssetKind.changelog,
    versionCreated: foobarStablePV.created,
    path: 'CHANGELOG.md',
    textContent: foobarChangelogContent,
  ),
  AssetKind.example: PackageVersionAsset.init(
    package: foobarPkgName,
    version: foobarStableVersion,
    kind: AssetKind.example,
    versionCreated: foobarStablePV.created,
    path: 'example/lib/main.dart',
    textContent: foobarExampleContent,
  ),
};

final PackageVersion flutterPackageVersion =
    _clonePackageVersion(foobarStablePV)
      ..created = DateTime.utc(2015)
      ..pubspec = Pubspec.fromYaml(foobarStablePubspec +
          '''
flutter:
  plugin:
    class: SomeClass
  ''');

final PackageVersion foobarDevPV = _clonePackageVersion(foobarStablePV)
  ..id = foobarDevPVKey.id
  ..version = foobarDevPVKey.id;

PackageVersion _clonePackageVersion(PackageVersion original) => PackageVersion()
  ..parentKey = original.parentKey
  ..id = original.id
  ..version = original.version
  ..packageKey = original.packageKey
  ..created = original.created
  ..publisherId = original.publisherId
  ..uploader = original.uploader
  ..libraries = original.libraries
  ..pubspec = original.pubspec;

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

final foobarStablePubspec = generatePubspecYaml('foobar_pkg', '0.1.1+5');

String generatePubspecYaml(String name, String version) => '''
name: $name
version: $version
author: Hans Juergen <hans@juergen.com>
homepage: http://hans.juergen.com
description: 'my package description'
environment:
  sdk: '>=2.10.0 <3.0.0'

dependencies:
  gcloud: any
''';

PublisherMember publisherMember(
        String? userId, String publisherId, String role) =>
    PublisherMember()
      ..parentKey =
          Key.emptyKey(Partition(null)).append(Publisher, id: publisherId)
      ..id = userId
      ..userId = userId
      ..created = DateTime(2019, 07, 16)
      ..updated = DateTime(2019, 07, 16)
      ..role = role;
