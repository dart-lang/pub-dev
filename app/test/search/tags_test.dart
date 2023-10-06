// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/search/search_form.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:test/test.dart';

void main() {
  group('ServiceSearchQuery.tags', () {
    test('No tags in documents: positive tag match', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(package: 'pkg1'),
      ]);

      final rs = index.search(ServiceSearchQuery.parse(
        tagsPredicate: TagsPredicate(requiredTags: ['is:a']),
      ));
      expect(rs.toJson(), {
        'timestamp': isNotNull,
        'totalCount': 0,
        'sdkLibraryHits': [],
        'packageHits': [],
      });
    });

    test('No tags in documents: negative tag match', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(package: 'pkg1'),
      ]);

      final rs = index.search(ServiceSearchQuery.parse(
        tagsPredicate: TagsPredicate(prohibitedTags: ['is:a']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'pkg1', 'score': isNotNull},
        ],
      });
    });

    test('One tag in documents: negative tag match', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(package: 'pkg1', tags: ['is:a']),
        PackageDocument(package: 'pkg2', tags: ['is:b']),
      ]);

      final rs = index.search(ServiceSearchQuery.parse(
        tagsPredicate: TagsPredicate(prohibitedTags: ['is:a']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'pkg2', 'score': isNotNull},
        ],
      });
    });

    test('One tag in documents: positive tag match', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(package: 'pkg1', tags: ['is:a']),
        PackageDocument(package: 'pkg2', tags: ['is:b']),
      ]);

      final rs = index.search(ServiceSearchQuery.parse(
        tagsPredicate: TagsPredicate.parseQueryValues(['is:a']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'pkg1', 'score': isNotNull},
        ],
      });
    });

    test('More tags in documents: multiple results', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(package: 'pkg1', tags: ['is:a', 'is:dart1']),
        PackageDocument(package: 'pkg2', tags: ['is:b', 'is:dart1']),
      ]);

      final rs = index.search(ServiceSearchQuery.parse(
        tagsPredicate: TagsPredicate.parseQueryValues(['is:dart1']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'timestamp': isNotNull,
        'totalCount': 2,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'pkg1', 'score': isNotNull},
          {'package': 'pkg2', 'score': isNotNull},
        ],
      });
    });

    test('More tags in documents: multiple queried tags #1', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(package: 'pkg1', tags: ['is:a', 'is:dart1']),
        PackageDocument(package: 'pkg2', tags: ['is:b', 'is:dart1']),
      ]);

      final rs = index.search(ServiceSearchQuery.parse(
        tagsPredicate: TagsPredicate.parseQueryValues(['is:dart1', 'is:b']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'pkg2', 'score': isNotNull},
        ],
      });
    });

    test('More tags in documents: multiple queried tags #2', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(package: 'pkg1', tags: ['is:a', 'is:dart1']),
        PackageDocument(package: 'pkg2', tags: ['is:b', 'is:dart1']),
      ]);

      final rs = index.search(ServiceSearchQuery.parse(
        tagsPredicate: TagsPredicate.parseQueryValues(['is:dart1', '-is:b']),
      ));
      expect(json.decode(json.encode(rs.toJson())), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'pkg1', 'score': isNotNull},
        ],
      });
    });

    test('User-supplied queried tags #1', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(package: 'pkg1', tags: ['is:a', 'is:b']),
        PackageDocument(package: 'pkg2', tags: ['is:b']),
      ]);

      final rs = index.search(ServiceSearchQuery.parse(query: 'is:b -is:a'));
      expect(json.decode(json.encode(rs.toJson())), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'pkg2', 'score': isNotNull},
        ],
      });
    });

    test('User-supplied queried tags #2', () async {
      final index = InMemoryPackageIndex(documents: [
        PackageDocument(package: 'pkg1', tags: ['is:a', 'is:b']),
        PackageDocument(package: 'pkg2', tags: ['is:a']),
      ]);

      final rs = index.search(ServiceSearchQuery.parse(
          tagsPredicate: TagsPredicate(prohibitedTags: ['is:b']),
          query: 'is:a is:b'));
      expect(json.decode(json.encode(rs.toJson())), {
        'timestamp': isNotNull,
        'totalCount': 1,
        'sdkLibraryHits': [],
        'packageHits': [
          {'package': 'pkg1', 'score': isNotNull},
        ],
      });
    });
  });
}
