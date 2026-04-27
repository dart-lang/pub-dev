// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:unzip/src/reader.dart';

void main() {
  test('Read simple zip in memory', () async {
    // A minimal ZIP file with one file `test.txt` containing "hello" (stored).
    // Calculated manually based on ZIP spec.
    final zipBytes = Uint8List.fromList([
      // Local File Header
      0x50, 0x4b, 0x03, 0x04, // Signature
      0x14, 0x00, // Version needed
      0x00, 0x00, // Flags
      0x00, 0x00, // Method (Store)
      0x00, 0x00, 0x00, 0x00, // Time/Date
      0x86, 0xa6, 0x10, 0x36, // CRC32
      0x05, 0x00, 0x00, 0x00, // Compressed Size (5)
      0x05, 0x00, 0x00, 0x00, // Uncompressed Size (5)
      0x08, 0x00, // Filename length (8)
      0x00, 0x00, // Extra field length (0)
      // Filename: test.txt
      0x74, 0x65, 0x73, 0x74, 0x2e, 0x74, 0x78, 0x74,
      // Data: hello
      0x68, 0x65, 0x6c, 0x6c, 0x6f,

      // Central Directory Header
      0x50, 0x4b, 0x01, 0x02, // Signature
      0x14, 0x00, // Creator version
      0x14, 0x00, // Reader version
      0x00, 0x00, // Flags
      0x00, 0x00, // Method
      0x00, 0x00, 0x00, 0x00, // Time/Date
      0x86, 0xa6, 0x10, 0x36, // CRC32
      0x05, 0x00, 0x00, 0x00, // Compressed Size
      0x05, 0x00, 0x00, 0x00, // Uncompressed Size
      0x08, 0x00, // Filename length
      0x00, 0x00, // Extra length
      0x00, 0x00, // Comment length
      0x00, 0x00, // Disk start
      0x00, 0x00, // Internal attrs
      0x00, 0x00, 0x00, 0x00, // External attrs
      0x00, 0x00, 0x00, 0x00, // Local header offset (0)
      // Filename: test.txt
      0x74, 0x65, 0x73, 0x74, 0x2e, 0x74, 0x78, 0x74,

      // End of Central Directory Record
      0x50, 0x4b, 0x05, 0x06, // Signature
      0x00, 0x00, // Disk number
      0x00, 0x00, // Dir disk number
      0x01, 0x00, // Records this disk
      0x01, 0x00, // Records total
      0x36, 0x00, 0x00, 0x00, // Dir size (54)
      0x2b, 0x00, 0x00, 0x00, // Dir offset (43)
      0x00, 0x00, // Comment length
    ]);

    final zipReader = ZipReader.fromBytes(zipBytes);
    await zipReader.init();

    expect(zipReader.files.length, equals(1));
    expect(zipReader.files[0].header.name, equals('test.txt'));
    expect(zipReader.files[0].header.compressedSize64, equals(5));

    final contentStream = zipReader.files[0].open();
    final contentBytes = await contentStream.fold<List<int>>(
      [],
      (a, b) => [...a, ...b],
    );
    expect(String.fromCharCodes(contentBytes), equals('hello'));
  });

  test('Test CRC32 mismatch', () async {
    // A minimal ZIP file with one file `test.txt` containing "hello" (stored).
    // But with wrong CRC32 in headers!
    final zipBytes = Uint8List.fromList([
      // Local File Header
      0x50, 0x4b, 0x03, 0x04, // Signature
      0x14, 0x00, // Version needed
      0x00, 0x00, // Flags
      0x00, 0x00, // Method (Store)
      0x00, 0x00, 0x00, 0x00, // Time/Date
      0x00, 0x00, 0x00, 0x00, // Wrong CRC32
      0x05, 0x00, 0x00, 0x00, // Compressed Size (5)
      0x05, 0x00, 0x00, 0x00, // Uncompressed Size (5)
      0x08, 0x00, // Filename length (8)
      0x00, 0x00, // Extra field length (0)
      // Filename: test.txt
      0x74, 0x65, 0x73, 0x74, 0x2e, 0x74, 0x78, 0x74,
      // Data: hello
      0x68, 0x65, 0x6c, 0x6c, 0x6f,

      // Central Directory Header
      0x50, 0x4b, 0x01, 0x02, // Signature
      0x14, 0x00, // Creator version
      0x14, 0x00, // Reader version
      0x00, 0x00, // Flags
      0x00, 0x00, // Method
      0x00, 0x00, 0x00, 0x00, // Time/Date
      0x00, 0x00, 0x00, 0x00, // Wrong CRC32
      0x05, 0x00, 0x00, 0x00, // Compressed Size
      0x05, 0x00, 0x00, 0x00, // Uncompressed Size
      0x08, 0x00, // Filename length
      0x00, 0x00, // Extra length
      0x00, 0x00, // Comment length
      0x00, 0x00, // Disk start
      0x00, 0x00, // Internal attrs
      0x00, 0x00, 0x00, 0x00, // External attrs
      0x00, 0x00, 0x00, 0x00, // Local header offset (0)
      // Filename: test.txt
      0x74, 0x65, 0x73, 0x74, 0x2e, 0x74, 0x78, 0x74,

      // End of Central Directory Record
      0x50, 0x4b, 0x05, 0x06, // Signature
      0x00, 0x00, // Disk number
      0x00, 0x00, // Dir disk number
      0x01, 0x00, // Records this disk
      0x01, 0x00, // Records total
      0x36, 0x00, 0x00, 0x00, // Dir size (54)
      0x2b, 0x00, 0x00, 0x00, // Dir offset (43)
      0x00, 0x00, // Comment length
    ]);

    final zipReader = ZipReader.fromBytes(zipBytes);
    await zipReader.init();

    expect(zipReader.files.length, equals(1));
    final f = zipReader.files[0];

    final contentStream = f.open();
    expect(
      contentStream.fold<List<int>>([], (a, b) => [...a, ...b]),
      throwsA(
        isA<FormatException>().having(
          (x) => x.message,
          'message',
          contains('CRC32 checksum mismatch'),
        ),
      ),
    );
  });
  // Adapted from https://github.com/golang/go/blob/85f838f46c2f22e7eb28352439259f570cd5c185/src/archive/zip/reader_test.go#L1078
  test('TestIssue8186', () {
    // Directory headers & data found in the TOC of a JAR file.
    final dirEnts = [
      'PK\x01\x02\x0a\x00\x0a\x00\x00\x08\x00\x004\x9d3?\xaa\x1b\x06\xf0\x81\x02\x00\x00\x81\x02\x00\x00-\x00\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00res/drawable-xhdpi-v4/ic_actionbar_accept.png\xfe\xca\x00\x00\x00',
      'PK\x01\x02\x0a\x00\x0a\x00\x00\x08\x00\x004\x9d3?\x90K\x89\xc7t\x0a\x00\x00t\x0a\x00\x00\x0e\x00\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd1\x02\x00\x00resources.arsc\x00\x00\x00',
      'PK\x01\x02\x14\x00\x14\x00\x08\x08\x08\x004\x9d3?\xff\$\x18\xed3\x03\x00\x00\xb4\x08\x00\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00t\x0d\x00\x00AndroidManifest.xml',
      'PK\x01\x02\x14\x00\x14\x00\x08\x08\x08\x004\x9d3?\x14\xc5K\xab\x192\x02\x00\xc8\xcd\x04\x00\x0b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe8\x10\x00\x00classes.dex',
      'PK\x01\x02\x14\x00\x14\x00\x08\x08\x08\x004\x9d3?E\x96\x0aD\xac\x01\x00\x00P\x03\x00\x00&\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00:C\x02\x00res/layout/actionbar_set_wallpaper.xml',
      'PK\x01\x02\x14\x00\x14\x00\x08\x08\x08\x004\x9d3?Ļ\x14\xe3\xd8\x01\x00\x00\xd8\x03\x00\x00 \x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00:E\x02\x00res/layout/wallpaper_cropper.xml',
      'PK\x01\x02\x14\x00\x14\x00\x08\x08\x08\x004\x9d3?}\xc1\x15\x9eZ\x01\x00\x00!\x02\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00`G\x02\x00META-INF/MANIFEST.MF',
      'PK\x01\x02\x14\x00\x14\x00\x08\x08\x08\x004\x9d3?\xe6\x98Ьo\x01\x00\x00\x84\x02\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfcH\x02\x00META-INF/CERT.SF',
      'PK\x01\x02\x14\x00\x14\x00\x08\x08\x08\x004\x9d3?\xbfP\x96b\x86\x04\x00\x00\xb2\x06\x00\x00\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa9J\x02\x00META-INF/CERT.RSA',
    ];

    for (var i = 0; i < dirEnts.length; i++) {
      final s = dirEnts[i];
      final bytes = Uint8List.fromList(s.codeUnits);
      final reader = MemoryReader(bytes);

      final header = ZipReader.readDirectoryHeader(reader, 0);
      expect(header, isNotNull);
    }
  });
  // Adapted from https://github.com/golang/go/blob/85f838f46c2f22e7eb28352439259f570cd5c185/src/archive/zip/reader_test.go#L1102
  test('TestIssue10957', () async {
    final data =
        'PK\x03\x040000000PK\x01\x0200000'
        '0000000000000000000\x00'
        '\x00\x00\x00\x00\x00000000000000PK\x01'
        '\x020000000000000000000'
        '00000\x0b\x00\x00\x00\x00\x00000000000'
        '00000000000000PK\x01\x0200'
        '00000000000000000000'
        '00\x0b\x00\x00\x00\x00\x00000000000000'
        '00000000000PK\x01\x020000<'
        '0\x00\x0000000000000000\x0b\x00\x0b'
        '\x00\x00\x00\x00\x0000000000\x00\x00\x00\x00000'
        '00000000PK\x01\x0200000000'
        '0000000000000000\x0b\x00\x00\x00'
        '\x00\x0000PK\x05\x06000000\x05\x00\xfd\x00\x00\x00'
        '\x0b\x00\x00\x00\x00\x00';

    final bytes = Uint8List.fromList(data.codeUnits);
    final reader = MemoryReader(bytes);
    final zipReader = ZipReader(reader);

    await zipReader.init();

    for (var i = 0; i < zipReader.files.length; i++) {
      final f = zipReader.files[i];
      try {
        final stream = f.open();
        await stream.drain();
      } catch (e) {
        if (i == 3) {
          // Expected error on file 3.
          expect(e, isNotNull);
        }
      }
    }
  });
  // Adapted from https://github.com/golang/go/blob/85f838f46c2f22e7eb28352439259f570cd5c185/src/archive/zip/reader_test.go#L1141
  test('TestIssue10956', () {
    final data =
        'PK\x06\x06PK\x06\x070000\x00\x00\x00\x00\x00\x00\x00\x00'
        '0000PK\x05\x06000000000000'
        '0000\x0b\x00000\x00\x00\x00\x00\x00\x00\x000';

    final bytes = Uint8List.fromList(data.codeUnits);
    final reader = MemoryReader(bytes);
    final zipReader = ZipReader(reader);

    expect(() => zipReader.init(), throwsA(isA<ArgumentError>()));
  });
  // Adapted from https://github.com/golang/go/blob/85f838f46c2f22e7eb28352439259f570cd5c185/src/archive/zip/reader_test.go#L1371
  test('TestCVE202127919', () {
    final data = Uint8List.fromList([
      0x50,
      0x4b,
      0x03,
      0x04,
      0x14,
      0x00,
      0x08,
      0x00,
      0x08,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x0b,
      0x00,
      0x00,
      0x00,
      0x2e,
      0x2e,
      0x2f,
      0x74,
      0x65,
      0x73,
      0x74,
      0x2e,
      0x74,
      0x78,
      0x74,
      0x0a,
      0xc9,
      0xc8,
      0x2c,
      0x56,
      0xc8,
      0x2c,
      0x56,
      0x48,
      0x54,
      0x28,
      0x49,
      0x2d,
      0x2e,
      0x51,
      0x28,
      0x49,
      0xad,
      0x28,
      0x51,
      0x48,
      0xcb,
      0xcc,
      0x49,
      0xd5,
      0xe3,
      0x02,
      0x04,
      0x00,
      0x00,
      0xff,
      0xff,
      0x50,
      0x4b,
      0x07,
      0x08,
      0xc0,
      0xd7,
      0xed,
      0xc3,
      0x20,
      0x00,
      0x00,
      0x00,
      0x1a,
      0x00,
      0x00,
      0x00,
      0x50,
      0x4b,
      0x01,
      0x02,
      0x14,
      0x00,
      0x14,
      0x00,
      0x08,
      0x00,
      0x08,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0xc0,
      0xd7,
      0xed,
      0xc3,
      0x20,
      0x00,
      0x00,
      0x00,
      0x1a,
      0x00,
      0x00,
      0x00,
      0x0b,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x2e,
      0x2e,
      0x2f,
      0x74,
      0x65,
      0x73,
      0x74,
      0x2e,
      0x74,
      0x78,
      0x74,
      0x50,
      0x4b,
      0x05,
      0x06,
      0x00,
      0x00,
      0x00,
      0x00,
      0x01,
      0x00,
      0x01,
      0x00,
      0x39,
      0x00,
      0x00,
      0x00,
      0x59,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
    ]);

    final reader = MemoryReader(data);
    final zipReader = ZipReader(reader);

    expect(() => zipReader.init(), throwsException);
  });
  // Adapted from https://github.com/golang/go/blob/85f838f46c2f22e7eb28352439259f570cd5c185/src/archive/zip/reader_test.go#L1472
  test('TestCVE202133196', () {
    final data = Uint8List.fromList([
      0x50,
      0x4b,
      0x03,
      0x04,
      0x14,
      0x00,
      0x08,
      0x08,
      0x08,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x03,
      0x00,
      0x00,
      0x00,
      0x01,
      0x02,
      0x03,
      0x62,
      0x61,
      0x65,
      0x03,
      0x04,
      0x00,
      0x00,
      0xff,
      0xff,
      0x50,
      0x4b,
      0x07,
      0x08,
      0xbe,
      0x20,
      0x5c,
      0x6c,
      0x09,
      0x00,
      0x00,
      0x00,
      0x03,
      0x00,
      0x00,
      0x00,
      0x50,
      0x4b,
      0x01,
      0x02,
      0x14,
      0x00,
      0x14,
      0x00,
      0x08,
      0x08,
      0x08,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0xbe,
      0x20,
      0x5c,
      0x6c,
      0x09,
      0x00,
      0x00,
      0x00,
      0x03,
      0x00,
      0x00,
      0x00,
      0x03,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x01,
      0x02,
      0x03,
      0x50,
      0x4b,
      0x06,
      0x06,
      0x2c,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x2d,
      0x00,
      0x2d,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x01,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0x31,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x3a,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x50,
      0x4b,
      0x06,
      0x07,
      0x00,
      0x00,
      0x00,
      0x00,
      0x6b,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x00,
      0x01,
      0x00,
      0x00,
      0x00,
      0x50,
      0x4b,
      0x05,
      0x06,
      0x00,
      0x00,
      0x00,
      0x00,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0xff,
      0x00,
      0x00,
    ]);

    final reader = MemoryReader(data);
    final zipReader = ZipReader(reader);

    expect(() => zipReader.init(), throwsA(isA<ZipFormatException>()));
  });

  final tests = [
    ZipTest(
      name: 'test.zip',
      comment: 'This is a zipfile comment.',
      files: [
        ZipTestFile(
          name: 'test.txt',
          content: 'This is a test text file.\n'.codeUnits,
        ),
        ZipTestFile(name: 'gophercolor16x16.png', file: 'gophercolor16x16.png'),
      ],
    ),
    ZipTest(
      name: 'test-trailing-junk.zip',
      comment: 'This is a zipfile comment.',
      files: [
        ZipTestFile(
          name: 'test.txt',
          content: 'This is a test text file.\n'.codeUnits,
        ),
        ZipTestFile(name: 'gophercolor16x16.png', file: 'gophercolor16x16.png'),
      ],
    ),
    ZipTest(
      name: 'test-prefix.zip',
      comment: 'This is a zipfile comment.',
      files: [
        ZipTestFile(
          name: 'test.txt',
          content: 'This is a test text file.\n'.codeUnits,
        ),
        ZipTestFile(name: 'gophercolor16x16.png', file: 'gophercolor16x16.png'),
      ],
    ),
    ZipTest(name: 'readme.zip'),
    ZipTest(name: 'readme.notzip', error: Exception('Zip format error')),
    ZipTest(
      name: 'dd.zip',
      files: [
        ZipTestFile(
          name: 'filename',
          content: 'This is a test textfile.\n'.codeUnits,
        ),
      ],
    ),
    ZipTest(
      name: 'winxp.zip',
      files: [
        ZipTestFile(name: 'hello', content: 'world \r\n'.codeUnits),
        ZipTestFile(name: 'dir/bar', content: 'foo \r\n'.codeUnits),
        ZipTestFile(name: 'dir/empty/', content: []),
        ZipTestFile(name: 'readonly', content: 'important \r\n'.codeUnits),
      ],
    ),
    ZipTest(
      name: 'unix.zip',
      files: [
        ZipTestFile(name: 'hello', content: 'world \r\n'.codeUnits),
        ZipTestFile(name: 'dir/bar', content: 'foo \r\n'.codeUnits),
        ZipTestFile(name: 'dir/empty/', content: []),
        ZipTestFile(name: 'readonly', content: 'important \r\n'.codeUnits),
      ],
    ),
    ZipTest(
      name: 'utf8-7zip.zip',
      files: [ZipTestFile(name: '世界', content: [])],
    ),
    ZipTest(
      name: 'utf8-infozip.zip',
      files: [ZipTestFile(name: '世界', content: [], nonUTF8: true)],
    ),
    ZipTest(
      name: 'utf8-osx.zip',
      files: [ZipTestFile(name: '世界', content: [], nonUTF8: true)],
    ),
    ZipTest(
      name: 'utf8-winrar.zip',
      files: [ZipTestFile(name: '世界', content: [])],
    ),
    ZipTest(
      name: 'utf8-winzip.zip',
      files: [ZipTestFile(name: '世界', content: [])],
    ),
    ZipTest(
      name: 'time-7zip.zip',
      files: [ZipTestFile(name: 'test.txt', content: [], size: 1 << 32 - 1)],
    ),
    ZipTest(
      name: 'time-infozip.zip',
      files: [ZipTestFile(name: 'test.txt', content: [], size: 1 << 32 - 1)],
    ),
    ZipTest(
      name: 'time-osx.zip',
      files: [ZipTestFile(name: 'test.txt', content: [], size: 1 << 32 - 1)],
    ),
    ZipTest(
      name: 'time-win7.zip',
      files: [ZipTestFile(name: 'test.txt', content: [], size: 1 << 32 - 1)],
    ),
    ZipTest(
      name: 'time-winrar.zip',
      files: [ZipTestFile(name: 'test.txt', content: [], size: 1 << 32 - 1)],
    ),
    ZipTest(
      name: 'time-winzip.zip',
      files: [ZipTestFile(name: 'test.txt', content: [], size: 1 << 32 - 1)],
    ),
    ZipTest(
      name: 'time-go.zip',
      files: [ZipTestFile(name: 'test.txt', content: [], size: 1 << 32 - 1)],
    ),
    ZipTest(
      name: 'time-22738.zip',
      files: [ZipTestFile(name: 'file', content: [])],
    ),
    ZipTest(
      name: 'dupdir.zip',
      files: [
        ZipTestFile(name: 'a/', content: []),
        ZipTestFile(name: 'a/b', content: []),
        ZipTestFile(name: 'a/b/', content: []),
        ZipTestFile(name: 'a/b/c', content: []),
      ],
    ),
    ZipTest(
      name: 'comment-truncated.zip',
      error: Exception('Zip format error'),
    ),
  ];

  for (final zt in tests) {
    readTestZip(zt);
  }
}

