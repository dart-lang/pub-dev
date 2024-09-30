// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:html/parser.dart' as html_parser;
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart' as _utils;
import '../shared/handlers_test_utils.dart';
import '../shared/test_services.dart';
import '../shared/utils.dart';
import 'handlers_test_utils.dart';

void main() {
  group('handlers', () {
    group('not found', () {
      scopedTest('/xxx', () async {
        await expectNotFoundResponse(await issueGet('/xxx'));
      });
      scopedTest('/packages', () async {
        await expectNotFoundResponse(await issueGet('/packages'));
      });

      scopedTest('/packages/unknown', () async {
        await expectNotFoundResponse(await issueGet('/packages/unknown'));
      });
    });

    group('search', () {
      testWithProfile('Finds package by name', fn: () async {
        await expectJsonResponse(await issueGet('/search?q=oxygen'), body: {
          'timestamp': isNotNull,
          'totalCount': 1,
          'nameMatches': ['oxygen'],
          'sdkLibraryHits': [],
          'packageHits': [
            {'package': 'oxygen', 'score': isPositive},
          ],
        });
      });

      testWithProfile('Finds text in description or readme', fn: () async {
        await expectJsonResponse(await issueGet('/search?q=awesome'), body: {
          'timestamp': isNotNull,
          'totalCount': 3,
          'sdkLibraryHits': [],
          'packageHits': hasLength(3),
        });
      });

      testWithProfile('Finds package by package-prefix search only',
          fn: () async {
        await expectJsonResponse(await issueGet('/search?q=package:oxy'),
            body: {
              'timestamp': isNotNull,
              'totalCount': 1,
              'sdkLibraryHits': [],
              'packageHits': [
                {
                  'package': 'oxygen',
                  'score': isNotNull,
                },
              ],
            });
      });

      testWithProfile('pkg-prefix filters out results', fn: () async {
        await expectJsonResponse(await issueGet('/search?q=awesome+package:x'),
            body: {
              'timestamp': isNotNull,
              'totalCount': 0,
              'sdkLibraryHits': [],
              'packageHits': [],
            });
      });
    });
  });

  group('sort', () {
    Future<List<String>> queryPackageOrder(String url) async {
      final rs = await _utils.issueGet(url);
      return html_parser
          .parse(await rs.readAsString())
          .body!
          .querySelectorAll('a')
          .map((e) => e.attributes['href'])
          .nonNulls
          .where((p) => p.startsWith('/packages/'))
          .where((p) => p.endsWith('/score'))
          .map((p) => p.split('/')[2])
          .toList();
    }

    testWithProfile(
      'input text predicate overrides URL parameter',
      fn: () async {
        expect(
          await queryPackageOrder('/packages?sort=points'),
          ['oxygen', 'neon', 'flutter_titanium'],
        );
        expect(
          await queryPackageOrder('/packages?sort=popularity'),
          ['flutter_titanium', 'neon', 'oxygen'],
        );
        expect(
          await queryPackageOrder('/packages?sort=popularity&q=sort:points'),
          ['oxygen', 'neon', 'flutter_titanium'],
        );
      },
      processJobsWithFakeRunners: true,
    );
  });
}
