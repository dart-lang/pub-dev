// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('/api/account/likes', () {
    testWithServices('Like package', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = await client.getLikePackage('hydrogen');
      expect(rs.package, 'hydrogen');
      expect(rs.liked, false);

      final rs2 = await client.likePackage('hydrogen');
      expect(rs2.package, 'hydrogen');
      expect(rs2.liked, true);

      final rs3 = await client.getLikePackage('hydrogen');
      expect(rs3.package, 'hydrogen');
      expect(rs3.liked, true);

      final rs4 = await client.getLikePackage('hydrogen');
      expect(rs4.package, 'hydrogen');
      expect(rs4.liked, true);
    });

    testWithServices('List package likes', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = await client.getLikes();
      expect(rs.likedPackages.isEmpty, true);

      final rs2 = await client.likePackage('hydrogen');
      expect(rs2.package, 'hydrogen');
      expect(rs2.liked, true);

      final rs3 = await client.likePackage('helium');
      expect(rs3.package, 'helium');
      expect(rs3.liked, true);

      final rs4 = await client.getLikes();
      expect(rs4.likedPackages.length, 2);
      expect(rs4.likedPackages[0].liked, true);
      expect(rs4.likedPackages[1].liked, true);
    });

    testWithServices('Delete package like', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = await client.getLikes();
      expect(rs.likedPackages.isEmpty, true);

      final rs2 = await client.likePackage('hydrogen');
      expect(rs2.package, 'hydrogen');
      expect(rs2.liked, true);

      final rs3 = await client.likePackage('helium');
      expect(rs3.package, 'helium');
      expect(rs3.liked, true);

      final rs4 = await client.getLikes();
      expect(rs4.likedPackages.length, 2);
      expect(rs4.likedPackages[0].liked, true);
      expect(rs4.likedPackages[1].liked, true);

      await client.accountDeletePackageLike('hydrogen');

      final rs5 = await client.getLikePackage('hydrogen');
      expect(rs5.package, 'hydrogen');
      expect(rs5.liked, false);

      final rs6 = await client.getLikes();
      expect(rs6.likedPackages.length, 1);
      expect(rs6.likedPackages[0].package, 'helium');
    });

    testWithServices('Two users don\'t affect each other\'s package likes.',
        () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final client2 = createPubApiClient(authToken: joeUser.userId);

      final rs = await client.getLikes();
      expect(rs.likedPackages.isEmpty, true);

      final rs1 = await client2.getLikes();
      expect(rs1.likedPackages.isEmpty, true);

      final rs2 = await client.likePackage('hydrogen');
      expect(rs2.package, 'hydrogen');
      expect(rs2.liked, true);

      final rs3 = await client2.getLikes();
      expect(rs1.likedPackages.isEmpty, true);
    });
  });
}
