// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

final changelogFileNames = ['CHANGELOG.md'];
final readmeFileNames = ['README.md'];
final licenseFileNames = ['LICENSE'];

/// Returns the candidates in priority order to display under the 'Example' tab.
List<String> exampleFileCandidates(String package) {
  return <String>[
    'example/example.md',
    'example/lib/main.dart',
    'example/main.dart',
    'example/lib/$package.dart',
    'example/$package.dart',
    'example/lib/${package}_example.dart',
    'example/${package}_example.dart',
    'example/lib/example.dart',
    'example/example.dart',
    'example/README.md',
  ];
}
