// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:crypto/crypto.dart';
import 'package:test/test.dart';

/// Asserts that an HMAC using [hash] returns [mac] for [input] and [key].
void expectHmacEquals(Hash hash, List<int> input, List<int> key, String mac) {
  var hmac = new Hmac(hash, key);
  expect(hmac.convert(input).toString(), startsWith(mac));
}
