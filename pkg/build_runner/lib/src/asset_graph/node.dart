// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:build/build.dart';

/// A node in the asset graph which may be an input to other assets.
class AssetNode {
  final AssetId id;

  /// The assets that any [Builder] in the build graph declares it may output
  /// when run on this asset.
  final Set<AssetId> primaryOutputs = new Set<AssetId>();

  /// The [AssetId]s of all generated assets which are output by a [Builder]
  /// which reads this asset.
  final Set<AssetId> outputs = new Set<AssetId>();

  AssetNode(this.id);

  factory AssetNode.deserialize(List serializedNode) {
    AssetNode node;
    if (serializedNode.length == 3) {
      node = new AssetNode(new AssetId.deserialize(serializedNode[0] as List));
    } else if (serializedNode.length == 6) {
      node = new GeneratedAssetNode.deserialize(serializedNode);
    } else {
      throw new ArgumentError(
          'Unrecognized serialization format! $serializedNode');
    }
    node._addSerializedOutputs(serializedNode);
    return node;
  }

  void _addSerializedOutputs(List serialized) {
    outputs.addAll(new List.from(serialized[1]
        .map((id) => new AssetId.deserialize(id as List)) as Iterable));
    primaryOutputs.addAll(new List.from(serialized[2]
        .map((id) => new AssetId.deserialize(id as List)) as Iterable));
  }

  List serialize() => [
        id.serialize(),
        outputs.map((id) => id.serialize()).toList(),
        primaryOutputs.map((id) => id.serialize()).toList(),
      ];

  @override
  String toString() => 'AssetNode: $id';
}

/// A generated node in the asset graph.
class GeneratedAssetNode extends AssetNode {
  /// The phase which generated this asset.
  final int phaseNumber;

  /// The primary input which generated this node.
  final AssetId primaryInput;

  /// Whether or not this asset needs to be updated.
  bool needsUpdate;

  /// Whether the asset was actually output.
  bool wasOutput;

  GeneratedAssetNode(this.phaseNumber, this.primaryInput, this.needsUpdate,
      this.wasOutput, AssetId id)
      : super(id);

  factory GeneratedAssetNode.deserialize(List serialized) {
    var node = new GeneratedAssetNode(
        serialized[5] as int,
        new AssetId.deserialize(serialized[3] as List),
        false,
        serialized[4] as bool,
        new AssetId.deserialize(serialized[0] as List));
    node._addSerializedOutputs(serialized);
    return node;
  }

  @override
  List serialize() => super.serialize()
    ..addAll([primaryInput.serialize(), wasOutput, phaseNumber]);

  @override
  String toString() =>
      'GeneratedAssetNode: $id generated from input $primaryInput.';
}
