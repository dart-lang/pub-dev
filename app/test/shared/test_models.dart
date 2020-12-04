// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:pana/models.dart' hide ReportStatus;
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/package/model_properties.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/scorecard/models.dart';

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

final adminAtPubDevAuthToken = 'admin-at-pub-dot-dev';
final userAtPubDevAuthToken = 'user-at-pub-dot-dev';

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

final foobarPkgName = 'foobar_pkg';
final foobarPkgKey =
    Key.emptyKey(Partition(null)).append(Package, id: foobarPkgName);

final foobarStableVersion = '0.1.1+5';
final foobarStablePVKey =
    foobarPkgKey.append(PackageVersion, id: foobarStableVersion);
final foobarDevPVKey = foobarPkgKey.append(PackageVersion, id: '0.2.0-dev');

final moderatedPkgKey =
    Key.emptyKey(Partition(null)).append(ModeratedPackage, id: 'mo_derated');

final hansUser = User()
  ..id = 'hans-at-juergen-dot-com'
  ..email = 'hans@juergen.com'
  ..created = DateTime.utc(2014)
  ..isBlocked = false
  ..isDeleted = false;
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
  ..isBlocked = false
  ..isDeleted = false;
final testUserA = User()
  ..id = 'a-example-com'
  ..email = 'a@example.com'
  ..created = DateTime(2019, 01, 01)
  ..isBlocked = false
  ..isDeleted = false;
final adminUser = User()
  ..id = 'admin-at-pub-dot-dev'
  ..oauthUserId = 'admin-pub-dev'
  ..email = 'admin@pub.dev'
  ..created = DateTime(2019, 08, 01)
  ..isBlocked = false
  ..isDeleted = false;
final adminOAuthUserID = OAuthUserID()
  ..id = 'admin-pub-dev'
  ..userIdKey =
      Key.emptyKey(Partition(null)).append(User, id: 'admin-at-pub-dot-dev');

Package _createFoobarPackage() {
  return Package()
    ..parentKey = foobarPkgKey.parent
    ..id = foobarPkgName
    ..name = foobarPkgName
    ..created = DateTime.utc(2014)
    ..updated = DateTime.utc(2015)
    ..uploaders = [hansUser.userId]
    ..latestVersionKey = foobarStablePVKey
    ..latestPrereleaseVersionKey = foobarDevPVKey
    ..likes = 0
    ..isDiscontinued = false
    ..isUnlisted = false
    ..isWithheld = false
    ..assignedTags = [];
}

final foobarPackage = _createFoobarPackage();
final foobarUploaderEmails = [hansUser.email];

final Package discontinuedPackage = _createFoobarPackage()
  ..isDiscontinued = true
  ..replacedBy = 'helium';

final foobarStablePV = PackageVersion()
  ..parentKey = foobarStablePVKey.parent
  ..id = foobarStableVersion
  ..version = foobarStableVersion
  ..packageKey = foobarPkgKey
  ..created = DateTime.utc(2014)
  ..uploader = hansUser.userId
  ..libraries = ['foolib.dart']
  ..pubspec = Pubspec.fromYaml(foobarStablePubspec);

final foobarStablePvInfo = PackageVersionInfo()
  ..parentKey = foobarStablePV.parentKey.parent
  ..initFromKey(foobarStablePV.qualifiedVersionKey)
  ..versionCreated = foobarStablePV.created
  ..updated = foobarStablePV.created
  ..libraries = foobarStablePV.libraries
  ..libraryCount = foobarStablePV.libraries.length
  ..assets = [
    AssetKind.readme,
    AssetKind.changelog,
    AssetKind.example,
  ];

final foobarDevPvInfo = PackageVersionInfo()
  ..parentKey = foobarDevPV.parentKey.parent
  ..initFromKey(foobarDevPV.qualifiedVersionKey)
  ..versionCreated = foobarDevPV.created
  ..updated = foobarDevPV.created
  ..libraries = foobarDevPV.libraries
  ..libraryCount = foobarDevPV.libraries.length
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
}

