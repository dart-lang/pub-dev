// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('vm')
library code_transformers.test.benchmarks_test;

import 'package:barback/barback.dart';
import 'package:code_transformers/benchmarks.dart';
import 'package:test/test.dart';

main() {
  test('can benchmark transformers', () {
    var transformer = new TestTransformer();
    var transformers = [
      [transformer]
    ];
    var id = new AssetId('foo', 'lib/bar.dart');
    var files = {
      id: 'library foo.bar;',
    };
    var benchmark = new TransformerBenchmark(transformers, files);
    return benchmark.measure().then((result) {
      expect(result, greaterThan(0));
      expect(transformer.filesSeen[id], isNotNull);
      expect(transformer.filesSeen[id], greaterThanOrEqualTo(10));
    });
  });
}

class TestTransformer extends Transformer {
  /// Map of the asset ids that were seen to how many times they were seen.
  Map<AssetId, int> filesSeen = {};

  @override
  bool isPrimary(AssetId id) => true;

  @override
  void apply(Transform transform) {
    filesSeen.putIfAbsent(transform.primaryInput.id, () => 0);
    filesSeen[transform.primaryInput.id] += 1;
  }
}
