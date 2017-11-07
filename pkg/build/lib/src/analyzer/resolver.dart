// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'package:analyzer/dart/element/element.dart';

import '../asset/id.dart';
import '../builder/build_step.dart';

/// Standard interface for resolving Dart source code as part of a build.
abstract class Resolver {
  /// Returns whether [assetId] represents an Dart library file.
  ///
  /// This will be `false` in the case where the file is not Dart source code,
  /// or is a `part of` file (not a standalone Dart library).
  Future<bool> isLibrary(AssetId assetId);

  /// All libraries accessible from the entry point, recursively.
  ///
  /// **NOTE**: This includes all Dart SDK libraries as well.
  Stream<LibraryElement> get libraries;

  /// Returns a resolved library representing the file defined in [assetId].
  ///
  /// * Throws [NonLibraryAssetException] if [assetId] is not a Dart library.
  Future<LibraryElement> libraryFor(AssetId assetId);

  /// Returns the first library identified by [libraryName].
  ///
  /// If no library can be found, returns `null`.
  ///
  /// **NOTE**: In general, its recommended to use [libraryFor] with an absolute
  /// asset id instead of a named identifier that has the possibility of not
  /// being unique.
  Future<LibraryElement> findLibraryByName(String libraryName);
}

/// A resolver that should be manually released at the end of a build step.
abstract class ReleasableResolver implements Resolver {
  /// Release this resolver so it can be updated by following build steps.
  void release();
}

/// A factory that returns a resolver for a given [BuildStep].
abstract class Resolvers {
  Future<ReleasableResolver> get(BuildStep buildStep);
}

/// Thrown when attempting to read a non-Dart library in a [Resolver].
class NonLibraryAssetException implements Exception {
  final AssetId assetId;

  const NonLibraryAssetException(this.assetId);

  @override
  String toString() => 'Asset [$assetId] is not a Dart library source file.';
}