PackageVersionPubspec _pvPubspec(PackageVersion pv) {
  return PackageVersionPubspec()
    ..parentKey = pv.parentKey.parent
    ..initFromKey(pv.qualifiedVersionKey)
    ..versionCreated = pv.created
    ..updated = pv.created
    ..pubspec = pv.pubspec;
}

PackageVersionInfo _pvToInfo(PackageVersion pv, {List<String> assets}) {
  return PackageVersionInfo()
    ..parentKey = pv.parentKey.parent
    ..initFromKey(pv.qualifiedVersionKey)
    ..versionCreated = pv.created
    ..updated = pv.created
    ..libraries = pv.libraries
    ..libraryCount = pv.libraries.length
    ..assets = assets ??
        <String>[
          AssetKind.readme,
          AssetKind.changelog,
          AssetKind.example,
        ];
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
  final PackageVersion latestStableVersion;
  final List<PackageVersionInfo> infos;
  final List<PackageVersionAsset> assets;

  PkgBundle._(
    this.package,
    this.versions,
    this.latestStableVersion,
    this.infos,
    this.assets,
  ) {
    assert(package.latestVersionKey != null);
    assert(package.latestPrereleaseVersionKey != null);
  }

  factory PkgBundle(
    Package package,
    List<PackageVersion> versions,
    List<PackageVersionInfo> infos,
    List<PackageVersionAsset> assets,
  ) {
    versions.sort((a, b) => a.created.compareTo(b.created));
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
    package.latestPrereleaseVersionKey ??=
        latestDevVersion?.key ?? package.latestVersionKey;

    return PkgBundle._(
      package,
      versions,
      latestStableVersion,
      infos,
      assets,
    );
  }

  String get packageName => package.name;
  Key get packageKey => package.key;
  String get latestVersion => package.latestVersion;
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
    ..likes = 0
    ..isDiscontinued = false
    ..isUnlisted = false
    ..isWithheld = false
    ..assignedTags = []
    ..publisherId = publisherId
    ..uploaders =
        publisherId != null ? [] : uploaders.map((u) => u.userId).toList();

  DateTime ts = DateTime(2014);
  final versions = <PackageVersion>[];
  final infos = <PackageVersionInfo>[];
  final assets = <PackageVersionAsset>[];
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
      ..libraries = ['lib/$name.dart']
      ..uploader = uploader.userId
      ..publisherId = publisherId;
    versions.add(version);
    infos.add(_pvToInfo(version, assets: [
      if (readme != null) AssetKind.readme,
      if (changelog != null) AssetKind.changelog,
      if (example != null) AssetKind.example,
    ]));
    if (readme != null) {
      assets.add(PackageVersionAsset.init(
        package: name,
        version: versionValue,
        kind: AssetKind.readme,
        versionCreated: ts,
        path: 'README.md',
        textContent: readme,
      ));
    }
    if (changelog != null) {
      assets.add(PackageVersionAsset.init(
        package: name,
        version: versionValue,
        kind: AssetKind.changelog,
        versionCreated: ts,
        path: 'CHANGELOG.md',
        textContent: changelog,
      ));
    }
    if (example != null) {
      assets.add(PackageVersionAsset.init(
        package: name,
        version: versionValue,
        kind: AssetKind.example,
        versionCreated: ts,
        path: 'example/example.dart',
        textContent: example,
      ));
    }
  }

  return PkgBundle(package, versions, infos, assets);
}

PanaReport generatePanaReport({List<String> derivedTags}) {
  return PanaReport(
    timestamp: DateTime.now(),
    panaRuntimeInfo: PanaRuntimeInfo(),
    reportStatus: ReportStatus.success,
    derivedTags: derivedTags ?? <String>[],
    pkgDependencies: null,
    allDependencies: null,
    licenseFile: null,
    flags: null,
    report: Report(sections: <ReportSection>[]),
  );
}
