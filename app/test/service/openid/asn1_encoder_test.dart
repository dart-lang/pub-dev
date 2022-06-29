// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/service/openid/asn1_encoder.dart';
import 'package:test/test.dart';

void main() {
  group('length', () {
    test('zero', () {
      expect(encodeLength(0), [0]);
    });

    test('small', () {
      expect(encodeLength(3), [3]);
      expect(encodeLength(127), [127]);
    });

    test('larger', () {
      expect(encodeLength(128), [0x81, 0x80]);
      expect(encodeLength(255), [0x81, 0xff]);
      expect(encodeLength(256), [0x82, 0x01, 0x00]);
      expect(encodeLength(4999), [0x82, 0x13, 0x87]);
    });
  });

  group('integer from bytes', () {
    test('encode small number', () {
      expect(
        encodeIntegerFromBytes([0x11, 0x22, 0x33]),
        [0x02, 0x03, 0x11, 0x22, 0x33],
      );
    });

    test('padding', () {
      expect(
        encodeIntegerFromBytes([0x8f]),
        [0x02, 0x02, 0x00, 0x8f],
      );
    });
  });

  group('sequence', () {
    test('small sequence', () {
      expect(
          encodeSequence([
            encodeIntegerFromBytes([0x11]),
            encodeIntegerFromBytes([0x22]),
            encodeIntegerFromBytes([0x33]),
          ]),
          <int>[
            0x30, // sequence
            0x09, // length
            0x02, // 0x11
            0x01,
            0x11,
            0x02, // 0x22
            0x01,
            0x22,
            0x02, // 0x33
            0x01,
            0x33,
          ]);
    });
  });

  group('bit string', () {
    test('bits', () {
      expect(
        encodeBitString([0x11, 0x12]),
        [0x03, 0x03, 0x00, 0x11, 0x12],
      );
    });
  });
}
