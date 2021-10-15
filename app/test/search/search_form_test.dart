// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/search/search_form.dart';
import 'package:test/test.dart';

void main() {
  group('SearchForm', () {
    test('query with defaults', () {
      final form = SearchForm(query: 'web framework');
      expect(form.toSearchLink(), '/packages?q=web+framework');
      expect(form.toSearchLink(page: 1), '/packages?q=web+framework');
      expect(form.toSearchLink(page: 2), '/packages?q=web+framework&page=2');
    });

    test('query with defaults on page 1', () {
      final form = SearchForm(query: 'web framework', currentPage: 1);
      expect(form.toSearchLink(), '/packages?q=web+framework');
      expect(form.toSearchLink(page: 1), '/packages?q=web+framework');
      expect(form.toSearchLink(page: 2), '/packages?q=web+framework&page=2');
    });

    test('query with defaults on page 3', () {
      final form = SearchForm(query: 'web framework', currentPage: 3);
      expect(form.toSearchLink(), '/packages?q=web+framework&page=3');
      expect(form.toSearchLink(page: 1), '/packages?q=web+framework');
      expect(form.toSearchLink(page: 2), '/packages?q=web+framework&page=2');
      expect(form.toSearchLink(page: 3), '/packages?q=web+framework&page=3');
    });

    test('query with with sdk', () {
      final form = SearchForm(
        context: SearchContext.flutter(),
        query: 'some framework',
      );
      expect(form.toSearchLink(), '/flutter/packages?q=some+framework');
      expect(form.toSearchLink(page: 1), '/flutter/packages?q=some+framework');
      expect(form.toSearchLink(page: 2),
          '/flutter/packages?q=some+framework&page=2');
    });

    test('removing Dart runtimes', () {
      final form = SearchForm(
        context: SearchContext.dart(),
        query: 'text',
        runtimes: ['js'],
      );
      expect(form.toSearchLink(), '/dart/packages?q=text&runtime=js');
      expect(form.change(context: SearchContext.dart()).toSearchLink(),
          form.toSearchLink());
      expect(form.change(context: SearchContext.flutter()).toSearchLink(),
          '/flutter/packages?q=text');
      expect(form.change(context: SearchContext.regular()).toSearchLink(),
          '/packages?q=text');
    });

    test('removing Flutter platforms', () {
      final form = SearchForm(
          query: 'text', context: SearchContext.flutter(), platforms: ['web']);
      expect(form.toSearchLink(), '/flutter/packages?q=text&platform=web');
      expect(form.change(context: SearchContext.dart()).toSearchLink(),
          '/dart/packages?q=text');
      expect(form.change(context: SearchContext.flutter()).toSearchLink(),
          form.toSearchLink());
      expect(form.change(context: SearchContext.regular()).toSearchLink(),
          '/packages?q=text');
    });
  });
}
