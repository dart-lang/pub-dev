// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_package_reader/pub_package_reader.dart';
import 'package:pub_package_reader/src/known_templates.dart';
import 'package:test/test.dart';

void main() {
  group('description', () {
    test('known template', () {
      expect(
        validateDescription('A sample command-line application.'),
        isNotEmpty,
      );
    });

    test('known template with some extra text', () {
      expect(
        validateDescription('A sample command-line application by xyz.'),
        isNotEmpty,
      );
    });
  });

  group('readme', () {
    test('no readme', () {
      expect(validateKnownTemplateReadme(null, null), isEmpty);
    });

    test('some readme', () {
      expect(
        validateKnownTemplateReadme('README.md', 'This is not a template.'),
        isEmpty,
      );
    });

    test('known template', () {
      expect(
        validateKnownTemplateReadme(
          'README.md',
          'TODO: Tell users more about the package, and do not leave such templates in the README.md.',
        ),
        isNotEmpty,
      );
    });

    test('rewrite Github blob image URLs', (){
      final input = '![example](https://github.com/org/repo/blob/main/img.png)';
      final expected = '![example](https://raw.githubusercontent.com/org/repo/main/img.png)';
      final output = rewriteGithubImagesInMarkdown(input);
      expect(output, expected);
    });
  });
}
