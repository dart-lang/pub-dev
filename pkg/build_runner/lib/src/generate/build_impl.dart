// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:build_barback/build_barback.dart' show BarbackResolvers;
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:watcher/watcher.dart';

import '../asset/reader.dart';
import '../asset/writer.dart';
import '../asset_graph/graph.dart';
import '../asset_graph/node.dart';
import '../logging/logging.dart';
import '../package_graph/package_graph.dart';
import '../util/constants.dart';
import 'build_definition.dart';
import 'build_result.dart';
import 'exceptions.dart';
import 'input_set.dart';
import 'options.dart';
import 'phase.dart';

final _logger = new Logger('Build');

Future<BuildResult> singleBuild(
    BuildOptions options, List<BuildAction> buildActions) async {
  var buildDefinition = await BuildDefinition.load(options, buildActions);
  return (await BuildImpl.create(buildDefinition, buildActions)).firstBuild;
}

typedef void _OnDelete(AssetId id);

class BuildImpl {
  BuildResult _firstBuild;
  BuildResult get firstBuild => _firstBuild;

  final List<BuildAction> _buildActions;
  final PackageGraph _packageGraph;
  final AssetReader _reader;
  final RunnerAssetWriter _writer;
  final _resolvers = const BarbackResolvers();
  final AssetGraph _assetGraph;

  final _OnDelete _onDelete;

  BuildImpl._(BuildDefinition buildDefinition, List<BuildAction> buildActions,
      this._onDelete)
      : _packageGraph = buildDefinition.packageGraph,
        _reader = buildDefinition.reader,
        _writer = buildDefinition.writer,
        _assetGraph = buildDefinition.assetGraph,
        _buildActions = buildActions;

  static Future<BuildImpl> create(
      BuildDefinition buildDefinition, List<BuildAction> buildActions,
      {void onDelete(AssetId id)}) async {
    var build = new BuildImpl._(buildDefinition, buildActions, onDelete);

    _logger.info('Checking for stale files');
    await build._firstBuildCleanup(buildDefinition.conflictingAssets,
        buildDefinition.deleteFilesByDefault);

    build._firstBuild = await build.run(buildDefinition.updates);
    return build;
  }

  Future<BuildResult> run(Map<AssetId, ChangeType> updates) async {
    var watch = new Stopwatch()..start();
    if (updates.isNotEmpty) await _updateAssetGraph(updates);
    var result = await _safeBuild();
    if (result.status == BuildStatus.success) {
      _logger.info('Succeeded after ${watch.elapsedMilliseconds}ms with '
          '${result.outputs.length} outputs\n\n');
    } else {
      if (result.exception is FatalBuildException) {
        // TODO(???) Really bad idea. Should not set exit codes in libraries!
        exitCode = 1;
      }
      _logger.severe('Failed after ${watch.elapsedMilliseconds}ms',
          result.exception, result.stackTrace);
    }
    return result;
  }

  Future<Null> _updateAssetGraph(Map<AssetId, ChangeType> updates) async {
    var deletes = _assetGraph.updateAndInvalidate(_buildActions, updates);
    await Future.wait(deletes.map(_delete));
  }

  /// Runs a build inside a zone with an error handler and stack chain
  /// capturing.
  Future<BuildResult> _safeBuild() {
    var done = new Completer<BuildResult>();
    var buildStartTime = new DateTime.now();
    Chain.capture(() async {
      // Run a fresh build.
      var result = await logWithTime(_logger, 'Running build', _runPhases);

      // Write out the dependency graph file.
      await logWithTime(_logger, 'Caching finalized dependency graph',
          () async {
        _assetGraph.validAsOf = buildStartTime;
        await _writer.writeAsString(
            new AssetId(_packageGraph.root.name, assetGraphPath),
            JSON.encode(_assetGraph.serialize()));
      });

      done.complete(result);
    }, onError: (e, Chain chain) {
      done.complete(new BuildResult(BuildStatus.failure, [],
          exception: e, stackTrace: chain.toTrace()));
    });
    return done.future;
  }

