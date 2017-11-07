// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';

import '../analyzer/resolver.dart';
import '../asset/id.dart';
import '../asset/reader.dart';
import '../asset/writer.dart';
import '../resource/resource.dart';

/// A single step in a build process.
///
/// This represents a single [inputId], logic around resolving as a library,
/// and the ability to read and write assets as allowed by the underlying build
/// system.
abstract class BuildStep implements AssetReader, AssetWriter {
  /// The primary for this build step.
  AssetId get inputId;

  /// Resolved library defined by [inputId].
  ///
  /// Throws [NonLibraryAssetException] if [inputId] is not a Dart library file.
  Future<LibraryElement> get inputLibrary;

  /// Gets an instance provided by [resource] which is guaranteed to be unique
  /// within a single build, and may be reused across build steps within a
  /// build if the implementation allows.
  ///
  /// It is also guaranteed that [resource] will be disposed before the next
  /// build starts (and the dispose callback will be invoked if provided).
  Future<T> fetchResource<T>(Resource<T> resource);

  /// Writes [bytes] to a binary file located at [id].
  ///
  /// Returns a [Future] that completes after writing the asset out.
  ///
  /// * Throws a `PackageNotFoundException` if `id.package` is not found.
  /// * Throws an `InvalidOutputException` if the output was not valid.
  ///
  /// **NOTE**: Most `Builder` implementations should not need to `await` this
  /// Future since the runner will be responsible for waiting until all outputs
  /// are written.
  @override
  Future writeAsBytes(AssetId id, FutureOr<List<int>> bytes);

  /// Writes [contents] to a text file located at [id] with [encoding].
  ///
  /// Returns a [Future] that completes after writing the asset out.
  ///
  /// * Throws a `PackageNotFoundException` if `id.package` is not found.
  /// * Throws an `InvalidOutputException` if the output was not valid.
  ///
  /// **NOTE**: Most `Builder` implementations should not need to `await` this
  /// Future since the runner will be responsible for waiting until all outputs
  /// are written.
  @override
  Future writeAsString(AssetId id, FutureOr<String> contents,
      {Encoding encoding: UTF8});

  /// A [Resolver] for [inputId].
  Resolver get resolver;
}
