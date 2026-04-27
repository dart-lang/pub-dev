// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:unzip/unzip.dart';

Future<void> main(List<String> args) async {
  if (args.length != 1) {
    print('Usage: dart example/example.dart <zip-file>');
    exit(1);
  }
  final zipReader = await ZipReader.open(args.single);

  print('Archive comment: ${zipReader.comment}');
  print('Files in archive:');

  for (final f in zipReader.files) {
    print(
      '  - ${f.header.name} (Compressed: ${f.header.compressedSize64} bytes)',
    );

    print('\n--- Content of ${f.header.name} ---');
    final stream = f.open();
    await for (final chunk in stream) {
      stdout.add(chunk);
    }
    print('\n-----------------------------------\n');
  }

  await zipReader.close();
}
