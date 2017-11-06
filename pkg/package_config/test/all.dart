// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:test/test.dart";

import "discovery_analysis_test.dart" as discovery_analysis;
import "discovery_test.dart" as discovery;
import "parse_test.dart" as parse;
import "parse_write_test.dart" as parse_write;

main() {
  group("parse:", parse.main);
  group("discovery:", discovery.main);
  group("discovery-analysis:", discovery_analysis.main);
  group("parse/write:", parse_write.main);
}
