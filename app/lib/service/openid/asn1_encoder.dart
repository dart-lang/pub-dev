// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// ASN.1 encoder utilities.
///
/// Some pointers and useful references:
/// - https://pub.dev/packages/asn1lib
/// - https://letsencrypt.org/docs/a-warm-welcome-to-asn1-and-der/
/// - https://lapo.it/asn1js/

import 'package:meta/meta.dart';

/// Encodes the [length] as single-byte or multi-byte value.
@visibleForTesting
List<int> encodeLength(int length) {
  if (length <= 127) {
    return [length];
  } else {
    final bytesReversed = <int>[];
    while (length > 0) {
      bytesReversed.add(length & 0xff);
      length = length >> 8;
    }
    return <int>[
      0x80 + bytesReversed.length,
      ...bytesReversed.reversed,
    ];
  }
}

/// Encodes the [bytes] as integer, using the big-endian enconding.
@visibleForTesting
List<int> encodeIntegerFromBytes(List<int> bytes) {
  final padBytes = bytes.isNotEmpty && (bytes.first & 0x80 > 0);
  final extraLength = padBytes ? 1 : 0;
  return <int>[
    0x02,
    ...encodeLength(bytes.length + extraLength),
    if (padBytes) 0x00,
    ...bytes,
  ];
}

/// Wraps [bytes] as bit-string container.
@visibleForTesting
List<int> encodeBitString(List<int> bytes) {
  return <int>[
    0x03,
    ...encodeLength(bytes.length + 1),
    0x00,
    ...bytes,
  ];
}

/// Encodes mulitple parts as a sequence.
@visibleForTesting
List<int> encodeSequence(Iterable<List<int>> parts) {
  final totalLength = parts.map((e) => e.length).fold<int>(0, (a, b) => a + b);
  return <int>[
    0x30,
    ...encodeLength(totalLength),
    ...parts.expand((e) => e),
  ];
}

const _objectIdentifierRsa = <int>[
  0x06,
  0x09,
  0x2A,
  0x86,
  0x48,
  0x86,
  0xF7,
  0x0D,
  0x01,
  0x01,
  0x01,
];

const _nullObject = <int>[0x05, 0x00];

/// Encodes the RSA public key components.
List<int> encodeRsaPublicKey({
  required List<int> modulus,
  required List<int> exponent,
}) {
  return encodeSequence([
    encodeSequence([
      _objectIdentifierRsa,
      _nullObject,
    ]),
    encodeBitString(
      encodeSequence([
        encodeIntegerFromBytes(modulus),
        encodeIntegerFromBytes(exponent),
      ]),
    ),
  ]);
}
