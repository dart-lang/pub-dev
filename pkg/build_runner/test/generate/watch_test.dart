// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:watcher/watcher.dart';

import 'package:build_runner/build_runner.dart';
import 'package:build_runner/src/asset_graph/graph.dart';
import 'package:build_runner/src/asset_graph/node.dart';
import 'package:build_test/build_test.dart';

import '../common/common.dart';

void main() {
  /// Basic phases/phase groups which get used in many tests
  final copyABuildAction = new BuildAction(new CopyBuilder(), 'a');

  group('watch', () {
    setUp(() {
      _terminateWatchController = new StreamController();
    });

    tearDown(() {
      FakeWatcher.watchers.clear();
      return terminateWatch();
    });

    group('simple', () {
      test('rebuilds on file updates', () async {
        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(
            startWatch([copyABuildAction], {'a|web/a.txt': 'a'}, writer));

        var result = await results.next;
        checkBuild(result, outputs: {'a|web/a.txt.copy': 'a'}, writer: writer);

        await writer.writeAsString(makeAssetId('a|web/a.txt'), 'b');
        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.MODIFY, path.absolute('a', 'web', 'a.txt')));

        result = await results.next;
        checkBuild(result, outputs: {'a|web/a.txt.copy': 'b'}, writer: writer);
      });

      test('rebuilds on new files', () async {
        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(
            startWatch([copyABuildAction], {'a|web/a.txt': 'a'}, writer));

        var result = await results.next;
        checkBuild(result, outputs: {'a|web/a.txt.copy': 'a'}, writer: writer);

        await writer.writeAsString(makeAssetId('a|web/b.txt'), 'b');
        FakeWatcher.notifyWatchers(
            new WatchEvent(ChangeType.ADD, path.absolute('a', 'web', 'b.txt')));

        result = await results.next;
        checkBuild(result, outputs: {'a|web/b.txt.copy': 'b'}, writer: writer);
        // Previous outputs should still exist.
        expect(writer.assets[makeAssetId('a|web/a.txt.copy')].stringValue, 'a');
      });

      test('rebuilds on deleted files', () async {
        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(startWatch([
          copyABuildAction
        ], {
          'a|web/a.txt': 'a',
          'a|web/b.txt': 'b',
        }, writer));

        var result = await results.next;
        checkBuild(result,
            outputs: {'a|web/a.txt.copy': 'a', 'a|web/b.txt.copy': 'b'},
            writer: writer);

        // Don't call writer.delete, that has side effects.
        writer.assets.remove(makeAssetId('a|web/a.txt'));
        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.REMOVE, path.absolute('a', 'web', 'a.txt')));

        result = await results.next;

        // Shouldn't rebuild anything, no outputs.
        checkBuild(result, outputs: {}, writer: writer);

        // The old output file should no longer exist either.
        expect(writer.assets[makeAssetId('a|web/a.txt.copy')], isNull);
        // Previous outputs should still exist.
        expect(writer.assets[makeAssetId('a|web/b.txt.copy')].stringValue, 'b');
      });

      test('rebuilds properly update asset_graph.json', () async {
        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(startWatch([copyABuildAction],
            {'a|web/a.txt': 'a', 'a|web/b.txt': 'b'}, writer));

        var result = await results.next;
        checkBuild(result,
            outputs: {'a|web/a.txt.copy': 'a', 'a|web/b.txt.copy': 'b'},
            writer: writer);

        await writer.writeAsString(makeAssetId('a|web/c.txt'), 'c');
        FakeWatcher.notifyWatchers(
            new WatchEvent(ChangeType.ADD, path.absolute('a', 'web', 'c.txt')));
        // Don't call writer.delete, that has side effects.
        writer.assets.remove(makeAssetId('a|web/a.txt'));
        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.REMOVE, path.absolute('a', 'web', 'a.txt')));

        result = await results.next;
        checkBuild(result, outputs: {'a|web/c.txt.copy': 'c'}, writer: writer);

        var serialized = JSON.decode(
            writer.assets[makeAssetId('a|$assetGraphPath')].stringValue) as Map;
        var cachedGraph = new AssetGraph.deserialize(serialized);

        var expectedGraph = new AssetGraph.build([], new Set());
        var bCopyNode = new GeneratedAssetNode(null, makeAssetId('a|web/b.txt'),
            false, true, makeAssetId('a|web/b.txt.copy'));
        expectedGraph.add(bCopyNode);
        expectedGraph.add(makeAssetNode('a|web/b.txt', [bCopyNode.id]));
        var cCopyNode = new GeneratedAssetNode(null, makeAssetId('a|web/c.txt'),
            false, true, makeAssetId('a|web/c.txt.copy'));
        expectedGraph.add(cCopyNode);
        expectedGraph.add(makeAssetNode('a|web/c.txt', [cCopyNode.id]));

        expect(cachedGraph, equalsAssetGraph(expectedGraph));
      });

      test('build fails if script is updated after the first build starts',
          () async {
        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(
            startWatch([copyABuildAction], {'a|web/a.txt': 'a'}, writer));

        var result = await results.next;
        checkBuild(result, outputs: {'a|web/a.txt.copy': 'a'}, writer: writer);

        /// Pretend like a part of the dart script got updated.
        await writer.writeAsString(makeAssetId('test|lib/test.dart'), '',
            lastModified: new DateTime.now().add(new Duration(days: 1)));
        await writer.writeAsString(makeAssetId('a|web/a.txt'), 'b');
        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.MODIFY, path.absolute('a', 'web', 'a.txt')));

        result = await results.next;
        checkBuild(result, status: BuildStatus.failure);
      });

      test('ignores events from nested packages', () async {
        var writer = new InMemoryRunnerAssetWriter();
        var packageA = new PackageNode(
            'a', '0.1.0', PackageDependencyType.path, new Uri.file('a/'));
        var packageB = new PackageNode(
            'b', '0.1.0', PackageDependencyType.path, new Uri.file('a/b/'));
        packageA.dependencies.add(packageB);
        var packageGraph = new PackageGraph.fromRoot(packageA);

        var results = new StreamQueue(startWatch([
          copyABuildAction
        ], {
          'a|web/a.txt': 'a',
          'b|web/b.txt': 'b'
        }, writer, packageGraph: packageGraph));

        var result = await results.next;
        // Should ignore the files under the `b` package, even though they
        // match the input set.
        checkBuild(result, outputs: {'a|web/a.txt.copy': 'a'}, writer: writer);

        await writer.writeAsString(makeAssetId('a|web/a.txt'), 'b');
        await writer.writeAsString(makeAssetId('b|web/b.txt'), 'c');
        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.MODIFY, path.absolute('a', 'b', 'web', 'a.txt')));
        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.MODIFY, path.absolute('a', 'web', 'a.txt')));

        result = await results.next;
        // Ignores the modification under the `b` package, even though it
        // matches the input set.
        checkBuild(result, outputs: {'a|web/a.txt.copy': 'b'}, writer: writer);
      });

      test('converts packages paths to absolute ones', () async {
        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(
            startWatch([copyABuildAction], {'a|lib/a.txt': 'a'}, writer));

        var result = await results.next;
        checkBuild(result, outputs: {'a|lib/a.txt.copy': 'a'}, writer: writer);

        await writer.writeAsString(makeAssetId('a|lib/a.txt'), 'b');
        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.MODIFY, path.absolute('a', 'packages', 'a', 'a.txt')));

        result = await results.next;
        checkBuild(result, outputs: {'a|lib/a.txt.copy': 'b'}, writer: writer);
      });
    });

    group('multiple phases', () {
      test('edits propagate through all phases', () async {
        var buildActions = [
          copyABuildAction,
          new BuildAction(new CopyBuilder(), 'a', inputs: ['**/*.copy'])
        ];

        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(
            startWatch(buildActions, {'a|web/a.txt': 'a'}, writer));

        var result = await results.next;
        checkBuild(result,
            outputs: {'a|web/a.txt.copy': 'a', 'a|web/a.txt.copy.copy': 'a'},
            writer: writer);

        await writer.writeAsString(makeAssetId('a|web/a.txt'), 'b');
        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.MODIFY, path.absolute('a', 'web', 'a.txt')));

        result = await results.next;
        checkBuild(result,
            outputs: {'a|web/a.txt.copy': 'b', 'a|web/a.txt.copy.copy': 'b'},
            writer: writer);
      });

      test('adds propagate through all phases', () async {
        var buildActions = [
          copyABuildAction,
          new BuildAction(new CopyBuilder(), 'a', inputs: ['**/*.copy'])
        ];

        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(
            startWatch(buildActions, {'a|web/a.txt': 'a'}, writer));

        var result = await results.next;
        checkBuild(result,
            outputs: {'a|web/a.txt.copy': 'a', 'a|web/a.txt.copy.copy': 'a'},
            writer: writer);

        await writer.writeAsString(makeAssetId('a|web/b.txt'), 'b');
        FakeWatcher.notifyWatchers(
            new WatchEvent(ChangeType.ADD, path.absolute('a', 'web', 'b.txt')));

        result = await results.next;
        checkBuild(result,
            outputs: {'a|web/b.txt.copy': 'b', 'a|web/b.txt.copy.copy': 'b'},
            writer: writer);
        // Previous outputs should still exist.
        expect(writer.assets[makeAssetId('a|web/a.txt.copy')].stringValue, 'a');
        expect(writer.assets[makeAssetId('a|web/a.txt.copy.copy')].stringValue,
            'a');
      });

      test('deletes propagate through all phases', () async {
        var buildActions = [
          copyABuildAction,
          new BuildAction(new CopyBuilder(), 'a', inputs: ['**/*.copy'])
        ];

        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(startWatch(
            buildActions, {'a|web/a.txt': 'a', 'a|web/b.txt': 'b'}, writer));

        var result = await results.next;
        checkBuild(result,
            outputs: {
              'a|web/a.txt.copy': 'a',
              'a|web/a.txt.copy.copy': 'a',
              'a|web/b.txt.copy': 'b',
              'a|web/b.txt.copy.copy': 'b'
            },
            writer: writer);

        // Don't call writer.delete, that has side effects.
        writer.assets.remove(makeAssetId('a|web/a.txt'));

        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.REMOVE, path.absolute('a', 'web', 'a.txt')));

        result = await results.next;
        // Shouldn't rebuild anything, no outputs.
        checkBuild(result, outputs: {}, writer: writer);

        // Derived outputs should no longer exist.
        expect(writer.assets[makeAssetId('a|web/a.txt.copy')], isNull);
        expect(writer.assets[makeAssetId('a|web/a.txt.copy.copy')], isNull);
        // Other outputs should still exist.
        expect(writer.assets[makeAssetId('a|web/b.txt.copy')].stringValue, 'b');
        expect(writer.assets[makeAssetId('a|web/b.txt.copy.copy')].stringValue,
            'b');
      });

      test('deleted generated outputs are regenerated', () async {
        var buildActions = [
          copyABuildAction,
          new BuildAction(new CopyBuilder(), 'a', inputs: ['**/*.copy']),
        ];

        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(
            startWatch(buildActions, {'a|web/a.txt': 'a'}, writer));

        var result = await results.next;
        checkBuild(result,
            outputs: {
              'a|web/a.txt.copy': 'a',
              'a|web/a.txt.copy.copy': 'a',
            },
            writer: writer);

        // Don't call writer.delete, that has side effects.
        writer.assets.remove(makeAssetId('a|web/a.txt.copy'));
        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.REMOVE, path.absolute('a', 'web', 'a.txt.copy')));

        result = await results.next;
        // Should rebuild the generated asset and its outputs.
        checkBuild(result,
            outputs: {
              'a|web/a.txt.copy': 'a',
              'a|web/a.txt.copy.copy': 'a',
            },
            writer: writer);
      });
    });

    /// Tests for updates
    group('secondary dependency', () {
      test('of an output file is edited', () async {
        var buildActions = [
          new BuildAction(
              new CopyBuilder(copyFromAsset: makeAssetId('a|web/b.txt')), 'a',
              inputs: ['web/a.txt'])
        ];

        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(startWatch(
            buildActions, {'a|web/a.txt': 'a', 'a|web/b.txt': 'b'}, writer));

        var result = await results.next;
        checkBuild(result, outputs: {'a|web/a.txt.copy': 'b'}, writer: writer);

        await writer.writeAsString(makeAssetId('a|web/b.txt'), 'c');
        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.MODIFY, path.absolute('a', 'web', 'b.txt')));

        result = await results.next;
        checkBuild(result, outputs: {'a|web/a.txt.copy': 'c'}, writer: writer);
      });

      test(
          'of an output which is derived from another generated file is edited',
          () async {
        var buildActions = [
          new BuildAction(new CopyBuilder(), 'a', inputs: ['web/a.txt']),
          new BuildAction(
              new CopyBuilder(copyFromAsset: makeAssetId('a|web/b.txt')), 'a',
              inputs: ['web/a.txt.copy'])
        ];

        var writer = new InMemoryRunnerAssetWriter();
        var results = new StreamQueue(startWatch(
            buildActions, {'a|web/a.txt': 'a', 'a|web/b.txt': 'b'}, writer));

        var result = await results.next;
        checkBuild(result,
            outputs: {'a|web/a.txt.copy': 'a', 'a|web/a.txt.copy.copy': 'b'},
            writer: writer);

        await writer.writeAsString(makeAssetId('a|web/b.txt'), 'c');
        FakeWatcher.notifyWatchers(new WatchEvent(
            ChangeType.MODIFY, path.absolute('a', 'web', 'b.txt')));

        result = await results.next;
        checkBuild(result,
            outputs: {'a|web/a.txt.copy.copy': 'c'}, writer: writer);
      });
    });
  });
}

