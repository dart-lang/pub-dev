// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:pub_dev/account/like_backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/tool/test_profile/import_source.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('pub.dev importer tests', () {
    testWithProfile(
      'retry',
      testProfile: TestProfile(
        defaultUser: 'dev@example.com',
        packages: [
          TestPackage(
            name: 'retry',
            versions: [TestVersion(version: '3.1.0')],
            publisher: 'example.com',
          )
        ],
      ),
      importSource: ImportSource.fromPubDev(),
      fn: () async {
        final users = await dbService.query<User>().run().toList();
        expect(users.single.userId, hasLength(36));
        expect(users.single.oauthUserId, 'dev-example-com');

        final packages = await dbService.query<Package>().run().toList();
        expect(packages.single.name, 'retry');
        expect(packages.single.publisherId, 'example.com');
        expect(packages.single.latestVersion, '3.1.0');

        final versions = await dbService.query<PackageVersion>().run().toList();
        expect(versions.single.version, '3.1.0');
        expect(versions.single.uploader, users.single.userId);

        final publishers = await dbService.query<Publisher>().run().toList();
        expect(publishers.single.publisherId, 'example.com');

        final members = await dbService.query<PublisherMember>().run().toList();
        expect(members.single.userId, users.single.userId);
        expect(members.single.role, 'admin');
      },
    );

    testWithProfile(
      'http',
      testProfile: TestProfile(
        packages: [
          TestPackage(name: 'http', uploaders: ['dev@example.com']),
        ],
      ),
      importSource: ImportSource.fromPubDev(),
      fn: () async {
        final users = await dbService.query<User>().run().toList();
        expect(users.single.userId, hasLength(36));
        expect(users.single.oauthUserId, 'dev-example-com');

        final packages = await dbService.query<Package>().run().toList();
        final packageNames = packages.map((p) => p.name).toSet();
        expect(packageNames, contains('http'));
        expect(packageNames, contains('http_parser'));
        expect(packageNames, contains('path'));

        final publishers = await dbService.query<Publisher>().run().toList();
        expect(publishers, isEmpty);

        final members = await dbService.query<PublisherMember>().run().toList();
        expect(members, isEmpty);
      },
    );
  });

  group('semi-random importer tests', () {
    testWithProfile(
      'sample',
      testProfile: TestProfile(
        defaultUser: 'dev@example.com',
        packages: [TestPackage(name: 'sample')],
      ),
      fn: () async {
        final users = await dbService.query<User>().run().toList();
        expect(users.single.userId, hasLength(36));
        expect(users.single.oauthUserId, 'dev-example-com');

        final packages = await dbService.query<Package>().run().toList();
        expect(packages.single.name, 'sample');
        expect(packages.single.publisherId, isNull);
        expect(packages.single.latestVersion, '1.2.7');

        final versions = await dbService.query<PackageVersion>().run().toList();
        expect(versions.single.version, '1.2.7');
        expect(versions.single.uploader, users.single.userId);

        final publishers = await dbService.query<Publisher>().run().toList();
        expect(publishers, isEmpty);

        final members = await dbService.query<PublisherMember>().run().toList();
        expect(members, isEmpty);
      },
    );

    testWithProfile(
      'fill in likes',
      testProfile: TestProfile(
        packages: [
          TestPackage(
            name: 'sample',
            likeCount: 10,
          ),
        ],
        users: [
          TestUser(
            email: 'admin@pub.dev',
            likes: ['sample'],
          ),
        ],
        defaultUser: 'admin@pub.dev',
      ),
      fn: () async {
        // Has 10 likes.
        final p = await packageBackend.lookupPackage('sample');
        expect(p!.likes, 10);

        // Has 10 users.
        final users = await dbService.query<User>().run().toList();
        expect(users, hasLength(10));

        // All of the is liking the package.
        for (final user in users) {
          final status =
              await likeBackend.getPackageLikeStatus(user.userId, 'sample');
          expect(status, isNotNull);
        }
      },
    );
  });
}
