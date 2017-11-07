// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';

import 'generated_output.dart';
import 'generator.dart';
import 'library.dart';
import 'utils.dart';

typedef String _OutputFormatter(String code);

/// A [Builder] wrapping on one or more [Generator]s.
class _Builder extends Builder {
  /// Function that determines how the generated code is formatted.
  final _OutputFormatter formatOutput;

  /// The generators run for each targeted library.
  final List<Generator> _generators;

  /// The [buildExtensions] configuration for `.dart`
  final String _generatedExtension;

  /// Whether to emit a standalone (non-`part`) file in this builder.
  final bool _isStandalone;

  final bool _requireLibraryDirective;

  final String _header;

  @override
  final Map<String, List<String>> buildExtensions;

  /// Wrap [_generators] to form a [Builder]-compatible API.
  _Builder(this._generators,
      {String formatOutput(String code),
      String generatedExtension: '.g.dart',
      List<String> additionalOutputExtensions: const [],
      bool isStandalone: false,
      bool requireLibraryDirective: true,
      String header})
      : _generatedExtension = generatedExtension,
        buildExtensions = {
          '.dart': [generatedExtension]..addAll(additionalOutputExtensions)
        },
        _isStandalone = isStandalone,
        formatOutput = formatOutput ?? _formatter.format,
        _requireLibraryDirective = requireLibraryDirective,
        _header = header ?? defaultFileHeader {
    if (_generatedExtension == null) {
      throw new ArgumentError.notNull('generatedExtension');
    }
    if (_generatedExtension.isEmpty || !_generatedExtension.startsWith('.')) {
      throw new ArgumentError.value(_generatedExtension, 'generatedExtension',
          'Extension must be in the format of .*');
    }
    if (this._isStandalone && this._generators.length > 1) {
      throw new ArgumentError(
          'A standalone file can only be generated from a single Generator.');
    }
  }

  @override
  Future build(BuildStep buildStep) async {
    var resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;
    var lib = await buildStep.inputLibrary;
    await _generateForLibrary(lib, buildStep);
  }

  AssetId _generatedFile(AssetId input) =>
      input.changeExtension(_generatedExtension);

  Future _generateForLibrary(
      LibraryElement library, BuildStep buildStep) async {
    log.fine('Running $_generators for ${buildStep.inputId}');
    var generatedOutputs =
        await _generate(library, _generators, buildStep).toList();

    // Don't output useless files.
    //
    // NOTE: It is important to do this check _before_ checking for valid
    // library/part definitions because users expect some files to be skipped
    // therefore they do not have "library".
    if (generatedOutputs.isEmpty) return;
    final outputId = _generatedFile(buildStep.inputId);

    var contentBuffer = new StringBuffer();

    if (_header.isNotEmpty) {
      contentBuffer.writeln(_header);
    }

    if (!_isStandalone) {
      var asset = buildStep.inputId;
      var name = nameOfPartial(
        library,
        asset,
        allowUnnamedPartials: !_requireLibraryDirective,
      );
      if (name == null) {
        var suggest = suggestLibraryName(asset);
        throw new InvalidGenerationSourceError(
            'Could not find library identifier so a "part of" cannot be built.',
            todo: ''
                'Consider adding the following to your source file:\n\n'
                'library $suggest;');
      }
      final part = computePartUrl(buildStep.inputId, outputId);
      if (!library.parts.map((c) => c.uri).contains(part)) {
        // TODO: Upgrade to error in a future breaking change?
        log.warning('Missing "part \'$part\';".');
      }
      contentBuffer.writeln('part of $name;');
      contentBuffer.writeln();
    }

    for (GeneratedOutput output in generatedOutputs) {
      contentBuffer.writeln('');
      contentBuffer.writeln(_headerLine);
      contentBuffer.writeln('// Generator: ${output.generator}');
      contentBuffer.writeln(_headerLine);
      contentBuffer.writeln('');

      contentBuffer.writeln(output.output);
    }

    var genPartContent = contentBuffer.toString();

    try {
      genPartContent = formatOutput(genPartContent);
    } catch (e, stack) {
      log.severe(
          'Error formatting generated source code for ${library.identifier}'
          'which was output to ${outputId.path}.\n'
          'This may indicate an issue in the generated code or in the '
          'formatter.\n'
          'Please check the generated code and file an issue on source_gen if '
          'appropriate.',
          e,
          stack);
    }

    buildStep.writeAsString(outputId, genPartContent);
  }
}

