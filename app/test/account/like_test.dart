// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  setUpAll(() => updateLocalBuiltFilesIfNeeded());

  group('/api/account/likes', () {
    final pkg1 = 'oxygen';
    final pkg2 = 'neon';

    testWithProfile('Like package', fn: () async {
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final rs = await client.getLikePackage(pkg1);
      expect(rs.package, pkg1);
      expect(rs.liked, false);

      final rs2 = await client.likePackage(pkg1);
      expect(rs2.package, pkg1);
      expect(rs2.liked, true);

      final rs3 = await client.getLikePackage(pkg1);
      expect(rs3.package, pkg1);
      expect(rs3.liked, true);
    });

    testWithProfile('Like already liked package', fn: () async {
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final rs = await client.likePackage(pkg1);
      expect(rs.package, pkg1);
      expect(rs.liked, true);

      final rs2 = await client.likePackage(pkg1);
      expect(rs2.package, pkg1);
      expect(rs2.liked, true);

      final rs3 = await client.getLikePackage(pkg1);
      expect(rs3.package, pkg1);
      expect(rs3.liked, true);
    });

    testWithProfile('Like non-existing package', fn: () async {
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      await expectApiException(client.likePackage('non_existing_package'),
          status: 404);
    });

    testWithProfile('List package likes', fn: () async {
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final rs = await client.listPackageLikes();
      expect(rs.likedPackages!.isEmpty, true);

      final rs2 = await client.likePackage(pkg1);
      expect(rs2.package, pkg1);
      expect(rs2.liked, true);

      final rs3 = await client.likePackage(pkg2);
      expect(rs3.package, pkg2);
      expect(rs3.liked, true);

      final rs4 = await client.listPackageLikes();
      expect(rs4.likedPackages!.length, 2);
      expect(rs4.likedPackages!.map((e) => e.package), contains(pkg1));
      expect(rs4.likedPackages!.map((e) => e.package), contains(pkg2));
      expect(rs4.likedPackages![0].liked, true);
      expect(rs4.likedPackages![1].liked, true);
    });

    testWithProfile('Unlike package', fn: () async {
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final rs = await client.listPackageLikes();
      expect(rs.likedPackages!.isEmpty, true);

      final rs2 = await client.likePackage(pkg1);
      expect(rs2.package, pkg1);
      expect(rs2.liked, true);

      final rs3 = await client.likePackage(pkg2);
      expect(rs3.package, pkg2);
      expect(rs3.liked, true);

      final rs4 = await client.listPackageLikes();
      expect(rs4.likedPackages!.length, 2);
      expect(rs4.likedPackages![0].liked, true);
      expect(rs4.likedPackages![1].liked, true);

      await client.unlikePackage(pkg1);

      final rs5 = await client.getLikePackage(pkg1);
      expect(rs5.package, pkg1);
      expect(rs5.liked, false);

      final rs6 = await client.listPackageLikes();
      expect(rs6.likedPackages!.length, 1);
      expect(rs6.likedPackages![0].package, pkg2);
    });

    testWithProfile('Unlike non-existing package', fn: () async {
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      await expectApiException(client.unlikePackage('non_existing_package'),
          status: 404);
    });

    testWithProfile('Two users don\'t affect each other\'s package likes.',
        fn: () async {
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final client2 =
          await createFakeAuthPubApiClient(email: adminAtPubDevEmail);
      final rs = await client.listPackageLikes();
      expect(rs.likedPackages!.isEmpty, true);

      final rs1 = await client2.listPackageLikes();
      expect(rs1.likedPackages!.isEmpty, true);

      final rs2 = await client.likePackage(pkg1);
      expect(rs2.package, pkg1);
      expect(rs2.liked, true);

      final rs3 = await client2.listPackageLikes();
      expect(rs3.likedPackages!.isEmpty, true);
    });

    testWithProfile('Package likes property is incremented/decremented.',
        fn: () async {
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      final client2 =
          await createFakeAuthPubApiClient(email: adminAtPubDevEmail);
      final rs = await client.getPackageLikes(pkg1);
      expect(rs.likes, 0);
      final rs2 = await client2.getPackageLikes(pkg1);
      expect(rs2.likes, 0);

      await client.likePackage(pkg1);

      final rs3 = await client.getPackageLikes(pkg1);
      expect(rs3.likes, 1);
      final rs4 = await client2.getPackageLikes(pkg1);
      expect(rs4.likes, 1);

      await client2.likePackage(pkg1);

      final rs5 = await client.getPackageLikes(pkg1);
      expect(rs5.likes, 2);
      final rs6 = await client2.getPackageLikes(pkg1);
      expect(rs6.likes, 2);

      await client.unlikePackage(pkg1);

      final rs7 = await client.getPackageLikes(pkg1);
      expect(rs7.likes, 1);
      final rs8 = await client2.getPackageLikes(pkg1);
      expect(rs8.likes, 1);

      /// Unliking already unliked package doesn't cause decrement
      await client.unlikePackage(pkg1);

      final rs9 = await client.getPackageLikes(pkg1);
      expect(rs9.likes, 1);
      final rs10 = await client2.getPackageLikes(pkg1);
      expect(rs10.likes, 1);

      await client2.unlikePackage(pkg1);

      final rs11 = await client.getPackageLikes(pkg1);
      expect(rs11.likes, 0);
      final rs12 = await client2.getPackageLikes(pkg1);
      expect(rs12.likes, 0);
    });

    testWithProfile('Get number of likes for non-existing package.',
        fn: () async {
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      await expectApiException(client.getPackageLikes('non_existing_package'),
          status: 404);
    });

    testWithProfile(
        'Get number of likes for client without authorization header.',
        fn: () async {
      final client = createPubApiClient();
      final rs = await client.getPackageLikes(pkg1);
      expect(rs.likes, 0);

      final authenticatedClient =
          await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      await authenticatedClient.likePackage(pkg1);

      final rs1 = await client.getPackageLikes(pkg1);
      expect(rs1.likes, 1);
    });
  });
}
