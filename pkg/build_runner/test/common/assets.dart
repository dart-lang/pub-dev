// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:build/build.dart';
import 'package:build_runner/src/asset_graph/node.dart';
import 'package:build_test/build_test.dart';

AssetNode makeAssetNode([String assetIdString, List<AssetId> outputs]) {
  var node = new AssetNode(makeAssetId(assetIdString));
  if (outputs != null) {
    node.outputs.addAll(outputs);
    node.primaryOutputs.addAll(outputs);
  }
  return node;
}
