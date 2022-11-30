// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';

import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/tool/test_profile/models.dart';

final defaultTestProfile = TestProfile(
  defaultUser: 'admin@pub.dev',
  packages: [
    TestPackage(
      name: 'oxygen',
      versions: [
        TestVersion(version: '1.0.0'),
        TestVersion(version: '1.2.0'),
        TestVersion(version: '2.0.0-dev'),
      ],
    ),
    TestPackage(
      name: 'neon',
      versions: [TestVersion(version: '1.0.0')],
      publisher: 'example.com',
    ),
    TestPackage(
      name: 'flutter_titanium',
      versions: [
        TestVersion(version: '1.9.0'),
        TestVersion(version: '1.10.0'),
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

String get adminAtPubDevAuthToken =>
    createFakeAuthTokenForEmail('admin@pub.dev');
String get userAtPubDevAuthToken => createFakeAuthTokenForEmail('user@pub.dev');
String get unauthorizedAtPubDevAuthToken =>
    createFakeAuthTokenForEmail('unauthorized@pub.dev');
String get adminClientToken => createFakeAuthTokenForEmail('admin@pub.dev',
    audience: 'fake-client-audience');
String get siteAdminToken =>
    createFakeServiceAccountToken(email: 'admin@pub.dev');
String get userClientToken => createFakeAuthTokenForEmail('user@pub.dev',
    audience: 'fake-client-audience');

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
