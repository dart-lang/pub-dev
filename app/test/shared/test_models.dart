// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/package/model_properties.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/scorecard/models.dart';

// regular package
final hydrogen = generateBundle('hydrogen', generateVersions(13, increment: 9));

// Flutter plugin
final helium = generateBundle(
  'helium',
  generateVersions(16, increment: 7),
  pubspecExtraContent: '''
flutter:
  plugin:
    class: SomeClass
''',
);

// Regular package with dev releases.
final lithium = generateBundle(
  'lithium',
  generateVersions(19, increment: 27, devOffset: 5),
  publisherId: exampleComPublisher.publisherId,
);

final Key foobarPkgKey =
    Key.emptyKey(Partition(null)).append(Package, id: 'foobar_pkg');

final Key foobarStablePVKey =
    foobarPkgKey.append(PackageVersion, id: '0.1.1+5');
final Key foobarDevPVKey = foobarPkgKey.append(PackageVersion, id: '0.2.0-dev');

final Key moderatedPkgKey =
    Key.emptyKey(Partition(null)).append(ModeratedPackage, id: 'mo_derated');

final hansUser = User()
  ..id = 'hans-at-juergen-dot-com'
  ..email = 'hans@juergen.com'
  ..created = DateTime.utc(2014)
  ..isDeletedFlag = false;
final hansUserSessionData = UserSessionData(
  userId: hansUser.userId,
  sessionId: 'hans-at-juergen-dot-com--session',
  email: hansUser.email,
  name: 'Hans Juergen',
  imageUrl: 'https://juergen.com/hans.jpg',
  created: hansUser.created,
  expires: DateTime.now().add(Duration(days: 7)),
);
final joeUser = User()
  ..id = 'joe-at-example-dot-com'
  ..email = 'joe@example.com'
  ..created = DateTime(2019, 01, 01)
  ..isDeletedFlag = false;
final testUserA = User()
  ..id = 'a-example-com'
  ..email = 'a@example.com'
  ..created = DateTime(2019, 01, 01)
  ..isDeletedFlag = false;
final adminUser = User()
  ..id = 'admin-at-pub-dot-dev'
  ..oauthUserId = 'admin-pub-dev'
  ..email = 'admin@pub.dev'
  ..created = DateTime(2019, 08, 01)
  ..isDeletedFlag = false;
final adminOAuthUserID = OAuthUserID()
  ..id = 'admin-pub-dev'
  ..userIdKey =
      Key.emptyKey(Partition(null)).append(User, id: 'admin-at-pub-dot-dev');

Package createFoobarPackage({String name, List<User> uploaders}) {
  name ??= foobarPkgKey.id as String;
  uploaders ??= [hansUser];
  return Package()
    ..parentKey = foobarPkgKey.parent
    ..id = name
    ..name = name
    ..created = DateTime.utc(2014)
    ..updated = DateTime.utc(2015)
    ..uploaders = uploaders.map((user) => user.userId).toList()
    ..latestVersionKey = foobarStablePVKey
    ..latestDevVersionKey = foobarDevPVKey
    ..downloads = 0
    ..likes = 0
    ..doNotAdvertise = false
    ..isDiscontinued = false
    ..assignedTags = [];
}

final Package foobarPackage = createFoobarPackage();
final foobarUploaderEmails = [hansUser.email];

final Package discontinuedPackage = createFoobarPackage()
  ..isDiscontinued = true;

final PackageVersion foobarStablePV = PackageVersion()
  ..parentKey = foobarStablePVKey.parent
  ..id = foobarStablePVKey.id
  ..version = foobarStablePVKey.id as String
  ..packageKey = foobarPkgKey
  ..created = DateTime.utc(2014)
  ..uploader = hansUser.userId
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
  ..parentKey = original.parentKey
  ..id = original.id
  ..version = original.version
  ..packageKey = original.packageKey
  ..created = original.created
  ..publisherId = original.publisherId
  ..uploader = original.uploader
  ..libraries = original.libraries
  ..pubspec = original.pubspec
  ..readmeFilename = original.readmeFilename
  ..readmeContent = original.readmeContent
  ..changelogFilename = original.changelogFilename
  ..changelogContent = original.changelogContent
  ..sortOrder = original.sortOrder
  ..downloads = original.downloads;

final moderatedPackage = ModeratedPackage()
  ..parentKey = moderatedPkgKey
  ..id = 'mo_derate'
  ..name = 'mo_derate'
  ..moderated = DateTime.utc(2014)
  ..uploaders = [hansUser.userId]
  ..versions = ['1.0.0'];

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

dependencies:
  gcloud: any
