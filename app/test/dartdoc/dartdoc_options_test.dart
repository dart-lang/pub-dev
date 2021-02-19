// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/dartdoc/dartdoc_options.dart';
import 'package:test/test.dart';

void main() {
  group('Dartdoc options', () {
    final _defaultOptions = {
      'dartdoc': {'showUndocumentedCategories': true}
    };

    test('no content', () {
      expect(customizeDartdocOptions(null), _defaultOptions);
    });

    test('bad content', () {
      expect(customizeDartdocOptions({'not': 'dartdoc'}), _defaultOptions);
    });

    test('empty content', () {
      expect(customizeDartdocOptions({'dartdoc': {}}), _defaultOptions);
    });

    test('bad type', () {
      expect(customizeDartdocOptions({'dartdoc': 'none'}), _defaultOptions);
    });

    test('pass-through', () {
      expect(
          customizeDartdocOptions({
            'dartdoc': {
              'categories': {
                'a': {
                  'markdown': 'doc/a.md',
                },
              },
              'categoryOrder': ['a'],
              'nodoc': ['lib/b.dart'],
            },
          }),
          {
            'dartdoc': {
              'categories': {
                'a': {
                  'markdown': 'doc/a.md',
                },
              },
              'categoryOrder': ['a'],
              'nodoc': ['lib/b.dart'],
              'showUndocumentedCategories': true,
            },
          });
    });

    test('remove', () {
      expect(
          customizeDartdocOptions({
            'dartdoc': {
              'ignore': ['a'],
            },
          }),
          _defaultOptions);
    });

    test('override', () {
      expect(
          customizeDartdocOptions({
            'dartdoc': {
              'showUndocumentedCategories': false,
            },
          }),
          _defaultOptions);
    });
  });
}
