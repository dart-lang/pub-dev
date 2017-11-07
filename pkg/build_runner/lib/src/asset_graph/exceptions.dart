// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'node.dart';

class DuplicateAssetNodeException implements Exception {
  final AssetNode assetNode;

  DuplicateAssetNodeException(this.assetNode);

  @override
  String toString() => 'DuplicateAssetNodeError: $assetNode';
}

class AssetGraphVersionException implements Exception {
  final int versionSeen;
  final int currentVersion;

  AssetGraphVersionException(this.versionSeen, this.currentVersion);

  @override
  String toString() => 'AssetGraphVersionException: saw version $versionSeen '
      'but the current version is $currentVersion.';
}
