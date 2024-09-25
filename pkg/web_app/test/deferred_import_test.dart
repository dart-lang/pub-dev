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
    /// Maps the library name parts to the libraries that are allowed to import it
    /// without using deferred (because e.g. they are already deferred).
    final deferredLibraryParts = <String, List<String>>{
      // Everything in api_client/ should be imported with deferred,
      // however, files inside the directory can be imported synchronously,
      // as they doesn't contain the api_client/ directory path.
      'api_client/': [],
      'admin_pages.dart': [],
      'deferred/http.dart': [
        'lib/src/api_client/api_client.dart',
      ],
      'deferred/markdown.dart': [],
      'package:http/': [
        'lib/src/api_client/pubapi.client.dart',
        'lib/src/deferred/http.dart',
      ],
      'package:markdown/': [
        'lib/src/deferred/markdown.dart',
      ],
      'completion/': [],
      'dismissible/': [],
    };

    for (final file in files) {
      final content = await file.readAsString();
      final lines = content.split('\n');
      for (final line in lines) {
        if (line.contains('import') || line.contains('export')) {
          final containsDeferred = line.contains(' deferred as ');
          var hasDefinition = false;
          for (final key in deferredLibraryParts.keys.where(line.contains)) {
            hasDefinition = true;
            final containsFile = deferredLibraryParts[key]!.contains(file.path);
            expect(containsFile, !containsDeferred,
                reason:
                    'Import line pattern not recognized: $line in ${file.path}.');
          }
          if (containsDeferred) {
            expect(hasDefinition, isTrue,
                reason: 'Unknown library from `$line` in ${file.path}');
          }
        }
      }
    }
  });
}
