// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:identity_codec/identity_codec.dart';

void main() {
  const codec = const IdentityCodec();
  test('map', () {
    final source = {'a': 'b'};
    expect(identical(codec.encode(source), source), isTrue);
    expect(identical(codec.decode(source), source), isTrue);
  });
}