class ZipTest {
  final String name;
  final Uint8List Function()? source;
  final String? comment;
  final List<ZipTestFile>? files;
  final bool obscured;
  final Exception? error;

  ZipTest({
    required this.name,
    this.source,
    this.comment,
    this.files,
    this.obscured = false,
    this.error,
  });
}

class ZipTestFile {
  final String name;
  final int? mode;
  final bool nonUTF8;
  final DateTime? modified;
  final Exception? contentErr;
  final List<int>? content;
  final String? file;
  final int? size;

  ZipTestFile({
    required this.name,
    this.mode,
    this.nonUTF8 = false,
    this.modified,
    this.contentErr,
    this.content,
    this.file,
    this.size,
  });
}

void readTestZip(ZipTest zt) {
  group(zt.name, () {
    test('Run test', () async {
      RandomAccessReader reader;
      if (zt.source != null) {
        final bytes = zt.source!();
        reader = MemoryReader(bytes);
      } else {
        final path = 'test/testdata/${zt.name}';
        final file = File(path);
        if (!file.existsSync()) {
          return;
        }
        final raf = file.openSync();
        reader = FileReader(raf);
      }

      final zipReader = ZipReader(reader);

      if (zt.error != null) {
        expect(() => zipReader.init(), throwsA(isA<Exception>()));
        return;
      }

      await zipReader.init();

      if (zt.comment != null) {
        expect(zipReader.comment, equals(zt.comment));
      }

      if (zt.files != null) {
        expect(zipReader.files.length, equals(zt.files!.length));
        for (var i = 0; i < zipReader.files.length; i++) {
          final f = zipReader.files[i];
          final ft = zt.files![i];

          if (f.header.name == ft.name) {
            // Match as string (correctly decoded or ASCII).
          } else if (ft.nonUTF8) {
            expect(f.header.name.codeUnits, equals(utf8.encode(ft.name)));
          } else {
            expect(f.header.name, equals(ft.name));
          }

          List<int> expectedContent;
          if (ft.content != null) {
            expectedContent = ft.content!;
          } else if (ft.file != null) {
            final file = File('test/testdata/${ft.file}');
            expectedContent = file.readAsBytesSync();
          } else {
            continue;
          }

          final stream = f.open();
          final contentBytes = await stream.fold<List<int>>(
            [],
            (a, b) => [...a, ...b],
          );
          expect(contentBytes, equals(expectedContent));
        }
      }
    });
  });
}

