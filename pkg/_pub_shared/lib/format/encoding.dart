// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

/// Base64 encodes [dataPoints] as 32-bit unsigned integers serialized with
/// big endian byte order.
String encodeIntsAsBigEndianBase64String(List<int> dataPoints) {
  final byteData = ByteData(4 * dataPoints.length);
  for (int i = 0; i < dataPoints.length; i++) {
    byteData.setUint32(4 * i, dataPoints[i], Endian.little);
  }
  return base64Encode(byteData.buffer.asUint8List());
}

/// Counter part to [encodeIntsAsBigEndianBase64String].
List<int> decodeIntsFromBigEndianBase64String(String encoded) {
  final bytes = base64Decode(encoded);
  final resLength = bytes.length ~/ 4;
  final dataPoints = List.filled(resLength, -1);
  final sublist = ByteData.sublistView(bytes);
  for (int i = 0; i < resLength; i++) {
    dataPoints[i] = sublist.getUint32(4 * i, Endian.little);
  }
  return dataPoints;
}
