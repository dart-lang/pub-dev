// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:csslib/parser.dart';
import 'package:csslib/visitor.dart';
import 'package:test/test.dart';

void main() {
  group('build + check rules', () {
    final file = File('../../static/css/style.css');

    setUpAll(() async {
      if (!file.existsSync()) {
        final pr = await Process.run('/bin/sh', ['build.sh']);
        if (pr.exitCode != 0) {
          throw Exception('Build process failed. ${pr.stdout}');
        }
      }
    });

    test('Check if all expressions are referenced in source files.', () async {
      final styles = parse(
        await file.readAsString(),
        options: PreprocessorOptions(
          throwOnWarnings: true,
          throwOnErrors: true,
          checked: true,
        ),
      );
      final visitor = _Visitor();
      styles.visit(visitor);

      // Sanity checks
      expect(visitor.elements, isNotEmpty);
      expect(visitor.ids, isNotEmpty);
      expect(visitor.classes, isNotEmpty);
      expect(visitor.classes, contains('unlisted'));
      expect(visitor.selectors, isNotEmpty);

      final expressions = <String>{
        ...visitor.elements,
        ...visitor.ids,
        ...visitor.classes,
        ...visitor.selectors,
      };

      // These expressions are extracted from the CSS file, but they won't be
      // referenced in the sources.
      // CSS functions
      expressions.removeAll(<String>[
        'first-child',
        'focus-within',
        'keyframes',
        'last-child',
        'nth-child',
      ]);
      // composite patterns
      expressions.removeWhere((e) => e.startsWith('home-block-'));
      expressions.removeWhere(
          (e) => e.startsWith('detail-tab-') && e.endsWith('-content'));
      // hljs
      expressions.removeWhere((e) => e == 'hljs' || e.startsWith('hljs-'));
      // github-markdown.css
      expressions.removeAll([
        'kbd',
        'no-list',
        'emoji',
        'align-center',
        'align-right',
        'float-left',
        'float-right',
      ]);

      final files = <File>[
        ...await Directory('../../app/lib')
            .list(recursive: true)
            .where((f) => f is File)
            .cast<File>()
            .toList(),
        ...await Directory('../web_app/lib')
            .list(recursive: true)
            .where((f) => f is File)
            .cast<File>()
            .toList()
      ];

      for (final file in files) {
        if (expressions.isEmpty) break;
        final content = await file.readAsString();
        final matched = expressions.where(content.contains).toList();
        expressions.removeAll(matched);
      }

      expect(expressions, isEmpty);
    });
  });
}

class _Visitor extends Visitor {
  final ids = <String>{};
  final elements = <String>{};
  final classes = <String>{};
  final selectors = <String>{};

  @override
  void visitSelector(Selector node) {
    selectors
        .addAll(node.simpleSelectorSequences.map((e) => e.simpleSelector.name));
    return super.visitSelector(node);
  }

  @override
  void visitClassSelector(ClassSelector node) {
    classes.add(node.name);
    return super.visitClassSelector(node);
  }

  @override
  void visitIdSelector(IdSelector node) {
    ids.add(node.name);
    return super.visitIdSelector(node);
  }

  @override
  void visitElementSelector(ElementSelector node) {
    elements.add(node.name);
    return super.visitElementSelector(node);
  }
}
