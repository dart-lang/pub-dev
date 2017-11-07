// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'package:analyzer/analyzer.dart' show parseDirectives;
import 'package:build/build.dart';

import 'package:analyzer/dart/ast/ast.dart';

typedef FutureOr<V> ReadNode<K, V>(K key);
typedef FutureOr<Iterable<K>> ReadEdges<K, V>(K key, V value);

/// Crawls Dart files outside of the SDK transitively imported from any library
/// in [entryPoints].
Future crawlImports(
    Iterable<AssetId> entryPoints, ReadNode<AssetId, String> readAsset) async {
  var roots = entryPoints.where((id) => id.path.endsWith('.dart'));
  var crawler = new _AsyncCrawler(_assetReferences, readAsset, roots);
  await crawler.crawlAsync();
}

/// All the assets referenced by a [UriBasedDirective] in [source] that aren't
/// from the Dart SDK.
///
/// [id] represents the location of [source].
Iterable<AssetId> _assetReferences(AssetId id, String source) {
  if (source == null) return [];
  var unit = parseDirectives(source);
  return unit.directives
      .where((d) => d is UriBasedDirective)
      .map((d) => (d as UriBasedDirective).uri.stringValue)
      .where((uri) => !uri.startsWith('dart:'))
      .map((uri) => new AssetId.resolve(uri, from: id));
}

/// Crawls a graph where node values and edges are resolved asynchronously.
///
/// Nodes are keyed by type [K] and have values of type [V].
class _AsyncCrawler<K, V> {
  final _seen = <K, Future<V>>{};

  final ReadEdges<K, V> readEdges;
  final ReadNode<K, V> readNode;
  final Iterable<K> roots;

  _AsyncCrawler(this.readEdges, this.readNode, this.roots);

  /// Returns all nodes found by crawling from [roots].
  Future crawlAsync() => Future.wait(roots.map((k) => _visitNode(k)));

  /// Synchronously record the the node a [key] has been seen, then start the
  /// work.
  ///
  /// The returned Future will complete when the node at [key], and transitively
  /// reachable nodes, have either finished their crawl or are guaranteed to be
  /// completed within another future in [_seen].
  Future _visitNode(K key) {
    if (_seen.containsKey(key)) return new Future.value(null);
    return _seen[key] = _crawlFromNode(key);
  }

  /// Resolve the node at [key] and visit all transitively reachable nodes.
  Future<V> _crawlFromNode(K key) async {
    var value = await readNode(key);
    var next = await readEdges(key, value) ?? [];
    await Future.wait(next.map((k) => _visitNode(k)));
    return value;
  }
}
