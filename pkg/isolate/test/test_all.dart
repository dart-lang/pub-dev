// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library isolate.test.test_all;

import 'package:test/test.dart';

import 'isolaterunner_test.dart' as isolaterunner;
import 'ports_test.dart' as ports;
import 'registry_test.dart' as registy;

void main() {
  group('IsolateRunner', isolaterunner.main);
  group('ports', ports.main);
  group('registry', registy.main);
}
