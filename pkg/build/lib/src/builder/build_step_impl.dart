// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:async/async.dart';
import 'package:glob/glob.dart';

import '../analyzer/resolver.dart';
import '../asset/exceptions.dart';
import '../asset/id.dart';
import '../asset/reader.dart';
import '../asset/writer.dart';
import '../resource/resource.dart';
import 'build_step.dart';
import 'exceptions.dart';

/// A single step in the build processes.
///
/// This represents a single input and its expected and real outputs. It also
/// handles tracking of dependencies.
class BuildStepImpl implements BuildStep {
  final Resolvers _resolvers;

  /// The primary input id for this build step.
  @override
  final AssetId inputId;

  @override
  Future<LibraryElement> get inputLibrary async => resolver.libraryFor(inputId);

  /// The list of all outputs which are expected/allowed to be output from this
  /// step.
  final Set<AssetId> _expectedOutputs;

  /// The result of any writes which are starting during this step.
  final _writeResults = <Future<Result>>[];

  /// Used internally for reading files.
  final AssetReader _reader;

  /// Used internally for writing files.
  final AssetWriter _writer;

  /// The current root package, used for input/output validation.
  final String _rootPackage;

  final ResourceManager _resourceManager;

  BuildStepImpl(
      this.inputId,
      Iterable<AssetId> expectedOutputs,
      this._reader,
      this._writer,
      @deprecated this._rootPackage,
      this._resolvers,
      this._resourceManager)
      : _expectedOutputs = expectedOutputs.toSet();

  @override
  Resolver get resolver =>
      new _DelayedResolver(_resolver ??= _resolvers.get(this));

  Future<ReleasableResolver> _resolver;

  @override
  Future<bool> canRead(AssetId id) {
    _checkInput(id);
    return _reader.canRead(id);
  }

  @override
  Future<T> fetchResource<T>(Resource<T> resource) =>
      _resourceManager.fetch(resource);

  @override
  Future<List<int>> readAsBytes(AssetId id) {
    _checkInput(id);
    return _reader.readAsBytes(id);
  }

  @override
  Future<String> readAsString(AssetId id, {Encoding encoding: UTF8}) {
    _checkInput(id);
    return _reader.readAsString(id, encoding: encoding);
  }

  @override
  Iterable<AssetId> findAssets(Glob glob) {
    if (_reader is MultiPackageAssetReader) {
      return (_reader as MultiPackageAssetReader)
          .findAssets(glob, package: inputId?.package ?? _rootPackage);
    } else {
      return _reader.findAssets(glob);
    }
  }

  @override
  Future writeAsBytes(AssetId id, FutureOr<List<int>> bytes) {
    _checkOutput(id);
    var done =
        _futureOrWrite(bytes, (List<int> b) => _writer.writeAsBytes(id, b));
    _writeResults.add(Result.capture(done));
    return done;
  }

  @override
  Future writeAsString(AssetId id, FutureOr<String> content,
      {Encoding encoding: UTF8}) {
    _checkOutput(id);
    var done = _futureOrWrite(content,
        (String c) => _writer.writeAsString(id, c, encoding: encoding));
    _writeResults.add(Result.capture(done));
    return done;
  }

  Future _futureOrWrite<T>(FutureOr<T> content, Future write(T content)) =>
      (content is Future<T>) ? content.then(write) : write(content as T);

  /// Waits for work to finish and cleans up resources.
  ///
  /// This method should be called after a build has completed. After the
  /// returned [Future] completes then all outputs have been written and the
  /// [Resolver] for this build step - if any - has been released.
  Future complete() async {
    await Future.wait(_writeResults.map(Result.release));
    (await _resolver)?.release();
  }

  /// Checks that [id] is a valid input, and throws an [InvalidInputException]
  /// if its not.
  void _checkInput(AssetId id) {
    if (id.package != _rootPackage && !id.path.startsWith('lib/')) {
      throw new InvalidInputException(id);
    }
  }

  /// Checks that [id] is an expected output, and throws an
  /// [InvalidOutputException] or [UnexpectedOutputException] if it's not.
  void _checkOutput(AssetId id) {
    if (!_expectedOutputs.contains(id)) {
      throw new UnexpectedOutputException(id);
    }
  }
}

class _DelayedResolver implements Resolver {
  final Future<Resolver> _delegate;

  _DelayedResolver(this._delegate);

  @override
  Future<bool> isLibrary(AssetId assetId) async =>
      (await _delegate).isLibrary(assetId);

  @override
  Stream<LibraryElement> get libraries {
    var completer = new StreamCompleter<LibraryElement>();
    _delegate.then((r) => completer.setSourceStream(r.libraries));
    return completer.stream;
  }

  @override
  Future<LibraryElement> libraryFor(AssetId assetId) async =>
      (await _delegate).libraryFor(assetId);

  @override
  Future<LibraryElement> findLibraryByName(String libraryName) async =>
      (await _delegate).findLibraryByName(libraryName);
}
