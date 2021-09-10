// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:pub_dartdoc/src/pub_hooks.dart';
import 'package:test/test.dart';

void main() {
  test('limit number of files', () {
    final provider =
        PubResourceProvider(MemoryResourceProvider(), maxFileCount: 1000);

    for (var i = 0; i < 1000; i++) {
      provider.getFile('/tmp/$i.txt').writeAsStringSync('x');
    }

    expect(() => provider.getFile('/tmp/next.txt').writeAsStringSync('next'),
        throwsA(isA<DocumentationTooBigException>()));
  });

  test('limit total bytes', () {
    final provider = PubResourceProvider(MemoryResourceProvider(),
        maxTotalLengthBytes: 1024);
    provider.getFile('/tmp/1').writeAsBytesSync(List<int>.filled(1024, 0));
    expect(() => provider.getFile('/tmp/2').writeAsBytesSync(<int>[0]),
        throwsA(isA<DocumentationTooBigException>()));
  });
}
