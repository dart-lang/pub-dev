// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/format/encoding.dart';
import 'package:test/test.dart';

void main() {
  test('encode/decode success', () {
    final data = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    final encoded = encodeIntsAsBigEndianBase64String(data);
    expect(encoded, 'AAAAAQAAAAIAAAADAAAABAAAAAUAAAAGAAAABwAAAAgAAAAJ');
    expect(decodeIntsFromBigEndianBase64String(encoded), data);
  });

  test('encode/decode empty', () {
    final data = <int>[];
    final encoded = encodeIntsAsBigEndianBase64String(data);
    expect(encoded, '');
    expect(decodeIntsFromBigEndianBase64String(encoded), data);
  });

  test('encode/decode failure with negative integers', () {
    final data = <int>[-1, -2];
    final encoded = encodeIntsAsBigEndianBase64String(data);
    expect(encoded, '//////////4=');
    expect(decodeIntsFromBigEndianBase64String(encoded), isNot(data));
  });
}