  Future<Null> _firstBuildCleanup(
      Set<AssetId> conflictingAssets, bool deleteFilesByDefault) async {
    if (conflictingAssets.isEmpty) return;

    // Skip the prompt if using this option.
    if (deleteFilesByDefault) {
      _logger.info('Deleting ${conflictingAssets.length} declared outputs '
          'which already existed on disk.');
      await Future.wait(conflictingAssets.map(_delete));
      return;
    }

    // Prompt the user to delete files that are declared as outputs.
    _logger.warning('Found ${conflictingAssets.length} declared outputs '
        'which already exist on disk. This is likely because the'
        '`$cacheDir` folder was deleted, or you are submitting generated '
        'files to your source repository.');

    // If not in a standard terminal then we just exit, since there is no way
    // for the user to provide a yes/no answer.
    if (stdioType(stdin) != StdioType.TERMINAL) {
      throw new UnexpectedExistingOutputsException();
    }

    // Give a little extra space after the last message, need to make it clear
    // this is a prompt.
    stdout.writeln();
    var done = false;
    while (!done) {
      stdout.write('\nDelete these files (y/n) (or list them (l))?: ');
      var input = stdin.readLineSync();
      switch (input.toLowerCase()) {
        case 'y':
          stdout.writeln('Deleting files...');
          done = true;
          await Future.wait(conflictingAssets.map(_delete));
          break;
        case 'n':
          throw new UnexpectedExistingOutputsException();
          break;
        case 'l':
          for (var output in conflictingAssets) {
            stdout.writeln(output);
          }
          break;
        default:
          stdout.writeln('Unrecognized option $input, (y/n/l) expected.');
      }
    }
  }

  /// Runs the actions in [_buildActions] and returns a [Future<BuildResult>]
  /// which completes once all [BuildAction]s are done.
  Future<BuildResult> _runPhases() async {
    final outputs = <AssetId>[];
    var phaseNumber = 0;
    for (var action in _buildActions) {
      phaseNumber++;
      var inputs = _matchingInputs(action.inputSet, phaseNumber);
      await for (var output
          in _runBuilder(phaseNumber, action.builder, inputs)) {
        outputs.add(output);
      }
    }
    return new BuildResult(BuildStatus.success, outputs);
  }

  Set<AssetId> _inputsForPhase(int phaseNumber) => _assetGraph.allNodes
      .where((n) =>
          n is! GeneratedAssetNode ||
          (n as GeneratedAssetNode).phaseNumber < phaseNumber)
      .map((n) => n.id)
      .toSet();

  /// Gets a list of all inputs matching [inputSet].
  Set<AssetId> _matchingInputs(InputSet inputSet, int phaseNumber) =>
      _inputsForPhase(phaseNumber)
          .where((input) =>
              input.package == inputSet.package &&
              inputSet.globs.any((g) => g.matches(input.path)))
          .toSet();

  /// Runs [builder] with [primaryInputs] as inputs.
  Stream<AssetId> _runBuilder(int phaseNumber, Builder builder,
      Iterable<AssetId> primaryInputs) async* {
    for (var input in primaryInputs) {
      var builderOutputs = expectedOutputs(builder, input);

      // Add nodes to the AssetGraph for builderOutputs and input.
      var inputNode = _assetGraph.get(input);
      assert(inputNode != null,
          'Inputs should be known in the static graph. Missing $input');
      for (var output in builderOutputs) {
        inputNode.outputs.add(output);
        assert(inputNode.primaryOutputs.contains(output),
            '$input missing primary output $output');
      }
      assert(
          builderOutputs.every((o) => _assetGraph.contains(o)),
          'Outputs should be known statically. Missing '
          '${builderOutputs.where((o) => !_assetGraph.contains(o)).toList()}');
      // Skip the build step if none of the outputs need updating.
      var skipBuild = !builderOutputs.any((output) =>
          (_assetGraph.get(output) as GeneratedAssetNode).needsUpdate);
      if (skipBuild) continue;
      var wrappedReader = new SinglePhaseReader(
          _reader, _assetGraph, phaseNumber, _packageGraph.root.name);
      var wrappedWriter = new AssetWriterSpy(_writer);
      await runBuilder(
          builder, [input], wrappedReader, wrappedWriter, _resolvers);

      // Mark all outputs as no longer needing an update, and mark `wasOutput`
      // as `false` for now (this will get reset to true later one).
      for (var output in builderOutputs) {
        (_assetGraph.get(output) as GeneratedAssetNode)
          ..needsUpdate = false
          ..wasOutput = false;
      }

      // Update the asset graph based on the dependencies discovered.
      for (var dependency in wrappedReader.assetsRead) {
        var dependencyNode = _assetGraph.get(dependency);
        assert(dependencyNode != null, 'Asset Graph is missing $dependency');
        // We care about all builderOutputs, not just real outputs. Updates
        // to dependencies may cause a file to be output which wasn't before.
        dependencyNode.outputs.addAll(builderOutputs);
      }

      // Yield the outputs.
      for (var output in wrappedWriter.assetsWritten) {
        (_assetGraph.get(output) as GeneratedAssetNode).wasOutput = true;
        yield output;
      }
    }
  }

  Future _delete(AssetId id) {
    _onDelete?.call(id);
    return _writer.delete(id);
  }
}
