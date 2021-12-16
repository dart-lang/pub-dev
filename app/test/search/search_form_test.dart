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

    test('query with with sdk context', () {
      final form = SearchForm(
        context: SearchContext.flutter(),
        query: 'some framework',
      );
      expect(form.toSearchLink(), '/flutter/packages?q=some+framework');
      expect(form.toSearchLink(page: 1), '/flutter/packages?q=some+framework');
      expect(form.toSearchLink(page: 2),
          '/flutter/packages?q=some+framework&page=2');
    });

    test('query with with a single sdk parameter', () {
      final form = SearchForm.parse(SearchContext.regular(), {
        'q': 'sdk:dart some framework',
      });
      // pages
      expect(form.toSearchLink(), '/packages?q=sdk%3Adart+some+framework');
      expect(form.toSearchLink(page: 1), form.toSearchLink());
      expect(form.toSearchLink(page: 2),
          '/packages?q=sdk%3Adart+some+framework&page=2');
      // toggle
      expect(form.toggleSdk('flutter').toSearchLink(),
          '/packages?q=sdk%3Adart+sdk%3Aflutter+some+framework');
      expect(
          form.toggleSdk('dart').toSearchLink(), '/packages?q=some+framework');
      // query parameters
      expect(form.parsedQuery.tagsPredicate.toQueryParameters(), ['sdk:dart']);
      expect(
        form.toServiceQuery().toUriQueryParameters(),
        {
          'q': 'sdk:dart some framework',
          'tags': [
            '-is:discontinued',
            '-is:unlisted',
            '-is:legacy',
          ],
          'offset': '0',
          'limit': '10',
        },
      );
    });

    test('non-standard sdk query parameters', () {
      expect(
        SearchForm.parse(
          SearchContext.regular(),
          {'q': 'sdk:any'},
        ).parsedQuery.tagsPredicate.toQueryParameters(),
        ['sdk:any'],
      );
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

    test('toggle platforms', () {
      final form = SearchForm().togglePlatform('web');
      expect(form.toSearchLink(), '/packages?platform=web');
    });

    test('query-based show:hidden', () {
      expect(
        SearchForm(query: 'show:hidden')
            .toServiceQuery()
            .toUriQueryParameters()['tags'],
        [],
      );
    });

    test('query-based discontinued', () {
      expect(
        SearchForm(query: 'is:discontinued')
            .toServiceQuery()
            .toUriQueryParameters()['tags'],
        ['-is:unlisted', '-is:legacy'],
      );
      expect(
        SearchForm(query: 'show:discontinued')
            .toServiceQuery()
            .toUriQueryParameters()['tags'],
        ['-is:unlisted', '-is:legacy'],
      );
    });

    test('query-based unlisted', () {
      expect(
        SearchForm(query: 'is:unlisted')
            .toServiceQuery()
            .toUriQueryParameters()['tags'],
        ['-is:discontinued', '-is:legacy'],
      );
      expect(
        SearchForm(query: 'show:unlisted')
            .toServiceQuery()
            .toUriQueryParameters()['tags'],
        ['-is:discontinued', '-is:legacy'],
      );
    });

    test('query-based legacy', () {
      expect(
        SearchForm(query: 'is:legacy')
            .toServiceQuery()
            .toUriQueryParameters()['tags'],
        ['-is:discontinued', '-is:unlisted'],
      );
      expect(
        SearchForm(query: 'show:legacy')
            .toServiceQuery()
            .toUriQueryParameters()['tags'],
        ['-is:discontinued', '-is:unlisted'],
      );
    });
  });
}
