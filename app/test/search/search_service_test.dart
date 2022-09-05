// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:test/test.dart';

void main() {
  group('toServiceQuery', () {
    test('query with with a single sdk parameter', () {
      final form = SearchForm.parse({'q': 'sdk:dart some framework'});
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
        [],
      );
      expect(
        SearchForm(query: 'show:unlisted')
            .toServiceQuery()
            .toUriQueryParameters()['tags'],
        [],
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
