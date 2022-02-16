// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  final files = Directory('lib')
      .listSync(recursive: true)
      .where((f) => f is File && f.path.endsWith('.dart'))
      .cast<File>()
      .toList();

  // The test requires all recognized library imports to use `deferred as` library loading,
  // and it also requires to list all of the libraries that are loaded as deferred.
  test('deferred imports', () async {
    final deferredLibraryParts = {
      // Everything in api_client/ should be imported with deferred,
      // however, files inside the directory can be imported synchronously,
      // as they doesn't contain the api_client/ directory path.
      'api_client/',
      'admin_pages.dart',
      'package:intl/intl.dart',
    };

    for (final file in files) {
      final content = await file.readAsString();
      final lines = content.split('\n');
      for (final line in lines) {
        if (line.contains('import') || line.contains('export')) {
          final containsPart = deferredLibraryParts.any(line.contains);
          final containsDeferred = line.contains(' deferred as ');
          expect(containsPart, containsDeferred,
              reason: 'Import line pattern not recognized: $line');
        }
      }
    }
  });
}