List<int> rZipBytes() {
  var s = '''
0000000 50 4b 03 04 14 00 00 00 08 00 08 03 64 3c f9 f4
0000010 89 64 48 01 00 00 b8 01 00 00 07 00 00 00 72 2f
0000020 72 2e 7a 69 70 00 25 00 da ff 50 4b 03 04 14 00
0000030 00 00 08 00 08 03 64 3c f9 f4 89 64 48 01 00 00
0000040 b8 01 00 00 07 00 00 00 72 2f 72 2e 7a 69 70 00
0000050 2f 00 d0 ff 00 25 00 da ff 50 4b 03 04 14 00 00
0000060 00 08 00 08 03 64 3c f9 f4 89 64 48 01 00 00 b8
0000070 01 00 00 07 00 00 00 72 2f 72 2e 7a 69 70 00 2f
0000080 00 d0 ff c2 54 8e 57 39 00 05 00 fa ff c2 54 8e
0000090 57 39 00 05 00 fa ff 00 05 00 fa ff 00 14 00 eb
00000a0 ff c2 54 8e 57 39 00 05 00 fa ff 00 05 00 fa ff
00000b0 00 14 00 eb ff 42 88 21 c4 00 00 14 00 eb ff 42
00000c0 88 21 c4 00 00 14 00 eb ff 42 88 21 c4 00 00 14
00000d0 00 eb ff 42 88 21 c4 00 00 14 00 eb ff 42 88 21
00000e0 c4 00 00 00 00 ff ff 00 00 00 ff ff 00 34 00 cb
00000f0 ff 42 88 21 c4 00 00 00 00 ff ff 00 00 00 ff ff
0000100 00 34 00 cb ff 42 e8 21 5e 0f 00 00 00 ff ff 0a
0000110 f0 66 64 12 61 c0 15 dc e8 a0 48 bf 48 af 2a b3
0000120 20 c0 9b 95 0d c4 67 04 42 53 06 06 06 40 00 06
0000130 00 f9 ff 6d 01 00 00 00 00 42 e8 21 5e 0f 00 00
0000140 00 ff ff 0a f0 66 64 12 61 c0 15 dc e8 a0 48 bf
0000150 48 af 2a b3 20 c0 9b 95 0d c4 67 04 42 53 06 06
0000160 06 40 00 06 00 f9 ff 6d 01 00 00 00 00 50 4b 01
0000170 02 14 00 14 00 00 00 08 00 08 03 64 3c f9 f4 89
0000180 64 48 01 00 00 b8 01 00 00 07 00 00 00 00 00 00
0000190 00 00 00 00 00 00 00 00 00 00 00 72 2f 72 2e 7a
00001a0 69 70 50 4b 05 06 00 00 00 00 01 00 01 00 35 00
00001b0 00 00 6d 01 00 00 00 00
''';
  s = s.replaceAll(RegExp(r'[0-9a-fA-F]{7}'), '');
  s = s.replaceAll(RegExp(r'\s+'), '');

  final bytes = <int>[];
  for (var i = 0; i < s.length; i += 2) {
    bytes.add(int.parse(s.substring(i, i + 2), radix: 16));
  }
  return bytes;
}

