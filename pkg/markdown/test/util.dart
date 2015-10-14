// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library markdown.test.util;

import 'dart:io';
import 'dart:mirrors';

import 'package:markdown/markdown.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

final _indentPattern = new RegExp(r"^\(indent (\d+)\)\s*");

/// Run tests defined in "*.unit" files inside directory [name].
void testDirectory(String name) {
  // Locate the "test" directory. Use mirrors so that this works with the test
  // package, which loads this suite into an isolate.
  var testDir = p.dirname(currentMirrorSystem()
      .findLibrary(#markdown.test.util)
      .uri
      .path);

  var dir = p.join(testDir, name);
  var entries =
      new Directory(dir).listSync().where((e) => e.path.endsWith('.unit'));

  for (var entry in entries) {
    group("$name ${p.basename(entry.path)}", () {
      var lines = (entry as File).readAsLinesSync();

      var i = 0;
      while (i < lines.length) {
        var description = lines[i++].replaceAll(">>>", "").trim();

        // Let the test specify a leading indentation. This is handy for
        // regression tests which often come from a chunk of nested code.
        var indentMatch = _indentPattern.firstMatch(description);
        if (indentMatch != null) {
          // The test specifies it in spaces, but the formatter expects levels.
          description = description.substring(indentMatch.end);
        }

        if (description == "") {
          description = "line ${i + 1}";
        } else {
          description = "line ${i + 1}: $description";
        }

        var input = "";
        while (!lines[i].startsWith("<<<")) {
          input += lines[i++] + "\n";
        }

        var expectedOutput = "";
        while (++i < lines.length && !lines[i].startsWith(">>>")) {
          expectedOutput += lines[i] + "\n";
        }

        validateCore(description, input, expectedOutput);
      }
    });
  }
}

void validateCore(String description, String markdown, String html,
    {List<InlineSyntax> inlineSyntaxes, Resolver linkResolver,
    Resolver imageLinkResolver, bool inlineOnly: false}) {
  test(description, () {
    var result = markdownToHtml(markdown,
        inlineSyntaxes: inlineSyntaxes,
        linkResolver: linkResolver,
        imageLinkResolver: imageLinkResolver,
        inlineOnly: inlineOnly);

    expect(result, html);
  });
}
