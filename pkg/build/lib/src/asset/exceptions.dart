// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'id.dart';

class AssetNotFoundException implements Exception {
  final AssetId assetId;

  AssetNotFoundException(this.assetId);

  @override
  String toString() => 'AssetNotFoundException: $assetId';
}

class PackageNotFoundException implements Exception {
  final String name;

  PackageNotFoundException(this.name);

  @override
  String toString() => 'PackageNotFoundException: $name';
}

class InvalidOutputException implements Exception {
  final AssetId assetId;
  final String message;

  InvalidOutputException(this.assetId, this.message);

  @override
  String toString() => 'InvalidOutputException: $assetId\n$message';
}

class InvalidInputException implements Exception {
  final AssetId assetId;

  InvalidInputException(this.assetId);

  @override
  String toString() => 'InvalidInputException: $assetId\n'
      'For package dependencies, only files under `lib` may be used as inputs.';
}
