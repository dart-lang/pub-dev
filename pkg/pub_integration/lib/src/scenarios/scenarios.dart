// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_integration/src/scenarios/like_package.dart';
import 'package:pub_integration/src/test_scenario.dart' show TestScenario;

/// List of all [TestScenario]'s that can be used for integration and deployment
/// testing.
final scenarios = <TestScenario>[
  likePackageScenario,
];
