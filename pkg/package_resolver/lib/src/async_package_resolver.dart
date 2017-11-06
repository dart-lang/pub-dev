// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package_resolver.dart';
import 'sync_package_resolver.dart';

/// An implementation of [PackageResolver] that wraps a [SyncPackageResolver].
class AsyncPackageResolver implements PackageResolver {
  /// The wrapped [SyncPackageResolver].
  final SyncPackageResolver _inner;

  AsyncPackageResolver(this._inner);

  Future<Map<String, Uri>> get packageConfigMap async =>
      _inner.packageConfigMap;

  Future<Uri> get packageConfigUri async => _inner.packageConfigUri;
  Future<Uri> get packageRoot async => _inner.packageRoot;
  Future<SyncPackageResolver> get asSync async => _inner;
  Future<String> get processArgument async => _inner.processArgument;

  Future<Uri> resolveUri(packageUri) async => _inner.resolveUri(packageUri);
  Future<Uri> urlFor(String package, [String path]) async =>
      _inner.urlFor(package, path);
  Future<Uri> packageUriFor(url) async => _inner.packageUriFor(url);
  Future<String> packagePath(String package) async =>
      _inner.packagePath(package);
}
