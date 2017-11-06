// Copyright(c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library test_util;

import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';

Int64 make64(lo, [hi = null]) {
  if (hi == null) hi = lo < 0 ? -1 : 0;
  return new Int64.fromInts(hi, lo);
}

expect64(lo, [hi = null]) {
  final Int64 expected = make64(lo, hi);
  return predicate((Int64 actual) => actual == expected);
}
