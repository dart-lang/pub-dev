// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_integration/src/test_scenario.dart';

import 'script/public_pages.dart';
import 'script/publishing.dart';

export 'package:_pub_shared/pubapi.dart';
export 'package:pub_integration/src/fake_test_user.dart'
    show createHttpClientWithHeaders;
export 'package:pub_integration/src/test_scenario.dart';

/// Runs the integration tests on the [pubHostedUrl].
Future verifyPub({
  required String pubHostedUrl,
  required TestUser adminUser,
  required TestUser invitedUser,
  bool expectLiveSite = true,
}) async {
  final pubToolScript = PublishingScript(
    pubHostedUrl,
    expectLiveSite,
    adminUser: adminUser,
    invitedUser: invitedUser,
  );
  await pubToolScript.verify();

  final publicPagesScript = PublicPagesScript(
    pubHostedUrl,
    expectLiveSite: expectLiveSite,
  );
  await publicPagesScript.verify();
}
