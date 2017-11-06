library archive_test;

import 'dart:io' as io;
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:test/test.dart';

import '../bin/tar.dart' as tar_command;

part 'adler32_test.dart';
part 'bzip2_test.dart';
part 'commands_test.dart';
part 'crc32_test.dart';
part 'deflate_test.dart';
part 'gzip_test.dart';
part 'inflate_test.dart';
part 'input_stream_test.dart';
part 'output_stream_test.dart';
part 'pub_test.dart';
part 'tar_test.dart';
part 'zip_test.dart';
part 'zlib_test.dart';
part 'io_test.dart';

void compare_bytes(List<int> a, List<int> b) {
  expect(a.length, equals(b.length));
  int len = a.length;
  for (int i = 0; i < len; ++i) {
    expect(a[i], equals(b[i]));
  }
}

const String a_txt = """this is a test
of the
zip archive
format.
this is a test
of the
zip archive
format.
this is a test
of the
zip archive
format.
""";

void ListDir(List files, io.Directory dir) {
  var fileOrDirs = dir.listSync(recursive:true);
  for (var f in fileOrDirs) {
    if (f is io.File) {
      // Ignore paxHeader files, which 7zip write out since it doesn't properly
      // handle POSIX tar files.
      if (f.path.contains('PaxHeader')) {
        continue;
      }
      files.add(f);
    }
  }
}


void main() {
  defineInputStreamTests();
  defineOutputStreamTests();
  defineAdlerTests();
  defineCrc32Tests();
  defineBzip2Tests();
  defineDeflateTests();
  defineInflateTests();
  defineZlibTests();
  defineGZipTests();
  defineTarTests();
  defineZipTests();
  defineIoTests();
  defineCommandTests();
  //definePubTests();
}
