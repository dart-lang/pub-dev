// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('/api/account/likes', () {
    testWithServices('Like package', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = await client.getLikePackage(hydrogen.package.name);
      expect(rs.package, hydrogen.package.name);
      expect(rs.liked, false);

      final rs2 = await client.likePackage(hydrogen.package.name);
      expect(rs2.package, hydrogen.package.name);
      expect(rs2.liked, true);

      final rs3 = await client.getLikePackage(hydrogen.package.name);
      expect(rs3.package, hydrogen.package.name);
      expect(rs3.liked, true);
    });

    testWithServices('Like already liked package', () async {
      final client = createPubApiClient(authToken: hansUser.userId);

      final rs = await client.likePackage(hydrogen.package.name);
      expect(rs.package, hydrogen.package.name);
      expect(rs.liked, true);

      final rs2 = await client.likePackage(hydrogen.package.name);
      expect(rs2.package, hydrogen.package.name);
      expect(rs2.liked, true);

      final rs3 = await client.getLikePackage(hydrogen.package.name);
      expect(rs3.package, hydrogen.package.name);
      expect(rs3.liked, true);
    });

    testWithServices('Like non-existing package', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      await expectApiException(client.likePackage('non-existing_package'),
          status: 404);
    });

    testWithServices('List package likes', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = await client.listPackageLikes();
      expect(rs.likedPackages.isEmpty, true);

      final rs2 = await client.likePackage(hydrogen.package.name);
      expect(rs2.package, hydrogen.package.name);
      expect(rs2.liked, true);

      final rs3 = await client.likePackage(helium.package.name);
      expect(rs3.package, helium.package.name);
      expect(rs3.liked, true);

      final rs4 = await client.listPackageLikes();
      expect(rs4.likedPackages.length, 2);
      expect(rs4.likedPackages.map((e) => e.package),
          contains(hydrogen.package.name));
      expect(rs4.likedPackages.map((e) => e.package),
          contains(helium.package.name));
      expect(rs4.likedPackages[0].liked, true);
      expect(rs4.likedPackages[1].liked, true);
    });

    testWithServices('Unlike package', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = await client.listPackageLikes();
      expect(rs.likedPackages.isEmpty, true);

      final rs2 = await client.likePackage(hydrogen.package.name);
      expect(rs2.package, hydrogen.package.name);
      expect(rs2.liked, true);

      final rs3 = await client.likePackage(helium.package.name);
      expect(rs3.package, helium.package.name);
      expect(rs3.liked, true);

      final rs4 = await client.listPackageLikes();
      expect(rs4.likedPackages.length, 2);
      expect(rs4.likedPackages[0].liked, true);
      expect(rs4.likedPackages[1].liked, true);

      await client.unlikePackage(hydrogen.package.name);

      final rs5 = await client.getLikePackage(hydrogen.package.name);
      expect(rs5.package, hydrogen.package.name);
      expect(rs5.liked, false);

      final rs6 = await client.listPackageLikes();
      expect(rs6.likedPackages.length, 1);
      expect(rs6.likedPackages[0].package, helium.package.name);
    });

    testWithServices('Unlike non-existing package', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      await expectApiException(client.unlikePackage('non-existing_package'),
          status: 404);
    });

    testWithServices('Two users don\'t affect each other\'s package likes.',
        () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final client2 = createPubApiClient(authToken: joeUser.userId);

      final rs = await client.listPackageLikes();
      expect(rs.likedPackages.isEmpty, true);

      final rs1 = await client2.listPackageLikes();
      expect(rs1.likedPackages.isEmpty, true);

      final rs2 = await client.likePackage(hydrogen.package.name);
      expect(rs2.package, hydrogen.package.name);
      expect(rs2.liked, true);

      final rs3 = await client2.listPackageLikes();
      expect(rs3.likedPackages.isEmpty, true);
    });

    testWithServices('Package likes property is incremented/decremented.',
        () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final client2 = createPubApiClient(authToken: joeUser.userId);

      final rs = await client.getPackageLikes(hydrogen.package.name);
      expect(rs.likes, 0);
      final rs2 = await client2.getPackageLikes(hydrogen.package.name);
      expect(rs2.likes, 0);

      await client.likePackage(hydrogen.package.name);

      final rs3 = await client.getPackageLikes(hydrogen.package.name);
      expect(rs3.likes, 1);
      final rs4 = await client2.getPackageLikes(hydrogen.package.name);
      expect(rs4.likes, 1);

      await client2.likePackage(hydrogen.package.name);

      final rs5 = await client.getPackageLikes(hydrogen.package.name);
      expect(rs5.likes, 2);
      final rs6 = await client2.getPackageLikes(hydrogen.package.name);
      expect(rs6.likes, 2);

      await client.unlikePackage(hydrogen.package.name);

      final rs7 = await client.getPackageLikes(hydrogen.package.name);
      expect(rs7.likes, 1);
      final rs8 = await client2.getPackageLikes(hydrogen.package.name);
      expect(rs8.likes, 1);

      /// Unliking already unliked package doesn't cause decrement
      await client.unlikePackage(hydrogen.package.name);

      final rs9 = await client.getPackageLikes(hydrogen.package.name);
      expect(rs9.likes, 1);
      final rs10 = await client2.getPackageLikes(hydrogen.package.name);
      expect(rs10.likes, 1);

      await client2.unlikePackage(hydrogen.package.name);

      final rs11 = await client.getPackageLikes(hydrogen.package.name);
      expect(rs11.likes, 0);
      final rs12 = await client2.getPackageLikes(hydrogen.package.name);
      expect(rs12.likes, 0);
    });

    testWithServices('Get number of likes for non-existing package.', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      await expectApiException(client.getPackageLikes('non-existing_package'),
          status: 404);
    });

    testWithServices(
        'Get number of likes for client without authorization header.',
        () async {
      final client = createPubApiClient();
      final rs = await client.getPackageLikes(hydrogen.package.name);
      expect(rs.likes, 0);

      final authenticatedClient =
          createPubApiClient(authToken: hansUser.userId);
      await authenticatedClient.likePackage(hydrogen.package.name);

      final rs1 = await client.getPackageLikes(hydrogen.package.name);
      expect(rs1.likes, 1);
    });
  });
}
