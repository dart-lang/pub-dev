// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Returns common file name candidates for [base] (specified without any extension).
List<String> textFileNameCandidates(String base) {
  return <String>[
    base,
    '$base.md',
    '$base.markdown',
    '$base.mkdown',
    '$base.txt',
  ];
}

final List<String> changelogFileNames = textFileNameCandidates('changelog');

final List<String> readmeFileNames = textFileNameCandidates('readme');

/// Returns the candidates in priority order to display under the 'Example' tab.
List<String> exampleFileCandidates(String package) {
  return <String>[
    ...textFileNameCandidates('example/example'),
    'example/lib/main.dart',
    'example/main.dart',
    'example/lib/$package.dart',
    'example/$package.dart',
    'example/lib/${package}_example.dart',
    'example/${package}_example.dart',
    'example/lib/example.dart',
    'example/example.dart',
    ...textFileNameCandidates('example/readme'),
  ];
}
