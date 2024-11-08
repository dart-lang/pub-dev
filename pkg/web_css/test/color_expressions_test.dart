// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

final _whitespace = RegExp(r'\s+');

const _colors = {
  'black',
  'red',
  'white',
};

void main() {
  group('Color restrictions and rules', () {
    // TODO(https://github.com/dart-lang/pub-dev/issues/8248): comment in once issue is resolved.
    // test('text and bg colors are only defined in _variables.scss',
    //     skip: 'https://github.com/dart-lang/pub-dev/issues/8248', () {
    //   final files = Directory('lib')
    //       .listSync(recursive: true)
    //       .whereType<File>()
    //       .where((f) => f.path.endsWith('.scss'))
    //       // _variables.scss is not checked, this should be the place for all color definitions
    //       .where((f) => !f.path.endsWith('/_variables.scss'))

    //       // _staging_ribbon.scss is only used on staging
    //       .where((f) => !f.path.endsWith('/_staging_ribbon.scss'))

    //       // _footer.scss has only one color theme, skipping for now
    //       // TODO: migrate the variables in this file
    //       .where((f) => !f.path.endsWith('/_footer.scss'))

    //       // dartdoc files are not checked
    //       .where((f) => !f.path.endsWith('/dartdoc.scss'))
    //       .toList();

    //   final badExpressions = <String>[];

    //   for (final file in files) {
    //     var content = file.readAsStringSync();
    //     // remove multi-line comment blocks
    //     content =
    //         content.replaceAll(RegExp(r'\/\*.*\*/', multiLine: true), ' ');
    //     final lines = content.split('\n');
    //     for (var i = 0; i < lines.length; i++) {
    //       final line = lines[i];
    //       // remove single-line comment
    //       final expr =
    //           line.split('//').first.replaceAll(_whitespace, ' ').trim();
    //       if (expr.isEmpty) continue;

    //       // minimal parsing and sanity check
    //       final parts = expr.split(':');
    //       if (parts.length != 2) continue;
    //       final name = parts[0].trim();
    //       var value = parts[1].trim();

    //       // remove known overlapping variable names from checking
    //       value =
    //           value.replaceAll('--pub-badge-red-color', '--pub-badge-color');

    //       if (name.isEmpty || value.isEmpty) continue;

    //       // local mdc overrides are exempted for now
    //       // TODO: move these values to _variables.scss
    //       if (name.startsWith('--mdc-theme-')) {
    //         continue;
    //       }

    //       // border colors, box shadows and text-decorations are exempted for now
    //       // TODO: move these values to _variables.scss
    //       if (name == 'border' ||
    //           name.startsWith('border-') ||
    //           name == 'box-shadow' ||
    //           name == 'text-decoration') {
    //         continue;
    //       }

    //       // detect color patterns
    //       final hasColor = value.contains('#') ||
    //           // TODO: also migrate color- variables
    //           // value.contains(r'$color-') ||
    //           value.contains('rgb(') ||
    //           value.contains('rgba(') ||
    //           value.contains('hsl(') ||
    //           _colors.any((c) => value.contains(c));
    //       if (!hasColor) continue;

    //       badExpressions.add('${file.path} line #${i + 1}: `${expr.trim()}`');
    //     }
    //   }

    //   expect(badExpressions, isEmpty);
    // });
  });
}
