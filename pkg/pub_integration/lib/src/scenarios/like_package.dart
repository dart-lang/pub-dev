// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_integration/src/test_scenario.dart';

final likePackageScenario = TestScenario('like-package', (ctx) async {
  // Clean up by unliking initially, this should always be safe.
  await ctx.userA.api.unlikePackage(ctx.testPackage);

  // Try to like the package
  await ctx.userA.api.likePackage(ctx.testPackage);

  // TODO: grep html in the browser to check if the liked state is updated!

  // Try to unlike the package
  await ctx.userA.api.unlikePackage(ctx.testPackage);
});
