// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';
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

    test('query with sdk context', () {
      final form = SearchForm(query: 'sdk:flutter some framework');
      expect(form.toSearchLink(), '/packages?q=sdk%3Aflutter+some+framework');
      expect(form.toSearchLink(page: 1),
          '/packages?q=sdk%3Aflutter+some+framework');
      expect(form.toSearchLink(page: 2),
          '/packages?q=sdk%3Aflutter+some+framework&page=2');
    });

    test('query with a single sdk parameter', () {
      final form = SearchForm.parse({'q': 'sdk:dart some framework'});
      // pages
      expect(form.toSearchLink(), '/packages?q=sdk%3Adart+some+framework');
      expect(form.toSearchLink(page: 1), form.toSearchLink());
      expect(form.toSearchLink(page: 2),
          '/packages?q=sdk%3Adart+some+framework&page=2');
      // toggle
      expect(form.toggleRequiredTag('sdk:flutter').toSearchLink(),
          '/packages?q=sdk%3Adart+sdk%3Aflutter+some+framework');
      expect(form.toggleRequiredTag('sdk:dart').toSearchLink(),
          '/packages?q=some+framework');
      // query parameters
      expect(form.parsedQuery.tagsPredicate.toQueryParameters(), ['sdk:dart']);
    });

    test('non-standard sdk query parameters', () {
      expect(
        SearchForm.parse({'q': 'sdk:any'})
            .parsedQuery
            .tagsPredicate
            .toQueryParameters(),
        ['sdk:any'],
      );
    });

    test('query with license tag', () {
      final form = SearchForm(query: 'license:gpl some framework');
      expect(form.toSearchLink(), '/packages?q=license%3Agpl+some+framework');
      expect(form.parsedQuery.text, 'some framework');
      expect(
          form.parsedQuery.tagsPredicate.toQueryParameters(), ['license:gpl']);
    });
  });

  group('updated window parsing', () {
    test('invalid values', () {
      expect(parseTime(''), null);
      expect(parseTime('d'), null);
      expect(parseTime('1dd'), null);
      expect(parseTime('1.1m'), null);
    });

    test('valid values', () {
      expect(parseTime('1212d'), Duration(days: 1212));
      expect(parseTime('10w'), Duration(days: 70));
      expect(parseTime('6m'), Duration(days: 186));
      expect(parseTime('1y'), Duration(days: 365));
      expect(parseTime('2mo12h'), Duration(days: 62, hours: 12));
    });

    test('full query', () {
      final q = SearchForm(query: 'abc updated:2w');
      expect(q.parsedQuery.text, 'abc');
      expect(q.parsedQuery.updatedDuration, Duration(days: 14));
    });
  });

  group('SearchOrder enum', () {
    test('serialization', () {
      for (final value in SearchOrder.values) {
        final serialized = value.name;
        expect(serialized, isNotEmpty);
        final SearchOrder? deserialized = parseSearchOrder(serialized);
        expect(deserialized, value);
      }
    });

    test('unknown', () {
      expect(parseSearchOrder('foobar'), isNull);
    });
  });

  group('ParsedQuery', () {
    test('trim', () {
      expect(SearchForm(query: 'text').parsedQuery.text, 'text');
      expect(SearchForm(query: ' text ').query, 'text');
      expect(SearchForm(query: ' text ').parsedQuery.text, 'text');
    });

    test('no dependency', () {
      final query = SearchForm(query: 'text');
      expect(query.parsedQuery.text, 'text');
      expect(query.parsedQuery.refDependencies, []);
      expect(query.parsedQuery.allDependencies, []);
      expect(query.parsedQuery.hasAnyDependency, isFalse);
    });

    test('only one dependency', () {
      final query = SearchForm(query: 'dependency:pkg');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.refDependencies, ['pkg']);
      expect(query.parsedQuery.allDependencies, []);
      expect(query.parsedQuery.hasAnyDependency, isTrue);
    });

    test('only one dependency*', () {
      final query = SearchForm(query: 'dependency*:pkg');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.refDependencies, []);
      expect(query.parsedQuery.allDependencies, ['pkg']);
      expect(query.parsedQuery.hasAnyDependency, isTrue);
    });

    test('two dependencies with text blocks', () {
      final query =
          SearchForm(query: 'text1 dependency:pkg1 text2 dependency:pkg2');
      expect(query.parsedQuery.text, 'text1 text2');
      expect(query.parsedQuery.refDependencies, ['pkg1', 'pkg2']);
      expect(query.parsedQuery.allDependencies, []);
      expect(query.parsedQuery.hasAnyDependency, isTrue);
    });

    test('two mixed dependencies with text blocks', () {
      final query =
          SearchForm(query: 'text1 dependency:pkg1 text2 dependency*:pkg2');
      expect(query.parsedQuery.text, 'text1 text2');
      expect(query.parsedQuery.refDependencies, ['pkg1']);
      expect(query.parsedQuery.allDependencies, ['pkg2']);
      expect(query.parsedQuery.hasAnyDependency, isTrue);
    });

    test('only publisher', () {
      final query = SearchForm(query: 'publisher:example.com');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.tagsPredicate.toQueryParameters(),
          ['publisher:example.com']);
    });

    test('known tag', () {
      final query = SearchForm(query: 'is:legacy');
      expect(query.parsedQuery.text, isNull);
      expect(
          query.parsedQuery.tagsPredicate.toQueryParameters(), ['is:legacy']);
    });

    test('forbidden known tag', () {
      final query = SearchForm(query: '-is:legacy');
      expect(query.parsedQuery.text, isNull);
      expect(
          query.parsedQuery.tagsPredicate.toQueryParameters(), ['-is:legacy']);
    });

    test('known tag + package prefix + search text', () {
      final query = SearchForm(query: 'json is:legacy package:foo_');
      expect(query.parsedQuery.text, 'json');
      expect(
          query.parsedQuery.tagsPredicate.toQueryParameters(), ['is:legacy']);
      expect(query.parsedQuery.packagePrefix, 'foo_');
    });

    test('publisher + email + text + dependency', () {
      final query =
          SearchForm(query: 'publisher:example.com text dependency:pkg1');
      expect(query.parsedQuery.text, 'text');
      expect(query.parsedQuery.refDependencies, ['pkg1']);
      expect(query.parsedQuery.allDependencies, []);
      expect(query.parsedQuery.tagsPredicate.toQueryParameters(),
          ['publisher:example.com']);
    });

    test('text + topic with tag prefix', () {
      final query = SearchForm(query: 'abc topic:xyz');
      final pq = query.parsedQuery;
      expect(pq.text, 'abc');
      expect(pq.tagsPredicate.toQueryParameters(), ['topic:xyz']);
      expect(pq.toString(), 'topic:xyz abc');
    });

    test('text + topic with hash prefix', () {
      final query = SearchForm(query: 'abc #xyz');
      final pq = query.parsedQuery;
      expect(pq.text, 'abc #xyz');
      expect(pq.tagsPredicate.toQueryParameters(), []);
      expect(pq.toString(), 'abc #xyz');
    });
  });

  group('Search URLs', () {
    test('empty', () {
      final query = SearchForm();
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.packagePrefix, isNull);
      expect(query.toSearchLink(), '/packages');
    });

    test('platform: flutter', () {
      final query = SearchForm(query: SdkTag.sdkFlutter);
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.packagePrefix, isNull);
      expect(query.toSearchLink(), '/packages?q=sdk%3Aflutter');
    });

    test('Flutter favorites', () {
      final query = SearchForm(query: PackageTags.isFlutterFavorite);
      expect(query.toSearchLink(page: 2),
          '/packages?q=is%3Aflutter-favorite&page=2');
    });

    test('package prefix: angular', () {
      final query = SearchForm(query: 'package:angular');
      expect(query.parsedQuery.text, isNull);
      expect(query.parsedQuery.packagePrefix, 'angular');
      expect(query.toSearchLink(), '/packages?q=package%3Aangular');
    });

    test('complex search', () {
      final query =
          SearchForm(query: 'package:angular widget', order: SearchOrder.top);
      expect(query.parsedQuery.text, 'widget');
      expect(query.parsedQuery.packagePrefix, 'angular');
      expect(query.toSearchLink(),
          '/packages?q=package%3Aangular+widget&sort=top');
    });
  });
}
