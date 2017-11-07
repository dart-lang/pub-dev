// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('vm')
import 'dart:async';
import 'dart:convert';

import 'package:build_barback/build_barback.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'package:build/build.dart';
import 'package:build/src/builder/build_step_impl.dart';

void main() {
  ResourceManager resourceManager;

  setUp(() {
    resourceManager = new ResourceManager();
  });

  tearDown(() async {
    await resourceManager.disposeAll();
  });

  group('with reader/writer stub', () {
    AssetId primary;
    BuildStepImpl buildStep;

    setUp(() {
      var reader = new StubAssetReader();
      var writer = new StubAssetWriter();
      primary = makeAssetId();
      buildStep = new BuildStepImpl(primary, [], reader, writer,
          primary.package, const BarbackResolvers(), resourceManager);
    });

    test('doesnt allow non-expected outputs', () {
      var id = makeAssetId();
      expect(() => buildStep.writeAsString(id, '$id'),
          throwsA(new isInstanceOf<UnexpectedOutputException>()));
      expect(() => buildStep.writeAsBytes(id, [0]),
          throwsA(new isInstanceOf<UnexpectedOutputException>()));
    });

    test('canRead throws invalidInputExceptions', () async {
      expect(() => buildStep.canRead(makeAssetId('b|web/a.txt')),
          throwsA(invalidInputException));
      expect(() => buildStep.canRead(makeAssetId('b|a.txt')),
          throwsA(invalidInputException));
      expect(() => buildStep.canRead(makeAssetId('foo|bar.txt')),
          throwsA(invalidInputException));
    });

    test('readAs* throws InvalidInputExceptions', () async {
      var invalidInputs = [
        makeAssetId('b|web/a.txt'),
        makeAssetId('b|a.txt'),
        makeAssetId('foo|bar.txt')
      ];
      for (var id in invalidInputs) {
        expect(
            () => buildStep.readAsString(id), throwsA(invalidInputException));
        expect(() => buildStep.readAsBytes(id), throwsA(invalidInputException));
      }
    });

    test('fetchResource can fetch resources', () async {
      int expected = 1;
      var intResource = new Resource(() => expected);
      var actual = await buildStep.fetchResource(intResource);
      expect(actual, expected);
    });
  });

  group('with in memory file system', () {
    InMemoryAssetWriter writer;
    InMemoryAssetReader reader;

    setUp(() {
      writer = new InMemoryAssetWriter();
      reader = new InMemoryAssetReader(sourceAssets: writer.assets);
    });

    test('tracks outputs created by a builder', () async {
      var builder = new CopyBuilder();
      var primary = makeAssetId('a|web/primary.txt');
      var inputs = {
        primary: 'foo',
      };
      addAssets(inputs, writer);
      var outputId = new AssetId.parse('$primary.copy');
      var buildStep = new BuildStepImpl(primary, [outputId], reader, writer,
          'a', const BarbackResolvers(), resourceManager);

      await builder.build(buildStep);
      await buildStep.complete();

      // One output.
      expect(writer.assets[outputId].stringValue, 'foo');
    });

    group('resolve', () {
      test('can resolve assets', () async {
        var inputs = {
          makeAssetId('a|web/a.dart'): '''
              library a;

              import 'b.dart';
            ''',
          makeAssetId('a|web/b.dart'): '''
              library b;
            ''',
        };
        addAssets(inputs, writer);

        var primary = makeAssetId('a|web/a.dart');
        var buildStep = new BuildStepImpl(primary, [], reader, writer,
            primary.package, const BarbackResolvers(), resourceManager);
        var resolver = buildStep.resolver;

        var aLib = await resolver.libraryFor(primary);
        expect(aLib.name, 'a');
        expect(aLib.importedLibraries.length, 2);
        expect(aLib.importedLibraries.any((library) => library.name == 'b'),
            isTrue);

        var bLib = await resolver.findLibraryByName('b');
        expect(bLib.name, 'b');
        expect(bLib.importedLibraries.length, 1);

        await buildStep.complete();
      });
    });
  });

  group('With slow writes', () {
    BuildStepImpl buildStep;
    SlowAssetWriter assetWriter;
    AssetId outputId;
    String outputContent;

    setUp(() async {
      var primary = makeAssetId();
      assetWriter = new SlowAssetWriter();
      outputId = makeAssetId('a|test.txt');
      outputContent = '$outputId';
      buildStep = new BuildStepImpl(
          primary,
          [outputId],
          new StubAssetReader(),
          assetWriter,
          primary.package,
          const BarbackResolvers(),
          resourceManager);
    });

    test('Completes only after writes finish', () async {
      // ignore: unawaited_futures
      buildStep.writeAsString(outputId, outputContent);
      var isComplete = false;
      // ignore: unawaited_futures
      buildStep.complete().then((_) {
        isComplete = true;
      });
      await new Future(() {});
      expect(isComplete, false,
          reason: 'File has not written, should not be complete');
      assetWriter.finishWrite();
      await new Future(() {});
      expect(isComplete, true, reason: 'File is written, should be complete');
    });

    test('Completes only after async writes finish', () async {
      var outputCompleter = new Completer<String>();
      // ignore: unawaited_futures
      buildStep.writeAsString(outputId, outputCompleter.future);
      var isComplete = false;
      // ignore: unawaited_futures
      buildStep.complete().then((_) {
        isComplete = true;
      });
      await new Future(() {});
      expect(isComplete, false,
          reason: 'File has not resolved, should not be complete');
      outputCompleter.complete(outputContent);
      await new Future(() {});
      expect(isComplete, false,
          reason: 'File has not written, should not be complete');
      assetWriter.finishWrite();
      await new Future(() {});
      expect(isComplete, true, reason: 'File is written, should be complete');
    });
  });

  group('With erroring writes', () {
    AssetId primary;
    BuildStepImpl buildStep;
    AssetId output;

    setUp(() {
      var reader = new StubAssetReader();
      var writer = new StubAssetWriter();
      primary = makeAssetId();
      output = makeAssetId();
      buildStep = new BuildStepImpl(primary, [output], reader, writer,
          primary.package, const BarbackResolvers(), resourceManager);
    });

    test('Captures failed asynchronous writes', () {
      buildStep.writeAsString(output, new Future.error('error'));
      expect(buildStep.complete(), throwsA('error'));
    });
  });
}

class SlowAssetWriter implements AssetWriter {
  final _writeCompleter = new Completer<Null>();

  void finishWrite() {
    _writeCompleter.complete(null);
  }

  @override
  Future writeAsBytes(AssetId id, FutureOr<List<int>> bytes) =>
      _writeCompleter.future;

  @override
  Future writeAsString(AssetId id, FutureOr<String> contents,
          {Encoding encoding: UTF8}) =>
      _writeCompleter.future;
}
