#!/usr/bin/env dart
// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library coded_buffer_reader_tests;

import 'dart:typed_data';

import 'package:protobuf/protobuf.dart';
import 'package:test/test.dart';

import 'test_util.dart';

void main() {
  final throwsInvalidProtocolBufferException =
      throwsA(new isInstanceOf<InvalidProtocolBufferException>());

  group('testCodedBufferReader', () {
    List<int> inputBuffer = <int>[
      0xb8, 0x06, 0x20, // 103 int32 = 32
      0xc0, 0x06, 0x40, // 104 int64 = 64
      0xc8, 0x06, 0x20, // 105 uint32 = 32
      0xd0, 0x06, 0x40, // 106 uint64 = 64
      0xd8, 0x06, 0x40, // 107 sint32 = 32
      0xe0, 0x06, 0x80, 0x01, // 108 sint64 = 64
      0xed, 0x06, 0x20, 0x00, 0x00, 0x00, // 109 fixed32 = 32
      0xf1, 0x06, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, // 110 fixed64 = 64
      0xfd, 0x06, 0x20, 0x00, 0x00, 0x00, // 111 sfixed32 = 64
      0x81, 0x07, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, // 112 sfixed64 = 64
      0x88, 0x07, 0x01, // 113 bool = true
      0x92, 0x07, 0x0f, 0x6f, 0x70, 0x74, 0x69, 0x6f,
      0x6e, 0x61, 0x6c, 0x5f, 0x73, 0x74, 0x72,
      0x69, 0x6e, 0x67, // 114 string 15 optional_string
      0x9a, 0x07, 0x0e, 0x6f, 0x70, 0x74, 0x69, 0x6f,
      0x6e, 0x61, 0x6c, 0x5f, 0x62, 0x79, 0x74,
      0x65, 0x73 // 115 bytes 14 optional_bytes
    ];

    testWithList(List<int> inputBuffer) {
      CodedBufferReader cis = new CodedBufferReader(inputBuffer);

      expect(cis.readTag(), makeTag(103, WIRETYPE_VARINT));
      expect(cis.readInt32(), 32);

      expect(cis.readTag(), makeTag(104, WIRETYPE_VARINT));
      expect(cis.readInt64(), expect64(64));

      expect(cis.readTag(), makeTag(105, WIRETYPE_VARINT));
      expect(cis.readUint32(), 32);

      expect(cis.readTag(), makeTag(106, WIRETYPE_VARINT));
      expect(cis.readUint64(), expect64(64));

      expect(cis.readTag(), makeTag(107, WIRETYPE_VARINT));
      expect(cis.readSint32(), 32);

      expect(cis.readTag(), makeTag(108, WIRETYPE_VARINT));
      expect(cis.readSint64(), expect64(64));

      expect(cis.readTag(), makeTag(109, WIRETYPE_FIXED32));
      expect(cis.readFixed32(), 32);

      expect(cis.readTag(), makeTag(110, WIRETYPE_FIXED64));
      expect(cis.readFixed64(), expect64(64));

      expect(cis.readTag(), makeTag(111, WIRETYPE_FIXED32));
      expect(cis.readSfixed32(), 32);

      expect(cis.readTag(), makeTag(112, WIRETYPE_FIXED64));
      expect(cis.readSfixed64(), expect64(64));

      expect(cis.readTag(), makeTag(113, WIRETYPE_VARINT));
      expect(cis.readBool(), isTrue);

      expect(cis.readTag(), makeTag(114, WIRETYPE_LENGTH_DELIMITED));
      expect(cis.readString(), 'optional_string');

      expect(cis.readTag(), makeTag(115, WIRETYPE_LENGTH_DELIMITED));
      expect(cis.readBytes(), 'optional_bytes'.codeUnits);
    }

    test('normal-list', () {
      testWithList(inputBuffer);
    });

    test('uint8-list', () {
      var uint8List = new Uint8List.fromList(inputBuffer);
      testWithList(uint8List);
    });

    test('uint8-list-view', () {
      var uint8List = new Uint8List(inputBuffer.length + 4);
      uint8List[0] = 0xc0;
      uint8List[1] = 0xc8;
      uint8List.setRange(2, 2 + inputBuffer.length, inputBuffer);
      uint8List[inputBuffer.length + 2] = 0xe0;
      uint8List[inputBuffer.length + 3] = 0xed;
      var view = new Uint8List.view(uint8List.buffer, 2, inputBuffer.length);
      testWithList(view);
    });
  });

  test('testReadMaliciouslyLargeBlob', () {
    CodedBufferWriter output = new CodedBufferWriter();

    int tag = makeTag(1, WIRETYPE_LENGTH_DELIMITED);
    output.writeInt32NoTag(tag);
    output.writeInt32NoTag(0x7FFFFFFF);
    // Pad with a few random bytes.
    output.writeInt32NoTag(0);
    output.writeInt32NoTag(32);
    output.writeInt32NoTag(47);

    CodedBufferReader input = new CodedBufferReader(output.toBuffer());
    expect(input.readTag(), tag);

    expect(() {
      input.readBytes();
    }, throwsInvalidProtocolBufferException);
  });

  /// Tests that if we read a string that contains invalid UTF-8, no exception
  /// is thrown. Instead, the invalid bytes are replaced with the Unicode
  /// 'replacement character' U+FFFD.
  test('testReadInvalidUtf8', () {
    CodedBufferReader input = new CodedBufferReader([1, 0x80]);
    String text = input.readString();
    expect(text.codeUnitAt(0), 0xfffd);
  });

  test('testInvalidTag', () {
    // Any tag number which corresponds to field number zero is invalid and
    // should throw InvalidProtocolBufferException.
    for (int i = 0; i < 8; i++) {
      expect(() {
        new CodedBufferReader([i]).readTag();
      }, throwsInvalidProtocolBufferException);
    }
  });
}