''';

Iterable<Model> pvModels(PackageVersion pv) sync* {
  yield pv;
  yield _pvPubspec(pv);
  yield _pvInfo(pv);
}

PackageVersionPubspec _pvPubspec(PackageVersion pv) {
  return PackageVersionPubspec()
    ..parentKey = pv.parentKey.parent
    ..initFromKey(pv.qualifiedVersionKey)
    ..updated = pv.created
    ..pubspec = pv.pubspec;
}

PackageVersionInfo _pvInfo(PackageVersion pv) {
  return PackageVersionInfo()
    ..parentKey = pv.parentKey.parent
    ..initFromKey(pv.qualifiedVersionKey)
    ..updated = pv.created
    ..libraries = pv.libraries
    ..libraryCount = pv.libraries.length;
}

final exampleComPublisher = publisher('example.com');

Publisher publisher(String domain) => Publisher()
  ..parentKey = Key.emptyKey(Partition(null))
  ..id = domain
  ..description = 'This is us!'
  ..websiteUrl = 'https://$domain/'
  ..contactEmail = 'contact@$domain'
  ..created = DateTime(2019, 07, 15)
  ..updated = DateTime(2019, 07, 16)
  ..isAbandoned = false;

final exampleComHansAdmin =
    publisherMember(hansUser.userId, PublisherMemberRole.admin);

PublisherMember publisherMember(String userId, String role, {Key parentKey}) =>
    PublisherMember()
      ..parentKey = parentKey ?? exampleComPublisher.key
      ..id = userId
      ..userId = userId
      ..created = DateTime(2019, 07, 16)
      ..updated = DateTime(2019, 07, 16)
      ..role = role;

class PkgBundle {
  final Package package;
  final List<PackageVersion> versions;
  final PackageVersion firstVersion;
  final PackageVersion latestStableVersion;
  final PackageVersion latestDevVersion;

  PkgBundle._(this.package, this.versions, this.firstVersion,
      this.latestStableVersion, this.latestDevVersion) {
    assert(package.latestVersionKey != null);
    assert(package.latestDevVersionKey != null);
  }

  factory PkgBundle(Package package, List<PackageVersion> versions) {
    versions.sort((a, b) => a.created.compareTo(b.created));
    final firstVersion = versions.first;
    final latestStableVersion = versions.lastWhere(
      (pv) => !pv.semanticVersion.isPreRelease,
      orElse: () => null,
    );
    final latestDevVersion = versions.lastWhere(
      (pv) => pv.semanticVersion.isPreRelease,
      orElse: () => null,
    );

    package.created ??= versions.first.created;
    package.updated ??= versions.last.created;
    package.latestVersionKey ??=
        latestStableVersion?.key ?? latestDevVersion?.key;
    package.latestDevVersionKey ??=
        latestDevVersion?.key ?? package.latestVersionKey;

    return PkgBundle._(
        package, versions, firstVersion, latestStableVersion, latestDevVersion);
  }
}

Iterable<String> generateVersions(
  int count, {
  String start,
  int devOffset = 0,
  int increment = 1,
  int partThreshold = 10,
}) sync* {
  int devCounter = 0;
  Version version = Version.parse(start ?? '1.0.0');
  for (int i = 0; i < count; i++) {
    yield version.toString();
    final isPre = devOffset != 0 && (i % devOffset == devOffset - 1);
    int major = version.major;
    int minor = version.minor;
    int patch = version.patch + increment;
    if (patch >= partThreshold) {
      minor += patch ~/ partThreshold;
      patch = patch % partThreshold;
    }
    if (minor >= partThreshold) {
      major += minor ~/ partThreshold;
      minor = minor % partThreshold;
    }

    version =
        Version(major, minor, patch, pre: isPre ? 'dev${devCounter++}' : null);
  }
}

PkgBundle generateBundle(
  String name,
  Iterable<String> versionValues, {
  String description,
  String homepage,
  List<User> uploaders,
  String publisherId,
  String sdkConstraint = '>=2.4.0 <3.0.0',
  String pubspecExtraContent,
}) {
  description ??= '$name is a Dart package';
  uploaders ??= <User>[hansUser];
  homepage ??= 'https://example.com/$name';

  final package = Package()
    ..parentKey = Key.emptyKey(Partition(null))
    ..id = name
    ..name = name
    ..downloads = 0
    ..likes = 0
    ..doNotAdvertise = false
    ..isDiscontinued = false
    ..assignedTags = []
    ..publisherId = publisherId
    ..uploaders =
        publisherId != null ? [] : uploaders.map((u) => u.userId).toList();

  DateTime ts = DateTime(2014);
  final versions = <PackageVersion>[];
  for (String versionValue in versionValues) {
    final hash = (name.hashCode + versionValue.hashCode).abs();
    ts = ts.add(Duration(hours: hash % 177, minutes: hash % 60));

    final uploader = uploaders[hash % uploaders.length];

    final pubspec = 'name: $name\n'
        'version: $versionValue\n'
        'description: ${json.encode(description)}\n'
        'author: ${uploader.email}\n'
        'homepage: $homepage\n'
        'environment:\n'
        '  sdk: "$sdkConstraint"\n'
        '${pubspecExtraContent ?? ''}';

    final readme = (hash % 99 == 0) ? null : '# $name\n\n$description\n\n';
    final changelog = (hash % 17 == 0)
        ? null
        : '## $versionValue\n\n'
            '- Bug fix #1${hash % 10}.';
    final String example = (hash % 9 == 0)
        ? null
        : 'import \'package:$name\';\n\n'
            'main() {}';

    final version = PackageVersion()
      ..parentKey = package.key
      ..packageKey = package.key
      ..id = versionValue
      ..version = versionValue
      ..created = ts
      ..pubspec = Pubspec.fromYaml(pubspec)
      ..readmeFilename = readme == null ? null : 'README.md'
      ..readmeContent = readme
      ..changelogFilename = changelog == null ? null : 'CHANGELOG.md'
      ..changelogContent = changelog
      ..exampleFilename = example == null ? null : 'example/example.dart'
      ..exampleContent = example
      ..libraries = ['lib/$name.dart']
      ..downloads = 0
      ..sortOrder = 0
      ..uploader = uploader.userId
      ..publisherId = publisherId;
    versions.add(version);
  }

  return PkgBundle(package, versions);
}

PanaReport generatePanaReport({List<String> derivedTags}) {
  return PanaReport(
      timestamp: DateTime.now(),
      panaRuntimeInfo: PanaRuntimeInfo(),
      reportStatus: ReportStatus.success,
      healthScore: 1.0,
      maintenanceScore: 0.6,
      derivedTags: derivedTags ?? <String>[],
      pkgDependencies: null,
      licenses: null,
      panaSuggestions: null,
      healthSuggestions: null,
      maintenanceSuggestions: null,
      flags: null);
}
