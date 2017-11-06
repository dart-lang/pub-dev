// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library markdown.test.util;

import 'dart:mirrors';

import 'package:expected_output/expected_output.dart';
import 'package:markdown/markdown.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

final _indentPattern = new RegExp(r"^\(indent (\d+)\)\s*");

/// Run tests defined in "*.unit" files inside directory [name].
void testDirectory(String name) {
  for (var dataCase
      in dataCasesUnder(library: #markdown.test.util, subdirectory: name)) {
    validateCore(dataCase.description, dataCase.input, dataCase.expectedOutput);
  }
}

// Locate the "test" directory. Use mirrors so that this works with the test
// package, which loads this suite into an isolate.
String get _testDir =>
    p.dirname(currentMirrorSystem().findLibrary(#markdown.test.util).uri.path);

void testFile(String file,
    {Iterable<BlockSyntax> blockSyntaxes,
    Iterable<InlineSyntax> inlineSyntaxes}) {
  for (var dataCase in dataCasesInFile(path: p.join(_testDir, file))) {
    validateCore(dataCase.description, dataCase.input, dataCase.expectedOutput,
        blockSyntaxes: blockSyntaxes, inlineSyntaxes: inlineSyntaxes);
  }
}

void validateCore(String description, String markdown, String html,
    {Iterable<BlockSyntax> blockSyntaxes,
    Iterable<InlineSyntax> inlineSyntaxes,
    Resolver linkResolver,
    Resolver imageLinkResolver,
    bool inlineOnly: false}) {
  test(description, () {
    var result = markdownToHtml(markdown,
        blockSyntaxes: blockSyntaxes,
        inlineSyntaxes: inlineSyntaxes,
        linkResolver: linkResolver,
        imageLinkResolver: imageLinkResolver,
        inlineOnly: inlineOnly);

    expect(result, html);
  });
}
