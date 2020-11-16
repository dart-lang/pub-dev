// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/tool/test_profile/import_source.dart';
import 'package:pub_dev/tool/test_profile/importer.dart';
import 'package:pub_dev/tool/test_profile/models.dart';

import '../../package/backend_test_utils.dart';
import '../../shared/test_services.dart';

void main() {
  group('pub.dev importer tests', () {
    testWithServices(
      'retry',
      () async {
        final profile = TestProfile(
          defaultUser: 'dev@example.com',
          packages: [
            TestPackage(
              name: 'retry',
              versions: ['2.0.0'],
              publisher: 'example.com',
            )
          ],
        );

        await withTempDirectory((dir) async {
          await importProfile(
            profile: profile,
            source: ImportSource.fromPubDev(archiveCachePath: dir),
          );
        });

        final users = await dbService.query<User>().run().toList();
        expect(users.single.userId, '0378792c-a778-8b8d-b689-64e531ae52bc');
        expect(users.single.oauthUserId, 'dev-at-example-dot-com');

        final packages = await dbService.query<Package>().run().toList();
        expect(packages.single.name, 'retry');
        expect(packages.single.publisherId, 'example.com');
        expect(packages.single.latestVersion, '2.0.0');

        final versions = await dbService.query<PackageVersion>().run().toList();
        expect(versions.single.version, '2.0.0');
        expect(
            versions.single.uploader, '0378792c-a778-8b8d-b689-64e531ae52bc');

        final publishers = await dbService.query<Publisher>().run().toList();
        expect(publishers.single.publisherId, 'example.com');

        final members = await dbService.query<PublisherMember>().run().toList();
        expect(members.single.userId, '0378792c-a778-8b8d-b689-64e531ae52bc');
        expect(members.single.role, 'admin');
      },
      omitData: true,
    );

    testWithServices(
      'http',
      () async {
        final profile = TestProfile(
          packages: [
            TestPackage(name: 'http', uploaders: ['dev@example.com']),
          ],
        );

        await withTempDirectory((dir) async {
          await importProfile(
            profile: profile,
            source: ImportSource.fromPubDev(archiveCachePath: dir),
          );
        });

        final users = await dbService.query<User>().run().toList();
        expect(users.single.userId, '0378792c-a778-8b8d-b689-64e531ae52bc');
        expect(users.single.oauthUserId, 'dev-at-example-dot-com');

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
      omitData: true,
    );
  });

  group('semi-random importer tests', () {
    testWithServices(
      'sample',
      () async {
        final profile = TestProfile(
          defaultUser: 'dev@example.com',
          packages: [TestPackage(name: 'sample')],
        );

        await importProfile(
          profile: profile,
          source: ImportSource.semiRandom(),
        );

        final users = await dbService.query<User>().run().toList();
        expect(users.single.userId, '0378792c-a778-8b8d-b689-64e531ae52bc');
        expect(users.single.oauthUserId, 'dev-at-example-dot-com');

        final packages = await dbService.query<Package>().run().toList();
        expect(packages.single.name, 'sample');
        expect(packages.single.publisherId, isNull);
        expect(packages.single.latestVersion, '1.2.7');

        final versions = await dbService.query<PackageVersion>().run().toList();
        expect(versions.single.version, '1.2.7');
        expect(
            versions.single.uploader, '0378792c-a778-8b8d-b689-64e531ae52bc');

        final publishers = await dbService.query<Publisher>().run().toList();
        expect(publishers, isEmpty);

        final members = await dbService.query<PublisherMember>().run().toList();
        expect(members, isEmpty);
      },
      omitData: true,
    );
  });
}
