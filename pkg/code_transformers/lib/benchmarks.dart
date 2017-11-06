// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library code_transformers.benchmarks;

import 'dart:async';
import 'package:barback/barback.dart';
import 'src/async_benchmark_base.dart';

/// A benchmark for testing the performance of transformer phases.
class TransformerBenchmark extends AsyncBenchmarkBase {
  /// Internal abstraction layer for barback.
  _BenchmarkHelper _helper;

  /// The transformer phases to be ran.
  final List<List<Transformer>> transformers;

  /// The files to pass to barback.
  final Map<AssetId, String> files;

  TransformerBenchmark(this.transformers, this.files);

  @override
  Future setup() {
    _helper = new _BenchmarkHelper(transformers, files);
    return new Future.value();
  }

  @override
  Future run() => _helper.run();

  @override
  teardown() {
    _helper = null;
    return new Future.value();
  }
}

/// Barback abstraction layer.
class _BenchmarkHelper implements PackageProvider {
  /// All the files available.
  final Map<AssetId, String> _files;

  /// All the packages.
  final Iterable<String> packages;

  /// Internal instance of barback.
  Barback _barback;

  /// Subscription to barback results.
  StreamSubscription<BuildResult> resultSubscription;

  _BenchmarkHelper(
      List<List<Transformer>> transformers, Map<AssetId, String> files)
      : _files = files,
        packages = new Set.from(files.keys.map((assetId) => assetId.package)) {
    _barback = new Barback(this);
    for (var package in packages) {
      _barback.updateTransformers(package, transformers);
    }
  }

  /// Look up an [AssetId] in [files] and return an [Asset] for it.
  @override
  Future<Asset> getAsset(AssetId id) =>
      new Future.value(new Asset.fromString(id, _files[id]));

  /// Tells barback which files have changed, and thus anything that depends on
  /// it on should be computed. Returns a [Future] that completes once some
  /// results are received.
  Future run([Iterable<AssetId> assetIds]) {
    if (assetIds == null) assetIds = _files.keys;
    _barback.updateSources(assetIds);
    return _barback.results.first;
  }
}
