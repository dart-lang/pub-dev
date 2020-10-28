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
      final styles = parse(await file.readAsString());
      final visitor = _Visitor();
      styles.visit(visitor);

      // Sanity checks
      // TODO: figure out how to find more expressions
      expect(visitor.elements, isNotEmpty);

      // TODO: figure out why no element selector has been found
      // expect(visitor.ids, isNotEmpty);

      expect(visitor.classes, isNotEmpty);
      // TODO: figure out why 'unlisted' is not present, while it is in `_tags.scss`
      // expect(visitor.classes, contains('unlisted'));

      expect(visitor.selectors, isNotEmpty);

      final expressions = <String>{
        ...visitor.elements,
        ...visitor.ids,
        ...visitor.classes,
        ...visitor.selectors,
      };

      // These expressions are extracted from the CSS file, but they shouldn't
      // have been.
      expressions.removeAll(<String>[
        'site-font-color',
        'keyframes',
        'nth-child',
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
