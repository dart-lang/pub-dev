// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:test/test.dart';

import 'package:build_runner/src/asset_graph/exceptions.dart';
import 'package:build_runner/src/asset_graph/graph.dart';
import 'package:build_runner/src/asset_graph/node.dart';

final Matcher assetGraphVersionException =
    new isInstanceOf<AssetGraphVersionException>();
final Matcher duplicateAssetNodeException =
    new isInstanceOf<DuplicateAssetNodeException>();

Matcher equalsAssetGraph(AssetGraph expected, {bool checkValidAsOf}) =>
    new _AssetGraphMatcher(expected, checkValidAsOf ?? false);

class _AssetGraphMatcher extends Matcher {
  final AssetGraph _expected;
  final bool _checkValidAsOf;

  const _AssetGraphMatcher(this._expected, this._checkValidAsOf);

  @override
  bool matches(dynamic item, _) {
    if (item is! AssetGraph) return false;
    var graph = item as AssetGraph;
    if (graph.allNodes.length != _expected.allNodes.length) return false;
    if (_checkValidAsOf && (graph.validAsOf != _expected.validAsOf)) {
      return false;
    }
    for (var node in graph.allNodes) {
      var expectedNode = _expected.get(node.id);
      if (expectedNode == null || expectedNode.id != node.id) return false;
      if (!unorderedEquals(node.outputs).matches(expectedNode.outputs, null)) {
        return false;
      }
      if (!unorderedEquals(node.primaryOutputs)
          .matches(expectedNode.primaryOutputs, null)) {
        return false;
      }
      if (node is GeneratedAssetNode) {
        if (expectedNode is GeneratedAssetNode) {
          if (node.primaryInput != expectedNode.primaryInput) return false;
          if (node.needsUpdate != expectedNode.needsUpdate) return false;
          if (node.wasOutput != expectedNode.wasOutput) return false;
        } else {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Description describe(Description description) =>
      description.addDescriptionOf(_expected);
}
