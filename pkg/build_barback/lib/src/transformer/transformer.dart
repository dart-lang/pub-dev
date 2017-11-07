// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:convert';

import 'package:barback/barback.dart' as barback show AssetId;
import 'package:barback/barback.dart' hide Asset, AssetId;
import 'package:build/build.dart' as build;
import 'package:build/build.dart' hide AssetId;
import 'package:glob/glob.dart';
import 'package:logging/logging.dart';

import '../analyzer/resolver.dart';
import '../util/barback.dart';
import '../util/stream.dart';
import 'crawl_imports.dart';

/// An [AggregateTransformer] which runs a single [Builder] with a new
/// [BuildStep].
///
/// By default all [BuilderTransformer]s are [DeclaringAggregateTransformer]s.
/// If you wish to run as a [LazyAggregateTransformer], extend this class and
/// mix in LazyAggregateTransformer.
class BuilderTransformer
    implements AggregateTransformer, DeclaringAggregateTransformer {
  final Builder _builder;
  final _resolvers = const BarbackResolvers();

  BuilderTransformer(this._builder);

  @override
  classifyPrimary(barback.AssetId id) =>
      _builder.buildExtensions.keys.any((e) => id.path.endsWith(e))
          ? 'primary'
          : null;

  @override
  Future apply(AggregateTransform transform) async {
    // Wait for all inputs to be ready so the Resolvers won't see any file
    // changes before this transformer runs
    var inputs = (await transform.primaryInputs.toList())
        .map((input) => toBuildAssetId(input.id));
    // Wait for all dependencies to be finished running transformers and let us
    // read their assets.
    await crawlImports(
        inputs,
        (id) => transform
            .readInputAsString(toBarbackAssetId(id))
            .catchError((_) => null));
    var resourceManager = new ResourceManager();
    return Future
        .wait(inputs.map((input) => _apply(input, transform, resourceManager)))
        .then((_) => resourceManager.disposeAll());
  }

  Future _apply(build.AssetId inputId, AggregateTransform transform,
      ResourceManager resourceManager) async {
    var reader = new _TransformAssetReader(transform);
    var writer = new _TransformAssetWriter(transform);

    var expected = expectedOutputs(_builder, inputId);
    if (expected.isEmpty) return;

    // Check for overlapping outputs.
    var uniqueExpected = new Set<build.AssetId>();
    var preExistingFiles = [];
    for (var output in expected) {
      if (!uniqueExpected.add(output) ||
          await transform.hasInput(toBarbackAssetId(output))) {
        preExistingFiles.add(toBarbackAssetId(output));
      }
    }
    if (preExistingFiles.isNotEmpty) {
      transform.logger.error(
          'Builder `$_builder` declared outputs `$preExistingFiles` but those '
          'files already exist. This build step has been skipped.',
          asset: toBarbackAssetId(inputId));
      return;
    }

    hierarchicalLoggingEnabled = true;

    var logger = new Logger.detached('BuilderTransformer-$inputId');
    logger.level = Level.ALL;
    var logSubscription = logger.onRecord.listen((LogRecord log) {
      if (log.level <= Level.CONFIG) {
        transform.logger.fine(_logRecordToMessage(log));
      } else if (log.level <= Level.INFO) {
        transform.logger.info(_logRecordToMessage(log));
      } else if (log.level <= Level.WARNING) {
        transform.logger.warning(_logRecordToMessage(log));
      } else {
        transform.logger.error(_logRecordToMessage(log));
      }
    });

    await runBuilder(_builder, [inputId], reader, writer, _resolvers,
        logger: logger, resourceManager: resourceManager);
    await logSubscription.cancel();
  }

  String _logRecordToMessage(LogRecord log) {
    var buffer = new StringBuffer();
    buffer.write(log.message);
    if (log.error != null) {
      buffer.write('\nError: ${log.error}');
    }
    if (log.stackTrace != null) {
      buffer.write('\nStack Trace:\n${log.stackTrace}');
    }
    return buffer.toString();
  }

  @override
  Future declareOutputs(DeclaringAggregateTransform transform) =>
      transform.primaryIds
          .map(toBuildAssetId)
          .expand((i) => expectedOutputs(_builder, i))
          .map(toBarbackAssetId)
          .asyncMap(transform.declareOutput)
          .last;

  @override
  String toString() => 'BuilderTransformer: $_builder';
}

/// Very simple [AssetReader] which uses a [Transform].
class _TransformAssetReader implements AssetReader {
  final AggregateTransform transform;

  _TransformAssetReader(this.transform);

  @override
  Future<bool> canRead(build.AssetId id) =>
      transform.hasInput(toBarbackAssetId(id));

  @override
  Future<List<int>> readAsBytes(build.AssetId id) async =>
      await combineByteStream(transform.readInput(toBarbackAssetId(id)));

  @override
  Future<String> readAsString(build.AssetId id, {Encoding encoding: UTF8}) =>
      transform.readInputAsString(toBarbackAssetId(id), encoding: encoding);

  @override
  Iterable<build.AssetId> findAssets(Glob glob) => throw new UnsupportedError(
      'findAssets cannot be used within a Transformer.\n'
      'If you have a use case that requires support file an issue at '
      'https://github.com/dart-lang/build/issues');
}

/// Very simple [AssetWriter] which uses a [Transform].
class _TransformAssetWriter implements AssetWriter {
  final AggregateTransform transform;

  _TransformAssetWriter(this.transform);

  @override
  Future writeAsBytes(build.AssetId id, List<int> bytes) {
    transform.addOutput(barbackAssetFromBytes(id, bytes));
    return new Future.value(null);
  }

  @override
  Future writeAsString(build.AssetId id, String contents,
      {Encoding encoding: UTF8}) {
    transform.addOutput(barbackAssetFromString(id, contents));
    return new Future.value(null);
  }
}
