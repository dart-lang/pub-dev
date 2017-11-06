// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('vm')
import 'dart:async';

import 'package:build_barback/build_barback.dart';
import 'package:barback/barback.dart' as barback;
import 'package:test/test.dart';
import 'package:build_test/build_test.dart';

void main() {
  test('basic test', () async {
    final copyTransformerBuilder = new TransformerBuilder(
      new CopyTransformer(),
      const {
        '': const ['.copy']
      },
    );

    await testBuilder(copyTransformerBuilder, {
      'a|web/a.txt': 'a',
    }, outputs: {
      'a|web/a.txt.copy': 'a',
    });
  });
}

class CopyTransformer extends barback.Transformer
    with barback.DeclaringTransformer {
  @override
  Future apply(barback.Transform transform) async {
    var contents = await transform.primaryInput.readAsString();
    transform.addOutput(new barback.Asset.fromString(
        _toGeneratedAssetId(transform.primaryInput.id), contents));
  }

  @override
  void declareOutputs(barback.DeclaringTransform transform) {
    transform.declareOutput(_toGeneratedAssetId(transform.primaryId));
  }

  barback.AssetId _toGeneratedAssetId(barback.AssetId id) =>
      id.addExtension('.copy');
}
