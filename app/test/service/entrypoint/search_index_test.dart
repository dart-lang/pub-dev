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
    late IsolateRunner primaryRunner;
    late IsolateRunner reducedRunner;

    tearDown(() async {
      await primaryRunner.close();
      await reducedRunner.close();
    });

    test('start and work with local index', () async {
      await withTempDirectory((tempDir) async {
        // NOTE: The primary and the reduced index loads two different dataset,
        //       in order to make the testing of the executation path unambigious.
        final primaryPath = p.join(tempDir.path, 'primary.json.gz');
        await saveInMemoryPackageIndexToFile(
          [
            PackageDocument(
              package: 'json_annotation',
              description: 'Annotation metadata for JSON serialization.',
              tags: ['sdk:dart'],
            ),
          ],
          primaryPath,
        );

        primaryRunner = await startSearchIsolate(snapshot: primaryPath);

        final reducedPath = p.join(tempDir.path, 'reduced.json.gz');
        await saveInMemoryPackageIndexToFile(
          [
            PackageDocument(
              package: 'reduced_json_annotation',
              description: 'Annotation metadata for JSON serialization.',
              tags: ['sdk:dart'],
              downloadScore: 1.0,
              maxPoints: 100,
              grantedPoints: 100,
            ),
          ],
          reducedPath,
        );

        reducedRunner = await startSearchIsolate(snapshot: reducedPath);

        await primaryRunner.start(1);
        await reducedRunner.start(1);

        // index calling the sendport
        final searchIndex = IsolateSearchIndex(primaryRunner, reducedRunner);
        expect(await searchIndex.isReady(), true);

        // text query - result from primary index
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

        // predicate query - result from reduced index
        final rs2 = await searchIndex
            .search(ServiceSearchQuery.parse(query: 'sdk:dart'));
        expect(rs2.toJson(), {
          'timestamp': isNotEmpty,
          'totalCount': 1,
          'sdkLibraryHits': [],
          'packageHits': [
            {
              'package': 'reduced_json_annotation',
              'score': greaterThan(0.5),
            },
          ],
        });
      });
    }, timeout: Timeout(Duration(minutes: 5)));
  });
}