/// A [Builder] which generates `part of` files.
class PartBuilder extends _Builder {
  /// Wrap [generators] as a [Builder] that generates `part of` files.
  ///
  /// [generatedExtension] indicates what files will be created for each `.dart`
  /// input. Defaults to `.g.dart`. If any generator in [generators] will create
  /// additional outputs through the [BuildStep] they should be indicated in
  /// [additionalOutputExtensions].
  ///
  /// [formatOutput] is called to format the generated code. Defaults to
  /// [DartFormatter.format].
  ///
  /// [header] is used to specify the content at the top of each generated file.
  /// If `null`, the content of [defaultFileHeader] is used.
  /// If [header] is an empty `String` no header is added.
  ///
  /// May set [requireLibraryDirective] to `false` in order to opt-in to
  /// supporting a `1.25.0` feature of `part of` being usable without an
  /// explicit `library` directive. Developers should restrict their `pubspec`
  /// accordingly:
  /// ```yaml
  /// sdk: '>=1.25.0 <2.0.0'
  /// ```
  PartBuilder(List<Generator> generators,
      {String formatOutput(String code),
      String generatedExtension: '.g.dart',
      List<String> additionalOutputExtensions: const [],
      bool requireLibraryDirective: true,
      String header})
      : super(generators,
            formatOutput: formatOutput,
            generatedExtension: generatedExtension,
            additionalOutputExtensions: additionalOutputExtensions,
            requireLibraryDirective: requireLibraryDirective,
            header: header);
}

/// A [Builder] which generates Dart library files.
class LibraryBuilder extends _Builder {
  /// Wrap [generator] as a [Builder] that generates Dart library files.
  ///
  /// [generatedExtension] indicates what files will be created for each `.dart`
  /// input. Defaults to `.g.dart`. If [generator] will create additional
  /// outputs through the [BuildStep] they should be indicated in
  /// [additionalOutputExtensions].
  ///
  /// If `null`, the content of [defaultFileHeader] is used.
  /// If [header] is an empty `String` no header is added.
  ///
  /// [formatOutput] is called to format the generated code. Defaults to
  /// [DartFormatter.format].
  LibraryBuilder(Generator generator,
      {String formatOutput(String code),
      String generatedExtension: '.g.dart',
      List<String> additionalOutputExtensions: const [],
      String header})
      : super([generator],
            formatOutput: formatOutput,
            generatedExtension: generatedExtension,
            additionalOutputExtensions: additionalOutputExtensions,
            isStandalone: true,
            header: header);
}

Stream<GeneratedOutput> _generate(LibraryElement library,
    List<Generator> generators, BuildStep buildStep) async* {
  var libraryReader = new LibraryReader(library);
  for (var gen in generators) {
    try {
      log.finer('Running $gen for ${buildStep.inputId}');
      var createdUnit = await gen.generate(libraryReader, buildStep);

      if (createdUnit != null && createdUnit.isNotEmpty) {
        log.finest(() => 'Generated $createdUnit for ${buildStep.inputId}');
        yield new GeneratedOutput(gen, createdUnit);
      }
    } catch (e, stack) {
      log.severe('Error running $gen for ${buildStep.inputId}.', e, stack);
      yield new GeneratedOutput.fromError(gen, e, stack);
    }
  }
}

final _formatter = new DartFormatter();

const defaultFileHeader = '''// GENERATED CODE - DO NOT MODIFY BY HAND

''';

final _headerLine = '// '.padRight(77, '*');
