// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/search/backend.dart';
import 'package:pub_dev/search/sdk_mem_index.dart';
import 'package:pub_dev/tool/test_profile/importer.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('search backend', () {
    testWithProfile(
      'fetch SDK library description',
      fn: () async {
        final content = await loadOrFetchSdkIndexJsonAsString(
          SdkMemIndex.dartSdkIndexJsonUri,
        );
        final index = SdkMemIndex(
          dartIndex: DartdocIndex.parseJsonText(content),
          flutterIndex: DartdocIndex([]),
        );
        final rs = await index.search('dart:async');
        expect(
          rs.first.description,
          'Support for asynchronous programming, with classes such as Future and Stream.',
        );
      },
    );

    testWithProfile(
      'updates snapshot storage',
      fn: () async {
        var documents = await searchBackend.fetchSnapshotDocuments();
        expect(documents, isNull);
        await searchBackend.doCreateAndUpdateSnapshot(
          FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3))),
          concurrency: 2,
          sleepDuration: Duration(milliseconds: 300),
        );
        documents = await searchBackend.fetchSnapshotDocuments();
        expect(documents, isNotEmpty);
      },
    );

    testWithProfile(
      'picks up packages updated during the initial scan',
      fn: () async {
        // The claim needs to outlive the clock jump below.
        final claim = FakeGlobalLockClaim(clock.now().add(Duration(hours: 1)));
        final snapshotBuild = searchBackend.doCreateAndUpdateSnapshot(
          claim,
          concurrency: 2,
          sleepDuration: Duration(seconds: 3),
        );

        // Wait for the initial scan to complete and upload its snapshot.
        while (await searchBackend.fetchSnapshotDocuments() == null) {
          await Future.delayed(Duration(milliseconds: 10));
        }

        // Publish a package as if it had happened while the initial scan was
        // running, then move the clock well past the 5 minute window that the
        // incremental query looks back by.
        await importProfile(
          profile: TestProfile(
            defaultUser: 'admin@pub.dev',
            generatedPackages: [
              GeneratedTestPackage(
                name: 'late_arrival',
                versions: [GeneratedTestVersion(version: '1.0.0')],
                publisher: 'example.com',
              ),
            ],
          ),
        );
        clockControl.elapse(minutes: 30);

        // The monitoring loop should pick the package up in its first query.
        // The deadline uses wall-clock time, as [clock] is under test control.
        final deadline = DateTime.now().add(Duration(seconds: 15));
        var documents = await searchBackend.fetchSnapshotDocuments();
        while (!documents!.any((d) => d.package == 'late_arrival') &&
            DateTime.now().isBefore(deadline)) {
          await Future.delayed(Duration(milliseconds: 50));
          documents = await searchBackend.fetchSnapshotDocuments();
        }

        claim.expires = clock.now();
        await snapshotBuild;

        expect(documents.map((d) => d.package), contains('late_arrival'));
      },
    );
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
        canonicalizeSearchForm(_parse('abc topic:unrelated-topic')),
        isNull,
      );
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

    test('query with topic shortcut `#`', () {
      expect(
        canonicalizeSearchForm(_parse('#widget #testing'))?.query,
        'topic:widget topic:testing',
      );
    });
  });
}