List<int> biggestZipBytes() {
  var s = '''
0000000 50 4b 03 04 14 00 08 00 08 00 00 00 00 00 00 00
0000010 00 00 00 00 00 00 00 00 00 00 0a 00 00 00 62 69
0000020 67 67 65 72 2e 7a 69 70 ec dc 6b 4c 53 67 18 07
0000030 f0 16 c5 ca 65 2e cb b8 94 20 61 1f 44 33 c7 cd
0000040 c0 86 4a b5 c0 62 8a 61 05 c6 cd 91 b2 54 8c 1b
0000050 63 8b 03 9c 1b 95 52 5a e3 a0 19 6c b2 05 59 44
0000060 64 9d 73 83 71 11 46 61 14 b9 1d 14 09 4a c3 60
0000070 2e 4c 6e a5 60 45 02 62 81 95 b6 94 9e 9e 77 e7
0000080 d0 43 b6 f8 71 df 96 3c e7 a4 69 ce bf cf e9 79
0000090 ce ef 79 3f bf f1 31 db b6 bb 31 76 92 e7 f3 07
00000a0 8b fc 9c ca cc 08 cc cb cc 5e d2 1c 88 d9 7e bb
00000b0 4f bb 3a 3f 75 f1 5d 7f 8f c2 68 67 77 8f 25 ff
00000c0 84 e2 93 2d ef a4 95 3d 71 4e 2c b9 b0 87 c3 be
00000d0 3d f8 a7 60 24 61 c5 ef ae 9e c8 6c 6d 4e 69 c8
00000e0 67 65 34 f8 37 76 2d 76 5c 54 f3 95 65 49 c7 0f
00000f0 18 71 4b 7e 5b 6a d1 79 47 61 41 b0 4e 2a 74 45
0000100 43 58 12 b2 5a a5 c6 7d 68 55 88 d4 98 75 18 6d
0000110 08 d1 1f 8f 5a 9e 96 ee 45 cf a4 84 4e 4b e8 50
0000120 a7 13 d9 06 de 52 81 97 36 b2 d7 b8 fc 2b 5f 55
0000130 23 1f 32 59 cf 30 27 fb e2 8a b9 de 45 dd 63 9c
0000140 4b b5 8b 96 4c 7a 62 62 cc a1 a7 cf fa f1 fe dd
0000150 54 62 11 bf 36 78 b3 c7 b1 b5 f2 61 4d 4e dd 66
0000160 32 2e e6 70 34 5f f4 c9 e6 6c 43 6f da 6b c6 c3
0000170 09 2c ce 09 57 7f d2 7e b4 23 ba 7c 1b 99 bc 22
0000180 3e f1 de 91 2f e3 9c 1b 82 cc c2 84 39 aa e6 de
0000190 b4 69 fc cc cb 72 a6 61 45 f0 d3 1d 26 19 7c 8d
00001a0 29 c8 66 02 be 77 6a f9 3d 34 79 17 19 c8 96 24
00001b0 a3 ac e4 dd 3b 1a 8e c6 fe 96 38 6b bf 67 5a 23
00001c0 f4 16 f4 e6 8a b4 fc c2 cd bf 95 66 1d bb 35 aa
00001d0 92 7d 66 d8 08 8d a5 1f 54 2a af 09 cf 61 ff d2
00001e0 85 9d 8f b6 d7 88 07 4a 86 03 db 64 f3 d9 92 73
00001f0 df ec a7 fc 23 4c 8d 83 79 63 2a d9 fd 8d b3 c8
0000200 8f 7e d4 19 85 e6 8d 1c 76 f0 8b 58 32 fd 9a d6
0000210 85 e2 48 ad c3 d5 60 6f 7e 22 dd ef 09 49 7c 7f
0000220 3a 45 c3 71 b7 df f3 4c 63 fb b5 d9 31 5f 6e d6
0000230 24 1d a4 4a fe 32 a7 5c 16 48 5c 3e 08 6b 8a d3
0000240 25 1d a2 12 a5 59 24 ea 20 5f 52 6d ad 94 db 6b
0000250 94 b9 5d eb 4b a7 5c 44 bb 1e f2 3c 6b cf 52 c9
0000260 e9 e5 ba 06 b9 c4 e5 0a d0 00 0d d0 00 0d d0 00
0000270 0d d0 00 0d d0 00 0d d0 00 0d d0 00 0d d0 00 0d
0000280 d0 00 0d d0 00 0d d0 00 0d d0 00 0d d0 00 0d d0
0000290 00 0d d0 00 0d d0 00 0d d0 00 0d d0 00 0d d0 00
00002a0 0d d0 00 cd ff 9e 46 86 fa a7 7d 3a 43 d7 8e 10
00002b0 52 e9 be e6 6e cf eb 9e 85 4d 65 ce cc 30 c1 44
00002c0 c0 4e af bc 9c 6c 4b a0 d7 54 ff 1d d5 5c 89 fb
00002d0 b5 34 7e c4 c2 9e f5 a0 f6 5b 7e 6e ca 73 c7 ef
00002e0 5d be de f9 e8 81 eb a5 0a a5 63 54 2c d7 1c d1
00002f0 89 17 85 f8 16 94 f2 8a b2 a3 f5 b6 6d df 75 cd
0000300 90 dd 64 bd 5d 55 4e f2 55 19 1b b7 cc ef 1b ea
0000310 2e 05 9c f4 aa 1e a8 cd a6 82 c7 59 0f 5e 9d e0
0000320 bb fc 6c d6 99 23 eb 36 ad c6 c5 e1 d8 e1 e2 3e
0000330 d9 90 5a f7 91 5d 6f bc 33 6d 98 47 d2 7c 2e 2f
0000340 99 a4 25 72 85 49 2c be 0b 5b af 8f e5 6e 81 a6
0000350 a3 5a 6f 39 53 3a ab 7a 8b 1e 26 f7 46 6c 7d 26
0000360 53 b3 22 31 94 d3 83 f2 18 4d f5 92 33 27 53 97
0000370 0f d3 e6 55 9c a6 c5 31 87 6f d3 f3 ae 39 6f 56
0000380 10 7b ab 7e d0 b4 ca f2 b8 05 be 3f 0e 6e 5a 75
0000390 ab 0c f5 37 0e ba 8e 75 71 7a aa ed 7a dd 6a 63
00003a0 be 9b a0 97 27 6a 6f e7 d3 8b c4 7c ec d3 91 56
00003b0 d9 ac 5e bf 16 42 2f 00 1f 93 a2 23 87 bd e2 59
00003c0 a0 de 1a 66 c8 62 eb 55 8f 91 17 b4 61 42 7a 50
00003d0 40 03 34 40 03 34 40 03 34 40 03 34 40 03 34 40
00003e0 03 34 40 03 34 40 03 34 40 03 34 40 03 34 40 03
00003f0 34 40 03 34 40 03 34 ff 85 86 90 8b ea 67 90 0d
0000400 e1 42 1b d2 61 d6 79 ec fd 3e 44 28 a4 51 6c 5c
0000410 fc d2 72 ca ba 82 18 46 16 61 cd 93 a9 0f d1 24
0000420 17 99 e2 2c 71 16 84 0c c8 7a 13 0f 9a 5e c5 f0
0000430 79 64 e2 12 4d c8 82 a1 81 19 2d aa 44 6d 87 54
0000440 84 71 c1 f6 d4 ca 25 8c 77 b9 08 c7 c8 5e 10 8a
0000450 8f 61 ed 8c ba 30 1f 79 9a c7 60 34 2b b9 8c f8
0000460 18 a6 83 1b e3 9f ad 79 fe fd 1b 8b f1 fc 41 6f
0000470 d4 13 1f e3 b8 83 ba 64 92 e7 eb e4 77 05 8f ba
0000480 fa 3b 00 00 ff ff 50 4b 07 08 a6 18 b1 91 5e 04
0000490 00 00 e4 47 00 00 50 4b 01 02 14 00 14 00 08 00
00004a0 08 00 00 00 00 00 a6 18 b1 91 5e 04 00 00 e4 47
00004b0 00 00 0a 00 00 00 00 00 00 00 00 00 00 00 00 00
00004c0 00 00 00 00 62 69 67 67 65 72 2e 7a 69 70 50 4b
00004d0 05 06 00 00 00 00 01 00 01 00 38 00 00 00 96 04
00004e0 00 00 00 00
''';
  s = s.replaceAll(RegExp(r'[0-9a-fA-F]{7}'), '');
  s = s.replaceAll(RegExp(r'\s+'), '');

  final bytes = <int>[];
  for (var i = 0; i < s.length; i += 2) {
    bytes.add(int.parse(s.substring(i, i + 2), radix: 16));
  }
  return bytes;
}

Uint8List decodeObscuredFile(String path) {
  final file = File(path);
  final content = file.readAsStringSync();
  return base64.decode(content.replaceAll(RegExp(r'\s+'), ''));
}
