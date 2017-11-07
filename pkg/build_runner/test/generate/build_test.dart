// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:convert';

import 'package:test/test.dart';

import 'package:build/build.dart';
import 'package:build_runner/build_runner.dart';
import 'package:build_runner/src/asset_graph/graph.dart';
import 'package:build_runner/src/asset_graph/node.dart';

import '../common/common.dart';

void main() {
  /// Basic phases/phase groups which get used in many tests
  final copyABuildAction = new BuildAction(new CopyBuilder(), 'a');

  group('build', () {
    group('with root package inputs', () {
      test('one phase, one builder, one-to-one outputs', () async {
        await testActions(
            [copyABuildAction], {'a|web/a.txt': 'a', 'a|lib/b.txt': 'b'},
            outputs: {'a|web/a.txt.copy': 'a', 'a|lib/b.txt.copy': 'b'});
      });

      test('one phase, one builder, one-to-many outputs', () async {
        await testActions([
          new BuildAction(new CopyBuilder(numCopies: 2), 'a')
        ], {
          'a|web/a.txt': 'a',
          'a|lib/b.txt': 'b',
        }, outputs: {
          'a|web/a.txt.copy.0': 'a',
          'a|web/a.txt.copy.1': 'a',
          'a|lib/b.txt.copy.0': 'b',
          'a|lib/b.txt.copy.1': 'b',
        });
      });

      test('multiple build actions', () async {
        var buildActions = [
          copyABuildAction,
          new BuildAction(new CopyBuilder(extension: 'clone'), 'a',
              inputs: ['**/*.txt']),
          new BuildAction(new CopyBuilder(numCopies: 2), 'a',
              inputs: ['web/*.txt.clone'])
        ];
        await testActions(buildActions, {
          'a|web/a.txt': 'a',
          'a|lib/b.txt': 'b',
        }, outputs: {
          'a|web/a.txt.copy': 'a',
          'a|web/a.txt.clone': 'a',
          'a|lib/b.txt.copy': 'b',
          'a|lib/b.txt.clone': 'b',
          'a|web/a.txt.clone.copy.0': 'a',
          'a|web/a.txt.clone.copy.1': 'a',
        });
      });

      test('early step touches a not-yet-generated asset', () async {
        var buildActions = [
          new BuildAction(
              new CopyBuilder(touchAsset: new AssetId('a', 'lib/a.txt.copy')),
              'a',
              inputs: ['lib/b.txt']),
          new BuildAction(new CopyBuilder(), 'a', inputs: ['lib/a.txt'])
        ];
        await testActions(buildActions, {
          'a|lib/a.txt': 'a',
          'a|lib/b.txt': 'b',
        }, outputs: {
          'a|lib/a.txt.copy': 'a',
          'a|lib/b.txt.copy': 'b',
        });
      });
    });

    test('can\'t output files in non-root packages', () async {
      var packageB = new PackageNode(
          'b', '0.1.0', PackageDependencyType.path, new Uri.file('a/b/'));
      var packageA = new PackageNode(
          'a', '0.1.0', PackageDependencyType.path, new Uri.file('a/'))
        ..dependencies.add(packageB);
      var packageGraph = new PackageGraph.fromRoot(packageA);
      expect(
          testActions(
              [new BuildAction(new CopyBuilder(), 'b')], {'b|lib/b.txt': 'b'},
              packageGraph: packageGraph),
          throwsA(anything));
    });

    test('Can output files in non-root packages with `writeToCache`', () async {
      var packageB = new PackageNode(
          'b', '0.1.0', PackageDependencyType.path, new Uri.file('a/b/'));
      var packageA = new PackageNode(
          'a', '0.1.0', PackageDependencyType.path, new Uri.file('a/'))
        ..dependencies.add(packageB);
      var packageGraph = new PackageGraph.fromRoot(packageA);
      await testActions(
          [new BuildAction(new CopyBuilder(), 'b')], {'b|lib/b.txt': 'b'},
          packageGraph: packageGraph,
          outputs: {'b|lib/b.txt.copy': 'b'},
          writeToCache: true);
    });

    test('Will not delete from non-root packages with `writeToCache`',
        () async {
      var packageB = new PackageNode(
          'b', '0.1.0', PackageDependencyType.path, new Uri.file('a/b/'));
      var packageA = new PackageNode(
          'a', '0.1.0', PackageDependencyType.path, new Uri.file('a/'))
        ..dependencies.add(packageB);
      var packageGraph = new PackageGraph.fromRoot(packageA);
      var writer = new InMemoryRunnerAssetWriter()
        ..onDelete = (AssetId assetId) {
          if (assetId.package != 'a') {
            throw 'Should not delete outside of package:a';
          }
        };
      await testActions(
          [new BuildAction(new CopyBuilder(), 'b')],
          {
            'b|lib/b.txt': 'b',
            'a|.dart_tool/build/generated/b/lib/b.txt.copy': 'b'
          },
          packageGraph: packageGraph,
          writer: writer,
          outputs: {'b|lib/b.txt.copy': 'b'},
          writeToCache: true);
    });

    test('can read files from external packages', () async {
      var buildActions = [
        new BuildAction(
            new CopyBuilder(touchAsset: makeAssetId('b|lib/b.txt')), 'a')
      ];
      await testActions(buildActions, {
        'a|lib/a.txt': 'a',
        'b|lib/b.txt': 'b'
      }, outputs: {
        'a|lib/a.txt.copy': 'a',
      });
    });

    test('can\'t read files in .dart_tool', () async {
      await testActions([
        new BuildAction(
            new CopyBuilder(
                copyFromAsset: makeAssetId('a|.dart_tool/any_file')),
            'a')
      ], {
        'a|lib/a.txt': 'a',
        'a|.dart_tool/any_file': 'content'
      }, status: BuildStatus.failure);
    });

    test('won\'t try to delete files from other packages', () async {
      var packageB = new PackageNode(
          'b', '0.1.0', PackageDependencyType.path, new Uri.file('a/b/'));
      var packageA = new PackageNode(
          'a', '0.1.0', PackageDependencyType.path, new Uri.file('a/'))
        ..dependencies.add(packageB);
      var packageGraph = new PackageGraph.fromRoot(packageA);
      var writer = new InMemoryRunnerAssetWriter()
        ..onDelete = (AssetId assetId) {
          if (assetId.package != 'a') {
            throw 'Should not delete outside of package:a';
          }
        };
      await testActions([new BuildAction(new CopyBuilder(), 'a')],
          {'a|lib/a.txt': 'a', 'b|lib/b.txt': 'b', 'b|lib/b.txt.copy': 'b'},
          packageGraph: packageGraph,
          writer: writer,
          outputs: {
            'a|lib/a.txt.copy': 'a',
          });
    });
  });

  test('tracks dependency graph in a asset_graph.json file', () async {
    final writer = new InMemoryRunnerAssetWriter();
    await testActions(
        [copyABuildAction], {'a|web/a.txt': 'a', 'a|lib/b.txt': 'b'},
        outputs: {'a|web/a.txt.copy': 'a', 'a|lib/b.txt.copy': 'b'},
        writer: writer);

    var graphId = makeAssetId('a|$assetGraphPath');
    expect(writer.assets, contains(graphId));
    var cachedGraph = new AssetGraph.deserialize(
        JSON.decode(writer.assets[graphId].stringValue) as Map);

    var expectedGraph = new AssetGraph.build([], new Set());
    var aCopyNode = new GeneratedAssetNode(null, makeAssetId('a|web/a.txt'),
        false, true, makeAssetId('a|web/a.txt.copy'));
    expectedGraph.add(aCopyNode);
    expectedGraph.add(makeAssetNode('a|web/a.txt', [aCopyNode.id]));
    var bCopyNode = new GeneratedAssetNode(null, makeAssetId('a|lib/b.txt'),
        false, true, makeAssetId('a|lib/b.txt.copy'));
    expectedGraph.add(bCopyNode);
    expectedGraph.add(makeAssetNode('a|lib/b.txt', [bCopyNode.id]));

    expect(cachedGraph, equalsAssetGraph(expectedGraph));
  });

  test('outputs from previous full builds shouldn\'t be inputs to later ones',
      () async {
    final writer = new InMemoryRunnerAssetWriter();
    var inputs = <String, String>{'a|web/a.txt': 'a', 'a|lib/b.txt': 'b'};
    var outputs = <String, String>{
      'a|web/a.txt.copy': 'a',
      'a|lib/b.txt.copy': 'b'
    };
    // First run, nothing special.
    await testActions([copyABuildAction], inputs,
        outputs: outputs, writer: writer);
    // Second run, should have no extra outputs.
    await testActions([copyABuildAction], inputs,
        outputs: outputs, writer: writer);
  });

  test('can recover from a deleted asset_graph.json cache', () async {
    final writer = new InMemoryRunnerAssetWriter();
    var inputs = <String, String>{'a|web/a.txt': 'a', 'a|lib/b.txt': 'b'};
    var outputs = <String, String>{
      'a|web/a.txt.copy': 'a',
      'a|lib/b.txt.copy': 'b'
    };
    // First run, nothing special.
    await testActions([copyABuildAction], inputs,
        outputs: outputs, writer: writer);

    // Delete the `asset_graph.json` file!
    var outputId = makeAssetId('a|$assetGraphPath');
    await writer.delete(outputId);

    // Second run, should have no extra outputs.
    var done = testActions([copyABuildAction], inputs,
        outputs: outputs, writer: writer);
    // Should block on user input.
    await new Future.delayed(new Duration(seconds: 1));
    // Now it should complete!
    await done;
  });

  group('incremental builds with cached graph', () {
    test('one new asset, one modified asset, one unchanged asset', () async {
      var graph = new AssetGraph.build([], new Set())
        ..validAsOf = new DateTime.now();
      var bId = makeAssetId('a|lib/b.txt');
      var bCopyNode = new GeneratedAssetNode(
          1, bId, false, true, makeAssetId('a|lib/b.txt.copy'));
      graph.add(bCopyNode);
      var bNode = makeAssetNode('a|lib/b.txt', [bCopyNode.id]);
      graph.add(bNode);

      var writer = new InMemoryRunnerAssetWriter();
      await writer.writeAsString(makeAssetId('a|lib/b.txt'), 'b',
          lastModified: graph.validAsOf.subtract(new Duration(hours: 1)));
      await testActions([
        copyABuildAction
      ], {
        'a|web/a.txt': 'a',
        'a|lib/b.txt.copy': 'b',
        'a|lib/c.txt': 'c',
        'a|$assetGraphPath': JSON.encode(graph.serialize()),
      }, outputs: {
        'a|web/a.txt.copy': 'a',
        'a|lib/c.txt.copy': 'c',
      }, writer: writer);
    });

    test('invalidates generated assets based on graph age', () async {
      var buildActions = [
        copyABuildAction,
        new BuildAction(new CopyBuilder(extension: 'clone'), 'a',
            inputs: ['**/*.txt.copy'])
      ];

      var graph = new AssetGraph.build([], new Set())
        ..validAsOf = new DateTime.now();

      var aCloneNode = new GeneratedAssetNode(
          2,
          makeAssetId('a|lib/a.txt.copy'),
          false,
          true,
          makeAssetId('a|lib/a.txt.copy.clone'));
      graph.add(aCloneNode);
      var aCopyNode = new GeneratedAssetNode(1, makeAssetId('a|lib/a.txt'),
          false, true, makeAssetId('a|lib/a.txt.copy'))
        ..primaryOutputs.add(aCloneNode.id)
        ..outputs.add(aCloneNode.id);
      graph.add(aCopyNode);
      var aNode = makeAssetNode('a|lib/a.txt', [aCopyNode.id])
        ..primaryOutputs.add(aCopyNode.id);
      graph.add(aNode);

      var bCloneNode = new GeneratedAssetNode(
          2,
          makeAssetId('a|lib/b.txt.copy'),
          false,
          true,
          makeAssetId('a|lib/b.txt.copy.clone'));
      graph.add(bCloneNode);
      var bCopyNode = new GeneratedAssetNode(1, makeAssetId('a|lib/b.txt'),
          false, true, makeAssetId('a|lib/b.txt.copy'))
        ..primaryOutputs.add(bCloneNode.id)
        ..outputs.add(bCloneNode.id);
      graph.add(bCopyNode);
      var bNode = makeAssetNode('a|lib/b.txt', [bCopyNode.id])
        ..primaryOutputs.add(bCopyNode.id);
      graph.add(bNode);

      var writer = new InMemoryRunnerAssetWriter();
      await writer.writeAsString(makeAssetId('a|lib/b.txt'), 'b',
          lastModified: graph.validAsOf.subtract(new Duration(days: 1)));
      await testActions(
          buildActions,
          {
            'a|lib/a.txt': 'b',
            'a|lib/a.txt.copy': 'a',
            'a|lib/a.txt.copy.clone': 'a',
            'a|lib/b.txt.copy': 'b',
            'a|lib/b.txt.copy.clone': 'b',
            'a|$assetGraphPath': JSON.encode(graph.serialize()),
          },
          outputs: {
            'a|lib/a.txt.copy': 'b',
            'a|lib/a.txt.copy.clone': 'b',
          },
          writer: writer);
    });

    test('graph/file system get cleaned up for deleted inputs', () async {
      var buildActions = [
        copyABuildAction,
        new BuildAction(new CopyBuilder(extension: 'clone'), 'a',
            inputs: ['**/*.txt.copy'])
      ];

      var graph = new AssetGraph.build([], new Set())
        ..validAsOf = new DateTime.now();
      var aCloneNode = new GeneratedAssetNode(
          1,
          makeAssetId('a|lib/a.txt.copy'),
          false,
          true,
          makeAssetId('a|lib/a.txt.copy.clone'));
      graph.add(aCloneNode);
      var aCopyNode = new GeneratedAssetNode(1, makeAssetId('a|lib/a.txt'),
          false, true, makeAssetId('a|lib/a.txt.copy'))
        ..outputs.add(aCloneNode.id);
      graph.add(aCopyNode);
      var aNode = makeAssetNode('a|lib/a.txt', [aCopyNode.id]);
      graph.add(aNode);

      var writer = new InMemoryRunnerAssetWriter();
      await testActions(
          buildActions,
          {
            'a|lib/a.txt.copy': 'a',
            'a|lib/a.txt.copy.clone': 'a',
            'a|$assetGraphPath': JSON.encode(graph.serialize()),
          },
          outputs: {},
          writer: writer);

      /// Should be deleted using the writer, and removed from the new graph.
      var serialized = JSON.decode(
          writer.assets[makeAssetId('a|$assetGraphPath')].stringValue) as Map;
      var newGraph = new AssetGraph.deserialize(serialized);
      expect(newGraph.contains(aNode.id), isFalse);
      expect(newGraph.contains(aCopyNode.id), isFalse);
      expect(newGraph.contains(aCloneNode.id), isFalse);
      expect(writer.assets.containsKey(aNode.id), isFalse);
      expect(writer.assets.containsKey(aCopyNode.id), isFalse);
      expect(writer.assets.containsKey(aCloneNode.id), isFalse);
    });

    test('invalidates graph if build script updates', () async {
      var graph = new AssetGraph.build([], new Set())
        ..validAsOf = new DateTime.now().add(const Duration(hours: 1));
      var aId = makeAssetId('a|web/a.txt');
      var aCopyNode = new GeneratedAssetNode(
          1, aId, false, true, makeAssetId('a|web/a.txt.copy'));
      graph.add(aCopyNode);
      var aNode = makeAssetNode('a|web/a.txt', [aCopyNode.id]);
      graph.add(aNode);

      var writer = new InMemoryRunnerAssetWriter();

      /// Spoof the `package:test/test.dart` import and pretend its newer than
      /// the current graph to cause a rebuild.
      await writer.writeAsString(makeAssetId('test|lib/test.dart'), '',
          lastModified: graph.validAsOf.add(new Duration(hours: 2)));
      await testActions([
        copyABuildAction
      ], {
        'a|web/a.txt': 'a',
        'a|web/a.txt.copy': 'a',
        'a|$assetGraphPath': JSON.encode(graph.serialize()),
      }, outputs: {
        'a|web/a.txt.copy': 'a',
      }, writer: writer);
    });

    test('no outputs if no changed sources', () async {
      var graph = new AssetGraph.build([], new Set())
        ..validAsOf = new DateTime.now().add(const Duration(hours: 1));
      var aId = makeAssetId('a|web/a.txt');
      var aCopyNode = new GeneratedAssetNode(
          1, aId, false, true, makeAssetId('a|web/a.txt.copy'));
      graph.add(aCopyNode);
      var aNode = makeAssetNode('a|web/a.txt', [aCopyNode.id]);
      graph.add(aNode);

      var writer = new InMemoryRunnerAssetWriter();

      await writer.writeAsString(makeAssetId('a|web/a.txt'), '',
          lastModified: graph.validAsOf.subtract(new Duration(hours: 2)));
      await testActions([
        copyABuildAction
      ], {
        'a|web/a.txt': 'a',
        'a|web/a.txt.copy': 'a',
        'a|$assetGraphPath': JSON.encode(graph.serialize()),
      }, outputs: {}, writer: writer);
    });

    test('no outputs if no changed sources using `writeToCache`', () async {
      var graph = new AssetGraph.build([], new Set())
        ..validAsOf = new DateTime.now().add(const Duration(hours: 1));
      var aId = makeAssetId('a|web/a.txt');
      var aCopyNode = new GeneratedAssetNode(
          1, aId, false, true, makeAssetId('a|web/a.txt.copy'));
      graph.add(aCopyNode);
      var aNode = makeAssetNode('a|web/a.txt', [aCopyNode.id]);
      graph.add(aNode);

      var writer = new InMemoryRunnerAssetWriter();

      await writer.writeAsString(makeAssetId('a|web/a.txt'), '',
          lastModified: graph.validAsOf.subtract(new Duration(hours: 2)));
      await writer.writeAsString(
          makeAssetId('a|.dart_tool/build/generated/a/web/a.txt'), '',
          lastModified: graph.validAsOf.add(new Duration(hours: 2)));

      var packageA = new PackageNode(
          'a', '0.1.0', PackageDependencyType.path, new Uri.file('a/'));
      var packageGraph = new PackageGraph.fromRoot(packageA);
      await testActions([
        copyABuildAction
      ], {
        'a|web/a.txt': 'a',
        'a|.dart_tool/build/generated/a/web/a.txt.copy': 'a',
        'a|$assetGraphPath': JSON.encode(graph.serialize()),
      },
          outputs: {},
          writer: writer,
          writeToCache: true,
          packageGraph: packageGraph);
    });
  });
}
