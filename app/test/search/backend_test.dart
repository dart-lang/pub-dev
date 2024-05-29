// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/search/backend.dart';
import 'package:pub_dev/search/sdk_mem_index.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('search backend', () {
    testWithProfile('fetch SDK library description', fn: () async {
      final index = await SdkMemIndex.dart();
      final descr = await searchBackend.fetchSdkLibraryDescriptions(
        baseUri: index.baseUri,
        libraryRelativeUrls: {
          'dart:async': 'dart-async/dart-async-library.html',
        },
      );
      expect(descr, {
        'dart:async':
            'Support for asynchronous programming, with classes such as Future and Stream.',
      });
    });

    testWithProfile('updates snapshot storage', fn: () async {
      var documents = await searchBackend.fetchSnapshotDocuments();
      expect(documents, isNull);
      await searchBackend.doCreateAndUpdateSnapshot(
        FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
        concurrency: 2,
        sleepDuration: Duration(milliseconds: 300),
      );
      documents = await searchBackend.fetchSnapshotDocuments();
      expect(documents, isNotEmpty);
    });
  });

  group('canonical search form', () {
    SearchForm _parse(String text) {
      return SearchForm.parse({'q': text});
    }

    test('query without tags', () {
      expect(canonicalizeSearchForm(_parse('abc')), isNull);
    });

    test('query with unrelated tags', () {
      expect(canonicalizeSearchForm(_parse('abc is:null-safe')), isNull);
      expect(canonicalizeSearchForm(_parse('is:null-safe')), isNull);
    });

    test('query with non-aliased topic tags', () {
      expect(
          canonicalizeSearchForm(_parse('abc topic:unrelated-topic')), isNull);
      expect(canonicalizeSearchForm(_parse('topic:unrelated-topic')), isNull);
    });

    test('query with topic tags', () {
      expect(
        canonicalizeSearchForm(_parse('topic:widgets'))?.query,
        'topic:widget',
      );
      expect(
        canonicalizeSearchForm(_parse('abc topic:widgets'))?.query,
        'topic:widget abc',
      );
    });
  });
}
