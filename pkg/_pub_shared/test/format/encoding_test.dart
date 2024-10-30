// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/format/encoding.dart';
import 'package:test/test.dart';

void main() {
  test('encode/decode success', () {
    final data = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    final encoded = encodeIntsAsLittleEndianBase64String(data);
    expect(encoded, 'AQAAAAIAAAADAAAABAAAAAUAAAAGAAAABwAAAAgAAAAJAAAA');
    expect(decodeIntsFromLittleEndianBase64String(encoded), data);
  });

  test('encode/decode empty', () {
    final data = <int>[];
    final encoded = encodeIntsAsLittleEndianBase64String(data);
    expect(encoded, '');
    expect(decodeIntsFromLittleEndianBase64String(encoded), data);
  });

  test('encode/decode failure with negative integers', () {
    final data = <int>[-1, -2];
    final encoded = encodeIntsAsLittleEndianBase64String(data);
    expect(encoded, '//////7///8=');
    expect(decodeIntsFromLittleEndianBase64String(encoded), isNot(data));
  });
}
