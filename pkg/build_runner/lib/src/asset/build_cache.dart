import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:glob/glob.dart';

import '../asset_graph/graph.dart';
import '../asset_graph/node.dart';
import '../util/constants.dart';
import 'writer.dart';

/// Wraps an [AssetReader] and translates reads for generated files into reads
/// from the build cache directory
class BuildCacheReader implements AssetReader {
  final AssetReader _delegate;
  final AssetGraph _assetGraph;
  final String _rootPackage;

  BuildCacheReader(this._delegate, this._assetGraph, this._rootPackage);

  @override
  Future<bool> canRead(AssetId id) =>
      _delegate.canRead(cacheLocation(id, _assetGraph, _rootPackage));

  @override
  Future<List<int>> readAsBytes(AssetId id) =>
      _delegate.readAsBytes(cacheLocation(id, _assetGraph, _rootPackage));

  @override
  Future<String> readAsString(AssetId id, {Encoding encoding: UTF8}) =>
      _delegate.readAsString(cacheLocation(id, _assetGraph, _rootPackage),
          encoding: encoding);

  @override
  Iterable<AssetId> findAssets(Glob glob) => throw new UnimplementedError(
      'Asset globbing should be done per phase with the AssetGraph');
}

class BuildCacheWriter implements RunnerAssetWriter {
  final RunnerAssetWriter _delegate;
  final AssetGraph _assetGraph;
  final String _rootPackage;

  BuildCacheWriter(this._delegate, this._assetGraph, this._rootPackage);

  @override
  Future writeAsBytes(AssetId id, List<int> content) => _delegate.writeAsBytes(
      cacheLocation(id, _assetGraph, _rootPackage), content);
  @override
  Future writeAsString(AssetId id, String content, {Encoding encoding: UTF8}) =>
      _delegate.writeAsString(
          cacheLocation(id, _assetGraph, _rootPackage), content,
          encoding: encoding);
  @override
  Future delete(AssetId id) =>
      _delegate.delete(cacheLocation(id, _assetGraph, _rootPackage));
}

AssetId cacheLocation(AssetId id, AssetGraph assetGraph, String rootPackage) {
  if (id.path.startsWith(generatedOutputDirectory) ||
      id.path.startsWith(cacheDir)) {
    return id;
  }
  if (!assetGraph.contains(id)) {
    throw new ArgumentError('$id  is not a valid asset');
  }
  if (assetGraph.get(id) is GeneratedAssetNode) {
    return new AssetId(
        rootPackage, '$cacheDir/generated/${id.package}/${id.path}');
  }
  return id;
}
