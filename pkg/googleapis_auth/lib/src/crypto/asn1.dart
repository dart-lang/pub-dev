// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine_auth.asn;

import 'dart:typed_data';

import 'rsa.dart';

class ASN1Parser {
  static const INTEGER_TAG = 0x02;
  static const OCTET_STRING_TAG = 0x04;
  static const NULL_TAG = 0x05;
  static const OBJECT_ID_TAG = 0x06;
  static const SEQUENCE_TAG = 0x30;

  static ASN1Object parse(Uint8List bytes) {
    invalidFormat(String msg) {
      throw new ArgumentError("Invalid DER encoding: $msg");
    }

    var data = new ByteData.view(bytes.buffer);
    int offset = 0;
    int end = bytes.length;

    checkNBytesAvailable(int n) {
      if ((offset + n) > end) {
        invalidFormat('Tried to read more bytes than available.');
      }
    }

    List<int> readBytes(int n) {
      checkNBytesAvailable(n);

      var integerBytes = bytes.sublist(offset, offset + n);
      offset += n;
      return integerBytes;
    }

    int readEncodedLength() {
      checkNBytesAvailable(1);

      var lengthByte = data.getUint8(offset++);

      // Short length encoding form: This byte is the length itself.
      if (lengthByte < 0x80) {
        return lengthByte;
      }

      // Long length encoding form:
      // This byte has in bits 0..6 the number of bytes following which encode
      // the length.
      int countLengthBytes = lengthByte & 0x7f;
      checkNBytesAvailable(countLengthBytes);

      int length = 0;
      while (countLengthBytes > 0) {
        length = (length << 8) | data.getUint8(offset++);
        countLengthBytes--;
      }
      return length;
    }

    void readNullBytes() {
      checkNBytesAvailable(1);
      var nullByte = data.getUint8(offset++);
      if (nullByte != 0x00) {
        invalidFormat('Null byte expect, but was: $nullByte.');
      }
    }

    ASN1Object decodeObject() {
      checkNBytesAvailable(1);
      var tag = bytes[offset++];
      switch (tag) {
        case INTEGER_TAG:
          int size = readEncodedLength();
          return new ASN1Integer(RSAAlgorithm.bytes2Integer(readBytes(size)));
        case OCTET_STRING_TAG:
          var size = readEncodedLength();
          return new ASN1OctetString(readBytes(size));
        case NULL_TAG:
          readNullBytes();
          return new ASN1Null();
        case OBJECT_ID_TAG:
          var size = readEncodedLength();
          return new ASN1ObjectIdentifier(readBytes(size));
        case SEQUENCE_TAG:
          var lengthInBytes = readEncodedLength();
          if ((offset + lengthInBytes) > end) {
            invalidFormat('Tried to read more bytes than available.');
          }
          int endOfSequence = offset + lengthInBytes;

          var objects = <ASN1Object>[];
          while (offset < endOfSequence) {
            objects.add(decodeObject());
          }
          return new ASN1Sequence(objects);
        default:
          invalidFormat(
              'Unexpected tag $tag at offset ${offset-1} (end: $end).');
      }
      // Unreachable.
      return null;
    }

    var obj = decodeObject();
    if (offset != bytes.length) {
      throw new ArgumentError('More bytes than expected in ASN1 encoding.');
    }
    return obj;
  }
}

abstract class ASN1Object {}

class ASN1Sequence extends ASN1Object {
  final List<ASN1Object> objects;
  ASN1Sequence(this.objects);
}

class ASN1Integer extends ASN1Object {
  final int integer;
  ASN1Integer(this.integer);
}

class ASN1OctetString extends ASN1Object {
  final List<int> bytes;
  ASN1OctetString(this.bytes);
}

class ASN1ObjectIdentifier extends ASN1Object {
  final List<int> bytes;
  ASN1ObjectIdentifier(this.bytes);
}

class ASN1Null extends ASN1Object {}