final _debounceDelay = new Duration(milliseconds: 10);
StreamController _terminateWatchController;

/// Start watching files and running builds.
Stream<BuildResult> startWatch(List<BuildAction> buildActions,
    Map<String, String> inputs, InMemoryRunnerAssetWriter writer,
    {PackageGraph packageGraph}) {
  var buildResults = new StreamController<BuildResult>.broadcast();
  inputs.forEach((serializedId, contents) {
    writer.writeAsString(makeAssetId(serializedId), contents);
  });
  final actualAssets = writer.assets;
  final reader = new InMemoryRunnerAssetReader(actualAssets);
  if (packageGraph == null) {
    packageGraph ??= new PackageGraph.fromRoot(
        new PackageNode('a', null, null, new Uri.file('a/')));
  }
  final watcherFactory = (String path) => new FakeWatcher(path);

  var buildState = watch(buildActions,
      deleteFilesByDefault: true,
      debounceDelay: _debounceDelay,
      directoryWatcherFactory: watcherFactory,
      reader: reader,
      writer: writer,
      packageGraph: packageGraph,
      terminateEventStream: _terminateWatchController.stream,
      logLevel: Level.OFF);
  buildState
      .then((s) => buildResults.addStream(s.buildResults))
      .then((_) => buildResults.close());
  return buildResults.stream;
}

/// Tells the program to stop watching files and terminate.
Future terminateWatch() {
  assert(_terminateWatchController != null);

  /// Can add any type of event.
  _terminateWatchController.add(null);
  return _terminateWatchController.close();
}
