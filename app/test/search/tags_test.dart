// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:test/test.dart';

import 'package:pub_dev/search/index_simple.dart';
import 'package:pub_dev/search/search_service.dart';

void main() {
  group('SearchQuery.tags', () {
    test('No tags in documents: positive tag match', () async {
      final index = SimplePackageIndex();
      await index.addPackage(PackageDocument(package: 'pkg1'));
      await index.markReady();

      final rs = await index.search(SearchQuery.parse(
        tagsPredicate: TagsPredicate(requiredTags: ['is:a']),
      ));
      expect(rs.toJson(), {
        'indexUpdated': isNotEmpty,
        'totalCount': 0,
        'packages': [],
      });
    });

    test('No tags in documents: negative tag match', () async {
      final index = SimplePackageIndex();
      await index.addPackage(PackageDocument(package: 'pkg1'));
      await index.markReady();

      final rs = await index.search(SearchQuery.parse(
        tagsPredicate: TagsPredicate(prohibitedTags: ['is:a']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'indexUpdated': isNotEmpty,
        'totalCount': 1,
        'packages': [
          {'package': 'pkg1', 'score': isNotNull},
        ],
      });
    });

    test('One tag in documents: negative tag match', () async {
      final index = SimplePackageIndex();
      await index.addPackage(PackageDocument(package: 'pkg1', tags: ['is:a']));
      await index.addPackage(PackageDocument(package: 'pkg2', tags: ['is:b']));
      await index.markReady();

      final rs = await index.search(SearchQuery.parse(
        tagsPredicate: TagsPredicate(prohibitedTags: ['is:a']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'indexUpdated': isNotEmpty,
        'totalCount': 1,
        'packages': [
          {'package': 'pkg2', 'score': isNotNull},
        ],
      });
    });

    test('One tag in documents: positive tag match', () async {
      final index = SimplePackageIndex();
      await index.addPackage(PackageDocument(package: 'pkg1', tags: ['is:a']));
      await index.addPackage(PackageDocument(package: 'pkg2', tags: ['is:b']));
      await index.markReady();

      final rs = await index.search(SearchQuery.parse(
        tagsPredicate: TagsPredicate.parseQueryValues(['is:a']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'indexUpdated': isNotEmpty,
        'totalCount': 1,
        'packages': [
          {'package': 'pkg1', 'score': isNotNull},
        ],
      });
    });

    test('More tags in documents: multiple results', () async {
      final index = SimplePackageIndex();
      await index.addPackage(
          PackageDocument(package: 'pkg1', tags: ['is:a', 'is:dart1']));
      await index.addPackage(
          PackageDocument(package: 'pkg2', tags: ['is:b', 'is:dart1']));
      await index.markReady();

      final rs = await index.search(SearchQuery.parse(
        tagsPredicate: TagsPredicate.parseQueryValues(['is:dart1']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'indexUpdated': isNotEmpty,
        'totalCount': 2,
        'packages': [
          {'package': 'pkg1', 'score': isNotNull},
          {'package': 'pkg2', 'score': isNotNull},
        ],
      });
    });

    test('More tags in documents: multiple queried tags #1', () async {
      final index = SimplePackageIndex();
      await index.addPackage(
          PackageDocument(package: 'pkg1', tags: ['is:a', 'is:dart1']));
      await index.addPackage(
          PackageDocument(package: 'pkg2', tags: ['is:b', 'is:dart1']));
      await index.markReady();

      final rs = await index.search(SearchQuery.parse(
        tagsPredicate: TagsPredicate.parseQueryValues(['is:dart1', 'is:b']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'indexUpdated': isNotEmpty,
        'totalCount': 1,
        'packages': [
          {'package': 'pkg2', 'score': isNotNull},
        ],
      });
    });

    test('More tags in documents: multiple queried tags #2', () async {
      final index = SimplePackageIndex();
      await index.addPackage(
          PackageDocument(package: 'pkg1', tags: ['is:a', 'is:dart1']));
      await index.addPackage(
          PackageDocument(package: 'pkg2', tags: ['is:b', 'is:dart1']));
      await index.markReady();

      final rs = await index.search(SearchQuery.parse(
        tagsPredicate: TagsPredicate.parseQueryValues(['is:dart1', '-is:b']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'indexUpdated': isNotEmpty,
        'totalCount': 1,
        'packages': [
          {'package': 'pkg1', 'score': isNotNull},
        ],
      });
    });

    test('User-supplied queried tags #1', () async {
      final index = SimplePackageIndex();
      await index
          .addPackage(PackageDocument(package: 'pkg1', tags: ['is:a', 'is:b']));
      await index.addPackage(PackageDocument(package: 'pkg2', tags: ['is:b']));
      await index.markReady();

      final rs = await index.search(SearchQuery.parse(query: 'is:b -is:a'));
      expect(json.decode(json.encode(rs.toJson())), {
        'indexUpdated': isNotEmpty,
        'totalCount': 1,
        'packages': [
          {'package': 'pkg2', 'score': isNotNull},
        ],
      });
    });

    test('User-supplied queried tags #2', () async {
      final index = SimplePackageIndex();
      await index
          .addPackage(PackageDocument(package: 'pkg1', tags: ['is:a', 'is:b']));
      await index.addPackage(PackageDocument(package: 'pkg2', tags: ['is:a']));
      await index.markReady();

      final rs = await index.search(SearchQuery.parse(
          tagsPredicate: TagsPredicate(prohibitedTags: ['is:b']),
          query: 'is:a is:b'));
      expect(json.decode(json.encode(rs.toJson())), {
        'indexUpdated': isNotEmpty,
        'totalCount': 1,
        'packages': [
          {'package': 'pkg1', 'score': isNotNull},
        ],
      });
    });
  });
}
