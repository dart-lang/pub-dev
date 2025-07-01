// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:path/path.dart' as p;
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/updater.dart';
import 'package:pub_dev/service/entrypoint/_isolate.dart';
import 'package:pub_dev/service/entrypoint/search_index.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Search index inside an isolate', () {
    late IsolateRunner runner;

    tearDown(() async {
      await runner.close();
    });

    test('start and work with local index', () async {
      await withTempDirectory((tempDir) async {
        final snapshotPath = p.join(tempDir.path, 'snapshot.json.gz');
        await saveInMemoryPackageIndexToFile(
          [
            PackageDocument(
              package: 'json_annotation',
              description: 'Annotation metadata for JSON serialization.',
              tags: ['sdk:dart'],
            ),
          ],
          snapshotPath,
        );

        runner = await startSearchIsolate(snapshot: snapshotPath);

        // index calling the sendport
        final searchIndex = IsolateSearchIndex(runner);
        expect(await searchIndex.isReady(), true);

        // text query - result from package index
        final rs =
            await searchIndex.search(ServiceSearchQuery.parse(query: 'json'));
        expect(rs.toJson(), {
          'timestamp': isNotEmpty,
          'totalCount': 1,
          'sdkLibraryHits': [],
          'packageHits': [
            {
              'package': 'json_annotation',
              'score': greaterThan(0.5),
            },
          ],
        });
      });
    }, timeout: Timeout(Duration(minutes: 5)));
  });
}
